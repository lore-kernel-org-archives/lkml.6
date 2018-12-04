Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E0FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441C3214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w/9x5U/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441C3214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeLDLAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbeLDLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915D72146D;
        Tue,  4 Dec 2018 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921200;
        bh=A/oD4giaoXO3ELGULyv7wi0D/8IvhS+HcPKxWOJwWF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/9x5U/8R61fJyVE4xVv8nSFSHEu8gVuQdQniPgkzbuD6Y1FsWDFv/NYEEptusAze
         icqS9nQGYx+fx+k120XGJxtcOttYx0wEkWks7pWk21RYsBj2pQI+84pukQJB9RtOPV
         g2WJoJdPpTygOKRtitRciw+N4l5S4pynM9hUSHPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 112/139] function_graph: Use new curr_ret_depth to manage depth instead of curr_ret_stack
Date:   Tue,  4 Dec 2018 11:49:53 +0100
Message-Id: <20181204103655.218767463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

commit 39eb456dacb543de90d3bc6a8e0ac5cf51ac475e upstream.

Currently, the depth of the ret_stack is determined by curr_ret_stack index.
The issue is that there's a race between setting of the curr_ret_stack and
calling of the callback attached to the return of the function.

Commit 03274a3ffb44 ("tracing/fgraph: Adjust fgraph depth before calling
trace return callback") moved the calling of the callback to after the
setting of the curr_ret_stack, even stating that it was safe to do so, when
in fact, it was the reason there was a barrier() there (yes, I should have
commented that barrier()).

Not only does the curr_ret_stack keep track of the current call graph depth,
it also keeps the ret_stack content from being overwritten by new data.

The function profiler, uses the "subtime" variable of ret_stack structure
and by moving the curr_ret_stack, it allows for interrupts to use the same
structure it was using, corrupting the data, and breaking the profiler.

To fix this, there needs to be two variables to handle the call stack depth
and the pointer to where the ret_stack is being used, as they need to change
at two different locations.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/sched.h                |    1 +
 kernel/trace/ftrace.c                |    3 +++
 kernel/trace/trace_functions_graph.c |   21 +++++++++++++--------
 3 files changed, 17 insertions(+), 8 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1108,6 +1108,7 @@ struct task_struct {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
+	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
 	struct ftrace_ret_stack		*ret_stack;
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6814,6 +6814,7 @@ static int alloc_retstack_tasklist(struc
 			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
 			t->curr_ret_stack = -1;
+			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the -1 first: */
 			smp_wmb();
 			t->ret_stack = ret_stack_list[start++];
@@ -7038,6 +7039,7 @@ graph_init_task(struct task_struct *t, s
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
 	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
 	 * stack or no stack at all.
@@ -7068,6 +7070,7 @@ void ftrace_graph_init_task(struct task_
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
 	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
 		struct ftrace_ret_stack *ret_stack;
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -119,7 +119,7 @@ print_graph_duration(struct trace_array
 
 /* Add a function return address to the trace stack on thread info.*/
 static int
-ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
+ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	unsigned long long calltime;
@@ -177,8 +177,6 @@ ftrace_push_return_trace(unsigned long r
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	current->ret_stack[index].retp = retp;
 #endif
-	*depth = current->curr_ret_stack;
-
 	return 0;
 }
 
@@ -188,14 +186,20 @@ int function_graph_enter(unsigned long r
 	struct ftrace_graph_ent trace;
 
 	trace.func = func;
-	trace.depth = current->curr_ret_stack + 1;
+	trace.depth = ++current->curr_ret_depth;
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace))
-		return -EBUSY;
+		goto out;
 
-	return ftrace_push_return_trace(ret, func, &trace.depth,
-					frame_pointer, retp);
+	if (ftrace_push_return_trace(ret, func,
+				     frame_pointer, retp))
+		goto out;
+
+	return 0;
+ out:
+	current->curr_ret_depth--;
+	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
@@ -257,7 +261,7 @@ ftrace_pop_return_trace(struct ftrace_gr
 	trace->func = current->ret_stack[index].func;
 	trace->calltime = current->ret_stack[index].calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = index;
+	trace->depth = current->curr_ret_depth;
 }
 
 /*
@@ -273,6 +277,7 @@ unsigned long ftrace_return_to_handler(u
 	trace.rettime = trace_clock_local();
 	barrier();
 	current->curr_ret_stack--;
+	current->curr_ret_depth--;
 	/*
 	 * The curr_ret_stack can be less than -1 only if it was
 	 * filtered out and it's about to return from the function.


