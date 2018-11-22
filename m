Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056CAC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF34120878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF34120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbeKVMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbeKVMFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:01 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109D620821;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmk-0005Hy-Rq; Wed, 21 Nov 2018 20:28:02 -0500
Message-Id: <20181122012802.762973296@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:09 -0500
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
Subject: [RFC][PATCH 01/14] fgraph: Create a fgraph.c file to store function graph infrastructure
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the function graph infrastructure can be used by thing other than
tracing, moving the code to its own file out of the trace_functions_graph.c
code makes more sense.

The fgraph.c file will only contain the infrastructure required to hook into
functions and their return code.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Makefile                |   1 +
 kernel/trace/fgraph.c                | 233 +++++++++++++++++++++++++++
 kernel/trace/trace_functions_graph.c | 221 -------------------------
 3 files changed, 234 insertions(+), 221 deletions(-)
 create mode 100644 kernel/trace/fgraph.c

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..c7ade7965464 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
 ifeq ($(CONFIG_BLOCK),y)
 obj-$(CONFIG_EVENT_TRACING) += blktrace.o
 endif
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
new file mode 100644
index 000000000000..e8fcf1b2b38c
--- /dev/null
+++ b/kernel/trace/fgraph.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Infrastructure to took into function calls and returns.
+ * Copyright (c) 2008-2009 Frederic Weisbecker <fweisbec@gmail.com>
+ * Mostly borrowed from function tracer which
+ * is Copyright (c) Steven Rostedt <srostedt@redhat.com>
+ *
+ * Highly modified by Steven Rostedt (VMware).
+ */
+#include <linux/ftrace.h>
+
+#include "trace.h"
+
+static bool kill_ftrace_graph;
+
+/**
+ * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
+ *
+ * ftrace_graph_stop() is called when a severe error is detected in
+ * the function graph tracing. This function is called by the critical
+ * paths of function graph to keep those paths from doing any more harm.
+ */
+bool ftrace_graph_is_dead(void)
+{
+	return kill_ftrace_graph;
+}
+
+/**
+ * ftrace_graph_stop - set to permanently disable function graph tracincg
+ *
+ * In case of an error int function graph tracing, this is called
+ * to try to keep function graph tracing from causing any more harm.
+ * Usually this is pretty severe and this is called to try to at least
+ * get a warning out to the user.
+ */
+void ftrace_graph_stop(void)
+{
+	kill_ftrace_graph = true;
+}
+
+/* Add a function return address to the trace stack on thread info.*/
+static int
+ftrace_push_return_trace(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp)
+{
+	unsigned long long calltime;
+	int index;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return -EBUSY;
+
+	if (!current->ret_stack)
+		return -EBUSY;
+
+	/*
+	 * We must make sure the ret_stack is tested before we read
+	 * anything else.
+	 */
+	smp_rmb();
+
+	/* The return trace stack is full */
+	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
+		atomic_inc(&current->trace_overrun);
+		return -EBUSY;
+	}
+
+	/*
+	 * The curr_ret_stack is an index to ftrace return stack of
+	 * current task.  Its value should be in [0, FTRACE_RETFUNC_
+	 * DEPTH) when the function graph tracer is used.  To support
+	 * filtering out specific functions, it makes the index
+	 * negative by subtracting huge value (FTRACE_NOTRACE_DEPTH)
+	 * so when it sees a negative index the ftrace will ignore
+	 * the record.  And the index gets recovered when returning
+	 * from the filtered function by adding the FTRACE_NOTRACE_
+	 * DEPTH and then it'll continue to record functions normally.
+	 *
+	 * The curr_ret_stack is initialized to -1 and get increased
+	 * in this function.  So it can be less than -1 only if it was
+	 * filtered out via ftrace_graph_notrace_addr() which can be
+	 * set from set_graph_notrace file in tracefs by user.
+	 */
+	if (current->curr_ret_stack < -1)
+		return -EBUSY;
+
+	calltime = trace_clock_local();
+
+	index = ++current->curr_ret_stack;
+	if (ftrace_graph_notrace_addr(func))
+		current->curr_ret_stack -= FTRACE_NOTRACE_DEPTH;
+	barrier();
+	current->ret_stack[index].ret = ret;
+	current->ret_stack[index].func = func;
+	current->ret_stack[index].calltime = calltime;
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	current->ret_stack[index].fp = frame_pointer;
+#endif
+#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
+	current->ret_stack[index].retp = retp;
+#endif
+	return 0;
+}
+
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp)
+{
+	struct ftrace_graph_ent trace;
+
+	trace.func = func;
+	trace.depth = ++current->curr_ret_depth;
+
+	if (ftrace_push_return_trace(ret, func,
+				     frame_pointer, retp))
+		goto out;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		goto out_ret;
+
+	return 0;
+ out_ret:
+	current->curr_ret_stack--;
+ out:
+	current->curr_ret_depth--;
+	return -EBUSY;
+}
+
+/* Retrieve a function return address to the trace stack on thread info.*/
+static void
+ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
+			unsigned long frame_pointer)
+{
+	int index;
+
+	index = current->curr_ret_stack;
+
+	/*
+	 * A negative index here means that it's just returned from a
+	 * notrace'd function.  Recover index to get an original
+	 * return address.  See ftrace_push_return_trace().
+	 *
+	 * TODO: Need to check whether the stack gets corrupted.
+	 */
+	if (index < 0)
+		index += FTRACE_NOTRACE_DEPTH;
+
+	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic, otherwise we have no where to go */
+		*ret = (unsigned long)panic;
+		return;
+	}
+
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	/*
+	 * The arch may choose to record the frame pointer used
+	 * and check it here to make sure that it is what we expect it
+	 * to be. If gcc does not set the place holder of the return
+	 * address in the frame pointer, and does a copy instead, then
+	 * the function graph trace will fail. This test detects this
+	 * case.
+	 *
+	 * Currently, x86_32 with optimize for size (-Os) makes the latest
+	 * gcc do the above.
+	 *
+	 * Note, -mfentry does not use frame pointers, and this test
+	 *  is not needed if CC_USING_FENTRY is set.
+	 */
+	if (unlikely(current->ret_stack[index].fp != frame_pointer)) {
+		ftrace_graph_stop();
+		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
+		     "  from func %ps return to %lx\n",
+		     current->ret_stack[index].fp,
+		     frame_pointer,
+		     (void *)current->ret_stack[index].func,
+		     current->ret_stack[index].ret);
+		*ret = (unsigned long)panic;
+		return;
+	}
+#endif
+
+	*ret = current->ret_stack[index].ret;
+	trace->func = current->ret_stack[index].func;
+	trace->calltime = current->ret_stack[index].calltime;
+	trace->overrun = atomic_read(&current->trace_overrun);
+	trace->depth = current->curr_ret_depth--;
+	/*
+	 * We still want to trace interrupts coming in if
+	 * max_depth is set to 1. Make sure the decrement is
+	 * seen before ftrace_graph_return.
+	 */
+	barrier();
+}
+
+/*
+ * Send the trace to the ring-buffer.
+ * @return the original return address.
+ */
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+{
+	struct ftrace_graph_ret trace;
+	unsigned long ret;
+
+	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	trace.rettime = trace_clock_local();
+	ftrace_graph_return(&trace);
+	/*
+	 * The ftrace_graph_return() may still access the current
+	 * ret_stack structure, we need to make sure the update of
+	 * curr_ret_stack is after that.
+	 */
+	barrier();
+	current->curr_ret_stack--;
+	/*
+	 * The curr_ret_stack can be less than -1 only if it was
+	 * filtered out and it's about to return from the function.
+	 * Recover the index and continue to trace normal functions.
+	 */
+	if (current->curr_ret_stack < -1) {
+		current->curr_ret_stack += FTRACE_NOTRACE_DEPTH;
+		return ret;
+	}
+
+	if (unlikely(!ret)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic. What else to do? */
+		ret = (unsigned long)panic;
+	}
+
+	return ret;
+}
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2561460d7baf..af1759cd6eab 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -16,33 +16,6 @@
 #include "trace.h"
 #include "trace_output.h"
 
-static bool kill_ftrace_graph;
-
-/**
- * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
- *
- * ftrace_graph_stop() is called when a severe error is detected in
- * the function graph tracing. This function is called by the critical
- * paths of function graph to keep those paths from doing any more harm.
- */
-bool ftrace_graph_is_dead(void)
-{
-	return kill_ftrace_graph;
-}
-
-/**
- * ftrace_graph_stop - set to permanently disable function graph tracincg
- *
- * In case of an error int function graph tracing, this is called
- * to try to keep function graph tracing from causing any more harm.
- * Usually this is pretty severe and this is called to try to at least
- * get a warning out to the user.
- */
-void ftrace_graph_stop(void)
-{
-	kill_ftrace_graph = true;
-}
-
 /* When set, irq functions will be ignored */
 static int ftrace_graph_skip_irqs;
 
@@ -117,200 +90,6 @@ static void
 print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
 
-/* Add a function return address to the trace stack on thread info.*/
-static int
-ftrace_push_return_trace(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
-{
-	unsigned long long calltime;
-	int index;
-
-	if (unlikely(ftrace_graph_is_dead()))
-		return -EBUSY;
-
-	if (!current->ret_stack)
-		return -EBUSY;
-
-	/*
-	 * We must make sure the ret_stack is tested before we read
-	 * anything else.
-	 */
-	smp_rmb();
-
-	/* The return trace stack is full */
-	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
-		atomic_inc(&current->trace_overrun);
-		return -EBUSY;
-	}
-
-	/*
-	 * The curr_ret_stack is an index to ftrace return stack of
-	 * current task.  Its value should be in [0, FTRACE_RETFUNC_
-	 * DEPTH) when the function graph tracer is used.  To support
-	 * filtering out specific functions, it makes the index
-	 * negative by subtracting huge value (FTRACE_NOTRACE_DEPTH)
-	 * so when it sees a negative index the ftrace will ignore
-	 * the record.  And the index gets recovered when returning
-	 * from the filtered function by adding the FTRACE_NOTRACE_
-	 * DEPTH and then it'll continue to record functions normally.
-	 *
-	 * The curr_ret_stack is initialized to -1 and get increased
-	 * in this function.  So it can be less than -1 only if it was
-	 * filtered out via ftrace_graph_notrace_addr() which can be
-	 * set from set_graph_notrace file in tracefs by user.
-	 */
-	if (current->curr_ret_stack < -1)
-		return -EBUSY;
-
-	calltime = trace_clock_local();
-
-	index = ++current->curr_ret_stack;
-	if (ftrace_graph_notrace_addr(func))
-		current->curr_ret_stack -= FTRACE_NOTRACE_DEPTH;
-	barrier();
-	current->ret_stack[index].ret = ret;
-	current->ret_stack[index].func = func;
-	current->ret_stack[index].calltime = calltime;
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	current->ret_stack[index].fp = frame_pointer;
-#endif
-#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-	current->ret_stack[index].retp = retp;
-#endif
-	return 0;
-}
-
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
-{
-	struct ftrace_graph_ent trace;
-
-	trace.func = func;
-	trace.depth = ++current->curr_ret_depth;
-
-	if (ftrace_push_return_trace(ret, func,
-				     frame_pointer, retp))
-		goto out;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out_ret;
-
-	return 0;
- out_ret:
-	current->curr_ret_stack--;
- out:
-	current->curr_ret_depth--;
-	return -EBUSY;
-}
-
-/* Retrieve a function return address to the trace stack on thread info.*/
-static void
-ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer)
-{
-	int index;
-
-	index = current->curr_ret_stack;
-
-	/*
-	 * A negative index here means that it's just returned from a
-	 * notrace'd function.  Recover index to get an original
-	 * return address.  See ftrace_push_return_trace().
-	 *
-	 * TODO: Need to check whether the stack gets corrupted.
-	 */
-	if (index < 0)
-		index += FTRACE_NOTRACE_DEPTH;
-
-	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic, otherwise we have no where to go */
-		*ret = (unsigned long)panic;
-		return;
-	}
-
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	/*
-	 * The arch may choose to record the frame pointer used
-	 * and check it here to make sure that it is what we expect it
-	 * to be. If gcc does not set the place holder of the return
-	 * address in the frame pointer, and does a copy instead, then
-	 * the function graph trace will fail. This test detects this
-	 * case.
-	 *
-	 * Currently, x86_32 with optimize for size (-Os) makes the latest
-	 * gcc do the above.
-	 *
-	 * Note, -mfentry does not use frame pointers, and this test
-	 *  is not needed if CC_USING_FENTRY is set.
-	 */
-	if (unlikely(current->ret_stack[index].fp != frame_pointer)) {
-		ftrace_graph_stop();
-		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
-		     "  from func %ps return to %lx\n",
-		     current->ret_stack[index].fp,
-		     frame_pointer,
-		     (void *)current->ret_stack[index].func,
-		     current->ret_stack[index].ret);
-		*ret = (unsigned long)panic;
-		return;
-	}
-#endif
-
-	*ret = current->ret_stack[index].ret;
-	trace->func = current->ret_stack[index].func;
-	trace->calltime = current->ret_stack[index].calltime;
-	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth--;
-	/*
-	 * We still want to trace interrupts coming in if
-	 * max_depth is set to 1. Make sure the decrement is
-	 * seen before ftrace_graph_return.
-	 */
-	barrier();
-}
-
-/*
- * Send the trace to the ring-buffer.
- * @return the original return address.
- */
-unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
-{
-	struct ftrace_graph_ret trace;
-	unsigned long ret;
-
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
-	trace.rettime = trace_clock_local();
-	ftrace_graph_return(&trace);
-	/*
-	 * The ftrace_graph_return() may still access the current
-	 * ret_stack structure, we need to make sure the update of
-	 * curr_ret_stack is after that.
-	 */
-	barrier();
-	current->curr_ret_stack--;
-	/*
-	 * The curr_ret_stack can be less than -1 only if it was
-	 * filtered out and it's about to return from the function.
-	 * Recover the index and continue to trace normal functions.
-	 */
-	if (current->curr_ret_stack < -1) {
-		current->curr_ret_stack += FTRACE_NOTRACE_DEPTH;
-		return ret;
-	}
-
-	if (unlikely(!ret)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
-	}
-
-	return ret;
-}
-
 /**
  * ftrace_graph_ret_addr - convert a potentially modified stack return address
  *			   to its original value
-- 
2.19.1


