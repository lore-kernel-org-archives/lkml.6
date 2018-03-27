Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeC0FTJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:19:09 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:44504 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751088AbeC0FTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:19:07 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3870:3874:4321:5007:10004:10400:10848:11026:11658:11914:12043:12438:12555:12663:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21221:21324:21627:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: fuel04_89c9a7b1a8e34
X-Filterd-Recvd-Size: 1568
Message-ID: <1522127944.12357.49.camel@perches.com>
Subject: [PATCH] checkpatch: Test SYMBOLIC_PERMS multiple times per line
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 22:19:04 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are occasions where symbolic perms are used in a ternary like

		return (channel == 0) ? S_IRUGO | S_IWUSR : S_IRUGO;

The current test will find the first use "S_IRUGO | S_IWUSR" but not
the second use "S_IRUGO" on the same line.

Improve the test to look for all instances on a line.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5fe361e1ed5e..d2464002bb40 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6429,7 +6429,7 @@ sub process {
 		}
 
 # check for uses of S_<PERMS> that could be octal for readability
-		if ($line =~ /\b($multi_mode_perms_string_search)\b/) {
+		while ($line =~ m{\b($multi_mode_perms_string_search)\b}g) {
 			my $oval = $1;
 			my $octal = perms_to_octal($oval);
 			if (WARN("SYMBOLIC_PERMS",
