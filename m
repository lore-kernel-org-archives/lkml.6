Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBBDxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:53:39 -0500
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:37864 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751557AbeBBDxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:53:33 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:968:973:982:988:989:1260:1345:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3874:4321:5007:6261:7903:10004:10848:11026:11658:11914:12043:12296:12555:12663:12679:12895:13069:13095:13221:13229:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30054:30064,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: shock62_58fb6a37d3b06
X-Filterd-Recvd-Size: 2047
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc: Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Improve OPEN_BRACE test
Date: Thu,  1 Feb 2018 19:53:29 -0800
Message-Id: <db9b772999d1d2fbda3b9ee24bbca81a87837e13.1517543491.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some structure definitions that use macros trip the OPEN_BRACE test.

e.g. +struct bpf_map_def SEC("maps") control_map = {

Improve the test by using $balanced_parens instead of a .*

Miscellanea:

o Use $sline so any comments are ignored
o Correct the message output from declaration to definition
o Remove unnecessary parentheses

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Song Liu <songliubraving@fb.com>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78e7a310af46..3d4040322ae1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3919,10 +3919,12 @@ sub process {
 
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
-		if (($line=~/$Type\s*$Ident\(.*\).*\s*{/) and
-		    !($line=~/\#\s*define.*do\s\{/) and !($line=~/}/)) {
+		if ($^V && $^V ge 5.10.0 &&
+		    $sline =~ /$Type\s*$Ident\s*$balanced_parens\s*\{/ &&
+		    $sline !~ /\#\s*define\b.*do\s*\{/ &&
+		    $sline !~ /}/) {
 			if (ERROR("OPEN_BRACE",
-				  "open brace '{' following function declarations go on the next line\n" . $herecurr) &&
+				  "open brace '{' following function definitions go on the next line\n" . $herecurr) &&
 			    $fix) {
 				fix_delete_line($fixlinenr, $rawline);
 				my $fixed_line = $rawline;
-- 
2.15.0
