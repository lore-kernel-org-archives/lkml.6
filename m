Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA8C04EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB19020878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB19020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391452AbeKVMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388868AbeKVMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:02 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9876821707;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdml-0005LC-Lp; Wed, 21 Nov 2018 20:28:03 -0500
Message-Id: <20181122012803.576692300@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC][PATCH 07/14] fgraph: Add new fgraph_ops structure to enable function graph hooks
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               | 24 +++++++++++++++++-------
 kernel/trace/fgraph.c                |  9 ++++-----
 kernel/trace/ftrace.c                | 10 +++++++---
 kernel/trace/trace_functions_graph.c | 21 ++++++++++++++++-----
 kernel/trace/trace_irqsoff.c         | 10 +++++++---
 kernel/trace/trace_sched_wakeup.c    | 10 +++++++---
 kernel/trace/trace_selftest.c        |  8 ++++++--
 7 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index f98063e273e5..477ff9412d26 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -749,6 +749,18 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+struct fgraph_ops {
+	trace_func_graph_ent_t		entryfunc;
+	trace_func_graph_ret_t		retfunc;
+	struct fgraph_ops __rcu		*next;
+	unsigned long			flags;
+	void				*private;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	struct ftrace_ops_hash		local_hash;
+	struct ftrace_ops_hash		*func_hash;
+#endif
+};
+
 /*
  * Stack of return addresses for functions
  * of a thread.
@@ -792,8 +804,9 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 #define FTRACE_RETFUNC_DEPTH 50
 #define FTRACE_RETSTACK_ALLOC_SIZE 32
-extern int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-				trace_func_graph_ent_t entryfunc);
+
+extern int register_ftrace_graph(struct fgraph_ops *ops);
+extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
 extern bool ftrace_graph_is_dead(void);
 extern void ftrace_graph_stop(void);
@@ -802,8 +815,6 @@ extern void ftrace_graph_stop(void);
 extern trace_func_graph_ret_t ftrace_graph_return;
 extern trace_func_graph_ent_t ftrace_graph_entry;
 
-extern void unregister_ftrace_graph(void);
-
 extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
@@ -830,12 +841,11 @@ static inline void ftrace_graph_init_task(struct task_struct *t) { }
 static inline void ftrace_graph_exit_task(struct task_struct *t) { }
 static inline void ftrace_graph_init_idle_task(struct task_struct *t, int cpu) { }
 
-static inline int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			  trace_func_graph_ent_t entryfunc)
+static inline int register_ftrace_graph(struct fgraph_ops *ops);
 {
 	return -1;
 }
-static inline void unregister_ftrace_graph(void) { }
+static inline void unregister_ftrace_graph(struct fgraph_ops *ops) { }
 
 static inline int task_curr_ret_stack(struct task_struct *tsk)
 {
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b9c7dbbbdd96..f3a89ecac671 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -491,8 +491,7 @@ static int start_graph_tracing(void)
 	return ret;
 }
 
-int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			trace_func_graph_ent_t entryfunc)
+int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
 
@@ -513,7 +512,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 		goto out;
 	}
 
-	ftrace_graph_return = retfunc;
+	ftrace_graph_return = gops->retfunc;
 
 	/*
 	 * Update the indirect function to the entryfunc, and the
@@ -521,7 +520,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 	 * call the update fgraph entry function to determine if
 	 * the entryfunc should be called directly or not.
 	 */
-	__ftrace_graph_entry = entryfunc;
+	__ftrace_graph_entry = gops->entryfunc;
 	ftrace_graph_entry = ftrace_graph_entry_test;
 	update_function_graph_func();
 
@@ -531,7 +530,7 @@ int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 	return ret;
 }
 
-void unregister_ftrace_graph(void)
+void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	mutex_lock(&ftrace_lock);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 64e635994648..d057dde081e7 100644
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
index 0e0ff08357cf..7c7fd13d2373 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -336,17 +336,25 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 		trace_graph_return(trace);
 }
 
+static struct fgraph_ops funcgraph_threash_ops = {
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
+		ret = register_ftrace_graph(&funcgraph_threash_ops);
 	else
-		ret = register_ftrace_graph(&trace_graph_return,
-					    &trace_graph_entry);
+		ret = register_ftrace_graph(&funcgraph_ops);
 	if (ret)
 		return ret;
 	tracing_start_cmdline_record();
@@ -357,7 +365,10 @@ static int graph_trace_init(struct trace_array *tr)
 static void graph_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_cmdline_record();
-	unregister_ftrace_graph();
+	if (tracing_thresh)
+		unregister_ftrace_graph(&funcgraph_threash_ops);
+	else
+		unregister_ftrace_graph(&funcgraph_ops);
 }
 
 static int graph_trace_update_thresh(struct trace_array *tr)
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index b7357f9f82a3..1edab493849b 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -457,6 +457,11 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
+static struct fgraph_ops fgraph_ops = {
+	.entryfunc		= &irqsoff_graph_entry,
+	.retfunc		= &irqsoff_graph_return,
+};
+
 static int register_irqsoff_function(struct trace_array *tr, int graph, int set)
 {
 	int ret;
@@ -466,8 +471,7 @@ static int register_irqsoff_function(struct trace_array *tr, int graph, int set)
 		return 0;
 
 	if (graph)
-		ret = register_ftrace_graph(&irqsoff_graph_return,
-					    &irqsoff_graph_entry);
+		ret = register_ftrace_graph(&fgraph_ops);
 	else
 		ret = register_ftrace_function(tr->ops);
 
@@ -483,7 +487,7 @@ static void unregister_irqsoff_function(struct trace_array *tr, int graph)
 		return;
 
 	if (graph)
-		unregister_ftrace_graph();
+		unregister_ftrace_graph(&fgraph_ops);
 	else
 		unregister_ftrace_function(tr->ops);
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index a86b303e6c67..1cd61528137f 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -127,6 +127,11 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 }
 
+static struct fgraph_ops fgraph_wakeup_ops = {
+	.entryfunc = &wakeup_graph_entry,
+	.retfunc = &wakeup_graph_return,
+};
+
 static int register_wakeup_function(struct trace_array *tr, int graph, int set)
 {
 	int ret;
@@ -136,8 +141,7 @@ static int register_wakeup_function(struct trace_array *tr, int graph, int set)
 		return 0;
 
 	if (graph)
-		ret = register_ftrace_graph(&wakeup_graph_return,
-					    &wakeup_graph_entry);
+		ret = register_ftrace_graph(&fgraph_wakeup_ops);
 	else
 		ret = register_ftrace_function(tr->ops);
 
@@ -153,7 +157,7 @@ static void unregister_wakeup_function(struct trace_array *tr, int graph)
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


