Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E57C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBC321A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBC321A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHKQY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKQY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163AA217AE;
        Sat, 11 Aug 2018 13:50:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHS-0005zF-Vz; Sat, 11 Aug 2018 09:50:11 -0400
Message-Id: <20180811134928.034373761@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/34] tracing: My official queue finally passed testing and ready for linux-next
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: f8a79d5c7ef47c62d97a30e16064caf2ef91f648


Colin Ian King (1):
      ftrace: Remove unused pointer ftrace_swapper_pid

Erica Bugden (1):
      ftrace: Add missing check for existing hwlat thread

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Gustavo A. R. Silva (1):
      ftrace: Use true and false for boolean values in ops_references_rec()

Joel Fernandes (Google) (9):
      srcu: Add notrace variant of srcu_dereference
      tracing/irqsoff: Split reset into separate functions
      lib: Add module for testing preemptoff/irqsoff latency tracers
      kselftests: Add tests for the preemptoff and irqsoff tracers
      lockdep: Use this_cpu_ptr instead of get_cpu_var stats
      tracepoint: Make rcuidle tracepoint callers use SRCU
      tracing: Centralize preemptirq tracepoints and unify their usage
      trace: Use rcu_dereference_raw for hooks from trace-event subsystem
      tracing: irqsoff: Account for additional preempt_disable

Masami Hiramatsu (5):
      tracing: Remove orphaned function using_ftrace_ops_list_func().
      tracing: Remove orphaned function ftrace_nr_registered_ops()
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function
      tracing/kprobes: Fix within_notrace_func() to check only notrace functions

Paul McKenney (1):
      srcu: Add notrace variants of srcu_read_{lock,unlock}

Steven Rostedt (VMware) (13):
      tracing: Make unregister_trigger() static
      tracing/kprobes: Simplify the logic of enable_trace_kprobe()
      tracing: Do not call start/stop() functions when tracing_on does not change
      tracing: Do a WARN_ON() if start_thread() in hwlat is called when thread exists
      tracing: Make tracer_tracing_is_on() return bool
      ring-buffer: Make ring_buffer_record_is_on() return bool
      ring-buffer: Make ring_buffer_record_is_set_on() return bool
      tracing: Partial revert of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing/irqsoff: Handle preempt_count for different configs
      tracing: More reverting of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing: Fix synchronizing to event changes with tracepoint_synchronize_unregister()
      uprobes: Use synchronize_rcu() not synchronize_sched()
      tracepoints: Free early tracepoints after RCU is initialized

Zubin Mithra (1):
      tracefs: Annotate tracefs_ops with __ro_after_init

kbuild test robot (1):
      tracing: preemptirq_delay_run() can be static

----
 fs/tracefs/inode.c                                 |   5 +-
 include/linux/ftrace.h                             |  17 +-
 include/linux/irqflags.h                           |  15 +-
 include/linux/lockdep.h                            |   6 +-
 include/linux/preempt.h                            |   2 +-
 include/linux/ring_buffer.h                        |   4 +-
 include/linux/srcu.h                               |  22 ++
 include/linux/tracepoint.h                         |  40 ++-
 include/trace/events/preemptirq.h                  |  23 +-
 init/main.c                                        |   3 +-
 kernel/locking/lockdep.c                           |  35 +--
 kernel/sched/core.c                                |   2 +-
 kernel/trace/Kconfig                               |  57 ++++-
 kernel/trace/Makefile                              |   8 +-
 kernel/trace/ftrace.c                              |  41 +---
 kernel/trace/preemptirq_delay_test.c               |  72 ++++++
 kernel/trace/ring_buffer.c                         |   4 +-
 kernel/trace/trace.c                               |   6 +-
 kernel/trace/trace.h                               |  21 +-
 kernel/trace/trace_events.c                        |  12 +-
 kernel/trace/trace_events_filter.c                 |  15 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_trigger.c                |  12 +-
 kernel/trace/trace_hwlat.c                         |   3 +
 kernel/trace/trace_irqsoff.c                       | 269 +++++++--------------
 kernel/trace/trace_kprobe.c                        | 103 +++++---
 kernel/trace/trace_kprobe_selftest.c               |  10 +
 kernel/trace/trace_kprobe_selftest.h               |   7 +
 kernel/trace/trace_preemptirq.c                    |  89 +++++++
 kernel/trace/trace_uprobe.c                        |   2 +-
 kernel/tracepoint.c                                |  48 +++-
 tools/testing/selftests/ftrace/config              |   3 +
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  30 +--
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   2 +-
 .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |  73 ++++++
 35 files changed, 670 insertions(+), 393 deletions(-)
 create mode 100644 kernel/trace/preemptirq_delay_test.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h
 create mode 100644 kernel/trace/trace_preemptirq.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
