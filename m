Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F7621920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbeLUR6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391135AbeLUR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:58 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BFC21934;
        Fri, 21 Dec 2018 17:56:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2e-0002Ki-Jw; Fri, 21 Dec 2018 12:56:56 -0500
Message-Id: <20181221175656.503716620@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [for-next][PATCH 08/24] arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The structure of the ret_stack array on the task struct is going to
change, and accessing it directly via the curr_ret_stack index will no
longer give the ret_stack entry that holds the return address. To access
that, architectures must now use ftrace_graph_get_ret_stack() to get the
associated ret_stack that matches the saved return address.

Cc: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/perf_callchain.c |  2 +-
 arch/arm64/kernel/process.c        |  2 +-
 arch/arm64/kernel/return_address.c |  2 +-
 arch/arm64/kernel/stacktrace.c     | 12 +++++++-----
 arch/arm64/kernel/time.c           |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

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
index 7723dadf25be..1a29f2695ff2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -59,15 +59,17 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
-		if (WARN_ON_ONCE(frame->graph == -1))
-			return -EINVAL;
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
 
@@ -134,7 +136,7 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, save_trace, &data);
@@ -165,7 +167,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
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
-- 
2.19.2


