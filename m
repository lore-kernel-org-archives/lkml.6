Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750824AbeBPUX2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:23:28 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41933 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:23:26 -0500
X-Google-Smtp-Source: AH8x227jFX/2dDdocUv3ZAjVVtoFGv7cIYKw35TTObwiGpz96TPovlD2Kbv/kqrcynEa6lJax7MKjg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: apw@canonical.com, joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 0/3] Improve and extend checkpatch.pl Kconfig help text checks
Date: Fri, 16 Feb 2018 21:22:52 +0100
Message-Id: <20180216202255.25307-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset contains some improvements for the Kconfig help text check in
scripts/checkconfig.pl:

 - Commits 1 and 2 make the check more robust by checking menuconfig symbols
   and choices as well as symbols defined with 'config', and by making the
   detection of definition boundaries more reliable.

 - Commit 3 adds a check for new '---help---'s being introduced. IMO, 'help'
   should be encouraged in new code.

All three commits can be applied independently.

The existing code is a bit weird in that it doesn't require symbols with "long"
definitions (e.g., many selects) to have help texts. Fixing that is outside the
scope of this patchset. I couldn't tell if it was deliberate.

I'm a Perl noob, so check for bad practices. :)

The changes were tested by running 'checkpatch.pl -f' on some large existing
Kconfig files in the kernel and looking for false positives (e.g.
arch/{x86,arm}/Kconfig).

This test file was also used, which contains some cases that confused the old
code:

	config BAD_1
		bool "bad 1"
	
	config BAD_2
		bool 'bad 2'
	
	config BAD_3
		bool "bad 3"
		help
		  1
		  2
		  3
	
	menuconfig BAD_4
		bool "bad 4"
		help
		  1
		  2
		  3
	
	config BAD_5
		bool
		prompt "bad 5"
		help
		  1
		  2
		  3
	
	config BAD_6
		bool "bad 6"
		help
		  1
		  2
		  3
	
	if FOO
	
	config BAD_7
		bool "bad 7"
		help
		  1
		  2
		  3
	
	endif
	
	config BAD_8
		bool "bad 8"
		help
		  1
		  2
		  3
	
	source "foo"
	
	config BAD_9
		bool "bad 9"
		---help---
		  1
		  2
		  3
		  4
	
	choice
		bool "bad choice"
		help
		  1
		  2
		  3
	
	endchoice
	
	config OK_1
		bool
	
	config OK_2
		bool "ok 2"
		help
		  1
		  2
		  3
		  4
	
	config OK_3
		tristate "ok 3"
		help
		  1
		  2
		  3
		  4
	
	config OK_4
		tristate
		prompt "ok 4"
		help
		  1
		  2
		  3
		  4
	
	choice
		bool "ok choice"
		help
		  1
		  2
		  3
		  4
	
	endchoice


This now produces the following warnings:

	WARNING: please write a paragraph that describes the config symbol fully
	#9: FILE: Kconfig.test_help_check:9:
	+config BAD_1
	
	WARNING: please write a paragraph that describes the config symbol fully
	#12: FILE: Kconfig.test_help_check:12:
	+config BAD_2
	
	WARNING: please write a paragraph that describes the config symbol fully
	#15: FILE: Kconfig.test_help_check:15:
	+config BAD_3
	
	WARNING: please write a paragraph that describes the config symbol fully
	#22: FILE: Kconfig.test_help_check:22:
	+menuconfig BAD_4
	
	WARNING: please write a paragraph that describes the config symbol fully
	#29: FILE: Kconfig.test_help_check:29:
	+config BAD_5
	
	WARNING: please write a paragraph that describes the config symbol fully
	#37: FILE: Kconfig.test_help_check:37:
	+config BAD_6
	
	WARNING: please write a paragraph that describes the config symbol fully
	#46: FILE: Kconfig.test_help_check:46:
	+config BAD_7
	
	WARNING: please write a paragraph that describes the config symbol fully
	#55: FILE: Kconfig.test_help_check:55:
	+config BAD_8
	
	WARNING: prefer 'help' over '---help---' for new help texts
	#64: FILE: Kconfig.test_help_check:64:
	+config BAD_9
	
	WARNING: please write a paragraph that describes the config symbol fully
	#72: FILE: Kconfig.test_help_check:72:
	+choice
	
	total: 0 errors, 10 warnings, 117 lines checked
	
	NOTE: For some of the reported defects, checkpatch may be able to
	      mechanically convert to the typical style using --fix or --fix-inplace.
	
	Kconfig.test_help_check has style problems, please review.
	
	NOTE: If any of the errors are false positives, please report
	      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Cheers,
Ulf

Ulf Magnusson (3):
  checkpatch: kconfig: recognize more prompts when checking help texts
  checkpatch: kconfig: check help texts for menuconfig and choice
  checkpatch: kconfig: prefer 'help' over '---help---'

 scripts/checkpatch.pl | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.14.1
