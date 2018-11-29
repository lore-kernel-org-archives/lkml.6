Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D858C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211C92086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211C92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeK2Odd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbeK2Odd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:33:33 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA45206B6;
        Thu, 29 Nov 2018 03:29:38 +0000 (UTC)
Date:   Wed, 28 Nov 2018 22:29:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Message-ID: <20181128222936.74da7f54@vmware.local.home>
In-Reply-To: <20181128160021.09acd1af@gandalf.local.home>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
        <20181128160021.09acd1af@gandalf.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 16:00:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Nov 2018 15:39:31 -0500
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
> > Hi Steve,
> > 
> > With your ftrace/urgent branch linked above, if I try a quick
> > function_graph test like the following:
> > 
> >   SYSFS=/sys/kernel/debug/tracing
> > 
> >   echo 0 > "$SYSFS/tracing_on"
> >   echo cmdline_proc_show > "$SYSFS/set_graph_function"
> >   echo function_graph > "$SYSFS/current_tracer"
> >   echo 1 > "$SYSFS/tracing_on"
> > 
> > I see a bunch of scheduler interrupt functions in the trace/trace_pipe
> > without even invoking cmdline_proc_show().
> > 
> > This tests works as expected with Linux 4.20-rc3 though:
> > 
> >   % cat /sys/kernel/debug/tracing/trace_pipe
> >    2)               |  cmdline_proc_show() {
> >    2)   0.320 us    |    seq_puts();
> >    2)   0.030 us    |    seq_putc();
> >    2)   1.352 us    |  }
> > 
> > Operator error, or did the patchset break something?  
> 
> Nope, that does seem to be a bug :-/
>

Does this patch fix it for you?

-- Steve

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b8c0e24ab30..1c8f4aa7020e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -512,6 +512,9 @@ enum {
  * can only be modified by current, we can reuse trace_recursion.
  */
 	TRACE_IRQ_BIT,
+
+	/* Set if the function is in the set_graph_function file */
+	TRACE_GRAPH_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
@@ -855,6 +858,8 @@ static inline int ftrace_graph_addr(unsigned long addr)
 	}
 
 	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+
+		trace_recursion_set(TRACE_GRAPH_BIT);
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
 		 * is set, and called by an interrupt handler, we still
@@ -901,7 +906,8 @@ extern unsigned int fgraph_max_depth;
 static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 {
 	/* trace it when it is-nested-in or is a function enabled. */
-	return !(trace->depth || ftrace_graph_addr(trace->func)) ||
+	return !(trace_recursion_test(TRACE_GRAPH_BIT) ||
+		 ftrace_graph_addr(trace->func)) ||
 		(trace->depth < 0) ||
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2561460d7baf..69fbb6225637 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -509,6 +509,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	int cpu;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -532,6 +535,8 @@ void set_graph_array(struct trace_array *tr)
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 {
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index b7357f9f82a3..b20bf076ce7f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,6 +208,9 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index a86b303e6c67..069867f4eae6 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -270,6 +270,9 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	if (!func_prolog_preempt_disable(tr, &data, &pc))
 		return;
 
