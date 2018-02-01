Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBAXP7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:15:59 -0500
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:38971 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751544AbeBAXPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:15:55 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:4250:4321:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12438:12555:12663:12740:12760:12895:13069:13255:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21611:21627:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: slip63_8ac5d8401ba15
X-Filterd-Recvd-Size: 2262
Message-ID: <1517526952.7489.85.camel@perches.com>
Subject: Re: False positive of "open brace '{' following function
 declarations" in checkpatch.pl
From: Joe Perches <joe@perches.com>
To: Song Liu <songliubraving@fb.com>, Andy Whitcroft <apw@canonical.com>
Cc: Kernel Team <Kernel-team@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 01 Feb 2018 15:15:52 -0800
In-Reply-To: <01433B62-D050-4A86-83AB-485BB0FA2F3D@fb.com>
References: <01433B62-D050-4A86-83AB-485BB0FA2F3D@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 22:50 +0000, Song Liu wrote:
> Hi Andy and Joe, 
> 
> I am getting the following ERROR from check patch.pl:
> 
> ERROR: open brace '{' following function declarations go on the next line
> #235: FILE: tools/testing/selftests/bpf/test_stacktrace_map_build_id_offset.c:11:
> +struct bpf_map_def SEC("maps") control_map = {
> 
> 
> I guess it treats SEC("maps") as a function. But it is actually struct:
> 
> struct bpf_map_def SEC("maps") control_map = {
>         .type = BPF_MAP_TYPE_ARRAY,
>         .key_size = sizeof(__u32),
>         .value_size = sizeof(__u32),
>         .max_entries = 1,
> };

This seems to work better:
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78e7a310af46..b6a0da9c7de7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3919,8 +3919,10 @@ sub process {
 
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
-		if (($line=~/$Type\s*$Ident\(.*\).*\s*{/) and
-		    !($line=~/\#\s*define.*do\s\{/) and !($line=~/}/)) {
+		if ($^V && $^V ge 5.10.0 &&
+		    ($sline =~ /$Type\s*$Ident\s*$balanced_parens\s*{/) &&
+		    !($sline =~ /\#\s*define\b.*do\s*\{/) &&
+		    $sline !~ /}/) {
 			if (ERROR("OPEN_BRACE",
 				  "open brace '{' following function declarations go on the next line\n" . $herecurr) &&
 			    $fix) {
