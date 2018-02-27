Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB0CYs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:24:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751630AbeB0CYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:24:45 -0500
X-ME-Sender: <xms:bMGUWjcHdJ9iS1mOcuzJJleo7QJA-v40NvWvrWCRjVrBW_IU_Fq8yA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] checkpatch: add sub routine get_stat_real()
Date: Tue, 27 Feb 2018 13:24:20 +1100
Message-Id: <1519698263-17783-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698263-17783-1-git-send-email-me@tobin.cc>
References: <1519698263-17783-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch currently contains duplicate code. We can define a sub
routine and call that instead. This reduces code duplication and line
count.

Add subroutine get_stat_real()

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/checkpatch.pl | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..235a02f4f4e1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1644,6 +1644,17 @@ sub raw_line {
 	return $line;
 }
 
+sub get_stat_real {
+	my ($linenr, $lc) = @_;
+
+	my $stat_real = raw_line($linenr, 0);
+	for (my $count = $linenr + 1; $count <= $lc; $count++) {
+		$stat_real = $stat_real . "\n" . raw_line($count, 0);
+	}
+
+	return $stat_real;
+}
+
 sub cat_vet {
 	my ($vet) = @_;
 	my ($res, $coded);
@@ -5806,17 +5817,15 @@ sub process {
 				}
 			}
 			if ($bad_extension ne "") {
-				my $stat_real = raw_line($linenr, 0);
+				my $stat_real = get_stat_real($linenr, $lc);
 				my $ext_type = "Invalid";
 				my $use = "";
-				for (my $count = $linenr + 1; $count <= $lc; $count++) {
-					$stat_real = $stat_real . "\n" . raw_line($count, 0);
-				}
 				if ($bad_extension =~ /p[Ff]/) {
 					$ext_type = "Deprecated";
 					$use = " - use %pS instead";
 					$use =~ s/pS/ps/ if ($bad_extension =~ /pf/);
 				}
+
 				WARN("VSPRINTF_POINTER_EXTENSION",
 				     "$ext_type vsprintf pointer extension '$bad_extension'$use\n" . "$here\n$stat_real\n");
 			}
@@ -5931,10 +5940,7 @@ sub process {
 		     $stat !~ /(?:$Compare)\s*\bsscanf\s*$balanced_parens/)) {
 			my $lc = $stat =~ tr@\n@@;
 			$lc = $lc + $linenr;
-			my $stat_real = raw_line($linenr, 0);
-		        for (my $count = $linenr + 1; $count <= $lc; $count++) {
-				$stat_real = $stat_real . "\n" . raw_line($count, 0);
-			}
+			my $stat_real = get_stat_real($linenr, $lc);
 			WARN("NAKED_SSCANF",
 			     "unchecked sscanf return value\n" . "$here\n$stat_real\n");
 		}
@@ -5945,10 +5951,7 @@ sub process {
 		    $line =~ /\bsscanf\b/) {
 			my $lc = $stat =~ tr@\n@@;
 			$lc = $lc + $linenr;
-			my $stat_real = raw_line($linenr, 0);
-		        for (my $count = $linenr + 1; $count <= $lc; $count++) {
-				$stat_real = $stat_real . "\n" . raw_line($count, 0);
-			}
+			my $stat_real = get_stat_real($linenr, $lc);
 			if ($stat_real =~ /\bsscanf\b\s*\(\s*$FuncArg\s*,\s*("[^"]+")/) {
 				my $format = $6;
 				my $count = $format =~ tr@%@%@;
@@ -6382,10 +6385,7 @@ sub process {
 
 				my $lc = $stat =~ tr@\n@@;
 				$lc = $lc + $linenr;
-				my $stat_real = raw_line($linenr, 0);
-				for (my $count = $linenr + 1; $count <= $lc; $count++) {
-					$stat_real = $stat_real . "\n" . raw_line($count, 0);
-				}
+				my $stat_real = get_stat_real($linenr, $lc);
 
 				my $skip_args = "";
 				if ($arg_pos > 1) {
-- 
2.7.4
