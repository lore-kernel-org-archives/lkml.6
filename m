Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418F420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418F420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeLEXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbeLEXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090B421708;
        Wed,  5 Dec 2018 23:48:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu6-0000Be-3a; Wed, 05 Dec 2018 18:48:30 -0500
Message-Id: <20181205234830.009562488@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 11/30] fgraph: Add new fgraph_ops structure to enable function graph hooks
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently the registering of function graph is to pass in a entry and return
function. We need to have a way to associate those functions together where
the entry can determine to run the return hook. Having a structure that
contains both functions will facilitate the process of converting the code
to be able to do such.

This is similar to the way function hooks are enabled (it passes in
ftrace_ops). Instead of passing in the functions to use, a single structure
is passed in to the registering function.

The unregister function is now passed in the fgraph_ops handle. When we
allow more than one callback to the function graph hooks, this will let the
system know which one to remove.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               | 21 +++++++++++----------
 kernel/trace/fgraph.c                |  9 ++++-----
 kernel/trace/ftrace.c                | 10 +++++++---
 kernel/trace/trace_functions_graph.c | 21 ++++++++++++++++-----
 kernel/trace/trace_irqsoff.c         | 18 +++++++-----------
 kernel/trace/trace_sched_wakeup.c    | 16 +++++++---------
 kernel/trace/trace_selftest.c        |  8 ++++++--
 7 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 98625f10d982..21c80491ccde 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -749,6 +749,11 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+struct fgraph_ops {
+	trace_func_graph_ent_t		entryfunc;
+	trace_func_graph_ret_t		retfunc;
+};
+
 /*
  * Stack of return addresses for functions
  * of a thread.
@@ -792,8 +797,9 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 #define FTRACE_RETFUNC_DEPTH 50
 #define FTRACE_RETSTACK_ALLOC_SIZE 32
-extern int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-				trace_func_graph_ent_t entryfunc);
+
+extern int register_ftrace_graph(struct fgraph_ops *ops);
+extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
 extern bool ftrace_graph_is_dead(void);
 extern void ftrace_graph_stop(void);
@@ -802,8 +808,6 @@ extern void ftrace_graph_stop(void);
 extern trace_func_graph_ret_t ftrace_graph_return;
 extern trace_func_graph_ent_t ftrace_graph_entry;
 
-extern void unregister_ftrace_graph(void);
-
 extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
@@ -825,12 +829,9 @@ static inline void ftrace_graph_init_task(struct task_struct *t) { }
 static inline void ftrace_graph_exit_task(struct task_struct *t) { }
 static inline void ftrace_graph_init_idle_task(struct task_struct *t, int cpu) { }
 
-static inline int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			  trace_func_graph_ent_t entryfunc)
-{
-	return -1;
-}
-static inline void unregister_ftrace_graph(void) { }
+/* Define as macros as fgraph_ops may not be defined */
+#define register_ftrace_graph(ops) ({ -1; })
+#define unregister_ftrace_graph(ops) do { } while (0)
 
 static inline unsigned long
 ftrace_graph_ret_addr(struct task_struct *task, int *idx, unsigned long ret,
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 374f3e42e29e..cc35606e9a3e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -490,8 +490,7 @@ static int start_graph_tracing(void)
 	return ret;
 }
 
-int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			trace_func_graph_ent_t entryfunc)
+int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
 
@@ -512,7 +511,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 		goto out;
 	}
 
-	ftrace_graph_return = retfunc;
+	ftrace_graph_return = gops->retfunc;
 
 	/*
 	 * Update the indirect function to the entryfunc, and the
@@ -520,7 +519,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 	 * call the update fgraph entry function to determine if
 	 * the entryfunc should be called directly or not.
 	 */
-	__ftrace_graph_entry = entryfunc;
+	__ftrace_graph_entry = gops->entryfunc;
 	ftrace_graph_entry = ftrace_graph_entry_test;
 	update_function_graph_func();
 
@@ -530,7 +529,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 	return ret;
 }
 
-void unregister_ftrace_graph(void)
+void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	mutex_lock(&ftrace_lock);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c53533b833cf..d06fe588e650 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -849,15 +849,19 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	local_irq_restore(flags);
 }
 
+static struct fgraph_ops fprofiler_ops = {
+	.entryfunc = &profile_graph_entry,
+	.retfunc = &profile_graph_return,
+};
+
 static int register_ftrace_profiler(void)
 {
-	return register_ftrace_graph(&profile_graph_return,
-				     &profile_graph_entry);
+	return register_ftrace_graph(&fprofiler_ops);
 }
 
 static void unregister_ftrace_profiler(void)
 {
-	unregister_ftrace_graph();
+	unregister_ftrace_graph(&fprofiler_ops);
 }
 #else
 static struct ftrace_ops ftrace_profile_ops __read_mostly = {
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 855c13c61e77..140b4b51ab34 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -345,17 +345,25 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 		trace_graph_return(trace);
 }
 
+static struct fgraph_ops funcgraph_thresh_ops = {
+	.entryfunc = &trace_graph_entry,
+	.retfunc = &trace_graph_thresh_return,
+};
+
+static struct fgraph_ops funcgraph_ops = {
+	.entryfunc = &trace_graph_entry,
+	.retfunc = &trace_graph_return,
+};
+
 static int graph_trace_init(struct trace_array *tr)
 {
 	int ret;
 
 	set_graph_array(tr);
 	if (tracing_thresh)
-		ret = register_ftrace_graph(&trace_graph_thresh_return,
-					    &trace_graph_entry);
+		ret = register_ftrace_graph(&funcgraph_thresh_ops);
 	else
-		ret = register_ftrace_graph(&trace_graph_return,
-					    &trace_graph_entry);
+		ret = register_ftrace_graph(&funcgraph_ops);
 	if (ret)
 		return ret;
 	tracing_start_cmdline_record();
@@ -366,7 +374,10 @@ static int graph_trace_init(struct trace_array *tr)
 static void graph_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_cmdline_record();
-	unregister_ftrace_graph();
+	if (tracing_thresh)
+		unregister_ftrace_graph(&funcgraph_thresh_ops);
+	else
+		unregister_ftrace_graph(&funcgraph_ops);
 }
 
 static int graph_trace_update_thresh(struct trace_array *tr)
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 98ea6d28df15..d3294721f119 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -218,6 +218,11 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	atomic_dec(&data->disabled);
 }
 
+static struct fgraph_ops fgraph_ops = {
+	.entryfunc		= &irqsoff_graph_entry,
+	.retfunc		= &irqsoff_graph_return,
+};
+
 static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
@@ -272,13 +277,6 @@ __trace_function(struct trace_array *tr,
 #else
 #define __trace_function trace_function
 
-#ifdef CONFIG_FUNCTION_TRACER
-static int irqsoff_graph_entry(struct ftrace_graph_ent *trace)
-{
-	return -1;
-}
-#endif
-
 static enum print_line_t irqsoff_print_line(struct trace_iterator *iter)
 {
 	return TRACE_TYPE_UNHANDLED;
@@ -288,7 +286,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter) { }
 static void irqsoff_trace_close(struct trace_iterator *iter) { }
 
 #ifdef CONFIG_FUNCTION_TRACER
-static void irqsoff_graph_return(struct ftrace_graph_ret *trace) { }
 static void irqsoff_print_header(struct seq_file *s)
 {
 	trace_default_header(s);
@@ -468,8 +465,7 @@ static int register_irqsoff_function(struct trace_array *tr, int graph, int set)
 		return 0;
 
 	if (graph)
-		ret = register_ftrace_graph(&irqsoff_graph_return,
-					    &irqsoff_graph_entry);
+		ret = register_ftrace_graph(&fgraph_ops);
 	else
 		ret = register_ftrace_function(tr->ops);
 
@@ -485,7 +481,7 @@ static void unregister_irqsoff_function(struct trace_array *tr, int graph)
 		return;
 
 	if (graph)
-		unregister_ftrace_graph();
+		unregister_ftrace_graph(&fgraph_ops);
 	else
 		unregister_ftrace_function(tr->ops);
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 2ce78100b4d3..4ea7e6845efb 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -162,6 +162,11 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 	return;
 }
 
+static struct fgraph_ops fgraph_wakeup_ops = {
+	.entryfunc = &wakeup_graph_entry,
+	.retfunc = &wakeup_graph_return,
+};
+
 static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
@@ -197,12 +202,6 @@ static void wakeup_print_header(struct seq_file *s)
 	else
 		trace_default_header(s);
 }
-#else /* CONFIG_FUNCTION_GRAPH_TRACER */
-static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
-{
-	return -1;
-}
-static void wakeup_graph_return(struct ftrace_graph_ret *trace) { }
 #endif /* else CONFIG_FUNCTION_GRAPH_TRACER */
 
 /*
@@ -237,8 +236,7 @@ static int register_wakeup_function(struct trace_array *tr, int graph, int set)
 		return 0;
 
 	if (graph)
-		ret = register_ftrace_graph(&wakeup_graph_return,
-					    &wakeup_graph_entry);
+		ret = register_ftrace_graph(&fgraph_wakeup_ops);
 	else
 		ret = register_ftrace_function(tr->ops);
 
@@ -254,7 +252,7 @@ static void unregister_wakeup_function(struct trace_array *tr, int graph)
 		return;
 
 	if (graph)
-		unregister_ftrace_graph();
+		unregister_ftrace_graph(&fgraph_wakeup_ops);
 	else
 		unregister_ftrace_function(tr->ops);
 
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 11e9daa4a568..9d402e7fc949 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -741,6 +741,11 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
 	return trace_graph_entry(trace);
 }
 
+static struct fgraph_ops fgraph_ops __initdata  = {
+	.entryfunc		= &trace_graph_entry_watchdog,
+	.retfunc		= &trace_graph_return,
+};
+
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -765,8 +770,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 */
 	tracing_reset_online_cpus(&tr->trace_buffer);
 	set_graph_array(tr);
-	ret = register_ftrace_graph(&trace_graph_return,
-				    &trace_graph_entry_watchdog);
+	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
 		goto out;
-- 
2.19.1


