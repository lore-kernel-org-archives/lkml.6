Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeB0DEs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:04:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47757 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751632AbeB0DEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:04:31 -0500
X-ME-Sender: <xms:vsqUWkEa3AAeCJzPnhAPbx7gfKYN8Fa7h6aNI4RZG2_yXOsZxCOqrg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] checkpatch: warn for use of %px
Date: Tue, 27 Feb 2018 14:04:08 +1100
Message-Id: <1519700648-23108-5-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519700648-23108-1-git-send-email-me@tobin.cc>
References: <1519700648-23108-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of the new %px specifier potentially leaks sensitive
inforamtion. Printing kernel addresses exposes the kernel layout in
memory, this is potentially exploitable. We have tools in the kernel to
help us do the right thing. We can have checkpatch warn developers of
potential dangers of using %px.

Have checkpatch emit a warning for usage of specifier %px.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Co-Developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/checkpatch.pl | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 679a10298cb5..5628e847c6fc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5797,29 +5797,45 @@ sub process {
 		    defined $stat &&
 		    $stat =~ /^\+(?![^\{]*\{\s*).*\b(\w+)\s*\(.*$String\s*,/s &&
 		    $1 !~ /^_*volatile_*$/) {
-			my $bad_extension = "";
+			my $specifier;
+			my $extension;
+			my $bad_specifier = "";
+			my $stat_real;
+
 			my $lc = $stat =~ tr@\n@@;
 			$lc = $lc + $linenr;
 		        for (my $count = $linenr; $count <= $lc; $count++) {
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
-				if ($fmt =~ /(\%[\*\d\.]*p(?![\WSsBKRraEhMmIiUDdgVCbGNOx]).)/) {
-					$bad_extension = $1;
-					last;
-				}
-			}
-			if ($bad_extension ne "") {
-				my $stat_real = get_stat_real($linenr, $lc);
-				my $ext_type = "Invalid";
-				my $use = "";
-				if ($bad_extension =~ /p[Ff]/) {
-					$ext_type = "Deprecated";
-					$use = " - use %pS instead";
-					$use =~ s/pS/ps/ if ($bad_extension =~ /pf/);
+
+				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
+					$specifier = $1;
+					$extension = $2;
+					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOx]/) {
+						$bad_specifier = $specifier;
+						last;
+					}
+					if ($extension eq "x" && !defined($stat_real)) {
+						if (!defined($stat_real)) {
+							$stat_real = get_stat_real($linenr, $lc);
+						}
+						WARN("VSPRINTF_SPECIFIER_PX",
+						     "Using vsprintf specifier '\%px' potentially exposes the kernel memory layout, if you don't really need the address please consider using '\%p'.\n" . "$here\n$stat_real\n");
+					}
 				}
+				if ($bad_specifier ne "") {
+					my $stat_real = get_stat_real($linenr, $lc);
+					my $ext_type = "Invalid";
+					my $use = "";
+					if ($bad_specifier =~ /p[Ff]/) {
+						$ext_type = "Deprecated";
+						$use = " - use %pS instead";
+						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
+					}
 
-				WARN("VSPRINTF_POINTER_EXTENSION",
-				     "$ext_type vsprintf pointer extension '$bad_extension'$use\n" . "$here\n$stat_real\n");
+					WARN("VSPRINTF_POINTER_EXTENSION",
+					     "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
+				}
 			}
 		}
 
-- 
2.7.4
