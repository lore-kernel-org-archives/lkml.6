Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeEVAit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:38:49 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:54049 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752199AbeEVAiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:38:46 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3874:5007:6261:7903:10004:10848:11658:11914:12296:12555:12895:13069:13161:13221:13229:13311:13357:14181:14384:14394:14721:21080:21221:21451:21627:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: place29_4c5dac3bc9740
X-Filterd-Recvd-Size: 1876
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] get_maintainer: Improve patch recognition
Date: Mon, 21 May 2018 17:38:39 -0700
Message-Id: <bf63101a908d0ff51948164aa60e672368066186.1526949367.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1526949367.git.joe@perches.com>
References: <cover.1526949367.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are mode change and rename only patches that are unrecognized
by the get_maintainer.pl script.

Recognize them.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 99c96e86eccb..0d987ef5e0ab 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -542,7 +542,18 @@ foreach my $file (@ARGV) {
 
 	while (<$patch>) {
 	    my $patch_line = $_;
-	    if (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
+	    if (m/^ mode change [0-7]+ => [0-7]+ (\S+)\s*$/) {
+		my $filename = $1;
+		push(@files, $filename);
+	    } elsif (m/^rename (?:from|to) (\S+)\s*$/) {
+		my $filename = $1;
+		push(@files, $filename);
+	    } elsif (m/^diff --git a\/(\S+) b\/(\S+)\s*$/) {
+		my $filename1 = $1;
+		my $filename2 = $2;
+		push(@files, $filename1);
+		push(@files, $filename2);
+	    } elsif (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
 		my $filename = $1;
 		$filename =~ s@^[^/]*/@@;
 		$filename =~ s@\n@@;
-- 
2.15.0
