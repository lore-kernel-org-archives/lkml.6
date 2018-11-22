Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D55B2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D55B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbeKVMFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391359AbeKVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EEF721527;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdml-0005Kf-HX; Wed, 21 Nov 2018 20:28:03 -0500
Message-Id: <20181122012803.442190047@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:14 -0500
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
Subject: [RFC][PATCH 06/14] fgraph: Move function graph specific code into fgraph.c
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

To make the function graph infrastructure more managable, the code needs to
be in its own file (fgraph.c). Move the code that is specific for managing
the function graph infrastructure out of ftrace.c and into fgraph.c

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 360 ++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/ftrace.c | 368 +-----------------------------------------
 2 files changed, 366 insertions(+), 362 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5b0d554dbf65..b9c7dbbbdd96 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -7,11 +7,27 @@
  *
  * Highly modified by Steven Rostedt (VMware).
  */
+#include <linux/suspend.h>
 #include <linux/ftrace.h>
+#include <linux/slab.h>
 
-#include "trace.h"
+#include <trace/events/sched.h>
+
+#include "ftrace-internal.h"
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ASSIGN_OPS_HASH(opsname, val) \
+	.func_hash		= val, \
+	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+#else
+#define ASSIGN_OPS_HASH(opsname, val)
+#endif
 
 static bool kill_ftrace_graph;
+int ftrace_graph_active;
+
+/* Both enabled by default (can be cleared by function_graph tracer flags */
+static bool fgraph_sleep_time = true;
 
 /**
  * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
@@ -162,6 +178,31 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	barrier();
 }
 
+/*
+ * Hibernation protection.
+ * The state of the current task is too much unstable during
+ * suspend/restore to disk. We want to protect against that.
+ */
+static int
+ftrace_suspend_notifier_call(struct notifier_block *bl, unsigned long state,
+							void *unused)
+{
+	switch (state) {
+	case PM_HIBERNATION_PREPARE:
+		pause_graph_tracing();
+		break;
+
+	case PM_POST_HIBERNATION:
+		unpause_graph_tracing();
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ftrace_suspend_notifier = {
+	.notifier_call = ftrace_suspend_notifier_call,
+};
+
 /*
  * Send the trace to the ring-buffer.
  * @return the original return address.
@@ -191,3 +232,320 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 	return ret;
 }
+
+static struct ftrace_ops graph_ops = {
+	.func			= ftrace_stub,
+	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
+				   FTRACE_OPS_FL_INITIALIZED |
+				   FTRACE_OPS_FL_PID |
+				   FTRACE_OPS_FL_STUB,
+#ifdef FTRACE_GRAPH_TRAMP_ADDR
+	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
+	/* trampoline_size is only needed for dynamically allocated tramps */
+#endif
+	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
+};
+
+void ftrace_graph_sleep_time_control(bool enable)
+{
+	fgraph_sleep_time = enable;
+}
+
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+/* The callbacks that hook a function */
+trace_func_graph_ret_t ftrace_graph_return =
+			(trace_func_graph_ret_t)ftrace_stub;
+trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
+static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
+
+/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
+static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
+{
+	int i;
+	int ret = 0;
+	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
+	struct task_struct *g, *t;
+
+	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
+		ret_stack_list[i] =
+			kmalloc_array(FTRACE_RETFUNC_DEPTH,
+				      sizeof(struct ftrace_ret_stack),
+				      GFP_KERNEL);
+		if (!ret_stack_list[i]) {
+			start = 0;
+			end = i;
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		if (start == end) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
+
+		if (t->ret_stack == NULL) {
+			atomic_set(&t->tracing_graph_pause, 0);
+			atomic_set(&t->trace_overrun, 0);
+			t->curr_ret_stack = -1;
+			t->curr_ret_depth = -1;
+			/* Make sure the tasks see the -1 first: */
+			smp_wmb();
+			t->ret_stack = ret_stack_list[start++];
+		}
+	} while_each_thread(g, t);
+
+unlock:
+	read_unlock(&tasklist_lock);
+free:
+	for (i = start; i < end; i++)
+		kfree(ret_stack_list[i]);
+	return ret;
+}
+
+static void
+ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
+			struct task_struct *prev, struct task_struct *next)
+{
+	unsigned long long timestamp;
+	int index;
+
+	/*
+	 * Does the user want to count the time a function was asleep.
+	 * If so, do not update the time stamps.
+	 */
+	if (fgraph_sleep_time)
+		return;
+
+	timestamp = trace_clock_local();
+
+	prev->ftrace_timestamp = timestamp;
+
+	/* only process tasks that we timestamped */
+	if (!next->ftrace_timestamp)
+		return;
+
+	/*
+	 * Update all the counters in next to make up for the
+	 * time next was sleeping.
+	 */
+	timestamp -= next->ftrace_timestamp;
+
+	for (index = next->curr_ret_stack; index >= 0; index--)
+		next->ret_stack[index].calltime += timestamp;
+}
+
+static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
+{
+	if (!ftrace_ops_test(&global_ops, trace->func, NULL))
+		return 0;
+	return __ftrace_graph_entry(trace);
+}
+
+/*
+ * The function graph tracer should only trace the functions defined
+ * by set_ftrace_filter and set_ftrace_notrace. If another function
+ * tracer ops is registered, the graph tracer requires testing the
+ * function against the global ops, and not just trace any function
+ * that any ftrace_ops registered.
+ */
+void update_function_graph_func(void)
+{
+	struct ftrace_ops *op;
+	bool do_test = false;
+
+	/*
+	 * The graph and global ops share the same set of functions
+	 * to test. If any other ops is on the list, then
+	 * the graph tracing needs to test if its the function
+	 * it should call.
+	 */
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+		if (op != &global_ops && op != &graph_ops &&
+		    op != &ftrace_list_end) {
+			do_test = true;
+			/* in double loop, break out with goto */
+			goto out;
+		}
+	} while_for_each_ftrace_op(op);
+ out:
+	if (do_test)
+		ftrace_graph_entry = ftrace_graph_entry_test;
+	else
+		ftrace_graph_entry = __ftrace_graph_entry;
+}
+
+static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
+
+static void
+graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
+{
+	atomic_set(&t->tracing_graph_pause, 0);
+	atomic_set(&t->trace_overrun, 0);
+	t->ftrace_timestamp = 0;
+	/* make curr_ret_stack visible before we add the ret_stack */
+	smp_wmb();
+	t->ret_stack = ret_stack;
+}
+
+/*
+ * Allocate a return stack for the idle task. May be the first
+ * time through, or it may be done by CPU hotplug online.
+ */
+void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
+{
+	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
+	/*
+	 * The idle task has no parent, it either has its own
+	 * stack or no stack at all.
+	 */
+	if (t->ret_stack)
+		WARN_ON(t->ret_stack != per_cpu(idle_ret_stack, cpu));
+
+	if (ftrace_graph_active) {
+		struct ftrace_ret_stack *ret_stack;
+
+		ret_stack = per_cpu(idle_ret_stack, cpu);
+		if (!ret_stack) {
+			ret_stack =
+				kmalloc_array(FTRACE_RETFUNC_DEPTH,
+					      sizeof(struct ftrace_ret_stack),
+					      GFP_KERNEL);
+			if (!ret_stack)
+				return;
+			per_cpu(idle_ret_stack, cpu) = ret_stack;
+		}
+		graph_init_task(t, ret_stack);
+	}
+}
+
+/* Allocate a return stack for newly created task */
+void ftrace_graph_init_task(struct task_struct *t)
+{
+	/* Make sure we do not use the parent ret_stack */
+	t->ret_stack = NULL;
+	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
+
+	if (ftrace_graph_active) {
+		struct ftrace_ret_stack *ret_stack;
+
+		ret_stack = kmalloc_array(FTRACE_RETFUNC_DEPTH,
+					  sizeof(struct ftrace_ret_stack),
+					  GFP_KERNEL);
+		if (!ret_stack)
+			return;
+		graph_init_task(t, ret_stack);
+	}
+}
+
+void ftrace_graph_exit_task(struct task_struct *t)
+{
+	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
+
+	t->ret_stack = NULL;
+	/* NULL must become visible to IRQs before we free it: */
+	barrier();
+
+	kfree(ret_stack);
+}
+
+/* Allocate a return stack for each task */
+static int start_graph_tracing(void)
+{
+	struct ftrace_ret_stack **ret_stack_list;
+	int ret, cpu;
+
+	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
+				       sizeof(struct ftrace_ret_stack *),
+				       GFP_KERNEL);
+
+	if (!ret_stack_list)
+		return -ENOMEM;
+
+	/* The cpu_boot init_task->ret_stack will never be freed */
+	for_each_online_cpu(cpu) {
+		if (!idle_task(cpu)->ret_stack)
+			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	}
+
+	do {
+		ret = alloc_retstack_tasklist(ret_stack_list);
+	} while (ret == -EAGAIN);
+
+	if (!ret) {
+		ret = register_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+		if (ret)
+			pr_info("ftrace_graph: Couldn't activate tracepoint"
+				" probe to kernel_sched_switch\n");
+	}
+
+	kfree(ret_stack_list);
+	return ret;
+}
+
+int register_ftrace_graph(trace_func_graph_ret_t retfunc,
+			trace_func_graph_ent_t entryfunc)
+{
+	int ret = 0;
+
+	mutex_lock(&ftrace_lock);
+
+	/* we currently allow only one tracer registered at a time */
+	if (ftrace_graph_active) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	register_pm_notifier(&ftrace_suspend_notifier);
+
+	ftrace_graph_active++;
+	ret = start_graph_tracing();
+	if (ret) {
+		ftrace_graph_active--;
+		goto out;
+	}
+
+	ftrace_graph_return = retfunc;
+
+	/*
+	 * Update the indirect function to the entryfunc, and the
+	 * function that gets called to the entry_test first. Then
+	 * call the update fgraph entry function to determine if
+	 * the entryfunc should be called directly or not.
+	 */
+	__ftrace_graph_entry = entryfunc;
+	ftrace_graph_entry = ftrace_graph_entry_test;
+	update_function_graph_func();
+
+	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+out:
+	mutex_unlock(&ftrace_lock);
+	return ret;
+}
+
+void unregister_ftrace_graph(void)
+{
+	mutex_lock(&ftrace_lock);
+
+	if (unlikely(!ftrace_graph_active))
+		goto out;
+
+	ftrace_graph_active--;
+	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
+	ftrace_graph_entry = ftrace_graph_entry_stub;
+	__ftrace_graph_entry = ftrace_graph_entry_stub;
+	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
+	unregister_pm_notifier(&ftrace_suspend_notifier);
+	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+
+ out:
+	mutex_unlock(&ftrace_lock);
+}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6e407e8278f1..64e635994648 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -19,7 +19,6 @@
 #include <linux/sched/task.h>
 #include <linux/kallsyms.h>
 #include <linux/seq_file.h>
-#include <linux/suspend.h>
 #include <linux/tracefs.h>
 #include <linux/hardirq.h>
 #include <linux/kthread.h>
@@ -167,12 +166,6 @@ static void ftrace_sync_ipi(void *data)
 	smp_rmb();
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-/* Both enabled by default (can be cleared by function_graph tracer flags */
-static bool fgraph_sleep_time = true;
-static bool fgraph_graph_time = true;
-#endif
-
 static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
 {
 	/*
@@ -790,6 +783,13 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static bool fgraph_graph_time = true;
+
+void ftrace_graph_graph_time_control(bool enable)
+{
+	fgraph_graph_time = enable;
+}
+
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
 	int index = current->curr_ret_stack;
@@ -996,10 +996,6 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 }
 #endif /* CONFIG_FUNCTION_PROFILER */
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-int ftrace_graph_active;
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static struct ftrace_ops *removed_ops;
@@ -6697,353 +6693,3 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 	mutex_unlock(&ftrace_lock);
 	return ret;
 }
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-
-static struct ftrace_ops graph_ops = {
-	.func			= ftrace_stub,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
-				   FTRACE_OPS_FL_INITIALIZED |
-				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_FL_STUB,
-#ifdef FTRACE_GRAPH_TRAMP_ADDR
-	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
-	/* trampoline_size is only needed for dynamically allocated tramps */
-#endif
-	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
-};
-
-void ftrace_graph_sleep_time_control(bool enable)
-{
-	fgraph_sleep_time = enable;
-}
-
-void ftrace_graph_graph_time_control(bool enable)
-{
-	fgraph_graph_time = enable;
-}
-
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
-{
-	return 0;
-}
-
-/* The callbacks that hook a function */
-trace_func_graph_ret_t ftrace_graph_return =
-			(trace_func_graph_ret_t)ftrace_stub;
-trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
-static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
-
-/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
-static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
-{
-	int i;
-	int ret = 0;
-	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
-	struct task_struct *g, *t;
-
-	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
-		ret_stack_list[i] =
-			kmalloc_array(FTRACE_RETFUNC_DEPTH,
-				      sizeof(struct ftrace_ret_stack),
-				      GFP_KERNEL);
-		if (!ret_stack_list[i]) {
-			start = 0;
-			end = i;
-			ret = -ENOMEM;
-			goto free;
-		}
-	}
-
-	read_lock(&tasklist_lock);
-	do_each_thread(g, t) {
-		if (start == end) {
-			ret = -EAGAIN;
-			goto unlock;
-		}
-
-		if (t->ret_stack == NULL) {
-			atomic_set(&t->tracing_graph_pause, 0);
-			atomic_set(&t->trace_overrun, 0);
-			t->curr_ret_stack = -1;
-			t->curr_ret_depth = -1;
-			/* Make sure the tasks see the -1 first: */
-			smp_wmb();
-			t->ret_stack = ret_stack_list[start++];
-		}
-	} while_each_thread(g, t);
-
-unlock:
-	read_unlock(&tasklist_lock);
-free:
-	for (i = start; i < end; i++)
-		kfree(ret_stack_list[i]);
-	return ret;
-}
-
-static void
-ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
-			struct task_struct *prev, struct task_struct *next)
-{
-	unsigned long long timestamp;
-	int index;
-
-	/*
-	 * Does the user want to count the time a function was asleep.
-	 * If so, do not update the time stamps.
-	 */
-	if (fgraph_sleep_time)
-		return;
-
-	timestamp = trace_clock_local();
-
-	prev->ftrace_timestamp = timestamp;
-
-	/* only process tasks that we timestamped */
-	if (!next->ftrace_timestamp)
-		return;
-
-	/*
-	 * Update all the counters in next to make up for the
-	 * time next was sleeping.
-	 */
-	timestamp -= next->ftrace_timestamp;
-
-	for (index = next->curr_ret_stack; index >= 0; index--)
-		next->ret_stack[index].calltime += timestamp;
-}
-
-/* Allocate a return stack for each task */
-static int start_graph_tracing(void)
-{
-	struct ftrace_ret_stack **ret_stack_list;
-	int ret, cpu;
-
-	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
-				       sizeof(struct ftrace_ret_stack *),
-				       GFP_KERNEL);
-
-	if (!ret_stack_list)
-		return -ENOMEM;
-
-	/* The cpu_boot init_task->ret_stack will never be freed */
-	for_each_online_cpu(cpu) {
-		if (!idle_task(cpu)->ret_stack)
-			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
-	}
-
-	do {
-		ret = alloc_retstack_tasklist(ret_stack_list);
-	} while (ret == -EAGAIN);
-
-	if (!ret) {
-		ret = register_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
-		if (ret)
-			pr_info("ftrace_graph: Couldn't activate tracepoint"
-				" probe to kernel_sched_switch\n");
-	}
-
-	kfree(ret_stack_list);
-	return ret;
-}
-
-/*
- * Hibernation protection.
- * The state of the current task is too much unstable during
- * suspend/restore to disk. We want to protect against that.
- */
-static int
-ftrace_suspend_notifier_call(struct notifier_block *bl, unsigned long state,
-							void *unused)
-{
-	switch (state) {
-	case PM_HIBERNATION_PREPARE:
-		pause_graph_tracing();
-		break;
-
-	case PM_POST_HIBERNATION:
-		unpause_graph_tracing();
-		break;
-	}
-	return NOTIFY_DONE;
-}
-
-static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
-{
-	if (!ftrace_ops_test(&global_ops, trace->func, NULL))
-		return 0;
-	return __ftrace_graph_entry(trace);
-}
-
-/*
- * The function graph tracer should only trace the functions defined
- * by set_ftrace_filter and set_ftrace_notrace. If another function
- * tracer ops is registered, the graph tracer requires testing the
- * function against the global ops, and not just trace any function
- * that any ftrace_ops registered.
- */
-void update_function_graph_func(void)
-{
-	struct ftrace_ops *op;
-	bool do_test = false;
-
-	/*
-	 * The graph and global ops share the same set of functions
-	 * to test. If any other ops is on the list, then
-	 * the graph tracing needs to test if its the function
-	 * it should call.
-	 */
-	do_for_each_ftrace_op(op, ftrace_ops_list) {
-		if (op != &global_ops && op != &graph_ops &&
-		    op != &ftrace_list_end) {
-			do_test = true;
-			/* in double loop, break out with goto */
-			goto out;
-		}
-	} while_for_each_ftrace_op(op);
- out:
-	if (do_test)
-		ftrace_graph_entry = ftrace_graph_entry_test;
-	else
-		ftrace_graph_entry = __ftrace_graph_entry;
-}
-
-static struct notifier_block ftrace_suspend_notifier = {
-	.notifier_call = ftrace_suspend_notifier_call,
-};
-
-int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			trace_func_graph_ent_t entryfunc)
-{
-	int ret = 0;
-
-	mutex_lock(&ftrace_lock);
-
-	/* we currently allow only one tracer registered at a time */
-	if (ftrace_graph_active) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	register_pm_notifier(&ftrace_suspend_notifier);
-
-	ftrace_graph_active++;
-	ret = start_graph_tracing();
-	if (ret) {
-		ftrace_graph_active--;
-		goto out;
-	}
-
-	ftrace_graph_return = retfunc;
-
-	/*
-	 * Update the indirect function to the entryfunc, and the
-	 * function that gets called to the entry_test first. Then
-	 * call the update fgraph entry function to determine if
-	 * the entryfunc should be called directly or not.
-	 */
-	__ftrace_graph_entry = entryfunc;
-	ftrace_graph_entry = ftrace_graph_entry_test;
-	update_function_graph_func();
-
-	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
-out:
-	mutex_unlock(&ftrace_lock);
-	return ret;
-}
-
-void unregister_ftrace_graph(void)
-{
-	mutex_lock(&ftrace_lock);
-
-	if (unlikely(!ftrace_graph_active))
-		goto out;
-
-	ftrace_graph_active--;
-	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
-	ftrace_graph_entry = ftrace_graph_entry_stub;
-	__ftrace_graph_entry = ftrace_graph_entry_stub;
-	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-	unregister_pm_notifier(&ftrace_suspend_notifier);
-	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
-
- out:
-	mutex_unlock(&ftrace_lock);
-}
-
-static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
-
-static void
-graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
-{
-	atomic_set(&t->tracing_graph_pause, 0);
-	atomic_set(&t->trace_overrun, 0);
-	t->ftrace_timestamp = 0;
-	/* make curr_ret_stack visible before we add the ret_stack */
-	smp_wmb();
-	t->ret_stack = ret_stack;
-}
-
-/*
- * Allocate a return stack for the idle task. May be the first
- * time through, or it may be done by CPU hotplug online.
- */
-void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
-{
-	t->curr_ret_stack = -1;
-	t->curr_ret_depth = -1;
-	/*
-	 * The idle task has no parent, it either has its own
-	 * stack or no stack at all.
-	 */
-	if (t->ret_stack)
-		WARN_ON(t->ret_stack != per_cpu(idle_ret_stack, cpu));
-
-	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
-
-		ret_stack = per_cpu(idle_ret_stack, cpu);
-		if (!ret_stack) {
-			ret_stack =
-				kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					      sizeof(struct ftrace_ret_stack),
-					      GFP_KERNEL);
-			if (!ret_stack)
-				return;
-			per_cpu(idle_ret_stack, cpu) = ret_stack;
-		}
-		graph_init_task(t, ret_stack);
-	}
-}
-
-/* Allocate a return stack for newly created task */
-void ftrace_graph_init_task(struct task_struct *t)
-{
-	/* Make sure we do not use the parent ret_stack */
-	t->ret_stack = NULL;
-	t->curr_ret_stack = -1;
-	t->curr_ret_depth = -1;
-
-	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
-
-		ret_stack = kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					  sizeof(struct ftrace_ret_stack),
-					  GFP_KERNEL);
-		if (!ret_stack)
-			return;
-		graph_init_task(t, ret_stack);
-	}
-}
-
-void ftrace_graph_exit_task(struct task_struct *t)
-{
-	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
-
-	t->ret_stack = NULL;
-	/* NULL must become visible to IRQs before we free it: */
-	barrier();
-
-	kfree(ret_stack);
-}
-#endif
-- 
2.19.1


