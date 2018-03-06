Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeCFRPF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:15:05 -0500
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:50419 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753713AbeCFRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:15:04 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1345:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:2689:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3871:4321:5007:6261:10004:10848:11026:11658:11914:12043:12296:12555:12679:12895:12986:13069:13161:13221:13229:13311:13357:14181:14384:14394:14721:21080:21627:30054:30064:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: unit03_4913a697bef10
X-Filterd-Recvd-Size: 2032
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Improve get_quoted_string for TRACE_EVENT macros
Date: Tue,  6 Mar 2018 09:14:58 -0800
Message-Id: <9e9725342ca3dfc0f5e3e0b8ca3c482b0e5712cc.1520356392.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_quoted_string function does not expect invalid arguments.

The $stat test can return non-statements for complicated macros
like TRACE_EVENT.

Allow the $stat block and test for vsprintf misuses to exceed
the actual block lenght and possibly test invalid lines by
validating the arguments of get_quoted_string.

return "" if either get_quoted_string argument is undefined.

Miscellanea:

o Properly align the comment for the vsprintf extension test

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Chuck Lever <chuck.lever@oracle.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 16e542f4e027..5a6cef8f2376 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1298,6 +1298,7 @@ sub sanitise_line {
 sub get_quoted_string {
 	my ($line, $rawline) = @_;
 
+	return "" if (!defined($line) || !defined($rawline));
 	return "" if ($line !~ m/($String)/g);
 	return substr($rawline, $-[0], $+[0] - $-[0]);
 }
@@ -5817,7 +5818,7 @@ sub process {
 			}
 		}
 
-		# check for vsprintf extension %p<foo> misuses
+# check for vsprintf extension %p<foo> misuses
 		if ($^V && $^V ge 5.10.0 &&
 		    defined $stat &&
 		    $stat =~ /^\+(?![^\{]*\{\s*).*\b(\w+)\s*\(.*$String\s*,/s &&
-- 
2.15.0
