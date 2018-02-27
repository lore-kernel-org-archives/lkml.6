Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeB0CYz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:24:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38365 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751981AbeB0CYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:24:51 -0500
X-ME-Sender: <xms:c8GUWn6Q7Y3c-g_KAMm9tqEzOxShVCGN88hskoUjaPXL-iiRATTqGQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] checkpatch: add sub routine get_stat_here()
Date: Tue, 27 Feb 2018 13:24:22 +1100
Message-Id: <1519698263-17783-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698263-17783-1-git-send-email-me@tobin.cc>
References: <1519698263-17783-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch currently contains duplicate code. We can define a sub
routine and call that instead. This reduces code duplication and line
count.

Add subroutine get_stat_here()

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/checkpatch.pl | 52 ++++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d505fa4ec20c..679a10298cb5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1655,6 +1655,17 @@ sub get_stat_real {
 	return $stat_real;
 }
 
+sub get_stat_here {
+	my ($linenr, $cnt, $here) = @_;
+
+	my $herectx = $here . "\n";
+	for (my $n = 0; $n < $cnt; $n++) {
+		$herectx .= raw_line($linenr, $n) . "\n";
+	}
+
+	return $herectx;
+}
+
 sub cat_vet {
 	my ($vet) = @_;
 	my ($res, $coded);
@@ -4952,12 +4963,8 @@ sub process {
 			#print "REST<$rest> dstat<$dstat> ctx<$ctx>\n";
 
 			$ctx =~ s/\n*$//;
-			my $herectx = $here . "\n";
 			my $stmt_cnt = statement_rawlines($ctx);
-
-			for (my $n = 0; $n < $stmt_cnt; $n++) {
-				$herectx .= raw_line($linenr, $n) . "\n";
-			}
+			my $herectx = get_stat_here($linenr, $stmt_cnt, $here);
 
 			if ($dstat ne '' &&
 			    $dstat !~ /^(?:$Ident|-?$Constant),$/ &&			# 10, // foo(),
@@ -5029,12 +5036,9 @@ sub process {
 # check for macros with flow control, but without ## concatenation
 # ## concatenation is commonly a macro that defines a function so ignore those
 			if ($has_flow_statement && !$has_arg_concat) {
-				my $herectx = $here . "\n";
 				my $cnt = statement_rawlines($ctx);
+				my $herectx = get_stat_here($linenr, $cnt, $here);
 
-				for (my $n = 0; $n < $cnt; $n++) {
-					$herectx .= raw_line($linenr, $n) . "\n";
-				}
 				WARN("MACRO_WITH_FLOW_CONTROL",
 				     "Macros with flow control statements should be avoided\n" . "$herectx");
 			}
@@ -5074,11 +5078,7 @@ sub process {
 
 				$ctx =~ s/\n*$//;
 				my $cnt = statement_rawlines($ctx);
-				my $herectx = $here . "\n";
-
-				for (my $n = 0; $n < $cnt; $n++) {
-					$herectx .= raw_line($linenr, $n) . "\n";
-				}
+				my $herectx = get_stat_here($linenr, $cnt, $here);
 
 				if (($stmts =~ tr/;/;/) == 1 &&
 				    $stmts !~ /^\s*(if|while|for|switch)\b/) {
@@ -5092,11 +5092,7 @@ sub process {
 			} elsif ($dstat =~ /^\+\s*#\s*define\s+$Ident.*;\s*$/) {
 				$ctx =~ s/\n*$//;
 				my $cnt = statement_rawlines($ctx);
-				my $herectx = $here . "\n";
-
-				for (my $n = 0; $n < $cnt; $n++) {
-					$herectx .= raw_line($linenr, $n) . "\n";
-				}
+				my $herectx = get_stat_here($linenr, $cnt, $here);
 
 				WARN("TRAILING_SEMICOLON",
 				     "macros should not use a trailing semicolon\n" . "$herectx");
@@ -5219,12 +5215,8 @@ sub process {
 				}
 			}
 			if ($level == 0 && $block =~ /^\s*\{/ && !$allowed) {
-				my $herectx = $here . "\n";
 				my $cnt = statement_rawlines($block);
-
-				for (my $n = 0; $n < $cnt; $n++) {
-					$herectx .= raw_line($linenr, $n) . "\n";
-				}
+				my $herectx = get_stat_here($linenr, $cnt, $here);
 
 				WARN("BRACES",
 				     "braces {} are not necessary for single statement blocks\n" . $herectx);
@@ -6081,11 +6073,9 @@ sub process {
 			}
 			if ($r1 !~ /^sizeof\b/ && $r2 =~ /^sizeof\s*\S/ &&
 			    !($r1 =~ /^$Constant$/ || $r1 =~ /^[A-Z_][A-Z0-9_]*$/)) {
-				my $herectx = $here . "\n";
 				my $cnt = statement_rawlines($stat);
-				for (my $n = 0; $n < $cnt; $n++) {
-					$herectx .= raw_line($linenr, $n) . "\n";
-				}
+				my $herectx = get_stat_here($linenr, $cnt, $here);
+
 				if (WARN("ALLOC_WITH_MULTIPLY",
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
@@ -6168,11 +6158,9 @@ sub process {
 		if ($^V && $^V ge 5.10.0 &&
 		    defined $stat &&
 		    $stat =~ /^\+[$;\s]*(?:case[$;\s]+\w+[$;\s]*:[$;\s]*|)*[$;\s]*\bdefault[$;\s]*:[$;\s]*;/g) {
-			my $herectx = $here . "\n";
 			my $cnt = statement_rawlines($stat);
-			for (my $n = 0; $n < $cnt; $n++) {
-				$herectx .= raw_line($linenr, $n) . "\n";
-			}
+			my $herectx = get_stat_here($linenr, $cnt, $here);
+
 			WARN("DEFAULT_NO_BREAK",
 			     "switch default: should use break\n" . $herectx);
 		}
-- 
2.7.4
