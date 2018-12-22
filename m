Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526322197D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeLVQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeLVQrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:47:13 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7054B21B6C;
        Sat, 22 Dec 2018 16:28:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gak92-0001Dz-EZ; Sat, 22 Dec 2018 11:28:56 -0500
Message-Id: <20181222162007.697862256@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 22 Dec 2018 11:20:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and usages
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hope everyone is OK with these changes. I pushed to linux-next but I'm
willing to change them if there are still issues.

They ran through all my tests, althought zero-day-bot had a weird build
regression in sh, that looks totally unrelated:

 Regressions in current branch:

 arch/sh/kernel/dwarf.c:107:26: error: 'dwarf_frame_reg' defined but not used [-Werror=unused-function]
 arch/sh/kernel/dwarf.c:1209:0: error: unterminated argument list invoking macro "WARN_ON"
 arch/sh/kernel/dwarf.c:226:12: error: 'dwarf_read_encoded_value' defined but not used [-Werror=unused-function]
 arch/sh/kernel/dwarf.c:306:26: error: 'dwarf_lookup_cie' defined but not used [-Werror=unused-function]
 arch/sh/kernel/dwarf.c:38:27: error: 'dwarf_frame_cachep' defined but not used [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:399:12: error: 'dwarf_cfa_execute_insns' defined but not used [-Werror=unused-function]
 arch/sh/kernel/dwarf.c:41:27: error: 'dwarf_reg_cachep' defined but not used [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:580:22: error: unused variable 'frame' [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:581:20: error: unused variable 'cie' [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:582:20: error: unused variable 'fde' [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:583:20: error: unused variable 'reg' [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:584:16: error: unused variable 'addr' [-Werror=unused-variable]
 arch/sh/kernel/dwarf.c:622:3: error: expected ';' at end of input
 arch/sh/kernel/dwarf.c:622:3: error: expected declaration or statement at end of input
 arch/sh/kernel/dwarf.c:622:3: error: 'WARN_ON' undeclared (first use in this function); did you mean 'WMARK_LOW'?

Pushing to my for-next branch should kick off another run. Let's see
if it reports that again. Unless someone knows why that happened?

-- Steve



  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 92b9de3e574bd874188a4e27a8830bb901a08ef8


Steven Rostedt (VMware) (5):
      string.h: Add str_has_prefix() helper function
      tracing: Use str_has_prefix() helper for histogram code
      tracing: Use str_has_prefix() instead of using fixed sizes
      tracing: Have the historgram use the result of str_has_prefix() for len of prefix
      tracing: Use the return of str_has_prefix() to remove open coded numbers

----
 include/linux/string.h           | 20 ++++++++++++++++++++
 kernel/trace/trace.c             |  8 +++++---
 kernel/trace/trace_events.c      |  2 +-
 kernel/trace/trace_events_hist.c | 35 ++++++++++++++++++-----------------
 kernel/trace/trace_probe.c       | 17 +++++++++--------
 kernel/trace/trace_stack.c       |  6 ++++--
 6 files changed, 57 insertions(+), 31 deletions(-)
