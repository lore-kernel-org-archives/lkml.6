Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2956C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829F121841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBTSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfBTSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BDA21848;
        Wed, 20 Feb 2019 18:38:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkt-0006aE-0q; Wed, 20 Feb 2019 13:38:03 -0500
Message-Id: <20190220183802.911843633@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 01/29] function_graph: Support displaying relative timestamp
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

When function_graph is used for latency tracers, relative timestamp
is more straightforward than absolute timestamp as function trace
does. This change adds relative timestamp support to function_graph
and applies to latency tracers (wakeup and irqsoff).

Instead of:

 # tracer: irqsoff
 #
 # irqsoff latency trace v1.1.5 on 5.0.0-rc1-test
 # --------------------------------------------------------------------
 # latency: 521 us, #1125/1125, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:8)
 #    -----------------
 #    | task: swapper/2-0 (uid:0 nice:0 policy:0 rt_prio:0)
 #    -----------------
 #  => started at: __schedule
 #  => ended at:   _raw_spin_unlock_irq
 #
 #
 #                                       _-----=> irqs-off
 #                                      / _----=> need-resched
 #                                     | / _---=> hardirq/softirq
 #                                     || / _--=> preempt-depth
 #                                     ||| /
 #     TIME        CPU  TASK/PID       ||||  DURATION                  FUNCTION CALLS
 #      |          |     |    |        ||||   |   |                     |   |   |   |
   124.974306 |   2)  systemd-693   |  d..1  0.000 us    |  __schedule();
   124.974307 |   2)  systemd-693   |  d..1              |    rcu_note_context_switch() {
   124.974308 |   2)  systemd-693   |  d..1  0.487 us    |      rcu_preempt_deferred_qs();
   124.974309 |   2)  systemd-693   |  d..1  0.451 us    |      rcu_qs();
   124.974310 |   2)  systemd-693   |  d..1  2.301 us    |    }
[..]
   124.974826 |   2)    <idle>-0    |  d..2              |  finish_task_switch() {
   124.974826 |   2)    <idle>-0    |  d..2              |    _raw_spin_unlock_irq() {
   124.974827 |   2)    <idle>-0    |  d..2  0.000 us    |  _raw_spin_unlock_irq();
   124.974828 |   2)    <idle>-0    |  d..2  0.000 us    |  tracer_hardirqs_on();
   <idle>-0       2d..2  552us : <stack trace>
  => __schedule
  => schedule_idle
  => do_idle
  => cpu_startup_entry
  => start_secondary
  => secondary_startup_64

Show:

 # tracer: irqsoff
 #
 # irqsoff latency trace v1.1.5 on 5.0.0-rc1-test+
 # --------------------------------------------------------------------
 # latency: 511 us, #1053/1053, CPU#7 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:8)
 #    -----------------
 #    | task: swapper/7-0 (uid:0 nice:0 policy:0 rt_prio:0)
 #    -----------------
 #  => started at: __schedule
 #  => ended at:   _raw_spin_unlock_irq
 #
 #
 #                                       _-----=> irqs-off
 #                                      / _----=> need-resched
 #                                     | / _---=> hardirq/softirq
 #                                     || / _--=> preempt-depth
 #                                     ||| /
 #   REL TIME      CPU  TASK/PID       ||||  DURATION                  FUNCTION CALLS
 #      |          |     |    |        ||||   |   |                     |   |   |   |
         0 us |   7)   sshd-1704    |  d..1  0.000 us    |  __schedule();
         1 us |   7)   sshd-1704    |  d..1              |    rcu_note_context_switch() {
         1 us |   7)   sshd-1704    |  d..1  0.611 us    |      rcu_preempt_deferred_qs();
         2 us |   7)   sshd-1704    |  d..1  0.484 us    |      rcu_qs();
         3 us |   7)   sshd-1704    |  d..1  2.599 us    |    }
[..]
       509 us |   7)    <idle>-0    |  d..2              |  finish_task_switch() {
       510 us |   7)    <idle>-0    |  d..2              |    _raw_spin_unlock_irq() {
       510 us |   7)    <idle>-0    |  d..2  0.000 us    |  _raw_spin_unlock_irq();
       512 us |   7)    <idle>-0    |  d..2  0.000 us    |  tracer_hardirqs_on();
   <idle>-0       7d..2  543us : <stack trace>
  => __schedule
  => schedule_idle
  => do_idle
  => cpu_startup_entry
  => start_secondary
  => secondary_startup_64

Link: http://lkml.kernel.org/r/20190101154614.8887-2-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                 |  9 +++++----
 kernel/trace/trace_functions_graph.c | 25 +++++++++++++++++++++++++
 kernel/trace/trace_irqsoff.c         |  2 +-
 kernel/trace/trace_sched_wakeup.c    |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..a34fa5e76abb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -855,10 +855,11 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_PROC          0x8
 #define TRACE_GRAPH_PRINT_DURATION      0x10
 #define TRACE_GRAPH_PRINT_ABS_TIME      0x20
-#define TRACE_GRAPH_PRINT_IRQS          0x40
-#define TRACE_GRAPH_PRINT_TAIL          0x80
-#define TRACE_GRAPH_SLEEP_TIME		0x100
-#define TRACE_GRAPH_GRAPH_TIME		0x200
+#define TRACE_GRAPH_PRINT_REL_TIME      0x40
+#define TRACE_GRAPH_PRINT_IRQS          0x80
+#define TRACE_GRAPH_PRINT_TAIL          0x100
+#define TRACE_GRAPH_SLEEP_TIME          0x200
+#define TRACE_GRAPH_GRAPH_TIME          0x400
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c2af1560e856..16ebbdd7b22e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -500,6 +500,17 @@ static void print_graph_abs_time(u64 t, struct trace_seq *s)
 			 (unsigned long)t, usecs_rem);
 }
 
+static void
+print_graph_rel_time(struct trace_iterator *iter, struct trace_seq *s)
+{
+	unsigned long long usecs;
+
+	usecs = iter->ts - iter->trace_buffer->time_start;
+	do_div(usecs, NSEC_PER_USEC);
+
+	trace_seq_printf(s, "%9llu us |  ", usecs);
+}
+
 static void
 print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		enum trace_type type, int cpu, pid_t pid, u32 flags)
@@ -517,6 +528,10 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 			print_graph_abs_time(iter->ts, s);
 
+		/* Relative time */
+		if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+			print_graph_rel_time(iter, s);
+
 		/* Cpu */
 		if (flags & TRACE_GRAPH_PRINT_CPU)
 			print_graph_cpu(s, cpu);
@@ -725,6 +740,10 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		print_graph_abs_time(iter->ts, s);
 
+	/* Relative time */
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		print_graph_rel_time(iter, s);
+
 	/* Cpu */
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		print_graph_cpu(s, cpu);
@@ -1101,6 +1120,8 @@ static void print_lat_header(struct seq_file *s, u32 flags)
 
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		size += 16;
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		size += 16;
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		size += 4;
 	if (flags & TRACE_GRAPH_PRINT_PROC)
@@ -1125,6 +1146,8 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	seq_putc(s, '#');
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		seq_puts(s, "     TIME       ");
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		seq_puts(s, "   REL TIME     ");
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		seq_puts(s, " CPU");
 	if (flags & TRACE_GRAPH_PRINT_PROC)
@@ -1139,6 +1162,8 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	seq_putc(s, '#');
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		seq_puts(s, "      |         ");
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		seq_puts(s, "      |         ");
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		seq_puts(s, " |  ");
 	if (flags & TRACE_GRAPH_PRINT_PROC)
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d3294721f119..e6a62e7c6b69 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -238,7 +238,7 @@ static void irqsoff_trace_close(struct trace_iterator *iter)
 
 #define GRAPH_TRACER_FLAGS (TRACE_GRAPH_PRINT_CPU | \
 			    TRACE_GRAPH_PRINT_PROC | \
-			    TRACE_GRAPH_PRINT_ABS_TIME | \
+			    TRACE_GRAPH_PRINT_REL_TIME | \
 			    TRACE_GRAPH_PRINT_DURATION)
 
 static enum print_line_t irqsoff_print_line(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 4ea7e6845efb..b6c5fa10347e 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -180,7 +180,7 @@ static void wakeup_trace_close(struct trace_iterator *iter)
 }
 
 #define GRAPH_TRACER_FLAGS (TRACE_GRAPH_PRINT_PROC | \
-			    TRACE_GRAPH_PRINT_ABS_TIME | \
+			    TRACE_GRAPH_PRINT_REL_TIME | \
 			    TRACE_GRAPH_PRINT_DURATION)
 
 static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
-- 
2.20.1


