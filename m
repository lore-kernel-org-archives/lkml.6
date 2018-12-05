Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45612C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610FD20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610FD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeLEXsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbeLEXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39B2214C1;
        Wed,  5 Dec 2018 23:48:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu5-0000B5-Uo; Wed, 05 Dec 2018 18:48:29 -0500
Message-Id: <20181205234829.854565087@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [for-next][PATCH 10/30] tracing: Rearrange functions in trace_sched_wakeup.c
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Rearrange the functions in trace_sched_wakeup.c so that there are fewer
 #ifdef CONFIG_FUNCTION_TRACER and #ifdef CONFIG_FUNCTION_GRAPH_TRACER,
instead of having the #ifdefs spread all over.

No functional change is made.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_wakeup.c | 272 ++++++++++++++----------------
 1 file changed, 130 insertions(+), 142 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 7d04b9890755..2ce78100b4d3 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -35,26 +35,19 @@ static arch_spinlock_t wakeup_lock =
 
 static void wakeup_reset(struct trace_array *tr);
 static void __wakeup_reset(struct trace_array *tr);
+static int start_func_tracer(struct trace_array *tr, int graph);
+static void stop_func_tracer(struct trace_array *tr, int graph);
 
 static int save_flags;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static int wakeup_display_graph(struct trace_array *tr, int set);
 # define is_graph(tr) ((tr)->trace_flags & TRACE_ITER_DISPLAY_GRAPH)
 #else
-static inline int wakeup_display_graph(struct trace_array *tr, int set)
-{
-	return 0;
-}
 # define is_graph(tr) false
 #endif
 
-
 #ifdef CONFIG_FUNCTION_TRACER
 
-static int wakeup_graph_entry(struct ftrace_graph_ent *trace);
-static void wakeup_graph_return(struct ftrace_graph_ret *trace);
-
 static bool function_enabled;
 
 /*
@@ -104,122 +97,8 @@ func_prolog_preempt_disable(struct trace_array *tr,
 	return 0;
 }
 
-/*
- * wakeup uses its own tracer function to keep the overhead down:
- */
-static void
-wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
-		   struct ftrace_ops *op, struct pt_regs *pt_regs)
-{
-	struct trace_array *tr = wakeup_trace;
-	struct trace_array_cpu *data;
-	unsigned long flags;
-	int pc;
-
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
-		return;
-
-	local_irq_save(flags);
-	trace_function(tr, ip, parent_ip, flags, pc);
-	local_irq_restore(flags);
-
-	atomic_dec(&data->disabled);
-	preempt_enable_notrace();
-}
-
-static int register_wakeup_function(struct trace_array *tr, int graph, int set)
-{
-	int ret;
-
-	/* 'set' is set if TRACE_ITER_FUNCTION is about to be set */
-	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER_FUNCTION)))
-		return 0;
-
-	if (graph)
-		ret = register_ftrace_graph(&wakeup_graph_return,
-					    &wakeup_graph_entry);
-	else
-		ret = register_ftrace_function(tr->ops);
-
-	if (!ret)
-		function_enabled = true;
-
-	return ret;
-}
-
-static void unregister_wakeup_function(struct trace_array *tr, int graph)
-{
-	if (!function_enabled)
-		return;
-
-	if (graph)
-		unregister_ftrace_graph();
-	else
-		unregister_ftrace_function(tr->ops);
-
-	function_enabled = false;
-}
-
-static int wakeup_function_set(struct trace_array *tr, u32 mask, int set)
-{
-	if (!(mask & TRACE_ITER_FUNCTION))
-		return 0;
-
-	if (set)
-		register_wakeup_function(tr, is_graph(tr), 1);
-	else
-		unregister_wakeup_function(tr, is_graph(tr));
-	return 1;
-}
-#else
-static int register_wakeup_function(struct trace_array *tr, int graph, int set)
-{
-	return 0;
-}
-static void unregister_wakeup_function(struct trace_array *tr, int graph) { }
-static int wakeup_function_set(struct trace_array *tr, u32 mask, int set)
-{
-	return 0;
-}
-#endif /* CONFIG_FUNCTION_TRACER */
-
-static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
-{
-	struct tracer *tracer = tr->current_trace;
-
-	if (wakeup_function_set(tr, mask, set))
-		return 0;
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (mask & TRACE_ITER_DISPLAY_GRAPH)
-		return wakeup_display_graph(tr, set);
-#endif
-
-	return trace_keep_overwrite(tracer, mask, set);
-}
 
-static int start_func_tracer(struct trace_array *tr, int graph)
-{
-	int ret;
-
-	ret = register_wakeup_function(tr, graph, 0);
-
-	if (!ret && tracing_is_enabled())
-		tracer_enabled = 1;
-	else
-		tracer_enabled = 0;
-
-	return ret;
-}
-
-static void stop_func_tracer(struct trace_array *tr, int graph)
-{
-	tracer_enabled = 0;
-
-	unregister_wakeup_function(tr, graph);
-}
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int wakeup_display_graph(struct trace_array *tr, int set)
 {
 	if (!(is_graph(tr) ^ set))
@@ -318,20 +197,94 @@ static void wakeup_print_header(struct seq_file *s)
 	else
 		trace_default_header(s);
 }
+#else /* CONFIG_FUNCTION_GRAPH_TRACER */
+static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
+{
+	return -1;
+}
+static void wakeup_graph_return(struct ftrace_graph_ret *trace) { }
+#endif /* else CONFIG_FUNCTION_GRAPH_TRACER */
 
+/*
+ * wakeup uses its own tracer function to keep the overhead down:
+ */
 static void
-__trace_function(struct trace_array *tr,
-		 unsigned long ip, unsigned long parent_ip,
-		 unsigned long flags, int pc)
+wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
+		   struct ftrace_ops *op, struct pt_regs *pt_regs)
 {
-	if (is_graph(tr))
-		trace_graph_function(tr, ip, parent_ip, flags, pc);
+	struct trace_array *tr = wakeup_trace;
+	struct trace_array_cpu *data;
+	unsigned long flags;
+	int pc;
+
+	if (!func_prolog_preempt_disable(tr, &data, &pc))
+		return;
+
+	local_irq_save(flags);
+	trace_function(tr, ip, parent_ip, flags, pc);
+	local_irq_restore(flags);
+
+	atomic_dec(&data->disabled);
+	preempt_enable_notrace();
+}
+
+static int register_wakeup_function(struct trace_array *tr, int graph, int set)
+{
+	int ret;
+
+	/* 'set' is set if TRACE_ITER_FUNCTION is about to be set */
+	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER_FUNCTION)))
+		return 0;
+
+	if (graph)
+		ret = register_ftrace_graph(&wakeup_graph_return,
+					    &wakeup_graph_entry);
 	else
-		trace_function(tr, ip, parent_ip, flags, pc);
+		ret = register_ftrace_function(tr->ops);
+
+	if (!ret)
+		function_enabled = true;
+
+	return ret;
 }
-#else
-#define __trace_function trace_function
 
+static void unregister_wakeup_function(struct trace_array *tr, int graph)
+{
+	if (!function_enabled)
+		return;
+
+	if (graph)
+		unregister_ftrace_graph();
+	else
+		unregister_ftrace_function(tr->ops);
+
+	function_enabled = false;
+}
+
+static int wakeup_function_set(struct trace_array *tr, u32 mask, int set)
+{
+	if (!(mask & TRACE_ITER_FUNCTION))
+		return 0;
+
+	if (set)
+		register_wakeup_function(tr, is_graph(tr), 1);
+	else
+		unregister_wakeup_function(tr, is_graph(tr));
+	return 1;
+}
+#else /* CONFIG_FUNCTION_TRACER */
+static int register_wakeup_function(struct trace_array *tr, int graph, int set)
+{
+	return 0;
+}
+static void unregister_wakeup_function(struct trace_array *tr, int graph) { }
+static int wakeup_function_set(struct trace_array *tr, u32 mask, int set)
+{
+	return 0;
+}
+#endif /* else CONFIG_FUNCTION_TRACER */
+
+#ifndef CONFIG_FUNCTION_GRAPH_TRACER
 static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
 {
 	return TRACE_TYPE_UNHANDLED;
@@ -340,23 +293,58 @@ static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
 static void wakeup_trace_open(struct trace_iterator *iter) { }
 static void wakeup_trace_close(struct trace_iterator *iter) { }
 
-#ifdef CONFIG_FUNCTION_TRACER
-static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
-{
-	return -1;
-}
-static void wakeup_graph_return(struct ftrace_graph_ret *trace) { }
 static void wakeup_print_header(struct seq_file *s)
 {
 	trace_default_header(s);
 }
-#else
-static void wakeup_print_header(struct seq_file *s)
+#endif /* !CONFIG_FUNCTION_GRAPH_TRACER */
+
+static void
+__trace_function(struct trace_array *tr,
+		 unsigned long ip, unsigned long parent_ip,
+		 unsigned long flags, int pc)
+{
+	if (is_graph(tr))
+		trace_graph_function(tr, ip, parent_ip, flags, pc);
+	else
+		trace_function(tr, ip, parent_ip, flags, pc);
+}
+
+static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
 {
-	trace_latency_header(s);
+	struct tracer *tracer = tr->current_trace;
+
+	if (wakeup_function_set(tr, mask, set))
+		return 0;
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (mask & TRACE_ITER_DISPLAY_GRAPH)
+		return wakeup_display_graph(tr, set);
+#endif
+
+	return trace_keep_overwrite(tracer, mask, set);
+}
+
+static int start_func_tracer(struct trace_array *tr, int graph)
+{
+	int ret;
+
+	ret = register_wakeup_function(tr, graph, 0);
+
+	if (!ret && tracing_is_enabled())
+		tracer_enabled = 1;
+	else
+		tracer_enabled = 0;
+
+	return ret;
+}
+
+static void stop_func_tracer(struct trace_array *tr, int graph)
+{
+	tracer_enabled = 0;
+
+	unregister_wakeup_function(tr, graph);
 }
-#endif /* CONFIG_FUNCTION_TRACER */
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 /*
  * Should this new latency be reported/recorded?
-- 
2.19.1


