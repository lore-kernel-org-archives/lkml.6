Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBDE2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBDE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbeKVMGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391365AbeKVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1BF20989;
        Thu, 22 Nov 2018 01:28:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmm-0005OO-HA; Wed, 21 Nov 2018 20:28:04 -0500
Message-Id: <20181122012804.433194970@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:21 -0500
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
Subject: [RFC][PATCH 13/14] function_graph: Allow multiple users to attach to function graph
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow for multiple users to attach to function graph tracer at the same
time. Only 16 simultaneous users can attach to the tracer. This is because
there's an array that stores the pointers to the attached fgraph_ops. When a
a function being traced is entered, each of the ftrace_ops entryfunc is
called and if it returns non zero, its index into the array will be added to
the shadow stack.

On exit of the function being traced, the shadow stack will contain the
indexes of the ftrace_ops on the array that want their retfunc to be called.

Because a function may sleep for a long time (if a task sleeps itself), the
return of the function may be literally days later. If the ftrace_ops is
removed, its place on the array is replaced with a ftrace_ops that contains
the stub functions and that will be called when the function finally
returns.

If another ftrace_ops is added that happens to get the same index into the
array, its return function may be called. But that's actually the way things
current work with the old function graph tracer. If one tracer is removed
and another is added, the new one will get the return calls of the function
traced by the previous one, thus this is not a regression.

Note, being able to filter functions when both are called is not completely
handled yet, but that shouldn't be too hard to manage.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |   4 +
 kernel/trace/fgraph.c  | 261 +++++++++++++++++++++++++++++++----------
 2 files changed, 206 insertions(+), 59 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 36a0fd1316dd..746b865c46b6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -779,6 +779,8 @@ struct ftrace_ret_stack {
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	unsigned long *retp;
 #endif
+	unsigned long callers;
+	unsigned long calls[];
 };
 
 /*
@@ -798,6 +800,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp);
 /*
  * Sometimes we don't want to trace a function with the function
  * graph tracer but we want them to keep traced by the usual function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 826fa158f9b7..6e5efe1663b9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -25,26 +25,72 @@
 
 #define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
 #define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
-#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH * FGRAPH_RET_SIZE)
+
+#define FGRAPH_ARRAY_SIZE	16
+#define FGRAPH_ARRAY_MASK	0xff
+
+/* Currently the max stack index can't be more than register callers */
+#define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
+
+#define FGRAPH_INDEX_SHIFT	8
+
+#define FGRAPH_FRAME_SIZE (FGRAPH_RET_SIZE + FGRAPH_ARRAY_SIZE * (sizeof(long)))
+#define FGRAPH_FRAME_INDEX (ALIGN(FGRAPH_FRAME_SIZE,		\
+				  sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH * FGRAPH_FRAME_SIZE)
 #define SHADOW_STACK_INDEX			\
 	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_FRAME_INDEX)
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
 
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
-#define FGRAPH_ARRAY_SIZE	16
-
-#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH *			\
-	(sizeof(struct ftrace_ret_stack) +				\
-	FGRAPH_ARRAY_SIZE * sizeof(long)))
+static int fgraph_array_cnt;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int get_stack_index(struct task_struct *t, int offset)
+{
+	return current->ret_stack[offset] >> FGRAPH_INDEX_SHIFT;
+}
+
+/*
+ * @offset: The index into @t->ret_stack to find the ret_stack entry
+ * @index: Where to place the index into @t->ret_stack of that entry
+ *
+ * Calling this with:
+ *
+ *   offset = task->curr_ret_stack;
+ *   do {
+ *	ret_stack = get_ret_stack(task, offset, &offset);
+ *   } while (ret_stack);
+ *
+ * Will iterate through all the ret_stack entries from curr_ret_stack
+ * down to the first one.
+ */
+static inline struct ftrace_ret_stack *
+get_ret_stack(struct task_struct *t, int offset, int *index)
+{
+	int idx;
+
+	if (offset <= 0)
+		return NULL;
+
+	idx = get_stack_index(t, offset - 1);
+
+	if (idx <= 0 || idx > FGRAPH_MAX_INDEX)
+		return NULL;
+
+	offset -= idx + FGRAPH_RET_INDEX;
+	if (offset < 0)
+		return NULL;
+
+	*index = offset;
+	return RET_STACK(current, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -103,8 +149,28 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	calltime = trace_clock_local();
 
 	index = current->curr_ret_stack;
-	RET_STACK_INC(current->curr_ret_stack);
+	current->ret_stack[index + FGRAPH_RET_INDEX] = 1 << FGRAPH_INDEX_SHIFT;
 	ret_stack = RET_STACK(current, index);
+	ret_stack->ret = ret;
+	/*
+	 * The undwinders expect curr_ret_stack to point to either zero
+	 * or an index where to find the next ret_stack. Even though the
+	 * ret stack might be bogus, we want to write the ret and the
+	 * index to find the ret_stack before we increment the stack point.
+	 * If an interrupt comes in now before we increment the curr_ret_stack
+	 * it may blow away what we wrote. But that's fine, because the
+	 * index will still be correct (even though the ret wont be).
+	 * What we worry about is the index being correct after we increment
+	 * the curr_ret_stack and before we update that index, as if an
+	 * interrupt comes in and does an unwind stack dump, it will need
+	 * at least a correct index!
+	 */
+	barrier();
+	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
 	barrier();
 	ret_stack->ret = ret;
 	ret_stack->func = func;
@@ -122,6 +188,11 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	int cnt = 0;
+	int offset;
+	int idx;
+	int val;
+	int i;
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
@@ -130,38 +201,73 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 				     frame_pointer, retp))
 		goto out;
 
-	/* Only trace if the calling function expects to */
-	if (!fgraph_array[0]->entryfunc(&trace))
+	offset = current->curr_ret_stack - 1;
+
+	for (i = 0, idx = 0; i < fgraph_array_cnt; i++) {
+		if (fgraph_array[i]->entryfunc(&trace)) {
+			val = i | ((++idx) << FGRAPH_INDEX_SHIFT);
+			current->ret_stack[offset] = val;
+			/*
+			 * ftrace_push_return_trace includes one
+			 * callback already (to ensure unwinders can
+			 * find the ret_stack.
+			 * We only need to increment curr_ret_stack
+			 * if there's more than one.
+			 */
+			if (idx == 1) {
+				offset++;
+				cnt++;
+				continue;
+			}
+			/*
+			 * Write the value before we increment, so that
+			 * if an interrupt comes in after we increment
+			 * it will still see the value and skip over
+			 * this.
+			 */
+			barrier();
+			/*
+			 * Have to write again, in case an interrupt
+			 * came in before the increment and after we
+			 * wrote the value.
+			 */
+			current->curr_ret_stack++;
+			barrier();
+			current->ret_stack[offset++] = val;
+			cnt++;
+		}
+	}
+
+	if (!cnt)
 		goto out_ret;
 
 	return 0;
  out_ret:
-	RET_STACK_DEC(current->curr_ret_stack);
+	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-static void
+static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 			unsigned long frame_pointer)
 {
 	struct ftrace_ret_stack *ret_stack;
 	int index;
 
-	index = current->curr_ret_stack;
-	RET_STACK_DEC(index);
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
 
-	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
+		WARN(1, "Bad function graph ret_stack pointer: %d",
+		     index);
 		/* Might as well panic, otherwise we have no where to go */
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 
-	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -181,12 +287,12 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
-		     current->ret_stack[index].fp,
+		     ret_stack->fp,
 		     frame_pointer,
 		     (void *)ret_stack->func,
 		     ret_stack->ret);
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 #endif
 
@@ -194,13 +300,15 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth--;
+	trace->depth = current->curr_ret_depth;
 	/*
 	 * We still want to trace interrupts coming in if
 	 * max_depth is set to 1. Make sure the decrement is
 	 * seen before ftrace_graph_return.
 	 */
 	barrier();
+
+	return ret_stack;
 }
 
 /*
@@ -234,40 +342,63 @@ static struct notifier_block ftrace_suspend_notifier = {
  */
 unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
+	int offset;
+	int index;
+	int idx;
+	int val;
+	int i;
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
-	trace.rettime = trace_clock_local();
-	fgraph_array[0]->retfunc(&trace);
-	/*
-	 * The ftrace_graph_return() may still access the current
-	 * ret_stack structure, we need to make sure the update of
-	 * curr_ret_stack is after that.
-	 */
-	barrier();
-	RET_STACK_DEC(current->curr_ret_stack);
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
+		return (unsigned long)panic;
 	}
 
+	trace.rettime = trace_clock_local();
+
+	offset = current->curr_ret_stack - 1;
+	index = get_stack_index(current, offset);
+
+	/* index has to be at least one! Optimize for it */
+	i = 0;
+	do {
+		val = current->ret_stack[offset - i];
+		idx = val & FGRAPH_ARRAY_MASK;
+		fgraph_array[idx]->retfunc(&trace);
+		i++;
+	} while (i < index);
+
+	/*
+	 * The ftrace_graph_return() may still access the current
+	 * ret_stack structure, we need to make sure the update of
+	 * curr_ret_stack is after that.
+	 */
+	barrier();
+	current->curr_ret_stack -= index + FGRAPH_RET_INDEX;
+	current->curr_ret_depth--;
 	return ret;
 }
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
+	struct ftrace_ret_stack *ret_stack = NULL;
 	int index = task->curr_ret_stack;
 
-	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;
 
-	return RET_STACK(task, index);
+	do {
+		ret_stack = get_ret_stack(task, index, &index);
+	} while (ret_stack && --idx >= 0);
+
+	return ret_stack;
 }
 
 /**
@@ -290,16 +421,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index = task->curr_ret_stack;
-	int i;
+	int i = task->curr_ret_stack;
 
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	RET_STACK_DEC(index);
-
-	for (i = index; i >= 0; RET_STACK_DEC(i)) {
-		ret_stack = RET_STACK(task, i);
+	while (i > 0) {
+		ret_stack = get_ret_stack(current, i, &i);
+		if (!ret_stack)
+			break;
 		if (ret_stack->retp == retp)
 			return ret_stack->ret;
 	}
@@ -310,21 +440,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	int task_idx;
+	struct ftrace_ret_stack *ret_stack;
+	int task_idx = task->curr_ret_stack;
+	int i;
 
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	task_idx = task->curr_ret_stack;
-	RET_STACK_DEC(task_idx);
-
-	if (!task->ret_stack || task_idx < *idx)
+	if (!idx)
 		return ret;
 
-	task_idx -= *idx;
-	RET_STACK_INC(*idx);
+	i = *idx;
+	do {
+		ret_stack = get_ret_stack(task, task_idx, &task_idx);
+		i--;
+	} while (i >= 0 && ret_stack);
+
+	if (ret_stack)
+		return ret_stack->ret;
 
-	return RET_STACK(task, task_idx);
+	return ret;
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -435,10 +570,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index -= FGRAPH_RET_INDEX;
+	for (index = next->curr_ret_stack; index > 0; ) {
+		ret_stack = get_ret_stack(next, index, &index);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -490,6 +625,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 	atomic_set(&t->tracing_graph_pause, 0);
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = 0;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;
@@ -610,6 +747,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	}
 
 	fgraph_array[i] = gops;
+	if (i + 1 > fgraph_array_cnt)
+		fgraph_array_cnt = i + 1;
 
 	register_pm_notifier(&ftrace_suspend_notifier);
 
@@ -646,15 +785,19 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	/* Look for an available spot */
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
-		if (fgraph_array[i] == gops)
+	for (i = 0; i < fgraph_array_cnt; i++)
+		if (gops == fgraph_array[i])
 			break;
-	}
-	if (i == FGRAPH_ARRAY_SIZE)
+	if (i >= fgraph_array_cnt)
 		goto out;
 
 	fgraph_array[i] = &fgraph_stub;
+	if (i + 1 == fgraph_array_cnt) {
+		for (; i >= 0; i--)
+			if (fgraph_array[i] != &fgraph_stub)
+				break;
+		fgraph_array_cnt = i + 1;
+	}
 
 	ftrace_graph_active--;
 	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
-- 
2.19.1


