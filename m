Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeEINTi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:19:38 -0400
Received: from osg.samsung.com ([64.30.133.232]:60030 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935219AbeEINTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:18 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 06/11] scripts/documentation-file-ref-check: rewrite it in perl with auto-fix mode
Date: Wed,  9 May 2018 10:18:49 -0300
Message-Id: <f66d3153db8798ddb96a1231ca5994e47afda076.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original shell script works, but:
	1) it is too slow;
	2) it is hard to exclude rejex patterns

Convert it to perl.

Here, the new version is able to check the entire tree in
less than a second (after cached):

	real	0m0,284s
	user	0m0,668s
	sys	0m0,778s

The old version takes more than a minute to complete (also
after cached):
	real	1m17,905s
	user	0m25,583s
	sys	0m55,334s

It also produce less false-positives (if any).

The new script also contains an auto-fix mode.

Usually, file references get lost when they're moved to some other
place and/or renamed to .rst.

Add an experimental mode to auto-fix those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 125 ++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 12 deletions(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index bc1659900e89..2520bc14ffac 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -1,15 +1,116 @@
-#!/bin/sh
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+#
 # Treewide grep for references to files under Documentation, and report
 # non-existing files in stderr.
 
-for f in $(git ls-files); do
-	for ref in $(grep -ho "Documentation/[A-Za-z0-9_.,~/*+-]*" "$f"); do
-		# presume trailing . and , are not part of the name
-		ref=${ref%%[.,]}
-
-		# use ls to handle wildcards
-		if ! ls $ref >/dev/null 2>&1; then
-			echo "$f: $ref" >&2
-		fi
-	done
-done
+use warnings;
+use strict;
+use Getopt::Long qw(:config no_auto_abbrev);
+
+my $scriptname = $0;
+$scriptname =~ s,.*/([^/]+/),$1,;
+
+# Parse arguments
+my $help = 0;
+my $fix = 0;
+
+GetOptions(
+	'fix' => \$fix,
+	'h|help|usage' => \$help,
+);
+
+if ($help != 0) {
+    print "$scriptname [--help] [--fix-rst]\n";
+    exit -1;
+}
+
+# Step 1: find broken references
+print "Finding broken references. This may take a while...  " if ($fix);
+
+my %broken_ref;
+
+open IN, "git grep 'Documentation/'|"
+     or die "Failed to run git grep";
+while (<IN>) {
+	next if (!m/^([^:]+):(.*)/);
+
+	my $f = $1;
+	my $ln = $2;
+
+	# Makefiles contain nasty expressions to parse docs
+	next if ($f =~ m/Makefile/);
+	# Skip this script
+	next if ($f eq $scriptname);
+
+	if ($ln =~ m,\b(\S*)(Documentation/[A-Za-z0-9\_\.\,\~/\*+-]*),) {
+		my $prefix = $1;
+		my $ref = $2;
+		my $base = $2;
+
+		$ref =~ s/[\,\.]+$//;
+
+		my $fulref = "$prefix$ref";
+
+		$fulref =~ s/^(\<file|ref)://;
+		$fulref =~ s/^[\'\`]+//;
+		$fulref =~ s,^\$\(.*\)/,,;
+		$base =~ s,.*/,,;
+
+		# Remove URL false-positives
+		next if ($fulref =~ m/^http/);
+
+		# Check if exists, evaluating wildcards
+		next if (grep -e, glob("$ref $fulref"));
+
+		if ($fix) {
+			if (!($ref =~ m/(devicetree|scripts|Kconfig|Kbuild)/)) {
+				$broken_ref{$ref}++;
+			}
+		} else {
+			print STDERR "$f: $fulref\n";
+		}
+	}
+}
+
+exit 0 if (!$fix);
+
+# Step 2: Seek for file name alternatives
+print "Auto-fixing broken references. Please double-check the results\n";
+
+foreach my $ref (keys %broken_ref) {
+	my $new =$ref;
+
+	# get just the basename
+	$new =~ s,.*/,,;
+
+	# Seek for the same name on another place, as it may have been moved
+	my $f="";
+
+	$f = qx(find . -iname $new) if ($new);
+
+	# usual reason for breakage: file renamed to .rst
+	if (!$f) {
+		$new =~ s/\.txt$/.rst/;
+		$f=qx(find . -iname $new) if ($new);
+	}
+
+	my @find = split /\s+/, $f;
+
+	if (!$f) {
+		print STDERR "ERROR: Didn't find a replacement for $ref\n";
+	} elsif (scalar(@find) > 1) {
+		print STDERR "WARNING: Won't auto-replace, as found multiple files close to $ref:\n";
+		foreach my $j (@find) {
+			$j =~ s,^./,,;
+			print STDERR "    $j\n";
+		}
+	} else {
+		$f = $find[0];
+		$f =~ s,^./,,;
+		print "INFO: Replacing $ref to $f\n";
+		foreach my $j (qx(git grep -l $ref)) {
+			qx(sed "s\@$ref\@$f\@g" -i $j);
+		}
+	}
+}
-- 
2.17.0
