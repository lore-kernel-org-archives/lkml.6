Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F360C21874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeL1X2Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeL1X2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:28:25 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DA8217F9;
        Fri, 28 Dec 2018 23:28:15 +0000 (UTC)
Date:   Fri, 28 Dec 2018 18:28:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [GIT PULL] tracing: Update for 4.21
Message-ID: <20181228182813.01ae131a@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing changes for v4.21:

 - Rework of the kprobe/uprobe and synthetic events to consolidate all
   the dynamic event code. This will make changes in the future easier.

 - Partial rewrite of the function graph tracing infrastructure.
   This will allow for multiple users of hooking onto functions
   to get the callback (return) of the function. This is the ground
   work for having kprobes and function graph tracer using one code base.

 - Clean up of the histogram code that will facilitate adding more
   features to the histograms in the future.

 - Addition of str_has_prefix() and a few use cases. There currently
   is a similar function strstart() that is used in a few places, but
   only returns a bool and not a length. These instances will be
   removed in the future to use str_has_prefix() instead.

 - A few other various clean ups as well.


Please pull the latest trace-v4.21 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.21

Tag SHA1: bcf1ea7cb12ce702d1d0660dfba0c3462c0b04e1
Head SHA1: 3d739c1f6156c70eb0548aa288dcfbac9e0bd162


Dan Carpenter (1):
      tracing: Have trace_stack nr_entries compare not be so subtle

Joe Lawrence (1):
      scripts/recordmcount.{c,pl}: support -ffunction-sections .text.* section names

Masami Hiramatsu (11):
      tracing/uprobes: Add busy check when cleanup all uprobes
      tracing: Lock event_mutex before synth_event_mutex
      tracing: Simplify creation and deletion of synthetic events
      tracing: Integrate similar probe argument parsers
      tracing: Add unified dynamic event framework
      tracing/kprobes: Use dyn_event framework for kprobe events
      tracing/uprobes: Use dyn_event framework for uprobe events
      tracing: Use dyn_event framework for synthetic events
      tracing: Remove unneeded synth_event_mutex
      tracing: Add generic event-name based remove event method
      selftests/ftrace: Add testcases for dynamic event

Mathieu Malaterre (1):
      tracing: Make function ‘ftrace_exports’ static

Michael Ellerman (2):
      seq_buf: Make seq_buf_puts() null-terminate the buffer
      seq_buf: Use size_t for len in seq_buf_puts()

Rasmus Villemoes (3):
      tracing: Merge seq_print_sym_short() and seq_print_sym_offset()
      tracing: Avoid -Wformat-nonliteral warning
      tracing: Simplify printf'ing in seq_print_sym

Steven Rostedt (VMware) (31):
      function_graph: Remove unused task_curr_ret_stack()
      tracing: Do not line wrap short line in function_graph_enter()
      fgraph: Create a fgraph.c file to store function graph infrastructure
      fgraph: Have set_graph_notrace only affect function_graph tracer
      arm64: function_graph: Remove use of FTRACE_NOTRACE_DEPTH
      function_graph: Remove the use of FTRACE_NOTRACE_DEPTH
      ftrace: Create new ftrace_internal.h header
      function_graph: Do not expose the graph_time option when profiler is not configured
      fgraph: Move function graph specific code into fgraph.c
      tracing: Rearrange functions in trace_sched_wakeup.c
      fgraph: Add new fgraph_ops structure to enable function graph hooks
      function_graph: Move ftrace_graph_ret_addr() to fgraph.c
      function_graph: Have profiler use new helper ftrace_graph_get_ret_stack()
      ring-buffer: Add percentage of ring buffer full to wake up reader
      tracing: Add tracefs file buffer_percentage
      tracing: Change default buffer_percent to 50
      tracing: Consolidate trace_add/remove_event_call back to the nolock functions
      ftrace: Allow ftrace_replace_code() to be schedulable
      arm64: ftrace: Set FTRACE_MAY_SLEEP before ftrace_modify_all_code()
      fgraph: Add comment to describe ftrace_graph_get_ret_stack
      x86/ftrace: Do not call function graph from dynamic trampolines
      powerpc/frace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      tracing: Fix ftrace_graph_get_ret_stack() to use task and not current
      string.h: Add str_has_prefix() helper function
      tracing: Use str_has_prefix() helper for histogram code
      tracing: Use str_has_prefix() instead of using fixed sizes
      tracing: Have the historgram use the result of str_has_prefix() for len of prefix
      tracing: Use the return of str_has_prefix() to remove open coded numbers

Tom Zanussi (7):
      tracing: Remove unnecessary hist trigger struct field
      tracing: Change strlen to sizeof for hist trigger static strings
      tracing: Use var_refs[] for hist trigger reference checking
      tracing: Remove open-coding of hist trigger var_ref management
      tracing: Use hist trigger's var_ref array to destroy var_refs
      tracing: Remove hist trigger synth_var_refs
      tracing: Add hist trigger comments for variable-related fields

----
 Documentation/trace/kprobetrace.rst                |   3 +
 Documentation/trace/uprobetracer.rst               |   4 +
 arch/arm64/kernel/ftrace.c                         |   1 +
 arch/arm64/kernel/perf_callchain.c                 |   2 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/arm64/kernel/return_address.c                 |   2 +-
 arch/arm64/kernel/stacktrace.c                     |  15 +-
 arch/arm64/kernel/time.c                           |   2 +-
 arch/arm64/kernel/traps.c                          |   2 +-
 arch/powerpc/kernel/process.c                      |  13 +-
 arch/sh/kernel/dumpstack.c                         |  11 +-
 arch/sh/kernel/dwarf.c                             |   9 +-
 arch/sparc/kernel/perf_event.c                     |   8 +-
 arch/sparc/kernel/stacktrace.c                     |   8 +-
 arch/sparc/kernel/traps_64.c                       |   7 +-
 arch/x86/kernel/ftrace.c                           |  41 +-
 arch/x86/kernel/ftrace_64.S                        |   8 +-
 include/linux/ftrace.h                             |  36 +-
 include/linux/ring_buffer.h                        |   4 +-
 include/linux/string.h                             |  20 +
 kernel/events/uprobes.c                            |   2 -
 kernel/trace/Kconfig                               |   6 +
 kernel/trace/Makefile                              |   2 +
 kernel/trace/fgraph.c                              | 626 +++++++++++++++++++++
 kernel/trace/ftrace.c                              | 491 ++--------------
 kernel/trace/ftrace_internal.h                     |  75 +++
 kernel/trace/ring_buffer.c                         |  94 +++-
 kernel/trace/trace.c                               |  82 ++-
 kernel/trace/trace.h                               |  13 +
 kernel/trace/trace_dynevent.c                      | 217 +++++++
 kernel/trace/trace_dynevent.h                      | 119 ++++
 kernel/trace/trace_events.c                        |  10 +-
 kernel/trace/trace_events_filter.c                 |   5 +-
 kernel/trace/trace_events_hist.c                   | 597 +++++++++++---------
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/trace_functions_graph.c               | 334 ++---------
 kernel/trace/trace_irqsoff.c                       |  18 +-
 kernel/trace/trace_kprobe.c                        | 353 ++++++------
 kernel/trace/trace_output.c                        |  38 +-
 kernel/trace/trace_probe.c                         |  91 ++-
 kernel/trace/trace_probe.h                         |   9 +-
 kernel/trace/trace_sched_wakeup.c                  | 270 +++++----
 kernel/trace/trace_selftest.c                      |   8 +-
 kernel/trace/trace_stack.c                         |   8 +-
 kernel/trace/trace_uprobe.c                        | 301 +++++-----
 lib/seq_buf.c                                      |   8 +-
 scripts/recordmcount.c                             |   2 +-
 scripts/recordmcount.pl                            |  13 +
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  30 +
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |  27 +
 .../ftrace/test.d/dynevent/clear_select_events.tc  |  50 ++
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |  49 ++
 52 files changed, 2497 insertions(+), 1655 deletions(-)
 create mode 100644 kernel/trace/fgraph.c
 create mode 100644 kernel/trace/ftrace_internal.h
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
---------------------------
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 47e765c2f2c3..235ce2ab131a 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -20,6 +20,9 @@ current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/kprobe_events, and enable it via
 /sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
 
+You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+kprobe_events. That interface will provide unified access to other
+dynamic events too.
 
 Synopsis of kprobe_events
 -------------------------
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index d0822811527a..4c3bfde2ba47 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -18,6 +18,10 @@ current_tracer. Instead of that, add probe points via
 However unlike kprobe-event tracer, the uprobe event interface expects the
 user to calculate the offset of the probepoint in the object.
 
+You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+uprobe_events. That interface will provide unified access to other
+dynamic events too.
+
 Synopsis of uprobe_tracer
 -------------------------
 ::
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 57e962290df3..57d4e936a176 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 
 void arch_ftrace_update_code(int command)
 {
+	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
 }
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..1b792b46604e 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -164,7 +164,7 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, callchain_trace, entry);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d6dd8b..37a66394b07d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -459,7 +459,7 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.fp = thread_saved_fp(p);
 	frame.pc = thread_saved_pc(p);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = p->curr_ret_stack;
+	frame.graph = 0;
 #endif
 	do {
 		if (unwind_frame(p, &frame))
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 933adbc0f654..53c40196b607 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -44,7 +44,7 @@ void *return_address(unsigned int level)
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.pc = (unsigned long)return_address; /* dummy */
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, save_return_addr, &data);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7ea1e59..1a29f2695ff2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -59,18 +59,17 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
-		if (WARN_ON_ONCE(frame->graph == -1))
-			return -EINVAL;
-		if (frame->graph < -1)
-			frame->graph += FTRACE_NOTRACE_DEPTH;
-
+		struct ftrace_ret_stack *ret_stack;
 		/*
 		 * This is a case where function graph tracer has
 		 * modified a return address (LR) in a stack frame
 		 * to hook a function return.
 		 * So replace it to an original value.
 		 */
-		frame->pc = tsk->ret_stack[frame->graph--].ret;
+		ret_stack = ftrace_graph_get_ret_stack(tsk, frame->graph++);
+		if (WARN_ON_ONCE(!ret_stack))
+			return -EINVAL;
+		frame->pc = ret_stack->ret;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
@@ -137,7 +136,7 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, save_trace, &data);
@@ -168,7 +167,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		frame.pc = (unsigned long)__save_stack_trace;
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(tsk, &frame, save_trace, &data);
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index f258636273c9..a777ae90044d 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -52,7 +52,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 	do {
 		int ret = unwind_frame(NULL, &frame);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5f4d9acb32f5..49ebf3771391 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -122,7 +122,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = thread_saved_pc(tsk);
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	skip = !!regs;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..ce393df243aa 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2061,9 +2061,10 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int count = 0;
 	int firstframe = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	int curr_frame = current->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack;
 	extern void return_to_handler(void);
 	unsigned long rth = (unsigned long)return_to_handler;
+	int curr_frame = 0;
 #endif
 
 	sp = (unsigned long) stack;
@@ -2089,9 +2090,13 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
-				pr_cont(" (%pS)",
-				       (void *)current->ret_stack[curr_frame].ret);
-				curr_frame--;
+				ret_stack = ftrace_graph_get_ret_stack(current,
+								  curr_frame++);
+				if (ret_stack)
+					pr_cont(" (%pS)",
+						(void *)ret_stack->ret);
+				else
+					curr_frame = -1;
 			}
 #endif
 			if (firstframe)
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index b564b1eae4ae..2c2e151bf39e 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -59,17 +59,20 @@ print_ftrace_graph_addr(unsigned long addr, void *data,
 			struct thread_info *tinfo, int *graph)
 {
 	struct task_struct *task = tinfo->task;
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long ret_addr;
-	int index = task->curr_ret_stack;
 
 	if (addr != (unsigned long)return_to_handler)
 		return;
 
-	if (!task->ret_stack || index < *graph)
+	if (!task->ret_stack)
 		return;
 
-	index -= *graph;
-	ret_addr = task->ret_stack[index].ret;
+	ret_stack = ftrace_graph_get_ret_stack(task, *graph);
+	if (!ret_stack)
+		return;
+
+	ret_addr = ret_stack->ret;
 
 	ops->address(data, ret_addr, 1);
 
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bb511e2d9d68..df0fd6efe758 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -608,17 +608,18 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * expected to find the real return address.
 	 */
 	if (pc == (unsigned long)&return_to_handler) {
-		int index = current->curr_ret_stack;
+		struct ftrace_ret_stack *ret_stack;
 
+		ret_stack = ftrace_graph_get_ret_stack(current, 0);
+		if (ret_stack)
+			pc = ret_stack->ret;
 		/*
 		 * We currently have no way of tracking how many
 		 * return_to_handler()'s we've seen. If there is more
 		 * than one patched return address on our stack,
 		 * complain loudly.
 		 */
-		WARN_ON(index > 0);
-
-		pc = current->ret_stack[index].ret;
+		WARN_ON(ftrace_graph_get_ret_stack(current, 1);
 	}
 #endif
 
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 47c871394ccb..6de7c684c29f 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1767,9 +1767,11 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		perf_callchain_store(entry, pc);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 		if ((pc + 8UL) == (unsigned long) &return_to_handler) {
-			int index = current->curr_ret_stack;
-			if (current->ret_stack && index >= graph) {
-				pc = current->ret_stack[index - graph].ret;
+			struct ftrace_ret_stack *ret_stack;
+			ret_stack = ftrace_graph_get_ret_stack(current,
+							       graph);
+			if (ret_stack) {
+				pc = ret_stack->ret;
 				perf_callchain_store(entry, pc);
 				graph++;
 			}
diff --git a/arch/sparc/kernel/stacktrace.c b/arch/sparc/kernel/stacktrace.c
index be4c14cccc05..dd654e651500 100644
--- a/arch/sparc/kernel/stacktrace.c
+++ b/arch/sparc/kernel/stacktrace.c
@@ -57,9 +57,11 @@ static void __save_stack_trace(struct thread_info *tp,
 			trace->entries[trace->nr_entries++] = pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((pc + 8UL) == (unsigned long) &return_to_handler) {
-				int index = t->curr_ret_stack;
-				if (t->ret_stack && index >= graph) {
-					pc = t->ret_stack[index - graph].ret;
+				struct ftrace_ret_stack *ret_stack;
+				ret_stack = ftrace_graph_get_ret_stack(t,
+								       graph);
+				if (ret_stack) {
+					pc = ret_stack->ret;
 					if (trace->nr_entries <
 					    trace->max_entries)
 						trace->entries[trace->nr_entries++] = pc;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index aa624ed79db1..0cd02a64a451 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2502,9 +2502,10 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		printk(" [%016lx] %pS\n", pc, (void *) pc);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 		if ((pc + 8UL) == (unsigned long) &return_to_handler) {
-			int index = tsk->curr_ret_stack;
-			if (tsk->ret_stack && index >= graph) {
-				pc = tsk->ret_stack[index - graph].ret;
+			struct ftrace_ret_stack *ret_stack;
+			ret_stack = ftrace_graph_get_ret_stack(tsk, graph);
+			if (ret_stack) {
+				pc = ret_stack->ret;
 				printk(" [%016lx] %pS\n", pc, (void *) pc);
 				graph++;
 			}
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7ee8067cbf45..8257a59704ae 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -733,18 +733,20 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
+#define RET_SIZE		1
+
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 {
-	unsigned const char *jmp;
 	unsigned long start_offset;
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long ip;
+	unsigned long retq;
 	unsigned long *ptr;
 	void *trampoline;
+	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	union ftrace_op_code_union op_ptr;
@@ -764,27 +766,27 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	/*
 	 * Allocate enough size to store the ftrace_caller code,
-	 * the jmp to ftrace_epilogue, as well as the address of
-	 * the ftrace_ops this trampoline is used for.
+	 * the iret , as well as the address of the ftrace_ops this
+	 * trampoline is used for.
 	 */
-	trampoline = alloc_tramp(size + MCOUNT_INSN_SIZE + sizeof(void *));
+	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
 	if (!trampoline)
 		return 0;
 
-	*tramp_size = size + MCOUNT_INSN_SIZE + sizeof(void *);
+	*tramp_size = size + RET_SIZE + sizeof(void *);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0)) {
-		tramp_free(trampoline, *tramp_size);
-		return 0;
-	}
+	if (WARN_ON(ret < 0))
+		goto fail;
 
-	ip = (unsigned long)trampoline + size;
+	ip = trampoline + size;
 
-	/* The trampoline ends with a jmp to ftrace_epilogue */
-	jmp = ftrace_jmp_replace(ip, (unsigned long)ftrace_epilogue);
-	memcpy(trampoline + size, jmp, MCOUNT_INSN_SIZE);
+	/* The trampoline ends with ret(q) */
+	retq = (unsigned long)ftrace_stub;
+	ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
+	if (WARN_ON(ret < 0))
+		goto fail;
 
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
@@ -794,17 +796,15 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the global function_trace_op variable.
 	 */
 
-	ptr = (unsigned long *)(trampoline + size + MCOUNT_INSN_SIZE);
+	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
 	*ptr = (unsigned long)ops;
 
 	op_offset -= start_offset;
 	memcpy(&op_ptr, trampoline + op_offset, OP_REF_SIZE);
 
 	/* Are we pointing to the reference? */
-	if (WARN_ON(memcmp(op_ptr.op, op_ref, 3) != 0)) {
-		tramp_free(trampoline, *tramp_size);
-		return 0;
-	}
+	if (WARN_ON(memcmp(op_ptr.op, op_ref, 3) != 0))
+		goto fail;
 
 	/* Load the contents of ptr into the callback parameter */
 	offset = (unsigned long)ptr;
@@ -819,6 +819,9 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
 	return (unsigned long)trampoline;
+fail:
+	tramp_free(trampoline, *tramp_size);
+	return 0;
 }
 
 static unsigned long calc_trampoline_call_offset(bool save_regs)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 91b2cff4b79a..75f2b36b41a6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -171,9 +171,6 @@ GLOBAL(ftrace_call)
 	restore_mcount_regs
 
 	/*
-	 * The copied trampoline must call ftrace_epilogue as it
-	 * still may need to call the function graph tracer.
-	 *
 	 * The code up to this label is copied into trampolines so
 	 * think twice before adding any new code or changing the
 	 * layout here.
@@ -185,7 +182,10 @@ GLOBAL(ftrace_graph_call)
 	jmp ftrace_stub
 #endif
 
-/* This is weak to keep gas from relaxing the jumps */
+/*
+ * This is weak to keep gas from relaxing the jumps.
+ * It is also used to copy the retq for trampolines.
+ */
 WEAK(ftrace_stub)
 	retq
 ENDPROC(ftrace_caller)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dd16e8218db3..13485a19e964 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -389,6 +389,7 @@ enum {
 	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
 	FTRACE_START_FUNC_RET		= (1 << 3),
 	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_MAY_SLEEP		= (1 << 5),
 };
 
 /*
@@ -749,6 +750,11 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+struct fgraph_ops {
+	trace_func_graph_ent_t		entryfunc;
+	trace_func_graph_ret_t		retfunc;
+};
+
 /*
  * Stack of return addresses for functions
  * of a thread.
@@ -780,6 +786,9 @@ extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
+struct ftrace_ret_stack *
+ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
+
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 
@@ -790,11 +799,11 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
  */
 #define __notrace_funcgraph		notrace
 
-#define FTRACE_NOTRACE_DEPTH 65536
 #define FTRACE_RETFUNC_DEPTH 50
 #define FTRACE_RETSTACK_ALLOC_SIZE 32
-extern int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-				trace_func_graph_ent_t entryfunc);
+
+extern int register_ftrace_graph(struct fgraph_ops *ops);
+extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
 extern bool ftrace_graph_is_dead(void);
 extern void ftrace_graph_stop(void);
@@ -803,17 +812,10 @@ extern void ftrace_graph_stop(void);
 extern trace_func_graph_ret_t ftrace_graph_return;
 extern trace_func_graph_ent_t ftrace_graph_entry;
 
-extern void unregister_ftrace_graph(void);
-
 extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
 
-static inline int task_curr_ret_stack(struct task_struct *t)
-{
-	return t->curr_ret_stack;
-}
-
 static inline void pause_graph_tracing(void)
 {
 	atomic_inc(&current->tracing_graph_pause);
@@ -831,17 +833,9 @@ static inline void ftrace_graph_init_task(struct task_struct *t) { }
 static inline void ftrace_graph_exit_task(struct task_struct *t) { }
 static inline void ftrace_graph_init_idle_task(struct task_struct *t, int cpu) { }
 
-static inline int register_ftrace_graph(trace_func_graph_ret_t retfunc,
-			  trace_func_graph_ent_t entryfunc)
-{
-	return -1;
-}
-static inline void unregister_ftrace_graph(void) { }
-
-static inline int task_curr_ret_stack(struct task_struct *tsk)
-{
-	return -1;
-}
+/* Define as macros as fgraph_ops may not be defined */
+#define register_ftrace_graph(ops) ({ -1; })
+#define unregister_ftrace_graph(ops) do { } while (0)
 
 static inline unsigned long
 ftrace_graph_ret_addr(struct task_struct *task, int *idx, unsigned long ret,
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0940fda59872..5b9ae62272bb 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -97,7 +97,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
-int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full);
+int ring_buffer_wait(struct ring_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table);
 
@@ -189,6 +189,8 @@ bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
+size_t ring_buffer_nr_pages(struct ring_buffer *buffer, int cpu);
+size_t ring_buffer_nr_dirty_pages(struct ring_buffer *buffer, int cpu);
 
 void *ring_buffer_alloc_read_page(struct ring_buffer *buffer, int cpu);
 void ring_buffer_free_read_page(struct ring_buffer *buffer, int cpu, void *data);
diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..7927b875f80c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -456,4 +456,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 98b9312ce6b2..96d4bee83489 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -572,9 +572,7 @@ static void put_uprobe(struct uprobe *uprobe)
 		 * gets called, we don't get a chance to remove uprobe from
 		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 		 */
-		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
-		mutex_unlock(&delayed_uprobe_lock);
 		kfree(uprobe);
 	}
 }
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5e3de28c7677..fa8b1fe824f3 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -461,6 +461,7 @@ config KPROBE_EVENTS
 	bool "Enable kprobes-based dynamic events"
 	select TRACING
 	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
 	default y
 	help
 	  This allows the user to add tracing events (similar to tracepoints)
@@ -500,6 +501,7 @@ config UPROBE_EVENTS
 	depends on PERF_EVENTS
 	select UPROBES
 	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
 	select TRACING
 	default y
 	help
@@ -518,6 +520,9 @@ config BPF_EVENTS
 	help
 	  This allows the user to attach BPF programs to kprobe events.
 
+config DYNAMIC_EVENTS
+	def_bool n
+
 config PROBE_EVENTS
 	def_bool n
 
@@ -630,6 +635,7 @@ config HIST_TRIGGERS
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select TRACING_MAP
 	select TRACING
+	select DYNAMIC_EVENTS
 	default n
 	help
 	  Hist triggers allow one or more arbitrary trace event fields
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..c2b2148bb1d2 100644
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
@@ -78,6 +79,7 @@ endif
 ifeq ($(CONFIG_TRACING),y)
 obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
+obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
new file mode 100644
index 000000000000..8dfd5021b933
--- /dev/null
+++ b/kernel/trace/fgraph.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Infrastructure to took into function calls and returns.
+ * Copyright (c) 2008-2009 Frederic Weisbecker <fweisbec@gmail.com>
+ * Mostly borrowed from function tracer which
+ * is Copyright (c) Steven Rostedt <srostedt@redhat.com>
+ *
+ * Highly modified by Steven Rostedt (VMware).
+ */
+#include <linux/suspend.h>
+#include <linux/ftrace.h>
+#include <linux/slab.h>
+
+#include <trace/events/sched.h>
+
+#include "ftrace_internal.h"
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ASSIGN_OPS_HASH(opsname, val) \
+	.func_hash		= val, \
+	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+#else
+#define ASSIGN_OPS_HASH(opsname, val)
+#endif
+
+static bool kill_ftrace_graph;
+int ftrace_graph_active;
+
+/* Both enabled by default (can be cleared by function_graph tracer flags */
+static bool fgraph_sleep_time = true;
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
+	calltime = trace_clock_local();
+
+	index = ++current->curr_ret_stack;
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
+	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
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
+
+/**
+ * ftrace_graph_get_ret_stack - return the entry of the shadow stack
+ * @task: The task to read the shadow stack from
+ * @idx: Index down the shadow stack
+ *
+ * Return the ret_struct on the shadow stack of the @task at the
+ * call graph at @idx starting with zero. If @idx is zero, it
+ * will return the last saved ret_stack entry. If it is greater than
+ * zero, it will return the corresponding ret_stack for the depth
+ * of saved return addresses.
+ */
+struct ftrace_ret_stack *
+ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
+{
+	idx = task->curr_ret_stack - idx;
+
+	if (idx >= 0 && idx <= task->curr_ret_stack)
+		return &task->ret_stack[idx];
+
+	return NULL;
+}
+
+/**
+ * ftrace_graph_ret_addr - convert a potentially modified stack return address
+ *			   to its original value
+ *
+ * This function can be called by stack unwinding code to convert a found stack
+ * return address ('ret') to its original value, in case the function graph
+ * tracer has modified it to be 'return_to_handler'.  If the address hasn't
+ * been modified, the unchanged value of 'ret' is returned.
+ *
+ * 'idx' is a state variable which should be initialized by the caller to zero
+ * before the first call.
+ *
+ * 'retp' is a pointer to the return address on the stack.  It's ignored if
+ * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
+ */
+#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
+unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
+				    unsigned long ret, unsigned long *retp)
+{
+	int index = task->curr_ret_stack;
+	int i;
+
+	if (ret != (unsigned long)return_to_handler)
+		return ret;
+
+	if (index < 0)
+		return ret;
+
+	for (i = 0; i <= index; i++)
+		if (task->ret_stack[i].retp == retp)
+			return task->ret_stack[i].ret;
+
+	return ret;
+}
+#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
+unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
+				    unsigned long ret, unsigned long *retp)
+{
+	int task_idx;
+
+	if (ret != (unsigned long)return_to_handler)
+		return ret;
+
+	task_idx = task->curr_ret_stack;
+
+	if (!task->ret_stack || task_idx < *idx)
+		return ret;
+
+	task_idx -= *idx;
+	(*idx)++;
+
+	return task->ret_stack[task_idx].ret;
+}
+#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
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
+int register_ftrace_graph(struct fgraph_ops *gops)
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
+	ftrace_graph_return = gops->retfunc;
+
+	/*
+	 * Update the indirect function to the entryfunc, and the
+	 * function that gets called to the entry_test first. Then
+	 * call the update fgraph entry function to determine if
+	 * the entryfunc should be called directly or not.
+	 */
+	__ftrace_graph_entry = gops->entryfunc;
+	ftrace_graph_entry = ftrace_graph_entry_test;
+	update_function_graph_func();
+
+	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+out:
+	mutex_unlock(&ftrace_lock);
+	return ret;
+}
+
+void unregister_ftrace_graph(struct fgraph_ops *gops)
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
index e23eb9fc77aa..ab3e8b995e12 100644
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
@@ -40,6 +39,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 
+#include "ftrace_internal.h"
 #include "trace_output.h"
 #include "trace_stat.h"
 
@@ -77,7 +77,12 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-static struct ftrace_ops ftrace_list_end __read_mostly = {
+enum {
+	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
+	FTRACE_MODIFY_MAY_SLEEP_FL	= (1 << 1),
+};
+
+struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
 	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
 	INIT_OPS_HASH(ftrace_list_end)
@@ -112,11 +117,11 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops);
  */
 static int ftrace_disabled __read_mostly;
 
-static DEFINE_MUTEX(ftrace_lock);
+DEFINE_MUTEX(ftrace_lock);
 
-static struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
+struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
 ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
-static struct ftrace_ops global_ops;
+struct ftrace_ops global_ops;
 
 #if ARCH_SUPPORTS_FTRACE_OPS
 static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
@@ -127,26 +132,6 @@ static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
 #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
 #endif
 
-/*
- * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_notrace() is that elements removed from this list
- * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
- * concurrent insertions into the ftrace_global_list.
- *
- * Silly Alpha and silly pointer-speculation compiler optimizations!
- */
-#define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_notrace(list);			\
-	do
-
-/*
- * Optimized for just a single item in the list (as that is the normal case).
- */
-#define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
-	       unlikely((op) != &ftrace_list_end))
-
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -186,18 +171,6 @@ static void ftrace_sync_ipi(void *data)
 	smp_rmb();
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static void update_function_graph_func(void);
-
-/* Both enabled by default (can be cleared by function_graph tracer flags */
-static bool fgraph_sleep_time = true;
-static bool fgraph_graph_time = true;
-
-#else
-static inline void update_function_graph_func(void) { }
-#endif
-
-
 static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
 {
 	/*
@@ -334,7 +307,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops);
 
-static int __register_ftrace_function(struct ftrace_ops *ops)
+int __register_ftrace_function(struct ftrace_ops *ops)
 {
 	if (ops->flags & FTRACE_OPS_FL_DELETED)
 		return -EINVAL;
@@ -375,7 +348,7 @@ static int __register_ftrace_function(struct ftrace_ops *ops)
 	return 0;
 }
 
-static int __unregister_ftrace_function(struct ftrace_ops *ops)
+int __unregister_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret;
 
@@ -815,9 +788,16 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
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
-	int index = current->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -825,14 +805,16 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace)
 	if (!current->ret_stack)
 		return 0;
 
-	if (index >= 0 && index < FTRACE_RETFUNC_DEPTH)
-		current->ret_stack[index].subtime = 0;
+	ret_stack = ftrace_graph_get_ret_stack(current, 0);
+	if (ret_stack)
+		ret_stack->subtime = 0;
 
 	return 1;
 }
 
 static void profile_graph_return(struct ftrace_graph_ret *trace)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
 	unsigned long long calltime;
 	struct ftrace_profile *rec;
@@ -850,16 +832,15 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	calltime = trace->rettime - trace->calltime;
 
 	if (!fgraph_graph_time) {
-		int index;
-
-		index = current->curr_ret_stack;
 
 		/* Append this call time to the parent time to subtract */
-		if (index)
-			current->ret_stack[index - 1].subtime += calltime;
+		ret_stack = ftrace_graph_get_ret_stack(current, 1);
+		if (ret_stack)
+			ret_stack->subtime += calltime;
 
-		if (current->ret_stack[index].subtime < calltime)
-			calltime -= current->ret_stack[index].subtime;
+		ret_stack = ftrace_graph_get_ret_stack(current, 0);
+		if (ret_stack && ret_stack->subtime < calltime)
+			calltime -= ret_stack->subtime;
 		else
 			calltime = 0;
 	}
@@ -874,15 +855,19 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
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
@@ -1021,12 +1006,6 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 }
 #endif /* CONFIG_FUNCTION_PROFILER */
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static int ftrace_graph_active;
-#else
-# define ftrace_graph_active 0
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static struct ftrace_ops *removed_ops;
@@ -1067,7 +1046,7 @@ static const struct ftrace_hash empty_hash = {
 };
 #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)
 
-static struct ftrace_ops global_ops = {
+struct ftrace_ops global_ops = {
 	.func				= ftrace_stub,
 	.local_hash.notrace_hash	= EMPTY_HASH,
 	.local_hash.filter_hash		= EMPTY_HASH,
@@ -1503,7 +1482,7 @@ static bool hash_contains_ip(unsigned long ip,
  * This needs to be called with preemption disabled as
  * the hashes are freed with call_rcu_sched().
  */
-static int
+int
 ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 {
 	struct ftrace_ops_hash hash;
@@ -2415,10 +2394,12 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 	return -1; /* unknow ftrace bug */
 }
 
-void __weak ftrace_replace_code(int enable)
+void __weak ftrace_replace_code(int mod_flags)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
+	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
@@ -2435,6 +2416,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
@@ -2548,8 +2531,12 @@ int __weak ftrace_arch_code_modify_post_process(void)
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
+	int mod_flags = 0;
 	int err = 0;
 
+	if (command & FTRACE_MAY_SLEEP)
+		mod_flags = FTRACE_MODIFY_MAY_SLEEP_FL;
+
 	/*
 	 * If the ftrace_caller calls a ftrace_ops func directly,
 	 * we need to make sure that it only traces functions it
@@ -2567,9 +2554,9 @@ void ftrace_modify_all_code(int command)
 	}
 
 	if (command & FTRACE_UPDATE_CALLS)
-		ftrace_replace_code(1);
+		ftrace_replace_code(mod_flags | FTRACE_MODIFY_ENABLE_FL);
 	else if (command & FTRACE_DISABLE_CALLS)
-		ftrace_replace_code(0);
+		ftrace_replace_code(mod_flags);
 
 	if (update && ftrace_trace_function != ftrace_ops_list_func) {
 		function_trace_op = set_function_trace_op;
@@ -2682,7 +2669,7 @@ static void ftrace_startup_all(int command)
 	update_all_ops = false;
 }
 
-static int ftrace_startup(struct ftrace_ops *ops, int command)
+int ftrace_startup(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
@@ -2724,7 +2711,7 @@ static int ftrace_startup(struct ftrace_ops *ops, int command)
 	return 0;
 }
 
-static int ftrace_shutdown(struct ftrace_ops *ops, int command)
+int ftrace_shutdown(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
@@ -5460,7 +5447,6 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
-	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
 
@@ -6178,7 +6164,7 @@ void ftrace_init_trace_array(struct trace_array *tr)
 }
 #else
 
-static struct ftrace_ops global_ops = {
+struct ftrace_ops global_ops = {
 	.func			= ftrace_stub,
 	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
 				  FTRACE_OPS_FL_INITIALIZED |
@@ -6195,31 +6181,10 @@ core_initcall(ftrace_nodyn_init);
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
 static inline void ftrace_startup_enable(int command) { }
 static inline void ftrace_startup_all(int command) { }
-/* Keep as macros so we do not need to define the commands */
-# define ftrace_startup(ops, command)					\
-	({								\
-		int ___ret = __register_ftrace_function(ops);		\
-		if (!___ret)						\
-			(ops)->flags |= FTRACE_OPS_FL_ENABLED;		\
-		___ret;							\
-	})
-# define ftrace_shutdown(ops, command)					\
-	({								\
-		int ___ret = __unregister_ftrace_function(ops);		\
-		if (!___ret)						\
-			(ops)->flags &= ~FTRACE_OPS_FL_ENABLED;		\
-		___ret;							\
-	})
 
 # define ftrace_startup_sysctl()	do { } while (0)
 # define ftrace_shutdown_sysctl()	do { } while (0)
 
-static inline int
-ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
-{
-	return 1;
-}
-
 static void ftrace_update_trampoline(struct ftrace_ops *ops)
 {
 }
@@ -6746,353 +6711,3 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
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
-static void update_function_graph_func(void)
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
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
new file mode 100644
index 000000000000..0515a2096f90
--- /dev/null
+++ b/kernel/trace/ftrace_internal.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_FTRACE_INTERNAL_H
+#define  _LINUX_KERNEL_FTRACE_INTERNAL_H
+
+#ifdef CONFIG_FUNCTION_TRACER
+
+/*
+ * Traverse the ftrace_global_list, invoking all entries.  The reason that we
+ * can use rcu_dereference_raw_notrace() is that elements removed from this list
+ * are simply leaked, so there is no need to interact with a grace-period
+ * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
+ * concurrent insertions into the ftrace_global_list.
+ *
+ * Silly Alpha and silly pointer-speculation compiler optimizations!
+ */
+#define do_for_each_ftrace_op(op, list)			\
+	op = rcu_dereference_raw_notrace(list);			\
+	do
+
+/*
+ * Optimized for just a single item in the list (as that is the normal case).
+ */
+#define while_for_each_ftrace_op(op)				\
+	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
+	       unlikely((op) != &ftrace_list_end))
+
+extern struct ftrace_ops __rcu *ftrace_ops_list;
+extern struct ftrace_ops ftrace_list_end;
+extern struct mutex ftrace_lock;
+extern struct ftrace_ops global_ops;
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+int ftrace_startup(struct ftrace_ops *ops, int command);
+int ftrace_shutdown(struct ftrace_ops *ops, int command);
+int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
+
+#else /* !CONFIG_DYNAMIC_FTRACE */
+
+int __register_ftrace_function(struct ftrace_ops *ops);
+int __unregister_ftrace_function(struct ftrace_ops *ops);
+/* Keep as macros so we do not need to define the commands */
+# define ftrace_startup(ops, command)					\
+	({								\
+		int ___ret = __register_ftrace_function(ops);		\
+		if (!___ret)						\
+			(ops)->flags |= FTRACE_OPS_FL_ENABLED;		\
+		___ret;							\
+	})
+# define ftrace_shutdown(ops, command)					\
+	({								\
+		int ___ret = __unregister_ftrace_function(ops);		\
+		if (!___ret)						\
+			(ops)->flags &= ~FTRACE_OPS_FL_ENABLED;		\
+		___ret;							\
+	})
+static inline int
+ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
+{
+	return 1;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern int ftrace_graph_active;
+void update_function_graph_func(void);
+#else /* !CONFIG_FUNCTION_GRAPH_TRACER */
+# define ftrace_graph_active 0
+static inline void update_function_graph_func(void) { }
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#else /* !CONFIG_FUNCTION_TRACER */
+#endif /* CONFIG_FUNCTION_TRACER */
+
+#endif
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 65bd4616220d..5434c16f2192 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -487,6 +487,10 @@ struct ring_buffer_per_cpu {
 	local_t				dropped_events;
 	local_t				committing;
 	local_t				commits;
+	local_t				pages_touched;
+	local_t				pages_read;
+	long				last_pages_touch;
+	size_t				shortest_full;
 	unsigned long			read;
 	unsigned long			read_bytes;
 	u64				write_stamp;
@@ -529,6 +533,41 @@ struct ring_buffer_iter {
 	u64				read_stamp;
 };
 
+/**
+ * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
+ * @buffer: The ring_buffer to get the number of pages from
+ * @cpu: The cpu of the ring_buffer to get the number of pages from
+ *
+ * Returns the number of pages used by a per_cpu buffer of the ring buffer.
+ */
+size_t ring_buffer_nr_pages(struct ring_buffer *buffer, int cpu)
+{
+	return buffer->buffers[cpu]->nr_pages;
+}
+
+/**
+ * ring_buffer_nr_pages_dirty - get the number of used pages in the ring buffer
+ * @buffer: The ring_buffer to get the number of pages from
+ * @cpu: The cpu of the ring_buffer to get the number of pages from
+ *
+ * Returns the number of pages that have content in the ring buffer.
+ */
+size_t ring_buffer_nr_dirty_pages(struct ring_buffer *buffer, int cpu)
+{
+	size_t read;
+	size_t cnt;
+
+	read = local_read(&buffer->buffers[cpu]->pages_read);
+	cnt = local_read(&buffer->buffers[cpu]->pages_touched);
+	/* The reader can read an empty page, but not more than that */
+	if (cnt < read) {
+		WARN_ON_ONCE(read > cnt + 1);
+		return 0;
+	}
+
+	return cnt - read;
+}
+
 /*
  * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
  *
@@ -556,7 +595,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  * as data is added to any of the @buffer's cpu buffers. Otherwise
  * it will wait for data to be added to a specific cpu buffer.
  */
-int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
+int ring_buffer_wait(struct ring_buffer *buffer, int cpu, int full)
 {
 	struct ring_buffer_per_cpu *uninitialized_var(cpu_buffer);
 	DEFINE_WAIT(wait);
@@ -571,7 +610,7 @@ int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 	if (cpu == RING_BUFFER_ALL_CPUS) {
 		work = &buffer->irq_work;
 		/* Full only makes sense on per cpu reads */
-		full = false;
+		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -ENODEV;
@@ -623,15 +662,22 @@ int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 		    !ring_buffer_empty_cpu(buffer, cpu)) {
 			unsigned long flags;
 			bool pagebusy;
+			size_t nr_pages;
+			size_t dirty;
 
 			if (!full)
 				break;
 
 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+			nr_pages = cpu_buffer->nr_pages;
+			dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+			if (!cpu_buffer->shortest_full ||
+			    cpu_buffer->shortest_full < full)
+				cpu_buffer->shortest_full = full;
 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-
-			if (!pagebusy)
+			if (!pagebusy &&
+			    (!nr_pages || (dirty * 100) > full * nr_pages))
 				break;
 		}
 
@@ -1054,6 +1100,7 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
+	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -2586,7 +2633,9 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
 static __always_inline void
 rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
-	bool pagebusy;
+	size_t nr_pages;
+	size_t dirty;
+	size_t full;
 
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
@@ -2600,14 +2649,27 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 		irq_work_queue(&cpu_buffer->irq_work.work);
 	}
 
-	pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+	if (cpu_buffer->last_pages_touch == local_read(&cpu_buffer->pages_touched))
+		return;
 
-	if (!pagebusy && cpu_buffer->irq_work.full_waiters_pending) {
-		cpu_buffer->irq_work.wakeup_full = true;
-		cpu_buffer->irq_work.full_waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
-	}
+	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
+		return;
+
+	if (!cpu_buffer->irq_work.full_waiters_pending)
+		return;
+
+	cpu_buffer->last_pages_touch = local_read(&cpu_buffer->pages_touched);
+
+	full = cpu_buffer->shortest_full;
+	nr_pages = cpu_buffer->nr_pages;
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
+	if (full && nr_pages && (dirty * 100) <= full * nr_pages)
+		return;
+
+	cpu_buffer->irq_work.wakeup_full = true;
+	cpu_buffer->irq_work.full_waiters_pending = false;
+	/* irq_work_queue() supplies it's own memory barriers */
+	irq_work_queue(&cpu_buffer->irq_work.work);
 }
 
 /*
@@ -3732,13 +3794,15 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 		goto spin;
 
 	/*
-	 * Yeah! We succeeded in replacing the page.
+	 * Yay! We succeeded in replacing the page.
 	 *
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(cpu_buffer, &cpu_buffer->head_page);
 
+	local_inc(&cpu_buffer->pages_read);
+
 	/* Finally update the reader page to the new head */
 	cpu_buffer->reader_page = reader;
 	cpu_buffer->reader_page->read = 0;
@@ -4334,6 +4398,10 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, 0);
 	local_set(&cpu_buffer->committing, 0);
 	local_set(&cpu_buffer->commits, 0);
+	local_set(&cpu_buffer->pages_touched, 0);
+	local_set(&cpu_buffer->pages_read, 0);
+	cpu_buffer->last_pages_touch = 0;
+	cpu_buffer->shortest_full = 0;
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff1c4b20cd0a..18b86c3974e1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1431,7 +1431,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-static int wait_on_pipe(struct trace_iterator *iter, bool full)
+static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
@@ -2452,7 +2452,7 @@ static inline void ftrace_exports_disable(void)
 	static_branch_disable(&ftrace_exports_enabled);
 }
 
-void ftrace_exports(struct ring_buffer_event *event)
+static void ftrace_exports(struct ring_buffer_event *event)
 {
 	struct trace_export *export;
 
@@ -4408,13 +4408,15 @@ static int trace_set_options(struct trace_array *tr, char *option)
 	int neg = 0;
 	int ret;
 	size_t orig_len = strlen(option);
+	int len;
 
 	cmp = strstrip(option);
 
-	if (strncmp(cmp, "no", 2) == 0) {
+	len = str_has_prefix(cmp, "no");
+	if (len)
 		neg = 1;
-		cmp += 2;
-	}
+
+	cmp += len;
 
 	mutex_lock(&trace_types_lock);
 
@@ -4604,6 +4606,10 @@ static const char readme_msg[] =
 	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
+#ifdef CONFIG_DYNAMIC_EVENTS
+	"  dynamic_events\t\t- Add/remove/show the generic dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #ifdef CONFIG_KPROBE_EVENTS
 	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
@@ -4616,6 +4622,9 @@ static const char readme_msg[] =
 	"\t  accepts: event-definitions (one definition per line)\n"
 	"\t   Format: p[:[<group>/]<event>] <place> [<args>]\n"
 	"\t           r[maxactive][:[<group>/]<event>] <place> [<args>]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t           s:[synthetic/]<event> <field> [<field>]\n"
+#endif
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
@@ -4634,6 +4643,11 @@ static const char readme_msg[] =
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
 	"\t           <type>\\[<array-size>\\]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t    field: <stype> <name>;\n"
+	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
+	"\t           [unsigned] char/int/long\n"
+#endif
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
@@ -5693,7 +5707,7 @@ static int tracing_wait_pipe(struct file *filp)
 
 		mutex_unlock(&iter->mutex);
 
-		ret = wait_on_pipe(iter, false);
+		ret = wait_on_pipe(iter, 0);
 
 		mutex_lock(&iter->mutex);
 
@@ -6751,7 +6765,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
-			ret = wait_on_pipe(iter, false);
+			ret = wait_on_pipe(iter, 0);
 			if (ret)
 				return ret;
 
@@ -6948,7 +6962,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		ret = wait_on_pipe(iter, true);
+		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
@@ -7662,6 +7676,53 @@ static const struct file_operations rb_simple_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t
+buffer_percent_read(struct file *filp, char __user *ubuf,
+		    size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	char buf[64];
+	int r;
+
+	r = tr->buffer_percent;
+	r = sprintf(buf, "%d\n", r);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+buffer_percent_write(struct file *filp, const char __user *ubuf,
+		     size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	if (!val)
+		val = 1;
+
+	tr->buffer_percent = val;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations buffer_percent_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_percent_read,
+	.write		= buffer_percent_write,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 struct dentry *trace_instance_dir;
 
 static void
@@ -7970,6 +8031,11 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("timestamp_mode", 0444, d_tracer, tr,
 			  &trace_time_stamp_mode_fops);
 
+	tr->buffer_percent = 50;
+
+	trace_create_file("buffer_percent", 0444, d_tracer,
+			tr, &buffer_percent_fops);
+
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 447bd96ee658..08900828d282 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -247,6 +247,7 @@ struct trace_array {
 	int			clock_id;
 	int			nr_topts;
 	bool			clear_trace;
+	int			buffer_percent;
 	struct tracer		*current_trace;
 	unsigned int		trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
@@ -534,6 +535,13 @@ enum {
 
 	TRACE_GRAPH_DEPTH_START_BIT,
 	TRACE_GRAPH_DEPTH_END_BIT,
+
+	/*
+	 * To implement set_graph_notrace, if this bit is set, we ignore
+	 * function graph tracing of called functions, until the return
+	 * function is called to clear it.
+	 */
+	TRACE_GRAPH_NOTRACE_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
@@ -855,7 +863,12 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
 extern void ftrace_graph_sleep_time_control(bool enable);
+
+#ifdef CONFIG_FUNCTION_PROFILER
 extern void ftrace_graph_graph_time_control(bool enable);
+#else
+static inline void ftrace_graph_graph_time_control(bool enable) { }
+#endif
 
 extern enum print_line_t
 print_graph_function_flags(struct trace_iterator *iter, u32 flags);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
new file mode 100644
index 000000000000..dd1f43588d70
--- /dev/null
+++ b/kernel/trace/trace_dynevent.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic dynamic event control interface
+ *
+ * Copyright (C) 2018 Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/tracefs.h>
+
+#include "trace.h"
+#include "trace_dynevent.h"
+
+static DEFINE_MUTEX(dyn_event_ops_mutex);
+static LIST_HEAD(dyn_event_ops_list);
+
+int dyn_event_register(struct dyn_event_operations *ops)
+{
+	if (!ops || !ops->create || !ops->show || !ops->is_busy ||
+	    !ops->free || !ops->match)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ops->list);
+	mutex_lock(&dyn_event_ops_mutex);
+	list_add_tail(&ops->list, &dyn_event_ops_list);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return 0;
+}
+
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
+{
+	struct dyn_event *pos, *n;
+	char *system = NULL, *event, *p;
+	int ret = -ENOENT;
+
+	if (argv[0][0] == '-') {
+		if (argv[0][1] != ':')
+			return -EINVAL;
+		event = &argv[0][2];
+	} else {
+		event = strchr(argv[0], ':');
+		if (!event)
+			return -EINVAL;
+		event++;
+	}
+
+	p = strchr(event, '/');
+	if (p) {
+		system = event;
+		event = p + 1;
+		*p = '\0';
+	}
+	if (event[0] == '\0')
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event_safe(pos, n) {
+		if (type && type != pos->ops)
+			continue;
+		if (pos->ops->match(system, event, pos)) {
+			ret = pos->ops->free(pos);
+			break;
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int create_dyn_event(int argc, char **argv)
+{
+	struct dyn_event_operations *ops;
+	int ret;
+
+	if (argv[0][0] == '-' || argv[0][0] == '!')
+		return dyn_event_release(argc, argv, NULL);
+
+	mutex_lock(&dyn_event_ops_mutex);
+	list_for_each_entry(ops, &dyn_event_ops_list, list) {
+		ret = ops->create(argc, (const char **)argv);
+		if (!ret || ret != -ECANCELED)
+			break;
+	}
+	mutex_unlock(&dyn_event_ops_mutex);
+	if (ret == -ECANCELED)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* Protected by event_mutex */
+LIST_HEAD(dyn_event_list);
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+	return seq_list_start(&dyn_event_list, *pos);
+}
+
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &dyn_event_list, pos);
+}
+
+void dyn_event_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int dyn_event_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (ev && ev->ops)
+		return ev->ops->show(m, ev);
+
+	return 0;
+}
+
+static const struct seq_operations dyn_event_seq_op = {
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= dyn_event_seq_show
+};
+
+/*
+ * dyn_events_release_all - Release all specific events
+ * @type:	the dyn_event_operations * which filters releasing events
+ *
+ * This releases all events which ->ops matches @type. If @type is NULL,
+ * all events are released.
+ * Return -EBUSY if any of them are in use, and return other errors when
+ * it failed to free the given event. Except for -EBUSY, event releasing
+ * process will be aborted at that point and there may be some other
+ * releasable events on the list.
+ */
+int dyn_events_release_all(struct dyn_event_operations *type)
+{
+	struct dyn_event *ev, *tmp;
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event(ev) {
+		if (type && ev->ops != type)
+			continue;
+		if (ev->ops->is_busy(ev)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+	for_each_dyn_event_safe(ev, tmp) {
+		if (type && ev->ops != type)
+			continue;
+		ret = ev->ops->free(ev);
+		if (ret)
+			break;
+	}
+out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int dyn_event_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = dyn_events_release_all(NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &dyn_event_seq_op);
+}
+
+static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_dyn_event);
+}
+
+static const struct file_operations dynamic_events_ops = {
+	.owner          = THIS_MODULE,
+	.open           = dyn_event_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+	.write		= dyn_event_write,
+};
+
+/* Make a tracefs interface for controlling dynamic events */
+static __init int init_dynamic_event(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer))
+		return 0;
+
+	entry = tracefs_create_file("dynamic_events", 0644, d_tracer,
+				    NULL, &dynamic_events_ops);
+
+	/* Event list interface */
+	if (!entry)
+		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
+
+	return 0;
+}
+fs_initcall(init_dynamic_event);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
new file mode 100644
index 000000000000..8c334064e4d6
--- /dev/null
+++ b/kernel/trace/trace_dynevent.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common header file for generic dynamic events.
+ */
+
+#ifndef _TRACE_DYNEVENT_H
+#define _TRACE_DYNEVENT_H
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+
+#include "trace.h"
+
+struct dyn_event;
+
+/**
+ * struct dyn_event_operations - Methods for each type of dynamic events
+ *
+ * These methods must be set for each type, since there is no default method.
+ * Before using this for dyn_event_init(), it must be registered by
+ * dyn_event_register().
+ *
+ * @create: Parse and create event method. This is invoked when user passes
+ *  a event definition to dynamic_events interface. This must not destruct
+ *  the arguments and return -ECANCELED if given arguments doesn't match its
+ *  command prefix.
+ * @show: Showing method. This is invoked when user reads the event definitions
+ *  via dynamic_events interface.
+ * @is_busy: Check whether given event is busy so that it can not be deleted.
+ *  Return true if it is busy, otherwides false.
+ * @free: Delete the given event. Return 0 if success, otherwides error.
+ * @match: Check whether given event and system name match this event.
+ *  Return true if it matches, otherwides false.
+ *
+ * Except for @create, these methods are called under holding event_mutex.
+ */
+struct dyn_event_operations {
+	struct list_head	list;
+	int (*create)(int argc, const char *argv[]);
+	int (*show)(struct seq_file *m, struct dyn_event *ev);
+	bool (*is_busy)(struct dyn_event *ev);
+	int (*free)(struct dyn_event *ev);
+	bool (*match)(const char *system, const char *event,
+			struct dyn_event *ev);
+};
+
+/* Register new dyn_event type -- must be called at first */
+int dyn_event_register(struct dyn_event_operations *ops);
+
+/**
+ * struct dyn_event - Dynamic event list header
+ *
+ * The dyn_event structure encapsulates a list and a pointer to the operators
+ * for making a global list of dynamic events.
+ * User must includes this in each event structure, so that those events can
+ * be added/removed via dynamic_events interface.
+ */
+struct dyn_event {
+	struct list_head		list;
+	struct dyn_event_operations	*ops;
+};
+
+extern struct list_head dyn_event_list;
+
+static inline
+int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
+{
+	if (!ev || !ops)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ev->list);
+	ev->ops = ops;
+	return 0;
+}
+
+static inline int dyn_event_add(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!ev || !ev->ops)
+		return -EINVAL;
+
+	list_add_tail(&ev->list, &dyn_event_list);
+	return 0;
+}
+
+static inline void dyn_event_remove(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+	list_del_init(&ev->list);
+}
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void dyn_event_seq_stop(struct seq_file *m, void *v);
+int dyn_events_release_all(struct dyn_event_operations *type);
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type);
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ *
+ * This is just a basement of for_each macro. Wrap this for
+ * each actual event structure with ops filtering.
+ */
+#define for_each_dyn_event(pos)	\
+	list_for_each_entry(pos, &dyn_event_list, list)
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list safely
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ * @n:		the struct dyn_event * to use as temporary storage
+ */
+#define for_each_dyn_event_safe(pos, n)	\
+	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
+
+#endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f94be0c2827b..5b3b0c3c8a47 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1251,7 +1251,7 @@ static int f_show(struct seq_file *m, void *v)
 	 */
 	array_descriptor = strchr(field->type, '[');
 
-	if (!strncmp(field->type, "__data_loc", 10))
+	if (str_has_prefix(field->type, "__data_loc"))
 		array_descriptor = NULL;
 
 	if (!array_descriptor)
@@ -2309,7 +2309,8 @@ static void __add_event_to_tracers(struct trace_event_call *call);
 int trace_add_event_call(struct trace_event_call *call)
 {
 	int ret;
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	mutex_lock(&trace_types_lock);
 
 	ret = __register_event(call, NULL);
@@ -2317,7 +2318,6 @@ int trace_add_event_call(struct trace_event_call *call)
 		__add_event_to_tracers(call);
 
 	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -2371,13 +2371,13 @@ int trace_remove_event_call(struct trace_event_call *call)
 {
 	int ret;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	mutex_lock(&trace_types_lock);
 	down_write(&trace_event_sem);
 	ret = probe_remove_event_call(call);
 	up_write(&trace_event_sem);
 	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5574e862de8d..84a65173b1e9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -570,13 +570,11 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		}
 	}
 
-	kfree(op_stack);
-	kfree(inverts);
 	return prog;
 out_free:
 	kfree(op_stack);
-	kfree(inverts);
 	kfree(prog_stack);
+	kfree(inverts);
 	return ERR_PTR(ret);
 }
 
@@ -1720,7 +1718,6 @@ static int create_filter(struct trace_event_call *call,
 	err = process_preds(call, filter_string, *filterp, pe);
 	if (err && set_str)
 		append_filter_err(pe, *filterp);
-	create_filter_finish(pe);
 
 	return err;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb908ef2ecec..449d90cfa151 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -15,6 +15,7 @@
 
 #include "tracing_map.h"
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	16
@@ -39,6 +40,16 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+/*
+ * A hist_var (histogram variable) contains variable information for
+ * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
+ * flag set.  A hist_var has a variable name e.g. ts0, and is
+ * associated with a given histogram trigger, as specified by
+ * hist_data.  The hist_var idx is the unique index assigned to the
+ * variable by the hist trigger's tracing_map.  The idx is what is
+ * used to set a variable's value and, by a variable reference, to
+ * retrieve it.
+ */
 struct hist_var {
 	char				*name;
 	struct hist_trigger_data	*hist_data;
@@ -55,12 +66,29 @@ struct hist_field {
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+
+	/*
+	 * Variable fields contain variable-specific info in var.
+	 */
 	struct hist_var			var;
 	enum field_op_id		operator;
 	char				*system;
 	char				*event_name;
+
+	/*
+	 * The name field is used for EXPR and VAR_REF fields.  VAR
+	 * fields contain the variable name in var.name.
+	 */
 	char				*name;
-	unsigned int			var_idx;
+
+	/*
+	 * When a histogram trigger is hit, if it has any references
+	 * to variables, the values of those variables are collected
+	 * into a var_ref_vals array by resolve_var_refs().  The
+	 * current value of each variable is read from the tracing_map
+	 * using the hist field's hist_var.idx and entered into the
+	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
+	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -279,8 +307,6 @@ struct hist_trigger_data {
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
 
-	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
-	unsigned int                    n_synth_var_refs;
 	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_vars;
 	unsigned int			n_field_var_str;
@@ -292,6 +318,21 @@ struct hist_trigger_data {
 	unsigned int			n_max_var_str;
 };
 
+static int synth_event_create(int argc, const char **argv);
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
+static int synth_event_release(struct dyn_event *ev);
+static bool synth_event_is_busy(struct dyn_event *ev);
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev);
+
+static struct dyn_event_operations synth_event_ops = {
+	.create = synth_event_create,
+	.show = synth_event_show,
+	.is_busy = synth_event_is_busy,
+	.free = synth_event_release,
+	.match = synth_event_match,
+};
+
 struct synth_field {
 	char *type;
 	char *name;
@@ -301,7 +342,7 @@ struct synth_field {
 };
 
 struct synth_event {
-	struct list_head			list;
+	struct dyn_event			devent;
 	int					ref;
 	char					*name;
 	struct synth_field			**fields;
@@ -312,6 +353,32 @@ struct synth_event {
 	struct tracepoint			*tp;
 };
 
+static bool is_synth_event(struct dyn_event *ev)
+{
+	return ev->ops == &synth_event_ops;
+}
+
+static struct synth_event *to_synth_event(struct dyn_event *ev)
+{
+	return container_of(ev, struct synth_event, devent);
+}
+
+static bool synth_event_is_busy(struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	return event->ref != 0;
+}
+
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev)
+{
+	struct synth_event *sev = to_synth_event(ev);
+
+	return strcmp(sev->name, event) == 0 &&
+		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
+}
+
 struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
@@ -326,6 +393,14 @@ struct action_data {
 
 	union {
 		struct {
+			/*
+			 * When a histogram trigger is hit, the values of any
+			 * references to variables, including variables being passed
+			 * as parameters to synthetic events, are collected into a
+			 * var_ref_vals array.  This var_ref_idx is the index of the
+			 * first param in the array to be passed to the synthetic
+			 * event invocation.
+			 */
 			unsigned int		var_ref_idx;
 			char			*match_event;
 			char			*match_event_system;
@@ -402,9 +477,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static LIST_HEAD(synth_event_list);
-static DEFINE_MUTEX(synth_event_mutex);
-
 struct synth_trace_event {
 	struct trace_entry	ent;
 	u64			fields[];
@@ -446,7 +518,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
 
 static bool synth_field_signed(char *type)
 {
-	if (strncmp(type, "u", 1) == 0)
+	if (str_has_prefix(type, "u"))
 		return false;
 
 	return true;
@@ -469,7 +541,7 @@ static int synth_field_string_size(char *type)
 	start = strstr(type, "char[");
 	if (start == NULL)
 		return -EINVAL;
-	start += strlen("char[");
+	start += sizeof("char[") - 1;
 
 	end = strchr(type, ']');
 	if (!end || end < start)
@@ -738,14 +810,12 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, char **argv,
+static struct synth_field *parse_synth_field(int argc, const char **argv,
 					     int *consumed)
 {
 	struct synth_field *field;
-	const char *prefix = NULL;
-	char *field_type = argv[0], *field_name;
+	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
-	char *array;
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -762,20 +832,31 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		*consumed = 2;
 	}
 
-	len = strlen(field_name);
-	if (field_name[len - 1] == ';')
-		field_name[len - 1] = '\0';
-
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
 
-	len = strlen(field_type) + 1;
+	len = strlen(field_name);
 	array = strchr(field_name, '[');
+	if (array)
+		len -= strlen(array);
+	else if (field_name[len - 1] == ';')
+		len--;
+
+	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	if (field_type[0] == ';')
+		field_type++;
+	len = strlen(field_type) + 1;
 	if (array)
 		len += strlen(array);
 	if (prefix)
 		len += strlen(prefix);
+
 	field->type = kzalloc(len, GFP_KERNEL);
 	if (!field->type) {
 		ret = -ENOMEM;
@@ -786,7 +867,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	strcat(field->type, field_type);
 	if (array) {
 		strcat(field->type, array);
-		*array = '\0';
+		if (field->type[len - 1] == ';')
+			field->type[len - 1] = '\0';
 	}
 
 	field->size = synth_field_size(field->type);
@@ -800,11 +882,6 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	field->is_signed = synth_field_signed(field->type);
 
-	field->name = kstrdup(field_name, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
-		goto free;
-	}
  out:
 	return field;
  free:
@@ -868,9 +945,13 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 
 static struct synth_event *find_synth_event(const char *name)
 {
+	struct dyn_event *pos;
 	struct synth_event *event;
 
-	list_for_each_entry(event, &synth_event_list, list) {
+	for_each_dyn_event(pos) {
+		if (!is_synth_event(pos))
+			continue;
+		event = to_synth_event(pos);
 		if (strcmp(event->name, name) == 0)
 			return event;
 	}
@@ -959,7 +1040,7 @@ static void free_synth_event(struct synth_event *event)
 	kfree(event);
 }
 
-static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
 {
 	struct synth_event *event;
@@ -971,7 +1052,7 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
-	event->name = kstrdup(event_name, GFP_KERNEL);
+	event->name = kstrdup(name, GFP_KERNEL);
 	if (!event->name) {
 		kfree(event);
 		event = ERR_PTR(-ENOMEM);
@@ -985,6 +1066,8 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
+	dyn_event_init(&event->devent, &synth_event_ops);
+
 	for (i = 0; i < n_fields; i++)
 		event->fields[i] = fields[i];
 
@@ -1008,29 +1091,11 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static void add_or_delete_synth_event(struct synth_event *event, int delete)
-{
-	if (delete)
-		free_synth_event(event);
-	else {
-		mutex_lock(&synth_event_mutex);
-		if (!find_synth_event(event->name))
-			list_add(&event->list, &synth_event_list);
-		else
-			free_synth_event(event);
-		mutex_unlock(&synth_event_mutex);
-	}
-}
-
-static int create_synth_event(int argc, char **argv)
+static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
-	bool delete_event = false;
 	int i, consumed = 0, n_fields = 0, ret = 0;
-	char *name;
-
-	mutex_lock(&synth_event_mutex);
 
 	/*
 	 * Argument syntax:
@@ -1038,42 +1103,19 @@ static int create_synth_event(int argc, char **argv)
 	 *  - Remove synthetic event: !<event_name> field[;field] ...
 	 *      where 'field' = type field_name
 	 */
-	if (argc < 1) {
-		ret = -EINVAL;
-		goto out;
-	}
 
-	name = argv[0];
-	if (name[0] == '!') {
-		delete_event = true;
-		name++;
-	}
+	if (name[0] == '\0' || argc < 1)
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
 
 	event = find_synth_event(name);
 	if (event) {
-		if (delete_event) {
-			if (event->ref) {
-				event = NULL;
-				ret = -EBUSY;
-				goto out;
-			}
-			list_del(&event->list);
-			goto out;
-		}
-		event = NULL;
 		ret = -EEXIST;
 		goto out;
-	} else if (delete_event) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	if (argc < 2) {
-		ret = -EINVAL;
-		goto out;
 	}
 
-	for (i = 1; i < argc - 1; i++) {
+	for (i = 0; i < argc - 1; i++) {
 		if (strcmp(argv[i], ";") == 0)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
@@ -1101,83 +1143,91 @@ static int create_synth_event(int argc, char **argv)
 		event = NULL;
 		goto err;
 	}
+	ret = register_synth_event(event);
+	if (!ret)
+		dyn_event_add(&event->devent);
+	else
+		free_synth_event(event);
  out:
-	mutex_unlock(&synth_event_mutex);
-
-	if (event) {
-		if (delete_event) {
-			ret = unregister_synth_event(event);
-			add_or_delete_synth_event(event, !ret);
-		} else {
-			ret = register_synth_event(event);
-			add_or_delete_synth_event(event, ret);
-		}
-	}
+	mutex_unlock(&event_mutex);
 
 	return ret;
  err:
-	mutex_unlock(&synth_event_mutex);
-
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
-	free_synth_event(event);
 
-	return ret;
+	goto out;
 }
 
-static int release_all_synth_events(void)
+static int create_or_delete_synth_event(int argc, char **argv)
 {
-	struct list_head release_events;
-	struct synth_event *event, *e;
-	int ret = 0;
-
-	INIT_LIST_HEAD(&release_events);
-
-	mutex_lock(&synth_event_mutex);
+	const char *name = argv[0];
+	struct synth_event *event = NULL;
+	int ret;
 
-	list_for_each_entry(event, &synth_event_list, list) {
-		if (event->ref) {
-			mutex_unlock(&synth_event_mutex);
-			return -EBUSY;
-		}
+	/* trace_run_command() ensures argc != 0 */
+	if (name[0] == '!') {
+		mutex_lock(&event_mutex);
+		event = find_synth_event(name + 1);
+		if (event) {
+			if (event->ref)
+				ret = -EBUSY;
+			else {
+				ret = unregister_synth_event(event);
+				if (!ret) {
+					dyn_event_remove(&event->devent);
+					free_synth_event(event);
+				}
+			}
+		} else
+			ret = -ENOENT;
+		mutex_unlock(&event_mutex);
+		return ret;
 	}
 
-	list_splice_init(&event->list, &release_events);
+	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	return ret == -ECANCELED ? -EINVAL : ret;
+}
 
-	mutex_unlock(&synth_event_mutex);
+static int synth_event_create(int argc, const char **argv)
+{
+	const char *name = argv[0];
+	int len;
 
-	list_for_each_entry_safe(event, e, &release_events, list) {
-		list_del(&event->list);
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
 
-		ret = unregister_synth_event(event);
-		add_or_delete_synth_event(event, !ret);
+	/* This interface accepts group name prefix */
+	if (strchr(name, '/')) {
+		len = sizeof(SYNTH_SYSTEM "/") - 1;
+		if (strncmp(name, SYNTH_SYSTEM "/", len))
+			return -EINVAL;
+		name += len;
 	}
-
-	return ret;
+	return __create_synth_event(argc - 1, name, argv + 1);
 }
 
-
-static void *synth_events_seq_start(struct seq_file *m, loff_t *pos)
+static int synth_event_release(struct dyn_event *ev)
 {
-	mutex_lock(&synth_event_mutex);
+	struct synth_event *event = to_synth_event(ev);
+	int ret;
 
-	return seq_list_start(&synth_event_list, *pos);
-}
+	if (event->ref)
+		return -EBUSY;
 
-static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &synth_event_list, pos);
-}
+	ret = unregister_synth_event(event);
+	if (ret)
+		return ret;
 
-static void synth_events_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&synth_event_mutex);
+	dyn_event_remove(ev);
+	free_synth_event(event);
+	return 0;
 }
 
-static int synth_events_seq_show(struct seq_file *m, void *v)
+static int __synth_event_show(struct seq_file *m, struct synth_event *event)
 {
 	struct synth_field *field;
-	struct synth_event *event = v;
 	unsigned int i;
 
 	seq_printf(m, "%s\t", event->name);
@@ -1195,11 +1245,30 @@ static int synth_events_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	seq_printf(m, "s:%s/", event->class.system);
+
+	return __synth_event_show(m, event);
+}
+
+static int synth_events_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_synth_event(ev))
+		return 0;
+
+	return __synth_event_show(m, to_synth_event(ev));
+}
+
 static const struct seq_operations synth_events_seq_op = {
-	.start  = synth_events_seq_start,
-	.next   = synth_events_seq_next,
-	.stop   = synth_events_seq_stop,
-	.show   = synth_events_seq_show
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= synth_events_seq_show,
 };
 
 static int synth_events_open(struct inode *inode, struct file *file)
@@ -1207,7 +1276,7 @@ static int synth_events_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_synth_events();
+		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
 			return ret;
 	}
@@ -1220,7 +1289,7 @@ static ssize_t synth_events_write(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_synth_event);
+				       create_or_delete_synth_event);
 }
 
 static const struct file_operations synth_events_fops = {
@@ -1257,82 +1326,73 @@ static u64 hist_field_cpu(struct hist_field *hist_field,
 	return cpu;
 }
 
+/**
+ * check_field_for_var_ref - Check if a VAR_REF field references a variable
+ * @hist_field: The VAR_REF field to check
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the given VAR_REF field to see whether or not it references
+ * the given variable associated with the given trigger.
+ *
+ * Return: The VAR_REF field if it does reference the variable, NULL if not
+ */
 static struct hist_field *
 check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
 			unsigned int var_idx)
 {
-	struct hist_field *found = NULL;
-
-	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-		if (hist_field->var.idx == var_idx &&
-		    hist_field->var.hist_data == var_data) {
-			found = hist_field;
-		}
-	}
+	WARN_ON(!(hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF));
 
-	return found;
-}
-
-static struct hist_field *
-check_field_for_var_refs(struct hist_trigger_data *hist_data,
-			 struct hist_field *hist_field,
-			 struct hist_trigger_data *var_data,
-			 unsigned int var_idx,
-			 unsigned int level)
-{
-	struct hist_field *found = NULL;
-	unsigned int i;
-
-	if (level > 3)
-		return found;
-
-	if (!hist_field)
-		return found;
-
-	found = check_field_for_var_ref(hist_field, var_data, var_idx);
-	if (found)
-		return found;
-
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
-		struct hist_field *operand;
-
-		operand = hist_field->operands[i];
-		found = check_field_for_var_refs(hist_data, operand, var_data,
-						 var_idx, level + 1);
-		if (found)
-			return found;
-	}
+	if (hist_field && hist_field->var.idx == var_idx &&
+	    hist_field->var.hist_data == var_data)
+		return hist_field;
 
-	return found;
+	return NULL;
 }
 
+/**
+ * find_var_ref - Check if a trigger has a reference to a trigger variable
+ * @hist_data: The hist trigger that might have a reference to the variable
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the list of var_refs[] on the first hist trigger to see
+ * whether any of them are references to the variable on the second
+ * trigger.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
 {
-	struct hist_field *hist_field, *found = NULL;
+	struct hist_field *hist_field;
 	unsigned int i;
 
-	for_each_hist_field(i, hist_data) {
-		hist_field = hist_data->fields[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
-	}
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
-		hist_field = hist_data->synth_var_refs[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		if (check_field_for_var_ref(hist_field, var_data, var_idx))
+			return hist_field;
 	}
 
-	return found;
+	return NULL;
 }
 
+/**
+ * find_any_var_ref - Check if there is a reference to a given trigger variable
+ * @hist_data: The hist trigger
+ * @var_idx: The trigger variable identifier
+ *
+ * Check to see whether the given variable is currently referenced by
+ * any other trigger.
+ *
+ * The trigger the variable is defined on is explicitly excluded - the
+ * assumption being that a self-reference doesn't prevent a trigger
+ * from being removed.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 					   unsigned int var_idx)
 {
@@ -1351,6 +1411,19 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 	return found;
 }
 
+/**
+ * check_var_refs - Check if there is a reference to any of trigger's variables
+ * @hist_data: The hist trigger
+ *
+ * A trigger can define one or more variables.  If any one of them is
+ * currently referenced by any other trigger, this function will
+ * determine that.
+
+ * Typically used to determine whether or not a trigger can be removed
+ * - if there are any references to a trigger's variables, it cannot.
+ *
+ * Return: True if there is a reference to any of trigger's variables
+ */
 static bool check_var_refs(struct hist_trigger_data *hist_data)
 {
 	struct hist_field *field;
@@ -1808,8 +1881,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
-	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+	if ((str_has_prefix(str, "onmatch(")) ||
+	    (str_has_prefix(str, "onmax("))) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1826,34 +1899,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+	if ((str_has_prefix(str, "key=")) ||
+	    (str_has_prefix(str, "keys="))) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+	} else if ((str_has_prefix(str, "val=")) ||
+		   (str_has_prefix(str, "vals=")) ||
+		   (str_has_prefix(str, "values="))) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+	} else if (str_has_prefix(str, "sort=")) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+	} else if (str_has_prefix(str, "name=")) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+	} else if (str_has_prefix(str, "clock=")) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1866,7 +1939,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+	} else if (str_has_prefix(str, "size=")) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -2151,6 +2224,15 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void __destroy_hist_field(struct hist_field *hist_field)
+{
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
+	kfree(hist_field);
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -2162,14 +2244,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	if (!hist_field)
 		return;
 
+	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		return; /* var refs will be destroyed separately */
+
 	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
 		destroy_hist_field(hist_field->operands[i], level + 1);
 
-	kfree(hist_field->var.name);
-	kfree(hist_field->name);
-	kfree(hist_field->type);
-
-	kfree(hist_field);
+	__destroy_hist_field(hist_field);
 }
 
 static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
@@ -2296,6 +2377,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 			hist_data->fields[i] = NULL;
 		}
 	}
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
+		__destroy_hist_field(hist_data->var_refs[i]);
+		hist_data->var_refs[i] = NULL;
+	}
 }
 
 static int init_var_ref(struct hist_field *ref_field,
@@ -2354,7 +2441,23 @@ static int init_var_ref(struct hist_field *ref_field,
 	goto out;
 }
 
-static struct hist_field *create_var_ref(struct hist_field *var_field,
+/**
+ * create_var_ref - Create a variable reference and attach it to trigger
+ * @hist_data: The trigger that will be referencing the variable
+ * @var_field: The VAR field to create a reference to
+ * @system: The optional system string
+ * @event_name: The optional event_name string
+ *
+ * Given a variable hist_field, create a VAR_REF hist_field that
+ * represents a reference to it.
+ *
+ * This function also adds the reference to the trigger that
+ * now references the variable.
+ *
+ * Return: The VAR_REF field if successful, NULL if not
+ */
+static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
+					 struct hist_field *var_field,
 					 char *system, char *event_name)
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
@@ -2366,6 +2469,9 @@ static struct hist_field *create_var_ref(struct hist_field *var_field,
 			destroy_hist_field(ref_field, 0);
 			return NULL;
 		}
+
+		hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+		ref_field->var_ref_idx = hist_data->n_var_refs++;
 	}
 
 	return ref_field;
@@ -2439,7 +2545,8 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 	var_field = find_event_var(hist_data, system, event_name, var_name);
 	if (var_field)
-		ref_field = create_var_ref(var_field, system, event_name);
+		ref_field = create_var_ref(hist_data, var_field,
+					   system, event_name);
 
 	if (!ref_field)
 		hist_err_event("Couldn't find variable: $",
@@ -2557,8 +2664,6 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	if (!s) {
 		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
 		if (hist_field) {
-			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
-			hist_field->var_ref_idx = hist_data->n_var_refs++;
 			if (var_name) {
 				hist_field = create_alias(hist_data, hist_field, var_name);
 				if (!hist_field) {
@@ -3332,7 +3437,6 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	unsigned int var_ref_idx = hist_data->n_var_refs;
 	struct field_var *field_var;
 	char *onmax_var_str, *param;
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -3349,18 +3453,10 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 		return -EINVAL;
 	}
 
-	flags = HIST_FIELD_FL_VAR_REF;
-	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
+	ref_field = create_var_ref(hist_data, var_field, NULL, NULL);
 	if (!ref_field)
 		return -ENOMEM;
 
-	if (init_var_ref(ref_field, var_field, NULL, NULL)) {
-		destroy_hist_field(ref_field, 0);
-		ret = -ENOMEM;
-		goto out;
-	}
-	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
-	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->onmax.var = ref_field;
 
 	data->fn = onmax_save;
@@ -3462,7 +3558,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+	if (str_has_prefix(onmax_fn_name, "save")) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -3493,7 +3589,7 @@ static void onmatch_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
 
 	kfree(data->onmatch.match_event);
 	kfree(data->onmatch.match_event_system);
@@ -3506,8 +3602,6 @@ static void onmatch_destroy(struct action_data *data)
 		data->onmatch.synth_event->ref--;
 
 	kfree(data);
-
-	mutex_unlock(&synth_event_mutex);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3539,23 +3633,6 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 }
 
 
-static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++)
-		destroy_hist_field(hist_data->synth_var_refs[i], 0);
-}
-
-static void save_synth_var_ref(struct hist_trigger_data *hist_data,
-			 struct hist_field *var_ref)
-{
-	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-
-	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
-	var_ref->var_ref_idx = hist_data->n_var_refs++;
-}
-
 static int check_synth_field(struct synth_event *event,
 			     struct hist_field *hist_field,
 			     unsigned int field_pos)
@@ -3658,15 +3735,14 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	struct synth_event *event;
 	int ret = 0;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	event = find_synth_event(data->onmatch.synth_event_name);
 	if (!event) {
 		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
-		mutex_unlock(&synth_event_mutex);
 		return -EINVAL;
 	}
 	event->ref++;
-	mutex_unlock(&synth_event_mutex);
 
 	var_ref_idx = hist_data->n_var_refs;
 
@@ -3708,14 +3784,14 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (check_synth_field(event, hist_field, field_pos) == 0) {
-			var_ref = create_var_ref(hist_field, system, event_name);
+			var_ref = create_var_ref(hist_data, hist_field,
+						 system, event_name);
 			if (!var_ref) {
 				kfree(p);
 				ret = -ENOMEM;
 				goto err;
 			}
 
-			save_synth_var_ref(hist_data, var_ref);
 			field_pos++;
 			kfree(p);
 			continue;
@@ -3740,9 +3816,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
  out:
 	return ret;
  err:
-	mutex_lock(&synth_event_mutex);
 	event->ref--;
-	mutex_unlock(&synth_event_mutex);
 
 	goto out;
 }
@@ -4268,12 +4342,13 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	unsigned int i;
 	int ret = 0;
 	char *str;
+	int len;
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
-			char *action_str = str + strlen("onmatch(");
+		if ((len = str_has_prefix(str, "onmatch("))) {
+			char *action_str = str + len;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
@@ -4281,8 +4356,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
-			char *action_str = str + strlen("onmax(");
+		} else if ((len = str_has_prefix(str, "onmax("))) {
+			char *action_str = str + len;
 
 			data = onmax_parse(action_str);
 			if (IS_ERR(data)) {
@@ -4461,7 +4536,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	destroy_actions(hist_data);
 	destroy_field_vars(hist_data);
 	destroy_field_var_hists(hist_data);
-	destroy_synth_var_refs(hist_data);
 
 	kfree(hist_data);
 }
@@ -5450,6 +5524,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct synth_event *se;
 	const char *se_name;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_file_check_refs(file))
 		return;
 
@@ -5459,12 +5535,10 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			mutex_lock(&synth_event_mutex);
 			se_name = trace_event_name(file->event_call);
 			se = find_synth_event(se_name);
 			if (se)
 				se->ref--;
-			mutex_unlock(&synth_event_mutex);
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
@@ -5490,6 +5564,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	char *trigger, *p;
 	int ret = 0;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (glob && strlen(glob)) {
 		last_cmd_set(param);
 		hist_err_clear();
@@ -5516,9 +5592,9 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 			p++;
 			continue;
 		}
-		if (p >= param + strlen(param) - strlen("if") - 1)
+		if (p >= param + strlen(param) - (sizeof("if") - 1) - 1)
 			return -EINVAL;
-		if (*(p + strlen("if")) != ' ' && *(p + strlen("if")) != '\t') {
+		if (*(p + sizeof("if") - 1) != ' ' && *(p + sizeof("if") - 1) != '\t') {
 			p++;
 			continue;
 		}
@@ -5580,14 +5656,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		}
 
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
-
-		mutex_lock(&synth_event_mutex);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
 			se->ref--;
-		mutex_unlock(&synth_event_mutex);
-
 		ret = 0;
 		goto out_free;
 	}
@@ -5623,13 +5695,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	mutex_lock(&synth_event_mutex);
 	se_name = trace_event_name(file->event_call);
 	se = find_synth_event(se_name);
 	if (se)
 		se->ref++;
-	mutex_unlock(&synth_event_mutex);
-
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
@@ -5812,6 +5881,12 @@ static __init int trace_events_hist_init(void)
 	struct dentry *d_tracer;
 	int err = 0;
 
+	err = dyn_event_register(&synth_event_ops);
+	if (err) {
+		pr_warn("Could not register synth_event_ops\n");
+		return err;
+	}
+
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer)) {
 		err = PTR_ERR(d_tracer);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cd12ecb66eb9..2152d1e530cb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -732,10 +732,8 @@ int set_trigger_filter(char *filter_str,
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->event_call, filter_str, false, &filter);
-	/*
-	 * If create_event_filter() fails, filter still needs to be freed.
-	 * Which the calling code will do with data->filter.
-	 */
+	if (ret)
+		goto out;
  assign:
 	tmp = rcu_access_pointer(data->filter);
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 086af4f5c3e8..c2af1560e856 100644
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
 
@@ -87,8 +60,12 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(funcgraph-tail, TRACE_GRAPH_PRINT_TAIL) },
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
+
+#ifdef CONFIG_FUNCTION_PROFILER
 	/* Include time within nested functions */
 	{ TRACER_OPT(graph-time, TRACE_GRAPH_GRAPH_TIME) },
+#endif
+
 	{ } /* Empty entry */
 };
 
@@ -117,258 +94,6 @@ static void
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
-/**
- * ftrace_graph_ret_addr - convert a potentially modified stack return address
- *			   to its original value
- *
- * This function can be called by stack unwinding code to convert a found stack
- * return address ('ret') to its original value, in case the function graph
- * tracer has modified it to be 'return_to_handler'.  If the address hasn't
- * been modified, the unchanged value of 'ret' is returned.
- *
- * 'idx' is a state variable which should be initialized by the caller to zero
- * before the first call.
- *
- * 'retp' is a pointer to the return address on the stack.  It's ignored if
- * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
- */
-#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
-				    unsigned long ret, unsigned long *retp)
-{
-	int index = task->curr_ret_stack;
-	int i;
-
-	if (ret != (unsigned long)return_to_handler)
-		return ret;
-
-	if (index < -1)
-		index += FTRACE_NOTRACE_DEPTH;
-
-	if (index < 0)
-		return ret;
-
-	for (i = 0; i <= index; i++)
-		if (task->ret_stack[i].retp == retp)
-			return task->ret_stack[i].ret;
-
-	return ret;
-}
-#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
-unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
-				    unsigned long ret, unsigned long *retp)
-{
-	int task_idx;
-
-	if (ret != (unsigned long)return_to_handler)
-		return ret;
-
-	task_idx = task->curr_ret_stack;
-
-	if (!task->ret_stack || task_idx < *idx)
-		return ret;
-
-	task_idx -= *idx;
-	(*idx)++;
-
-	return task->ret_stack[task_idx].ret;
-}
-#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
-
 int __trace_graph_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
 				unsigned long flags,
@@ -409,6 +134,18 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	int cpu;
 	int pc;
 
+	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
+		return 0;
+
+	if (ftrace_graph_notrace_addr(trace->func)) {
+		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
+		/*
+		 * Need to return 1 to have the return called
+		 * that will clear the NOTRACE bit.
+		 */
+		return 1;
+	}
+
 	if (!ftrace_trace_task(tr))
 		return 0;
 
@@ -511,6 +248,11 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 
 	ftrace_graph_addr_finish(trace);
 
+	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
+		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+		return;
+	}
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -536,6 +278,11 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 {
 	ftrace_graph_addr_finish(trace);
 
+	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
+		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+		return;
+	}
+
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
@@ -543,17 +290,25 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
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
@@ -564,7 +319,10 @@ static int graph_trace_init(struct trace_array *tr)
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
@@ -874,10 +632,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
-		/* If a graph tracer ignored set_graph_notrace */
-		if (call->depth < -1)
-			call->depth += FTRACE_NOTRACE_DEPTH;
-
 		/*
 		 * Comments display at + 1 to depth. Since
 		 * this is a leaf function, keep the comments
@@ -920,10 +674,6 @@ print_graph_entry_nested(struct trace_iterator *iter,
 		struct fgraph_cpu_data *cpu_data;
 		int cpu = iter->cpu;
 
-		/* If a graph tracer ignored set_graph_notrace */
-		if (call->depth < -1)
-			call->depth += FTRACE_NOTRACE_DEPTH;
-
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 		cpu_data->depth = call->depth;
 
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
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fec67188c4d2..0e0f7b8024fb 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -12,6 +12,7 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
@@ -19,17 +20,51 @@
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
 
+static int trace_kprobe_create(int argc, const char **argv);
+static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_kprobe_release(struct dyn_event *ev);
+static bool trace_kprobe_is_busy(struct dyn_event *ev);
+static bool trace_kprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev);
+
+static struct dyn_event_operations trace_kprobe_ops = {
+	.create = trace_kprobe_create,
+	.show = trace_kprobe_show,
+	.is_busy = trace_kprobe_is_busy,
+	.free = trace_kprobe_release,
+	.match = trace_kprobe_match,
+};
+
 /**
  * Kprobe event core functions
  */
 struct trace_kprobe {
-	struct list_head	list;
+	struct dyn_event	devent;
 	struct kretprobe	rp;	/* Use rp.kp for kprobe use */
 	unsigned long __percpu *nhit;
 	const char		*symbol;	/* symbol name */
 	struct trace_probe	tp;
 };
 
+static bool is_trace_kprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_kprobe_ops;
+}
+
+static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_kprobe, devent);
+}
+
+/**
+ * for_each_trace_kprobe - iterate over the trace_kprobe list
+ * @pos:	the struct trace_kprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ */
+#define for_each_trace_kprobe(pos, dpos)	\
+	for_each_dyn_event(dpos)		\
+		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
+
 #define SIZEOF_TRACE_KPROBE(n)				\
 	(offsetof(struct trace_kprobe, tp.args) +	\
 	(sizeof(struct probe_arg) * (n)))
@@ -81,6 +116,22 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 	return ret;
 }
 
+static bool trace_kprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+
+	return trace_probe_is_enabled(&tk->tp);
+}
+
+static bool trace_kprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev)
+{
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+
+	return strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
+	    (!system || strcmp(tk->tp.call.class->system, system) == 0);
+}
+
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 {
 	unsigned long nhit = 0;
@@ -128,9 +179,6 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
-static DEFINE_MUTEX(probe_lock);
-static LIST_HEAD(probe_list);
-
 static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
 static int kretprobe_dispatcher(struct kretprobe_instance *ri,
 				struct pt_regs *regs);
@@ -192,7 +240,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	if (!tk->tp.class.system)
 		goto error;
 
-	INIT_LIST_HEAD(&tk->list);
+	dyn_event_init(&tk->devent, &trace_kprobe_ops);
 	INIT_LIST_HEAD(&tk->tp.files);
 	return tk;
 error:
@@ -207,6 +255,9 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i;
 
+	if (!tk)
+		return;
+
 	for (i = 0; i < tk->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tk->tp.args[i]);
 
@@ -220,9 +271,10 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 static struct trace_kprobe *find_trace_kprobe(const char *event,
 					      const char *group)
 {
+	struct dyn_event *pos;
 	struct trace_kprobe *tk;
 
-	list_for_each_entry(tk, &probe_list, list)
+	for_each_trace_kprobe(tk, pos)
 		if (strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
 		    strcmp(tk->tp.call.class->system, group) == 0)
 			return tk;
@@ -321,7 +373,7 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	 * created with perf_event_open. We don't need to wait for these
 	 * trace_kprobes
 	 */
-	if (list_empty(&tk->list))
+	if (list_empty(&tk->devent.list))
 		wait = 0;
  out:
 	if (wait) {
@@ -419,7 +471,7 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 	}
 }
 
-/* Unregister a trace_probe and probe_event: call with locking probe_lock */
+/* Unregister a trace_probe and probe_event */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
 	/* Enabled event can not be unregistered */
@@ -431,7 +483,7 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 		return -EBUSY;
 
 	__unregister_trace_kprobe(tk);
-	list_del(&tk->list);
+	dyn_event_remove(&tk->devent);
 
 	return 0;
 }
@@ -442,7 +494,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	struct trace_kprobe *old_tk;
 	int ret;
 
-	mutex_lock(&probe_lock);
+	mutex_lock(&event_mutex);
 
 	/* Delete old (same name) event if exist */
 	old_tk = find_trace_kprobe(trace_event_name(&tk->tp.call),
@@ -471,10 +523,10 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret < 0)
 		unregister_kprobe_event(tk);
 	else
-		list_add_tail(&tk->list, &probe_list);
+		dyn_event_add(&tk->devent);
 
 end:
-	mutex_unlock(&probe_lock);
+	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -483,6 +535,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
 {
 	struct module *mod = data;
+	struct dyn_event *pos;
 	struct trace_kprobe *tk;
 	int ret;
 
@@ -490,8 +543,8 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/* Update probes on coming module */
-	mutex_lock(&probe_lock);
-	list_for_each_entry(tk, &probe_list, list) {
+	mutex_lock(&event_mutex);
+	for_each_trace_kprobe(tk, pos) {
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
@@ -502,7 +555,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 					mod->name, ret);
 		}
 	}
-	mutex_unlock(&probe_lock);
+	mutex_unlock(&event_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -520,7 +573,7 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
-static int create_trace_kprobe(int argc, char **argv)
+static int trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
 	 * Argument syntax:
@@ -544,37 +597,37 @@ static int create_trace_kprobe(int argc, char **argv)
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_kprobe *tk;
-	int i, ret = 0;
-	bool is_return = false, is_delete = false;
-	char *symbol = NULL, *event = NULL, *group = NULL;
+	int i, len, ret = 0;
+	bool is_return = false;
+	char *symbol = NULL, *tmp = NULL;
+	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
 	int maxactive = 0;
-	char *arg;
 	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL;
 
 	/* argc must be >= 1 */
-	if (argv[0][0] == 'p')
-		is_return = false;
-	else if (argv[0][0] == 'r') {
+	if (argv[0][0] == 'r') {
 		is_return = true;
 		flags |= TPARG_FL_RETURN;
-	} else if (argv[0][0] == '-')
-		is_delete = true;
-	else {
-		pr_info("Probe definition must be started with 'p', 'r' or"
-			" '-'.\n");
-		return -EINVAL;
-	}
+	} else if (argv[0][0] != 'p' || argc < 2)
+		return -ECANCELED;
 
 	event = strchr(&argv[0][1], ':');
-	if (event) {
-		event[0] = '\0';
+	if (event)
 		event++;
-	}
+
 	if (is_return && isdigit(argv[0][1])) {
-		ret = kstrtouint(&argv[0][1], 0, &maxactive);
+		if (event)
+			len = event - &argv[0][1] - 1;
+		else
+			len = strlen(&argv[0][1]);
+		if (len > MAX_EVENT_NAME_LEN - 1)
+			return -E2BIG;
+		memcpy(buf, &argv[0][1], len);
+		buf[len] = '\0';
+		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret) {
 			pr_info("Failed to parse maxactive.\n");
 			return ret;
@@ -589,74 +642,37 @@ static int create_trace_kprobe(int argc, char **argv)
 		}
 	}
 
-	if (event) {
-		char *slash;
-
-		slash = strchr(event, '/');
-		if (slash) {
-			group = event;
-			event = slash + 1;
-			slash[0] = '\0';
-			if (strlen(group) == 0) {
-				pr_info("Group name is not specified\n");
-				return -EINVAL;
-			}
-		}
-		if (strlen(event) == 0) {
-			pr_info("Event name is not specified\n");
-			return -EINVAL;
-		}
-	}
-	if (!group)
-		group = KPROBE_EVENT_SYSTEM;
-
-	if (is_delete) {
-		if (!event) {
-			pr_info("Delete command needs an event name.\n");
-			return -EINVAL;
-		}
-		mutex_lock(&probe_lock);
-		tk = find_trace_kprobe(event, group);
-		if (!tk) {
-			mutex_unlock(&probe_lock);
-			pr_info("Event %s/%s doesn't exist.\n", group, event);
-			return -ENOENT;
-		}
-		/* delete an event */
-		ret = unregister_trace_kprobe(tk);
-		if (ret == 0)
-			free_trace_kprobe(tk);
-		mutex_unlock(&probe_lock);
-		return ret;
-	}
-
-	if (argc < 2) {
-		pr_info("Probe point is not specified.\n");
-		return -EINVAL;
-	}
-
 	/* try to parse an address. if that fails, try to read the
 	 * input as a symbol. */
 	if (kstrtoul(argv[1], 0, (unsigned long *)&addr)) {
+		/* Check whether uprobe event specified */
+		if (strchr(argv[1], '/') && strchr(argv[1], ':'))
+			return -ECANCELED;
 		/* a symbol specified */
-		symbol = argv[1];
+		symbol = kstrdup(argv[1], GFP_KERNEL);
+		if (!symbol)
+			return -ENOMEM;
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			pr_info("Failed to parse either an address or a symbol.\n");
-			return ret;
+			goto out;
 		}
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
 		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
 			pr_info("Given offset is not valid for return probe.\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	}
 	argc -= 2; argv += 2;
 
-	/* setup a probe */
-	if (!event) {
+	if (event) {
+		ret = traceprobe_parse_event_name(&event, &group, buf);
+		if (ret)
+			goto out;
+	} else {
 		/* Make a new event name */
 		if (symbol)
 			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
@@ -667,121 +683,67 @@ static int create_trace_kprobe(int argc, char **argv)
 		sanitize_event_name(buf);
 		event = buf;
 	}
+
+	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
 			       argc, is_return);
 	if (IS_ERR(tk)) {
 		pr_info("Failed to allocate trace_probe.(%d)\n",
 			(int)PTR_ERR(tk));
-		return PTR_ERR(tk);
+		ret = PTR_ERR(tk);
+		goto out;
 	}
 
 	/* parse arguments */
-	ret = 0;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
-
-		/* Increment count for freeing args in error case */
-		tk->tp.nr_args++;
-
-		/* Parse argument name */
-		arg = strchr(argv[i], '=');
-		if (arg) {
-			*arg++ = '\0';
-			parg->name = kstrdup(argv[i], GFP_KERNEL);
-		} else {
-			arg = argv[i];
-			/* If argument name is omitted, set "argN" */
-			snprintf(buf, MAX_EVENT_NAME_LEN, "arg%d", i + 1);
-			parg->name = kstrdup(buf, GFP_KERNEL);
-		}
-
-		if (!parg->name) {
-			pr_info("Failed to allocate argument[%d] name.\n", i);
+		tmp = kstrdup(argv[i], GFP_KERNEL);
+		if (!tmp) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
-		if (!is_good_name(parg->name)) {
-			pr_info("Invalid argument[%d] name: %s\n",
-				i, parg->name);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		if (traceprobe_conflict_field_name(parg->name,
-							tk->tp.args, i)) {
-			pr_info("Argument[%d] name '%s' conflicts with "
-				"another field.\n", i, argv[i]);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		/* Parse fetch argument */
-		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						 flags);
-		if (ret) {
-			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+		ret = traceprobe_parse_probe_arg(&tk->tp, i, tmp, flags);
+		kfree(tmp);
+		if (ret)
 			goto error;
-		}
 	}
 
 	ret = register_trace_kprobe(tk);
 	if (ret)
 		goto error;
-	return 0;
+out:
+	kfree(symbol);
+	return ret;
 
 error:
 	free_trace_kprobe(tk);
-	return ret;
+	goto out;
 }
 
-static int release_all_trace_kprobes(void)
+static int create_or_delete_trace_kprobe(int argc, char **argv)
 {
-	struct trace_kprobe *tk;
-	int ret = 0;
-
-	mutex_lock(&probe_lock);
-	/* Ensure no probe is in use. */
-	list_for_each_entry(tk, &probe_list, list)
-		if (trace_probe_is_enabled(&tk->tp)) {
-			ret = -EBUSY;
-			goto end;
-		}
-	/* TODO: Use batch unregistration */
-	while (!list_empty(&probe_list)) {
-		tk = list_entry(probe_list.next, struct trace_kprobe, list);
-		ret = unregister_trace_kprobe(tk);
-		if (ret)
-			goto end;
-		free_trace_kprobe(tk);
-	}
-
-end:
-	mutex_unlock(&probe_lock);
+	int ret;
 
-	return ret;
-}
+	if (argv[0][0] == '-')
+		return dyn_event_release(argc, argv, &trace_kprobe_ops);
 
-/* Probes listing interfaces */
-static void *probes_seq_start(struct seq_file *m, loff_t *pos)
-{
-	mutex_lock(&probe_lock);
-	return seq_list_start(&probe_list, *pos);
+	ret = trace_kprobe_create(argc, (const char **)argv);
+	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-static void *probes_seq_next(struct seq_file *m, void *v, loff_t *pos)
+static int trace_kprobe_release(struct dyn_event *ev)
 {
-	return seq_list_next(v, &probe_list, pos);
-}
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+	int ret = unregister_trace_kprobe(tk);
 
-static void probes_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&probe_lock);
+	if (!ret)
+		free_trace_kprobe(tk);
+	return ret;
 }
 
-static int probes_seq_show(struct seq_file *m, void *v)
+static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
 {
-	struct trace_kprobe *tk = v;
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
 	int i;
 
 	seq_putc(m, trace_kprobe_is_return(tk) ? 'r' : 'p');
@@ -803,10 +765,20 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int probes_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_trace_kprobe(ev))
+		return 0;
+
+	return trace_kprobe_show(m, ev);
+}
+
 static const struct seq_operations probes_seq_op = {
-	.start  = probes_seq_start,
-	.next   = probes_seq_next,
-	.stop   = probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show   = probes_seq_show
 };
 
@@ -815,7 +787,7 @@ static int probes_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_trace_kprobes();
+		ret = dyn_events_release_all(&trace_kprobe_ops);
 		if (ret < 0)
 			return ret;
 	}
@@ -827,7 +799,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_trace_kprobe);
+				       create_or_delete_trace_kprobe);
 }
 
 static const struct file_operations kprobe_events_ops = {
@@ -842,8 +814,13 @@ static const struct file_operations kprobe_events_ops = {
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
-	struct trace_kprobe *tk = v;
+	struct dyn_event *ev = v;
+	struct trace_kprobe *tk;
+
+	if (!is_trace_kprobe(ev))
+		return 0;
 
+	tk = to_trace_kprobe(ev);
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_event_name(&tk->tp.call),
 		   trace_kprobe_nhit(tk),
@@ -853,9 +830,9 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 }
 
 static const struct seq_operations profile_seq_op = {
-	.start  = probes_seq_start,
-	.next   = probes_seq_next,
-	.stop   = probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show   = probes_profile_seq_show
 };
 
@@ -1408,7 +1385,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	char *event;
 
 	/*
-	 * local trace_kprobes are not added to probe_list, so they are never
+	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
 	 * duplicated name here.
 	 */
@@ -1466,6 +1443,11 @@ static __init int init_kprobe_trace(void)
 {
 	struct dentry *d_tracer;
 	struct dentry *entry;
+	int ret;
+
+	ret = dyn_event_register(&trace_kprobe_ops);
+	if (ret)
+		return ret;
 
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
@@ -1523,9 +1505,8 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	pr_info("Testing kprobe tracing: ");
 
-	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target "
-				"$stack $stack0 +0($stack)",
-				create_trace_kprobe);
+	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)",
+				create_or_delete_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
@@ -1545,8 +1526,8 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 	}
 
-	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target "
-				"$retval", create_trace_kprobe);
+	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target $retval",
+				create_or_delete_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function return.\n");
 		warn++;
@@ -1616,20 +1597,24 @@ static __init int kprobe_trace_self_tests_init(void)
 			disable_trace_kprobe(tk, file);
 	}
 
-	ret = trace_run_command("-:testprobe", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe", create_or_delete_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
-	ret = trace_run_command("-:testprobe2", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe2", create_or_delete_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
 end:
-	release_all_trace_kprobes();
+	ret = dyn_events_release_all(&trace_kprobe_ops);
+	if (WARN_ON_ONCE(ret)) {
+		pr_warn("error on cleaning up probes.\n");
+		warn++;
+	}
 	/*
 	 * Wait for the optimizer work to finish. Otherwise it might fiddle
 	 * with probes in already freed __init text.
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 6e6cc64faa38..54373d93e251 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,43 +339,24 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym_short(struct trace_seq *s, const char *fmt, unsigned long address)
+seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 {
-	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
-	const char *name;
-
-	kallsyms_lookup(address, NULL, NULL, NULL, str);
-
-	name = kretprobed(str);
-
-	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
-		return;
-	}
-#endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
-}
-
-static void
-seq_print_sym_offset(struct trace_seq *s, const char *fmt,
-		     unsigned long address)
-{
 	char str[KSYM_SYMBOL_LEN];
-#ifdef CONFIG_KALLSYMS
 	const char *name;
 
-	sprint_symbol(str, address);
+	if (offset)
+		sprint_symbol(str, address);
+	else
+		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
+		trace_seq_puts(s, name);
 		return;
 	}
 #endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
+	trace_seq_printf(s, "0x%08lx", address);
 }
 
 #ifndef CONFIG_64BIT
@@ -424,10 +405,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	if (sym_flags & TRACE_ITER_SYM_OFFSET)
-		seq_print_sym_offset(s, "%s", ip);
-	else
-		seq_print_sym_short(s, "%s", ip);
+	seq_print_sym(s, ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bd30e9398d2a..9962cb5da8ac 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -154,24 +154,52 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 	return 0;
 }
 
+/* @buf must has MAX_EVENT_NAME_LEN size */
+int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
+				char *buf)
+{
+	const char *slash, *event = *pevent;
+
+	slash = strchr(event, '/');
+	if (slash) {
+		if (slash == event) {
+			pr_info("Group name is not specified\n");
+			return -EINVAL;
+		}
+		if (slash - event + 1 > MAX_EVENT_NAME_LEN) {
+			pr_info("Group name is too long\n");
+			return -E2BIG;
+		}
+		strlcpy(buf, event, slash - event + 1);
+		*pgroup = buf;
+		*pevent = slash + 1;
+	}
+	if (strlen(event) == 0) {
+		pr_info("Event name is not specified\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			    struct fetch_insn *code, unsigned int flags)
 {
-	int ret = 0;
 	unsigned long param;
+	int ret = 0;
+	int len;
 
 	if (strcmp(arg, "retval") == 0) {
 		if (flags & TPARG_FL_RETURN)
 			code->op = FETCH_OP_RETVAL;
 		else
 			ret = -EINVAL;
-	} else if (strncmp(arg, "stack", 5) == 0) {
-		if (arg[5] == '\0') {
+	} else if ((len = str_has_prefix(arg, "stack"))) {
+		if (arg[len] == '\0') {
 			code->op = FETCH_OP_STACKP;
-		} else if (isdigit(arg[5])) {
-			ret = kstrtoul(arg + 5, 10, &param);
+		} else if (isdigit(arg[len])) {
+			ret = kstrtoul(arg + len, 10, &param);
 			if (ret || ((flags & TPARG_FL_KERNEL) &&
 				    param > PARAM_MAX_STACK))
 				ret = -EINVAL;
@@ -186,10 +214,10 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	} else if (((flags & TPARG_FL_MASK) ==
 		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
-		   strncmp(arg, "arg", 3) == 0) {
-		if (!isdigit(arg[3]))
+		   (len = str_has_prefix(arg, "arg"))) {
+		if (!isdigit(arg[len]))
 			return -EINVAL;
-		ret = kstrtoul(arg + 3, 10, &param);
+		ret = kstrtoul(arg + len, 10, &param);
 		if (ret || !param || param > PARAM_MAX_STACK)
 			return -EINVAL;
 		code->op = FETCH_OP_ARG;
@@ -348,7 +376,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 }
 
 /* String length checking wrapper */
-int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
+static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		struct probe_arg *parg, unsigned int flags)
 {
 	struct fetch_insn *code, *scode, *tmp = NULL;
@@ -491,8 +519,8 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 }
 
 /* Return 1 if name is reserved or already used by another argument */
-int traceprobe_conflict_field_name(const char *name,
-			       struct probe_arg *args, int narg)
+static int traceprobe_conflict_field_name(const char *name,
+					  struct probe_arg *args, int narg)
 {
 	int i;
 
@@ -507,6 +535,47 @@ int traceprobe_conflict_field_name(const char *name,
 	return 0;
 }
 
+int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
+				unsigned int flags)
+{
+	struct probe_arg *parg = &tp->args[i];
+	char *body;
+	int ret;
+
+	/* Increment count for freeing args in error case */
+	tp->nr_args++;
+
+	body = strchr(arg, '=');
+	if (body) {
+		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
+		body++;
+	} else {
+		/* If argument name is omitted, set "argN" */
+		parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
+		body = arg;
+	}
+	if (!parg->name)
+		return -ENOMEM;
+
+	if (!is_good_name(parg->name)) {
+		pr_info("Invalid argument[%d] name: %s\n",
+			i, parg->name);
+		return -EINVAL;
+	}
+
+	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
+		pr_info("Argument[%d]: '%s' conflicts with another field.\n",
+			i, parg->name);
+		return -EINVAL;
+	}
+
+	/* Parse fetch argument */
+	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg, flags);
+	if (ret)
+		pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+	return ret;
+}
+
 void traceprobe_free_probe_arg(struct probe_arg *arg)
 {
 	struct fetch_insn *code = arg->code;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 974afc1a3e73..8a63f8bc01bc 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -272,16 +272,15 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
 #define TPARG_FL_FENTRY BIT(2)
 #define TPARG_FL_MASK	GENMASK(2, 0)
 
-extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		   struct probe_arg *parg, unsigned int flags);
-
-extern int traceprobe_conflict_field_name(const char *name,
-			       struct probe_arg *args, int narg);
+extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
+				char *arg, unsigned int flags);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
+extern int traceprobe_parse_event_name(const char **pevent,
+				       const char **pgroup, char *buf);
 
 extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 7d04b9890755..4ea7e6845efb 100644
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
 
-	return trace_keep_overwrite(tracer, mask, set);
-}
-
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
@@ -283,6 +162,11 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
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
@@ -318,20 +202,87 @@ static void wakeup_print_header(struct seq_file *s)
 	else
 		trace_default_header(s);
 }
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
+		ret = register_ftrace_graph(&fgraph_wakeup_ops);
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
+		unregister_ftrace_graph(&fgraph_wakeup_ops);
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
@@ -340,23 +291,58 @@ static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
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
 {
-	trace_latency_header(s);
+	if (is_graph(tr))
+		trace_graph_function(tr, ip, parent_ip, flags, pc);
+	else
+		trace_function(tr, ip, parent_ip, flags, pc);
+}
+
+static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
+{
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
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 2b0d1ee3241c..eec648a0d673 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -286,7 +286,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
@@ -448,8 +448,10 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
 {
-	if (strncmp(str, "_filter=", 8) == 0)
-		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
+	int len;
+
+	if ((len = str_has_prefix(str, "_filter=")))
+		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
 	last_stack_tracer_enabled = 1;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 31ea48eceda1..e335576b9411 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/uprobes.h>
@@ -14,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/rculist.h>
 
+#include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
 
@@ -37,11 +39,26 @@ struct trace_uprobe_filter {
 	struct list_head	perf_events;
 };
 
+static int trace_uprobe_create(int argc, const char **argv);
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_uprobe_release(struct dyn_event *ev);
+static bool trace_uprobe_is_busy(struct dyn_event *ev);
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev);
+
+static struct dyn_event_operations trace_uprobe_ops = {
+	.create = trace_uprobe_create,
+	.show = trace_uprobe_show,
+	.is_busy = trace_uprobe_is_busy,
+	.free = trace_uprobe_release,
+	.match = trace_uprobe_match,
+};
+
 /*
  * uprobe event core functions
  */
 struct trace_uprobe {
-	struct list_head		list;
+	struct dyn_event		devent;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
 	struct path			path;
@@ -53,6 +70,25 @@ struct trace_uprobe {
 	struct trace_probe		tp;
 };
 
+static bool is_trace_uprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_uprobe_ops;
+}
+
+static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_uprobe, devent);
+}
+
+/**
+ * for_each_trace_uprobe - iterate over the trace_uprobe list
+ * @pos:	the struct trace_uprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ */
+#define for_each_trace_uprobe(pos, dpos)	\
+	for_each_dyn_event(dpos)		\
+		if (is_trace_uprobe(dpos) && (pos = to_trace_uprobe(dpos)))
+
 #define SIZEOF_TRACE_UPROBE(n)				\
 	(offsetof(struct trace_uprobe, tp.args) +	\
 	(sizeof(struct probe_arg) * (n)))
@@ -60,9 +96,6 @@ struct trace_uprobe {
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static DEFINE_MUTEX(uprobe_lock);
-static LIST_HEAD(uprobe_list);
-
 struct uprobe_dispatch_data {
 	struct trace_uprobe	*tu;
 	unsigned long		bp_addr;
@@ -209,6 +242,22 @@ static inline bool is_ret_probe(struct trace_uprobe *tu)
 	return tu->consumer.ret_handler != NULL;
 }
 
+static bool trace_uprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return trace_probe_is_enabled(&tu->tp);
+}
+
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
+		(!system || strcmp(tu->tp.call.class->system, system) == 0);
+}
+
 /*
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */
@@ -236,7 +285,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu->tp.class.system)
 		goto error;
 
-	INIT_LIST_HEAD(&tu->list);
+	dyn_event_init(&tu->devent, &trace_uprobe_ops);
 	INIT_LIST_HEAD(&tu->tp.files);
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
@@ -255,6 +304,9 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 {
 	int i;
 
+	if (!tu)
+		return;
+
 	for (i = 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
 
@@ -267,9 +319,10 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 
 static struct trace_uprobe *find_probe_event(const char *event, const char *group)
 {
+	struct dyn_event *pos;
 	struct trace_uprobe *tu;
 
-	list_for_each_entry(tu, &uprobe_list, list)
+	for_each_trace_uprobe(tu, pos)
 		if (strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
 		    strcmp(tu->tp.call.class->system, group) == 0)
 			return tu;
@@ -277,7 +330,7 @@ static struct trace_uprobe *find_probe_event(const char *event, const char *grou
 	return NULL;
 }
 
-/* Unregister a trace_uprobe and probe_event: call with locking uprobe_lock */
+/* Unregister a trace_uprobe and probe_event */
 static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
@@ -286,7 +339,7 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	if (ret)
 		return ret;
 
-	list_del(&tu->list);
+	dyn_event_remove(&tu->devent);
 	free_trace_uprobe(tu);
 	return 0;
 }
@@ -302,13 +355,14 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
  */
 static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
 {
+	struct dyn_event *pos;
 	struct trace_uprobe *tmp, *old = NULL;
 	struct inode *new_inode = d_real_inode(new->path.dentry);
 
 	old = find_probe_event(trace_event_name(&new->tp.call),
 				new->tp.call.class->system);
 
-	list_for_each_entry(tmp, &uprobe_list, list) {
+	for_each_trace_uprobe(tmp, pos) {
 		if ((old ? old != tmp : true) &&
 		    new_inode == d_real_inode(tmp->path.dentry) &&
 		    new->offset == tmp->offset &&
@@ -326,7 +380,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	struct trace_uprobe *old_tu;
 	int ret;
 
-	mutex_lock(&uprobe_lock);
+	mutex_lock(&event_mutex);
 
 	/* register as an event */
 	old_tu = find_old_trace_uprobe(tu);
@@ -348,10 +402,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 		goto end;
 	}
 
-	list_add_tail(&tu->list, &uprobe_list);
+	dyn_event_add(&tu->devent);
 
 end:
-	mutex_unlock(&uprobe_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
@@ -362,91 +416,49 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  *
  *  - Remove uprobe: -:[GRP/]EVENT
  */
-static int create_trace_uprobe(int argc, char **argv)
+static int trace_uprobe_create(int argc, const char **argv)
 {
 	struct trace_uprobe *tu;
-	char *arg, *event, *group, *filename, *rctr, *rctr_end;
+	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
+	char *arg, *filename, *rctr, *rctr_end, *tmp;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
 	unsigned long offset, ref_ctr_offset;
-	bool is_delete, is_return;
+	bool is_return = false;
 	int i, ret;
 
 	ret = 0;
-	is_delete = false;
-	is_return = false;
-	event = NULL;
-	group = NULL;
 	ref_ctr_offset = 0;
 
 	/* argc must be >= 1 */
-	if (argv[0][0] == '-')
-		is_delete = true;
-	else if (argv[0][0] == 'r')
+	if (argv[0][0] == 'r')
 		is_return = true;
-	else if (argv[0][0] != 'p') {
-		pr_info("Probe definition must be started with 'p', 'r' or '-'.\n");
-		return -EINVAL;
-	}
+	else if (argv[0][0] != 'p' || argc < 2)
+		return -ECANCELED;
 
-	if (argv[0][1] == ':') {
+	if (argv[0][1] == ':')
 		event = &argv[0][2];
-		arg = strchr(event, '/');
-
-		if (arg) {
-			group = event;
-			event = arg + 1;
-			event[-1] = '\0';
-
-			if (strlen(group) == 0) {
-				pr_info("Group name is not specified\n");
-				return -EINVAL;
-			}
-		}
-		if (strlen(event) == 0) {
-			pr_info("Event name is not specified\n");
-			return -EINVAL;
-		}
-	}
-	if (!group)
-		group = UPROBE_EVENT_SYSTEM;
 
-	if (is_delete) {
-		int ret;
+	if (!strchr(argv[1], '/'))
+		return -ECANCELED;
 
-		if (!event) {
-			pr_info("Delete command needs an event name.\n");
-			return -EINVAL;
-		}
-		mutex_lock(&uprobe_lock);
-		tu = find_probe_event(event, group);
-
-		if (!tu) {
-			mutex_unlock(&uprobe_lock);
-			pr_info("Event %s/%s doesn't exist.\n", group, event);
-			return -ENOENT;
-		}
-		/* delete an event */
-		ret = unregister_trace_uprobe(tu);
-		mutex_unlock(&uprobe_lock);
-		return ret;
-	}
+	filename = kstrdup(argv[1], GFP_KERNEL);
+	if (!filename)
+		return -ENOMEM;
 
-	if (argc < 2) {
-		pr_info("Probe point is not specified.\n");
-		return -EINVAL;
-	}
 	/* Find the last occurrence, in case the path contains ':' too. */
-	arg = strrchr(argv[1], ':');
-	if (!arg)
-		return -EINVAL;
+	arg = strrchr(filename, ':');
+	if (!arg || !isdigit(arg[1])) {
+		kfree(filename);
+		return -ECANCELED;
+	}
 
 	*arg++ = '\0';
-	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
-	if (ret)
+	if (ret) {
+		kfree(filename);
 		return ret;
-
+	}
 	if (!d_is_reg(path.dentry)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
@@ -480,7 +492,11 @@ static int create_trace_uprobe(int argc, char **argv)
 	argv += 2;
 
 	/* setup a probe */
-	if (!event) {
+	if (event) {
+		ret = traceprobe_parse_event_name(&event, &group, buf);
+		if (ret)
+			goto fail_address_parse;
+	} else {
 		char *tail;
 		char *ptr;
 
@@ -508,60 +524,21 @@ static int create_trace_uprobe(int argc, char **argv)
 	tu->offset = offset;
 	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->path = path;
-	tu->filename = kstrdup(filename, GFP_KERNEL);
-
-	if (!tu->filename) {
-		pr_info("Failed to allocate filename.\n");
-		ret = -ENOMEM;
-		goto error;
-	}
+	tu->filename = filename;
 
 	/* parse arguments */
-	ret = 0;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		/* Increment count for freeing args in error case */
-		tu->tp.nr_args++;
-
-		/* Parse argument name */
-		arg = strchr(argv[i], '=');
-		if (arg) {
-			*arg++ = '\0';
-			parg->name = kstrdup(argv[i], GFP_KERNEL);
-		} else {
-			arg = argv[i];
-			/* If argument name is omitted, set "argN" */
-			snprintf(buf, MAX_EVENT_NAME_LEN, "arg%d", i + 1);
-			parg->name = kstrdup(buf, GFP_KERNEL);
-		}
-
-		if (!parg->name) {
-			pr_info("Failed to allocate argument[%d] name.\n", i);
+		tmp = kstrdup(argv[i], GFP_KERNEL);
+		if (!tmp) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
-		if (!is_good_name(parg->name)) {
-			pr_info("Invalid argument[%d] name: %s\n", i, parg->name);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		if (traceprobe_conflict_field_name(parg->name, tu->tp.args, i)) {
-			pr_info("Argument[%d] name '%s' conflicts with "
-				"another field.\n", i, argv[i]);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		/* Parse fetch argument */
-		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, tmp,
 					is_return ? TPARG_FL_RETURN : 0);
-		if (ret) {
-			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+		kfree(tmp);
+		if (ret)
 			goto error;
-		}
 	}
 
 	ret = register_trace_uprobe(tu);
@@ -575,48 +552,35 @@ static int create_trace_uprobe(int argc, char **argv)
 
 fail_address_parse:
 	path_put(&path);
+	kfree(filename);
 
 	pr_info("Failed to parse address or file.\n");
 
 	return ret;
 }
 
-static int cleanup_all_probes(void)
+static int create_or_delete_trace_uprobe(int argc, char **argv)
 {
-	struct trace_uprobe *tu;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&uprobe_lock);
-	while (!list_empty(&uprobe_list)) {
-		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
-		ret = unregister_trace_uprobe(tu);
-		if (ret)
-			break;
-	}
-	mutex_unlock(&uprobe_lock);
-	return ret;
-}
+	if (argv[0][0] == '-')
+		return dyn_event_release(argc, argv, &trace_uprobe_ops);
 
-/* Probes listing interfaces */
-static void *probes_seq_start(struct seq_file *m, loff_t *pos)
-{
-	mutex_lock(&uprobe_lock);
-	return seq_list_start(&uprobe_list, *pos);
+	ret = trace_uprobe_create(argc, (const char **)argv);
+	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-static void *probes_seq_next(struct seq_file *m, void *v, loff_t *pos)
+static int trace_uprobe_release(struct dyn_event *ev)
 {
-	return seq_list_next(v, &uprobe_list, pos);
-}
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-static void probes_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&uprobe_lock);
+	return unregister_trace_uprobe(tu);
 }
 
-static int probes_seq_show(struct seq_file *m, void *v)
+/* Probes listing interfaces */
+static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 {
-	struct trace_uprobe *tu = v;
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
@@ -634,11 +598,21 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int probes_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_trace_uprobe(ev))
+		return 0;
+
+	return trace_uprobe_show(m, ev);
+}
+
 static const struct seq_operations probes_seq_op = {
-	.start	= probes_seq_start,
-	.next	= probes_seq_next,
-	.stop	= probes_seq_stop,
-	.show	= probes_seq_show
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
+	.show   = probes_seq_show
 };
 
 static int probes_open(struct inode *inode, struct file *file)
@@ -646,7 +620,7 @@ static int probes_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = cleanup_all_probes();
+		ret = dyn_events_release_all(&trace_uprobe_ops);
 		if (ret)
 			return ret;
 	}
@@ -657,7 +631,8 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
+	return trace_parse_run_command(file, buffer, count, ppos,
+					create_or_delete_trace_uprobe);
 }
 
 static const struct file_operations uprobe_events_ops = {
@@ -672,17 +647,22 @@ static const struct file_operations uprobe_events_ops = {
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
-	struct trace_uprobe *tu = v;
+	struct dyn_event *ev = v;
+	struct trace_uprobe *tu;
 
+	if (!is_trace_uprobe(ev))
+		return 0;
+
+	tu = to_trace_uprobe(ev);
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
 			trace_event_name(&tu->tp.call), tu->nhit);
 	return 0;
 }
 
 static const struct seq_operations profile_seq_op = {
-	.start	= probes_seq_start,
-	.next	= probes_seq_next,
-	.stop	= probes_seq_stop,
+	.start  = dyn_event_seq_start,
+	.next   = dyn_event_seq_next,
+	.stop   = dyn_event_seq_stop,
 	.show	= probes_profile_seq_show
 };
 
@@ -1384,7 +1364,7 @@ create_local_trace_uprobe(char *name, unsigned long offs,
 	}
 
 	/*
-	 * local trace_kprobes are not added to probe_list, so they are never
+	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
 	 * duplicated name "DUMMY_EVENT" here.
 	 */
@@ -1432,6 +1412,11 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
 static __init int init_uprobe_trace(void)
 {
 	struct dentry *d_tracer;
+	int ret;
+
+	ret = dyn_event_register(&trace_uprobe_ops);
+	if (ret)
+		return ret;
 
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer))
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..bd807f545a9d 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -140,13 +140,17 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
  */
 int seq_buf_puts(struct seq_buf *s, const char *str)
 {
-	unsigned int len = strlen(str);
+	size_t len = strlen(str);
 
 	WARN_ON(s->size == 0);
 
+	/* Add 1 to len for the trailing null byte which must be there */
+	len += 1;
+
 	if (seq_buf_can_fit(s, len)) {
 		memcpy(s->buffer + s->len, str, len);
-		s->len += len;
+		/* Don't count the trailing null byte against the capacity */
+		s->len += len - 1;
 		return 0;
 	}
 	seq_buf_set_overflow(s);
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 895c40e8679f..a50a2aa963ad 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -397,7 +397,7 @@ static uint32_t (*w2)(uint16_t);
 static int
 is_mcounted_section_name(char const *const txtname)
 {
-	return strcmp(".text",           txtname) == 0 ||
+	return strncmp(".text",          txtname, 5) == 0 ||
 		strcmp(".init.text",     txtname) == 0 ||
 		strcmp(".ref.text",      txtname) == 0 ||
 		strcmp(".sched.text",    txtname) == 0 ||
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index f599031260d5..68841d01162c 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -142,6 +142,11 @@ my %text_sections = (
      ".text.unlikely" => 1,
 );
 
+# Acceptable section-prefixes to record.
+my %text_section_prefixes = (
+     ".text." => 1,
+);
+
 # Note: we are nice to C-programmers here, thus we skip the '||='-idiom.
 $objdump = 'objdump' if (!$objdump);
 $objcopy = 'objcopy' if (!$objcopy);
@@ -519,6 +524,14 @@ while (<IN>) {
 
 	# Only record text sections that we know are safe
 	$read_function = defined($text_sections{$1});
+	if (!$read_function) {
+	    foreach my $prefix (keys %text_section_prefixes) {
+	        if (substr($1, 0, length $prefix) eq $prefix) {
+	            $read_function = 1;
+	            last;
+	        }
+	    }
+	}
 	# print out any recorded offsets
 	update_funcs();
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
new file mode 100644
index 000000000000..c6d8387dbbb8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove kprobe events
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/kprobes/myevent1
+test -d events/kprobes/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
new file mode 100644
index 000000000000..62b77b5941d0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove synthetic events
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+test -d events/synthetic/latency1
+test -d events/synthetic/latency2
+
+echo "-:synthetic/latency2" >> dynamic_events
+
+grep -q latency1 dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
new file mode 100644
index 000000000000..e0842109cb57
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - selective clear (compatibility)
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+[ -f synthetic_events ] || exit_unsupported
+[ -f kprobe_events ] || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+setup_events() {
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+}
+
+setup_events
+echo > synthetic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+! grep -q latency1 dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events
+
+setup_events
+echo > kprobe_events
+
+! grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
new file mode 100644
index 000000000000..901922e97878
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - generic clear event
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+setup_events() {
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+}
+
+setup_events
+
+echo "!p:myevent1 $PLACE" >> dynamic_events
+! grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+grep -q myevent2 dynamic_events
+! grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!r:myevent2 $PLACE" >> dynamic_events
+! grep -q myevent2 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events
