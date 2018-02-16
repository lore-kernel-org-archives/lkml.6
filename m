Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeBPVO2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:14:28 -0500
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:49337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750727AbeBPVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:14:26 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:334:355:368:369:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2110:2376:2393:2553:2559:2562:2828:2908:2911:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4425:4605:5007:6609:7875:7903:7974:8531:10004:10848:11026:11232:11658:11914:12663:12740:12760:12895:13439:14096:14097:14180:14181:14659:14721:21080:21324:21433:21451:21611:21627:30012:30054:30070:30089:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: apple90_60abaa8b8ce61
X-Filterd-Recvd-Size: 5514
Message-ID: <1518815662.13169.27.camel@perches.com>
Subject: Re: [PATCH 0/3] Improve and extend checkpatch.pl Kconfig help text
 checks
From: Joe Perches <joe@perches.com>
To: Ulf Magnusson <ulfalizer@gmail.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Date: Fri, 16 Feb 2018 13:14:22 -0800
In-Reply-To: <20180216202255.25307-1-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 21:22 +0100, Ulf Magnusson wrote:
> Hello,
> 
> This patchset contains some improvements for the Kconfig help text check in
> scripts/checkconfig.pl:

Seems sensible enough to me.
Signed-off-by: Joe Perches <joe@perches.com>

>  - Commits 1 and 2 make the check more robust by checking menuconfig symbols
>    and choices as well as symbols defined with 'config', and by making the
>    detection of definition boundaries more reliable.
> 
>  - Commit 3 adds a check for new '---help---'s being introduced. IMO, 'help'
>    should be encouraged in new code.
> 
> All three commits can be applied independently.
> 
> The existing code is a bit weird in that it doesn't require symbols with "long"
> definitions (e.g., many selects) to have help texts. Fixing that is outside the
> scope of this patchset. I couldn't tell if it was deliberate.
> 
> I'm a Perl noob, so check for bad practices. :)

Everyone is.  Seems fine.

> The changes were tested by running 'checkpatch.pl -f' on some large existing
> Kconfig files in the kernel and looking for false positives (e.g.
> arch/{x86,arm}/Kconfig).
> 
> This test file was also used, which contains some cases that confused the old
> code:
> 
> 	config BAD_1
> 		bool "bad 1"
> 	
> 	config BAD_2
> 		bool 'bad 2'
> 	
> 	config BAD_3
> 		bool "bad 3"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	menuconfig BAD_4
> 		bool "bad 4"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	config BAD_5
> 		bool
> 		prompt "bad 5"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	config BAD_6
> 		bool "bad 6"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	if FOO
> 	
> 	config BAD_7
> 		bool "bad 7"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	endif
> 	
> 	config BAD_8
> 		bool "bad 8"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	source "foo"
> 	
> 	config BAD_9
> 		bool "bad 9"
> 		---help---
> 		  1
> 		  2
> 		  3
> 		  4
> 	
> 	choice
> 		bool "bad choice"
> 		help
> 		  1
> 		  2
> 		  3
> 	
> 	endchoice
> 	
> 	config OK_1
> 		bool
> 	
> 	config OK_2
> 		bool "ok 2"
> 		help
> 		  1
> 		  2
> 		  3
> 		  4
> 	
> 	config OK_3
> 		tristate "ok 3"
> 		help
> 		  1
> 		  2
> 		  3
> 		  4
> 	
> 	config OK_4
> 		tristate
> 		prompt "ok 4"
> 		help
> 		  1
> 		  2
> 		  3
> 		  4
> 	
> 	choice
> 		bool "ok choice"
> 		help
> 		  1
> 		  2
> 		  3
> 		  4
> 	
> 	endchoice
> 
> 
> This now produces the following warnings:
> 
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#9: FILE: Kconfig.test_help_check:9:
> 	+config BAD_1
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#12: FILE: Kconfig.test_help_check:12:
> 	+config BAD_2
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#15: FILE: Kconfig.test_help_check:15:
> 	+config BAD_3
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#22: FILE: Kconfig.test_help_check:22:
> 	+menuconfig BAD_4
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#29: FILE: Kconfig.test_help_check:29:
> 	+config BAD_5
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#37: FILE: Kconfig.test_help_check:37:
> 	+config BAD_6
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#46: FILE: Kconfig.test_help_check:46:
> 	+config BAD_7
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#55: FILE: Kconfig.test_help_check:55:
> 	+config BAD_8
> 	
> 	WARNING: prefer 'help' over '---help---' for new help texts
> 	#64: FILE: Kconfig.test_help_check:64:
> 	+config BAD_9
> 	
> 	WARNING: please write a paragraph that describes the config symbol fully
> 	#72: FILE: Kconfig.test_help_check:72:
> 	+choice
> 	
> 	total: 0 errors, 10 warnings, 117 lines checked
> 	
> 	NOTE: For some of the reported defects, checkpatch may be able to
> 	      mechanically convert to the typical style using --fix or --fix-inplace.
> 	
> 	Kconfig.test_help_check has style problems, please review.
> 	
> 	NOTE: If any of the errors are false positives, please report
> 	      them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> Cheers,
> Ulf
> 
> Ulf Magnusson (3):
>   checkpatch: kconfig: recognize more prompts when checking help texts
>   checkpatch: kconfig: check help texts for menuconfig and choice
>   checkpatch: kconfig: prefer 'help' over '---help---'
> 
>  scripts/checkpatch.pl | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
