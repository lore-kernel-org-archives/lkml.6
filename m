Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeC1WWL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:22:11 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:56936 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753816AbeC1WWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:22:10 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3874:4321:4823:5007:7903:10004:10400:10848:11658:11914:12043:12049:12438:12555:12760:12986:13069:13311:13357:13439:14181:14394:14659:14721:21080:21221:21627:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: robin41_6a012f4d67f4e
X-Filterd-Recvd-Size: 1734
Message-ID: <1522275726.2210.12.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for assignment at start of line
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 28 Mar 2018 15:22:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel style seems to prefer line wrapping an assignment
with the assignment operator on the previous line like:

	<leading tabs>	identifier =
				expression;
over
	<leading tabs>	identifier
				= expression;

somewhere around a 50:1 ratio

$ git grep -P "[^=]=\s*$" -- "*.[ch]" | wc -l
52008
$ git grep -P "^\s+[\*\/\+\|\%\-]?=[^=>]" | wc -l
1161

So add a --strict test for that condition.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5fe361e1ed5e..af2b73f19605 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3062,6 +3062,12 @@ sub process {
 			}
 		}
 
+# check for assignments on the start of a line
+		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
+			CHK("ASSIGNMENT_CONTINUATIONS",
+			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
+		}
+
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
 			CHK("LOGICAL_CONTINUATIONS",
