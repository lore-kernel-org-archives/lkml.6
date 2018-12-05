Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B606620892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B606620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeLEXvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLEXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:30 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E8C520645;
        Wed,  5 Dec 2018 23:48:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu4-00005Q-Er; Wed, 05 Dec 2018 18:48:28 -0500
Message-Id: <20181205234749.372720574@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [for-next][PATCH 00/30] tracing: Updates for the next merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note, I still have more in my queue that need to go through testing.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: e007f5165a2e366579324062a69e56236a97fad3


Dan Carpenter (1):
      tracing: Have trace_stack nr_entries compare not be so subtle

Joe Lawrence (1):
      scripts/recordmcount.{c,pl}: support -ffunction-sections .text.* section names

Masami Hiramatsu (11):
      tracing/uprobes: Add busy check when cleanup all uprobes
      tracing: Lock event_mutex before synth_event_mutex
      tracing: Simplify creation and deletion of synthetic events
      tracing: Integrate similar probe argument parsers
      tracing: Add unified dynamic event framework
      tracing/kprobes: Use dyn_event framework for kprobe events
      tracing/uprobes: Use dyn_event framework for uprobe events
      tracing: Use dyn_event framework for synthetic events
      tracing: Remove unneeded synth_event_mutex
      tracing: Add generic event-name based remove event method
      selftests/ftrace: Add testcases for dynamic event

Steven Rostedt (VMware) (17):
      function_graph: Remove unused task_curr_ret_stack()
      tracing: Do not line wrap short line in function_graph_enter()
      fgraph: Create a fgraph.c file to store function graph infrastructure
      fgraph: Have set_graph_notrace only affect function_graph tracer
      arm64: function_graph: Remove use of FTRACE_NOTRACE_DEPTH
      function_graph: Remove the use of FTRACE_NOTRACE_DEPTH
      ftrace: Create new ftrace_internal.h header
      function_graph: Do not expose the graph_time option when profiler is not configured
      fgraph: Move function graph specific code into fgraph.c
      tracing: Rearrange functions in trace_sched_wakeup.c
      fgraph: Add new fgraph_ops structure to enable function graph hooks
      function_graph: Move ftrace_graph_ret_addr() to fgraph.c
      function_graph: Have profiler use new helper ftrace_graph_get_ret_stack()
      ring-buffer: Add percentage of ring buffer full to wake up reader
      tracing: Add tracefs file buffer_percentage
      tracing: Change default buffer_percent to 50
      tracing: Consolidate trace_add/remove_event_call back to the nolock functions

----
 Documentation/trace/kprobetrace.rst                |   3 +
 Documentation/trace/uprobetracer.rst               |   4 +
 arch/arm64/kernel/stacktrace.c                     |   3 -
 include/linux/ftrace.h                             |  35 +-
 include/linux/ring_buffer.h                        |   4 +-
 kernel/trace/Kconfig                               |   6 +
 kernel/trace/Makefile                              |   2 +
 kernel/trace/fgraph.c                              | 615 +++++++++++++++++++++
 kernel/trace/ftrace.c                              | 471 ++--------------
 kernel/trace/ftrace_internal.h                     |  75 +++
 kernel/trace/ring_buffer.c                         |  94 +++-
 kernel/trace/trace.c                               |  72 ++-
 kernel/trace/trace.h                               |  13 +
 kernel/trace/trace_dynevent.c                      | 217 ++++++++
 kernel/trace/trace_dynevent.h                      | 119 ++++
 kernel/trace/trace_events.c                        |   8 +-
 kernel/trace/trace_events_hist.c                   | 316 ++++++-----
 kernel/trace/trace_functions_graph.c               | 334 ++---------
 kernel/trace/trace_irqsoff.c                       |  18 +-
 kernel/trace/trace_kprobe.c                        | 353 ++++++------
 kernel/trace/trace_probe.c                         |  74 ++-
 kernel/trace/trace_probe.h                         |   9 +-
 kernel/trace/trace_sched_wakeup.c                  | 270 +++++----
 kernel/trace/trace_selftest.c                      |   8 +-
 kernel/trace/trace_stack.c                         |   2 +-
 kernel/trace/trace_uprobe.c                        | 301 +++++-----
 scripts/recordmcount.c                             |   2 +-
 scripts/recordmcount.pl                            |  13 +
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  30 +
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |  27 +
 .../ftrace/test.d/dynevent/clear_select_events.tc  |  50 ++
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |  49 ++
 32 files changed, 2176 insertions(+), 1421 deletions(-)
 create mode 100644 kernel/trace/fgraph.c
 create mode 100644 kernel/trace/ftrace_internal.h
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
