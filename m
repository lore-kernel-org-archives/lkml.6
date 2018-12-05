Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6486DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D3720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D3720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeLEXu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbeLEXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:31 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D725213A2;
        Wed,  5 Dec 2018 23:48:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu5-00008o-DJ; Wed, 05 Dec 2018 18:48:29 -0500
Message-Id: <20181205234829.305599061@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 06/30] function_graph: Remove the use of FTRACE_NOTRACE_DEPTH
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The curr_ret_stack is no longer set to a negative value when a function is
not to be traced by the function graph tracer. Remove the usage of
FTRACE_NOTRACE_DEPTH, as it is no longer needed.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 -
 kernel/trace/fgraph.c                | 19 -------------------
 kernel/trace/trace_functions_graph.c | 11 -----------
 3 files changed, 31 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 10bd46434908..98625f10d982 100644
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
index e852b69c0e64..de887a983ac7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -112,16 +112,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 
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
@@ -190,15 +180,6 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
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
index ecf543df943b..eaf9b1629956 100644
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
 
@@ -675,10 +672,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 		cpu_data = per_cpu_ptr(data->cpu_data, cpu);
 
-		/* If a graph tracer ignored set_graph_notrace */
-		if (call->depth < -1)
-			call->depth += FTRACE_NOTRACE_DEPTH;
-
 		/*
 		 * Comments display at + 1 to depth. Since
 		 * this is a leaf function, keep the comments
@@ -721,10 +714,6 @@ print_graph_entry_nested(struct trace_iterator *iter,
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


