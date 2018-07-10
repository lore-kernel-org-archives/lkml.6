Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97371C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F70208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F70208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGJMKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:10:19 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41850 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGJMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:10:18 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 90AF1y00c3XaVaC010AFx7; Tue, 10 Jul 2018 14:10:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcrTD-0007v1-Oo; Tue, 10 Jul 2018 14:10:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcrTD-00086h-Li; Tue, 10 Jul 2018 14:10:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] checkpatch: Require author Signed-off-by
Date:   Tue, 10 Jul 2018 14:10:14 +0200
Message-Id: <20180710121014.31119-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print an error if none of the Signed-off-by lines cover the patch
author.

Non-ASCII quoted printable encoding in From: headers and (lack of)
double quotes are handled.
Split From: headers are not fully handled: only the first part is
compared.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested using a set of ca. 4000 real world commits.

Most common offenders are people using:
  - different email addresses for author and Sob,
  - different firstname/lastname order, or other different name
    spelling,
  - suse.de vs. suse.com.
---
 scripts/checkpatch.pl | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8d0bad190c25e2e0..53f3dcf9171447f4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -13,6 +13,7 @@ use POSIX;
 use File::Basename;
 use Cwd 'abs_path';
 use Term::ANSIColor qw(:constants);
+use MIME::Words 'decode_mimewords';
 
 my $P = $0;
 my $D = dirname(abs_path($P));
@@ -2236,6 +2237,8 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $author = '';
+	my $authorsignoff = 0;
 	my $is_patch = 0;
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
@@ -2518,10 +2521,23 @@ sub process {
 			}
 		}
 
+# Check the patch for a From:
+		if ($line =~ /^\s*From: (.*)/i) {
+			$author = decode_mimewords($1);
+			$author =~ s/"//g;
+		}
+
 # Check the patch for a signoff:
 		if ($line =~ /^\s*signed-off-by:/i) {
 			$signoff++;
 			$in_commit_log = 0;
+			if ($author ne '') {
+				my $l = $line;
+				$l =~ s/"//g;
+				if ($l =~ /^\s*signed-off-by: \Q$author\E/i) {
+				    $authorsignoff = 1;
+				}
+			}
 		}
 
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
@@ -6487,9 +6503,14 @@ sub process {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
-	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
-		ERROR("MISSING_SIGN_OFF",
-		      "Missing Signed-off-by: line(s)\n");
+	if ($is_patch && $has_commit_log && $chk_signoff) {
+		if ($signoff == 0) {
+			ERROR("MISSING_SIGN_OFF",
+			      "Missing Signed-off-by: line(s)\n");
+		} elsif (!$authorsignoff) {
+			ERROR("NO_AUTHOR_SIGN_OFF",
+			      "Missing Signed-off-by: line by patch author\n");
+		}
 	}
 
 	print report_dump();
-- 
2.17.1

