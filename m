Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CC5218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbeLUR6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbeLUR45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:57 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE3321920;
        Fri, 21 Dec 2018 17:56:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2d-0002GN-CO; Fri, 21 Dec 2018 12:56:55 -0500
Message-Id: <20181221175618.968519903@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 00/24] tracing: Updates for the next (coming soon) merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 05cd667ce570cb82a967af7166c54c610324861c


Mathieu Malaterre (1):
      tracing: Make function ‘ftrace_exports’ static

Michael Ellerman (2):
      seq_buf: Make seq_buf_puts() null-terminate the buffer
      seq_buf: Use size_t for len in seq_buf_puts()

Rasmus Villemoes (3):
      tracing: Merge seq_print_sym_short() and seq_print_sym_offset()
      tracing: Avoid -Wformat-nonliteral warning
      tracing: Simplify printf'ing in seq_print_sym

Steven Rostedt (1):
      string.h: Add strncmp_prefix() helper macro

Steven Rostedt (VMware) (10):
      ftrace: Allow ftrace_replace_code() to be schedulable
      arm64: ftrace: Set FTRACE_MAY_SLEEP before ftrace_modify_all_code()
      fgraph: Add comment to describe ftrace_graph_get_ret_stack
      x86/ftrace: Do not call function graph from dynamic trampolines
      powerpc/frace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      tracing: Fix ftrace_graph_get_ret_stack() to use task and not current
      tracing: Use strncmp_prefix() helper for histogram code

Tom Zanussi (7):
      tracing: Remove unnecessary hist trigger struct field
      tracing: Change strlen to sizeof for hist trigger static strings
      tracing: Use var_refs[] for hist trigger reference checking
      tracing: Remove open-coding of hist trigger var_ref management
      tracing: Use hist trigger's var_ref array to destroy var_refs
      tracing: Remove hist trigger synth_var_refs
      tracing: Add hist trigger comments for variable-related fields

----
 arch/arm64/kernel/ftrace.c         |   1 +
 arch/arm64/kernel/perf_callchain.c |   2 +-
 arch/arm64/kernel/process.c        |   2 +-
 arch/arm64/kernel/return_address.c |   2 +-
 arch/arm64/kernel/stacktrace.c     |  12 +-
 arch/arm64/kernel/time.c           |   2 +-
 arch/arm64/kernel/traps.c          |   2 +-
 arch/powerpc/kernel/process.c      |  13 +-
 arch/sh/kernel/dumpstack.c         |  11 +-
 arch/sh/kernel/dwarf.c             |   9 +-
 arch/sparc/kernel/perf_event.c     |   8 +-
 arch/sparc/kernel/stacktrace.c     |   8 +-
 arch/sparc/kernel/traps_64.c       |   7 +-
 arch/x86/kernel/ftrace.c           |  41 +++---
 arch/x86/kernel/ftrace_64.S        |   8 +-
 include/linux/ftrace.h             |   1 +
 include/linux/string.h             |  22 +++
 kernel/trace/fgraph.c              |  15 +-
 kernel/trace/ftrace.c              |  19 ++-
 kernel/trace/trace.c               |   2 +-
 kernel/trace/trace_events_hist.c   | 278 +++++++++++++++++++++----------------
 kernel/trace/trace_output.c        |  38 ++---
 lib/seq_buf.c                      |   8 +-
 23 files changed, 301 insertions(+), 210 deletions(-)
