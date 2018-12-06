Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E2C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08420700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108492;
	bh=Z1p+rp2JOvilIjQaokZ1LzV4kWrPrDxxDTVANMofVQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gur9KghRkmIzzlub1cP7z2k335M1F9TeqWKAuoYk+wpnjYrZh4Li5cBmT0qOlYH/R
	 avvl58IYaxPj6m745VTJvBC5JvZChOAQiJO9wdVW2vYHgumBq0K4bdaFXDcSkvhYKK
	 eocakLT+Hv5Vp9cMbwvK+Y4twJ3nCoho72c32sUg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLFPBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbeLFOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C891208E7;
        Thu,  6 Dec 2018 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107200;
        bh=Z1p+rp2JOvilIjQaokZ1LzV4kWrPrDxxDTVANMofVQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+hkm9KYloh/K6B1DGQ8GucwAGpweZn+d3VOYl1/m23gFGVRTVzmKJvdoaieefPsg
         OzmaQ5Wzia3/gcSB/GuJhLRB6ub6/gnKVBk8jo0H9EBxjOaZKKBUqJqS0p9bc9ijSY
         U5l59Dy2PZ9K5j8Xg0rGEZyy6OW0+wGq+4ztR/08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 13/41] tracing/fgraph: Fix set_graph_function from showing interrupts
Date:   Thu,  6 Dec 2018 15:38:53 +0100
Message-Id: <20181206142950.798620941@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 5cf99a0f3161bc3ae2391269d134d6bf7e26f00e upstream.

The tracefs file set_graph_function is used to only function graph functions
that are listed in that file (or all functions if the file is empty). The
way this is implemented is that the function graph tracer looks at every
function, and if the current depth is zero and the function matches
something in the file then it will trace that function. When other functions
are called, the depth will be greater than zero (because the original
function will be at depth zero), and all functions will be traced where the
depth is greater than zero.

The issue is that when a function is first entered, and the handler that
checks this logic is called, the depth is set to zero. If an interrupt comes
in and a function in the interrupt handler is traced, its depth will be
greater than zero and it will automatically be traced, even if the original
function was not. But because the logic only looks at depth it may trace
interrupts when it should not be.

The recent design change of the function graph tracer to fix other bugs
caused the depth to be zero while the function graph callback handler is
being called for a longer time, widening the race of this happening. This
bug was actually there for a longer time, but because the race window was so
small it seldom happened. The Fixes tag below is for the commit that widen
the race window, because that commit belongs to a series that will also help
fix the original bug.

Cc: stable@kernel.org
Fixes: 39eb456dacb5 ("function_graph: Use new curr_ret_depth to manage depth instead of curr_ret_stack")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.h                 |   57 +++++++++++++++++++++++++++++++++--
 kernel/trace/trace_functions_graph.c |    4 ++
 kernel/trace/trace_irqsoff.c         |    2 +
 kernel/trace/trace_sched_wakeup.c    |    2 +
 4 files changed, 62 insertions(+), 3 deletions(-)

--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -512,12 +512,44 @@ enum {
  * can only be modified by current, we can reuse trace_recursion.
  */
 	TRACE_IRQ_BIT,
+
+	/* Set if the function is in the set_graph_function file */
+	TRACE_GRAPH_BIT,
+
+	/*
+	 * In the very unlikely case that an interrupt came in
+	 * at a start of graph tracing, and we want to trace
+	 * the function in that interrupt, the depth can be greater
+	 * than zero, because of the preempted start of a previous
+	 * trace. In an even more unlikely case, depth could be 2
+	 * if a softirq interrupted the start of graph tracing,
+	 * followed by an interrupt preempting a start of graph
+	 * tracing in the softirq, and depth can even be 3
+	 * if an NMI came in at the start of an interrupt function
+	 * that preempted a softirq start of a function that
+	 * preempted normal context!!!! Luckily, it can't be
+	 * greater than 3, so the next two bits are a mask
+	 * of what the depth is when we set TRACE_GRAPH_BIT
+	 */
+
+	TRACE_GRAPH_DEPTH_START_BIT,
+	TRACE_GRAPH_DEPTH_END_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
 #define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
 #define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
 
+#define trace_recursion_depth() \
+	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
+#define trace_recursion_set_depth(depth) \
+	do {								\
+		current->trace_recursion &=				\
+			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
+		current->trace_recursion |=				\
+			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
+	} while (0)
+
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
@@ -843,8 +875,9 @@ extern void __trace_graph_return(struct
 extern struct ftrace_hash *ftrace_graph_hash;
 extern struct ftrace_hash *ftrace_graph_notrace_hash;
 
-static inline int ftrace_graph_addr(unsigned long addr)
+static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
+	unsigned long addr = trace->func;
 	int ret = 0;
 
 	preempt_disable_notrace();
@@ -855,6 +888,14 @@ static inline int ftrace_graph_addr(unsi
 	}
 
 	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+
+		/*
+		 * This needs to be cleared on the return functions
+		 * when the depth is zero.
+		 */
+		trace_recursion_set(TRACE_GRAPH_BIT);
+		trace_recursion_set_depth(trace->depth);
+
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
 		 * is set, and called by an interrupt handler, we still
@@ -872,6 +913,13 @@ out:
 	return ret;
 }
 
+static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+{
+	if (trace_recursion_test(TRACE_GRAPH_BIT) &&
+	    trace->depth == trace_recursion_depth())
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+}
+
 static inline int ftrace_graph_notrace_addr(unsigned long addr)
 {
 	int ret = 0;
@@ -885,7 +933,7 @@ static inline int ftrace_graph_notrace_a
 	return ret;
 }
 #else
-static inline int ftrace_graph_addr(unsigned long addr)
+static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
 	return 1;
 }
@@ -894,6 +942,8 @@ static inline int ftrace_graph_notrace_a
 {
 	return 0;
 }
+static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+{ }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
@@ -901,7 +951,8 @@ extern unsigned int fgraph_max_depth;
 static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 {
 	/* trace it when it is-nested-in or is a function enabled. */
-	return !(trace->depth || ftrace_graph_addr(trace->func)) ||
+	return !(trace_recursion_test(TRACE_GRAPH_BIT) ||
+		 ftrace_graph_addr(trace)) ||
 		(trace->depth < 0) ||
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -509,6 +509,8 @@ void trace_graph_return(struct ftrace_gr
 	int cpu;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -532,6 +534,8 @@ void set_graph_array(struct trace_array
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 {
+	ftrace_graph_addr_finish(trace);
+
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,6 +208,8 @@ static void irqsoff_graph_return(struct
 	unsigned long flags;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -270,6 +270,8 @@ static void wakeup_graph_return(struct f
 	unsigned long flags;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	if (!func_prolog_preempt_disable(tr, &data, &pc))
 		return;
 


