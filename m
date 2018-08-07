Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA0C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E6521990
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E6521990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeHHBqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbeHHBqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:46:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E4215F9;
        Tue,  7 Aug 2018 23:29:15 +0000 (UTC)
Date:   Tue, 7 Aug 2018 19:29:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing/irqsoff: Handle preempt_count for different configs
Message-ID: <20180807192913.0ecd3640@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

I was hitting the following warning:

WARNING: CPU: 0 PID: 1 at kernel/trace/trace_irqsoff.c:631 tracer_hardirqs_off+0x15/0x2a

Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc6-test+ #13
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: tracer_hardirqs_off+0x15/0x2a
Code: ff 85 c0 74 0e 8b 45 00 8b 50 04 8b 45 04 e8 35 ff ff ff 5d c3 55 64 a1 cc 37 51 c1 a9 ff ff ff 7f 89 e5 53 89 d3 89 ca 75 02 <0f> 0b e8 90 fc ff ff 85 c0 74 07 89 d8 e8 0c ff ff ff 5b 5d c3 55
EAX: 80000000 EBX: c04337f0 ECX: c04338e3 EDX: c04338e3
ESI: c04337f0 EDI: c04338e3 EBP: f2aa1d68 ESP: f2aa1d64
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210046
CR0: 80050033 CR2: 00000000 CR3: 01668000 CR4: 001406f0
Call Trace:
 trace_irq_disable_rcuidle+0x63/0x6c
 trace_hardirqs_off+0x26/0x30
 default_send_IPI_mask_allbutself_logical+0x31/0x93
 default_send_IPI_allbutself+0x37/0x48
 native_send_call_func_ipi+0x4d/0x6a
 smp_call_function_many+0x165/0x19d
 ? add_nops+0x34/0x34
 ? trace_hardirqs_on_caller+0x2d/0x2d
 ? add_nops+0x34/0x34
 smp_call_function+0x1f/0x23
 on_each_cpu+0x15/0x43
 ? trace_hardirqs_on_caller+0x2d/0x2d
 ? trace_hardirqs_on_caller+0x2d/0x2d
 ? trace_irq_disable_rcuidle+0x1/0x6c
 text_poke_bp+0xa0/0xc2
 ? trace_hardirqs_on_caller+0x2d/0x2d
 arch_jump_label_transform+0xa7/0xcb
 ? trace_irq_disable_rcuidle+0x5/0x6c
 __jump_label_update+0x3e/0x6d
 jump_label_update+0x7d/0x81
 static_key_slow_inc_cpuslocked+0x58/0x6d
 static_key_slow_inc+0x19/0x20
 tracepoint_probe_register_prio+0x19e/0x1d1
 ? start_critical_timings+0x1c/0x1c
 tracepoint_probe_register+0xf/0x11
 irqsoff_tracer_init+0x21/0xf2
 tracer_init+0x16/0x1a
 trace_selftest_startup_irqsoff+0x25/0xc4
 run_tracer_selftest+0xca/0x131
 register_tracer+0xd5/0x172
 ? trace_event_define_fields_preemptirq_template+0x45/0x45
 init_irqsoff_tracer+0xd/0x11
 do_one_initcall+0xab/0x1e8
 ? rcu_read_lock_sched_held+0x3d/0x44
 ? trace_initcall_level+0x52/0x86
 kernel_init_freeable+0x195/0x21a
 ? rest_init+0xb4/0xb4
 kernel_init+0xd/0xe4
 ret_from_fork+0x2e/0x38

It is due to running a CONFIG_PREEMPT_VOLUNTARY kernel, which would trigger
this warning every time:

	WARN_ON_ONCE(preempt_count());

Because on CONFIG_PREEMPT_VOLUNTARY, preempt_count() is always zero.

This warning is to make sure preempt_count is set because
tracer_hardirqs_on() does a preempt_enable_notrace() to make the
preempt_trace() work properly, as being called by a trace event, the trace
event code disables preemption, and the tracer wants to know what the
preemption was before it was called.

Instead of enabling preemption like this, just record the preempt_count,
subtract PREEMPT_DISABLE_OFFSET from it (which is zero with !CONFIG_PREEMPT
set), and pass that value to the necessary functions, which should use the
passed in parameter instead of calling preempt_count() directly.

Fixes: da5b3ebb45277 ("tracing: irqsoff: Account for additional preempt_disable")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index ffbf1505d5bc..4af990e9c594 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -40,12 +40,12 @@ static int start_irqsoff_tracer(struct trace_array *tr, int graph);
 
 #ifdef CONFIG_PREEMPT_TRACER
 static inline int
-preempt_trace(void)
+preempt_trace(int pc)
 {
-	return ((trace_type & TRACER_PREEMPT_OFF) && preempt_count());
+	return ((trace_type & TRACER_PREEMPT_OFF) && pc);
 }
 #else
-# define preempt_trace() (0)
+# define preempt_trace(pc) (0)
 #endif
 
 #ifdef CONFIG_IRQSOFF_TRACER
@@ -366,7 +366,7 @@ check_critical_timing(struct trace_array *tr,
 }
 
 static inline void
-start_critical_timing(unsigned long ip, unsigned long parent_ip)
+start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
@@ -394,7 +394,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 
 	local_save_flags(flags);
 
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
+	__trace_function(tr, ip, parent_ip, flags, pc);
 
 	per_cpu(tracing_cpu, cpu) = 1;
 
@@ -402,7 +402,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 }
 
 static inline void
-stop_critical_timing(unsigned long ip, unsigned long parent_ip)
+stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
@@ -428,7 +428,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	atomic_inc(&data->disabled);
 
 	local_save_flags(flags);
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
+	__trace_function(tr, ip, parent_ip, flags, pc);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start = 0;
 	atomic_dec(&data->disabled);
@@ -437,15 +437,19 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 /* start and stop critical timings used to for stoppage (in idle) */
 void start_critical_timings(void)
 {
-	if (preempt_trace() || irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) || irq_trace())
+		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	if (preempt_trace() || irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) || irq_trace())
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 
@@ -603,40 +607,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
  */
 static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
 {
+	unsigned int pc = preempt_count();
+
 	/*
 	 * Tracepoint probes are expected to be called with preempt disabled,
 	 * We don't care about being called with preempt disabled but we need
 	 * to know in the future if that changes so we can remove the next
 	 * preempt_enable.
 	 */
-	WARN_ON_ONCE(!preempt_count());
-
-	/* Tracepoint probes disable preemption atleast once, account for that */
-	preempt_enable_notrace();
+	WARN_ON_ONCE(pc < PREEMPT_DISABLE_OFFSET);
 
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(a0, a1);
+	/* Use PREEMPT_DISABLE_OFFSET to handle !CONFIG_PREEMPT cases */
+	pc -= PREEMPT_DISABLE_OFFSET;
 
-	preempt_disable_notrace();
+	if (!preempt_trace(pc) && irq_trace())
+		stop_critical_timing(a0, a1, pc);
 }
 
 static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
 {
+	unsigned int pc = preempt_count();
+
 	/*
 	 * Tracepoint probes are expected to be called with preempt disabled,
 	 * We don't care about being called with preempt disabled but we need
 	 * to know in the future if that changes so we can remove the next
 	 * preempt_enable.
 	 */
-	WARN_ON_ONCE(!preempt_count());
-
-	/* Tracepoint probes disable preemption atleast once, account for that */
-	preempt_enable_notrace();
+	WARN_ON_ONCE(pc < PREEMPT_DISABLE_OFFSET);
 
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(a0, a1);
+	/* Use PREEMPT_DISABLE_OFFSET to handle !CONFIG_PREEMPT cases */
+	pc -= PREEMPT_DISABLE_OFFSET;
 
-	preempt_disable_notrace();
+	if (!preempt_trace(pc) && irq_trace())
+		start_critical_timing(a0, a1, pc);
 }
 
 static int irqsoff_tracer_init(struct trace_array *tr)
@@ -679,14 +683,18 @@ static struct tracer irqsoff_tracer __read_mostly =
 #ifdef CONFIG_PREEMPT_TRACER
 static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
 {
-	if (preempt_trace() && !irq_trace())
-		stop_critical_timing(a0, a1);
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) && !irq_trace())
+		stop_critical_timing(a0, a1, pc);
 }
 
 static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
 {
-	if (preempt_trace() && !irq_trace())
-		start_critical_timing(a0, a1);
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) && !irq_trace())
+		start_critical_timing(a0, a1, pc);
 }
 
 static int preemptoff_tracer_init(struct trace_array *tr)
-- 
2.13.6

