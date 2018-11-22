Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64336C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354CA2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354CA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbeKVMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388885AbeKVMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:02 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1D5208A3;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdml-0005Jb-97; Wed, 21 Nov 2018 20:28:03 -0500
Message-Id: <20181122012803.182269143@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:12 -0500
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
Subject: [RFC][PATCH 04/14] function_graph: Remove the use of FTRACE_NOTRACE_DEPTH
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The curr_ret_stack is no longer set to a negative value when a function is
not to be traced by the function graph tracer. Remove the usage of
FTRACE_NOTRACE_DEPTH, as it is no longer needed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 -
 kernel/trace/fgraph.c                | 19 -------------------
 kernel/trace/trace_functions_graph.c | 11 -----------
 3 files changed, 31 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dd16e8218db3..f98063e273e5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -790,7 +790,6 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
  */
 #define __notrace_funcgraph		notrace
 
-#define FTRACE_NOTRACE_DEPTH 65536
 #define FTRACE_RETFUNC_DEPTH 50
 #define FTRACE_RETSTACK_ALLOC_SIZE 32
 extern int register_ftrace_graph(trace_func_graph_ret_t retfunc,
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c684968b87e7..5b0d554dbf65 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -113,16 +113,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 
 	index = current->curr_ret_stack;
 
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
 	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
@@ -191,15 +181,6 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	 */
 	barrier();
 	current->curr_ret_stack--;
-	/*
-	 * The curr_ret_stack can be less than -1 only if it was
-	 * filtered out and it's about to return from the function.
-	 * Recover the index and continue to trace normal functions.
-	 */
-	if (current->curr_ret_stack < -1) {
-		current->curr_ret_stack += FTRACE_NOTRACE_DEPTH;
-		return ret;
-	}
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4748dc1bf5e1..0e0ff08357cf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -115,9 +115,6 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	if (ret != (unsigned long)return_to_handler)
 		return ret;
 
-	if (index < -1)
-		index += FTRACE_NOTRACE_DEPTH;
-
 	if (index < 0)
 		return ret;
 
@@ -670,10 +667,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
-		/* If a graph tracer ignored set_graph_notrace */
-		if (call->depth < -1)
-			call->depth += FTRACE_NOTRACE_DEPTH;
-
 		/*
 		 * Comments display at + 1 to depth. Since
 		 * this is a leaf function, keep the comments
@@ -716,10 +709,6 @@ print_graph_entry_nested(struct trace_iterator *iter,
 		struct fgraph_cpu_data *cpu_data;
 		int cpu = iter->cpu;
 
-		/* If a graph tracer ignored set_graph_notrace */
-		if (call->depth < -1)
-			call->depth += FTRACE_NOTRACE_DEPTH;
-
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 		cpu_data->depth = call->depth;
 
-- 
2.19.1


