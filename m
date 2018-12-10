Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54FE2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54FE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeLJTeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeLJTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A731F20821;
        Mon, 10 Dec 2018 19:33:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWRJ8-0002pe-L1; Mon, 10 Dec 2018 14:33:34 -0500
Message-Id: <20181210193007.655970639@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 14:30:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/6] tracing / arch: Remove direct use of curr_ret_stack
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Folks, I'm working on rewriting the function graph tracer. In order to
do so, some changes need to be done that affect architecture specific
code. I'm only able to compile test these changes. I would like to
have folks check out my repo and give them a test.

The shadow stack of ret_stack is going to be modified to allow multiple
users of function graph tracer. It can no longer be referenced directly
as an array. A new utility "ftrace_graph_ret_stack()" is available to
get the ret_stack entry of a given frame of the shadow stack that
architectures can now use. This series converts all users to use the
new interface.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4


Steven Rostedt (VMware) (6):
      fgraph: Add comment to describe ftrace_graph_get_ret_stack
      x86/ftrace: Do not call function graph from dynamic trampolines
      powerpc/frace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack

----
 arch/arm64/kernel/perf_callchain.c |  2 +-
 arch/arm64/kernel/process.c        |  2 +-
 arch/arm64/kernel/return_address.c |  2 +-
 arch/arm64/kernel/stacktrace.c     | 12 +++++++-----
 arch/arm64/kernel/time.c           |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 arch/powerpc/kernel/process.c      | 13 +++++++++----
 arch/sh/kernel/dumpstack.c         | 11 +++++++----
 arch/sh/kernel/dwarf.c             |  9 +++++----
 arch/sparc/kernel/perf_event.c     |  8 +++++---
 arch/sparc/kernel/stacktrace.c     |  8 +++++---
 arch/sparc/kernel/traps_64.c       |  7 ++++---
 arch/x86/kernel/ftrace.c           | 40 +++++++++++++++++++++-----------------
 arch/x86/kernel/ftrace_64.S        |  8 ++++----
 kernel/trace/fgraph.c              | 11 +++++++++++
 15 files changed, 84 insertions(+), 53 deletions(-)
