#!/usr/bin/perl
use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/modules";
use CAF::RuleBasedEditor;
use Test::More;
use Test::Quattor::Object;
use Carp qw(confess);
use File::Path;
use File::Temp qw(tempfile);

my $testdir = 'target/test/editor';
mkpath($testdir);
(undef, our $filename) = tempfile(DIR => $testdir);

use constant TEXT => <<EOF;
En un lugar de La Mancha, de cuyo nombre no quiero acordarme
no ha tiempo que vivía un hidalgo de los de lanza en astillero...
EOF
use constant HEADTEXT => <<EOF;
... adarga antigua, rocín flaco y galgo corredor.
EOF

chomp($filename);
our $text = TEXT;

our %opts = ();
our $path;
my $obj = Test::Quattor::Object->new();

$SIG{__DIE__} = \&confess;

my $fh = CAF::RuleBasedEditor->new ($filename);
isa_ok ($fh, "CAF::RuleBasedEditor", "Correct class after new method");
isa_ok ($fh, "CAF::FileEditor", "Correct class inheritance after new method");
isa_ok ($fh, "CAF::FileWriter", "Correct class inheritance after new method");
is (${$fh->string_ref()}, TEXT, "File opened and correctly read");
$fh->close();

is(*$fh->{filename}, $filename, "The object stores its parent's attributes");

done_testing();

