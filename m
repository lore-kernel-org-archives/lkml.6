Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A712C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74C42080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74C42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbeKVMFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391363AbeKVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336602146F;
        Thu, 22 Nov 2018 01:28:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmm-0005NK-7V; Wed, 21 Nov 2018 20:28:04 -0500
Message-Id: <20181122012804.122411256@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:19 -0500
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
Subject: [RFC][PATCH 11/14] function_graph: Convert ret_stack to a series of longs
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to make it possible to have multiple callbacks registered with the
function_graph tracer, the retstack needs to be converted from an array of
ftrace_ret_stack structures to an array of longs. This will allow to store
the list of callbacks on the stack for the return side of the functions.

[ Note, this currently breaks architectures that access the ret_stack of a
  task to handle unwinding when 'return_to_handler' is on the stack ]

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/sched.h |   2 +-
 kernel/trace/fgraph.c | 123 +++++++++++++++++++++++-------------------
 2 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d6183a55e8eb..71a084a300da 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1119,7 +1119,7 @@ struct task_struct {
 	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
-	struct ftrace_ret_stack		*ret_stack;
+	unsigned long			*ret_stack;
 
 	/* Timestamp for last schedule: */
 	unsigned long long		ftrace_timestamp;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 9b85638ecded..1389fe39f64c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -23,6 +23,17 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
+#define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
+#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH * FGRAPH_RET_SIZE)
+#define SHADOW_STACK_INDEX			\
+	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+
+#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
+#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
+#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
+
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
@@ -59,6 +70,7 @@ static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
 	int index;
 
@@ -75,23 +87,25 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
+	if (current->curr_ret_stack > SHADOW_STACK_MAX_INDEX) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = ++current->curr_ret_stack;
+	index = current->curr_ret_stack;
+	RET_STACK_INC(current->curr_ret_stack);
+	ret_stack = RET_STACK(current, index);
 	barrier();
-	current->ret_stack[index].ret = ret;
-	current->ret_stack[index].func = func;
-	current->ret_stack[index].calltime = calltime;
+	ret_stack->ret = ret;
+	ret_stack->func = func;
+	ret_stack->calltime = calltime;
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	current->ret_stack[index].fp = frame_pointer;
+	ret_stack->fp = frame_pointer;
 #endif
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-	current->ret_stack[index].retp = retp;
+	ret_stack->retp = retp;
 #endif
 	return 0;
 }
@@ -114,7 +128,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	return 0;
  out_ret:
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -125,11 +139,13 @@ static void
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 			unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	int index;
 
 	index = current->curr_ret_stack;
+	RET_STACK_DEC(index);
 
-	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
+	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic, otherwise we have no where to go */
@@ -137,6 +153,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		return;
 	}
 
+	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -152,22 +169,22 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	 * Note, -mfentry does not use frame pointers, and this test
 	 *  is not needed if CC_USING_FENTRY is set.
 	 */
-	if (unlikely(current->ret_stack[index].fp != frame_pointer)) {
+	if (unlikely(ret_stack->fp != frame_pointer)) {
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
 		     current->ret_stack[index].fp,
 		     frame_pointer,
-		     (void *)current->ret_stack[index].func,
-		     current->ret_stack[index].ret);
+		     (void *)ret_stack->func,
+		     ret_stack->ret);
 		*ret = (unsigned long)panic;
 		return;
 	}
 #endif
 
-	*ret = current->ret_stack[index].ret;
-	trace->func = current->ret_stack[index].func;
-	trace->calltime = current->ret_stack[index].calltime;
+	*ret = ret_stack->ret;
+	trace->func = ret_stack->func;
+	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth--;
 	/*
@@ -221,7 +238,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
@@ -236,12 +253,13 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = current->curr_ret_stack - idx;
+	int index = task->curr_ret_stack;
 
-	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &current->ret_stack[idx];
+	index -= FGRAPH_RET_INDEX * (idx + 1);
+	if (index < 0)
+		return NULL;
 
-	return NULL;
+	return RET_STACK(task, index);
 }
 
 /**
@@ -263,18 +281,20 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
+	struct ftrace_ret_stack *ret_stack;
 	int index = task->curr_ret_stack;
 	int i;
 
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	if (index < 0)
-		return ret;
+	RET_STACK_DEC(index);
 
-	for (i = 0; i <= index; i++)
-		if (task->ret_stack[i].retp == retp)
-			return task->ret_stack[i].ret;
+	for (i = index; i >= 0; RET_STACK_DEC(i)) {
+		ret_stack = RET_STACK(task, i);
+		if (ret_stack->retp == retp)
+			return ret_stack->ret;
+	}
 
 	return ret;
 }
@@ -288,14 +308,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		return ret;
 
 	task_idx = task->curr_ret_stack;
+	RET_STACK_DEC(task_idx);
 
 	if (!task->ret_stack || task_idx < *idx)
 		return ret;
 
 	task_idx -= *idx;
-	(*idx)++;
+	RET_STACK_INC(*idx);
 
-	return task->ret_stack[task_idx].ret;
+	return RET_STACK(task, task_idx);
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -329,7 +350,7 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
-static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
+static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 {
 	int i;
 	int ret = 0;
@@ -337,10 +358,7 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 	struct task_struct *g, *t;
 
 	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
-		ret_stack_list[i] =
-			kmalloc_array(FTRACE_RETFUNC_DEPTH,
-				      sizeof(struct ftrace_ret_stack),
-				      GFP_KERNEL);
+		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 		if (!ret_stack_list[i]) {
 			start = 0;
 			end = i;
@@ -359,9 +377,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
-			t->curr_ret_stack = -1;
+			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
-			/* Make sure the tasks see the -1 first: */
+			/* Make sure the tasks see the 0 first: */
 			smp_wmb();
 			t->ret_stack = ret_stack_list[start++];
 		}
@@ -379,6 +397,7 @@ static void
 ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 			struct task_struct *prev, struct task_struct *next)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
 	int index;
 
@@ -403,8 +422,11 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack; index >= 0; index--)
-		next->ret_stack[index].calltime += timestamp;
+	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
+		ret_stack = RET_STACK(next, index);
+		ret_stack->calltime += timestamp;
+		index -= FGRAPH_RET_INDEX;
+	}
 }
 
 static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
@@ -447,10 +469,10 @@ void update_function_graph_func(void)
 		ftrace_graph_entry = __ftrace_graph_entry;
 }
 
-static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
+static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
 
 static void
-graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
+graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->tracing_graph_pause, 0);
 	atomic_set(&t->trace_overrun, 0);
@@ -466,7 +488,7 @@ graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
  */
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
-	t->curr_ret_stack = -1;
+	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
@@ -476,14 +498,11 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 		WARN_ON(t->ret_stack != per_cpu(idle_ret_stack, cpu));
 
 	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
+		unsigned long *ret_stack;
 
 		ret_stack = per_cpu(idle_ret_stack, cpu);
 		if (!ret_stack) {
-			ret_stack =
-				kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					      sizeof(struct ftrace_ret_stack),
-					      GFP_KERNEL);
+			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 			if (!ret_stack)
 				return;
 			per_cpu(idle_ret_stack, cpu) = ret_stack;
@@ -497,15 +516,13 @@ void ftrace_graph_init_task(struct task_struct *t)
 {
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
-	t->curr_ret_stack = -1;
+	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
+		unsigned long *ret_stack;
 
-		ret_stack = kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					  sizeof(struct ftrace_ret_stack),
-					  GFP_KERNEL);
+		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 		if (!ret_stack)
 			return;
 		graph_init_task(t, ret_stack);
@@ -514,7 +531,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 
 void ftrace_graph_exit_task(struct task_struct *t)
 {
-	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
+	unsigned long *ret_stack = t->ret_stack;
 
 	t->ret_stack = NULL;
 	/* NULL must become visible to IRQs before we free it: */
@@ -526,12 +543,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
 /* Allocate a return stack for each task */
 static int start_graph_tracing(void)
 {
-	struct ftrace_ret_stack **ret_stack_list;
+	unsigned long **ret_stack_list;
 	int ret, cpu;
 
-	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
-				       sizeof(struct ftrace_ret_stack *),
-				       GFP_KERNEL);
+	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
-- 
2.19.1


