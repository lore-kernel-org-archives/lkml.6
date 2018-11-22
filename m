Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DB02075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DB02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391529AbeKVMGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391361AbeKVMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:02 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E491B20892;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdml-0005MG-UN; Wed, 21 Nov 2018 20:28:03 -0500
Message-Id: <20181122012803.843285508@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:17 -0500
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
Subject: [RFC][PATCH 09/14] function_graph: Move ftrace_graph_get_addr() to fgraph.c
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Move the function function_graph_get_addr() to fgraph.c, as the management
of the curr_ret_stack is going to change, and all the accesses to ret_stack
needs to be done in fgraph.c.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c                | 55 ++++++++++++++++++++++++++++
 kernel/trace/trace_functions_graph.c | 55 ----------------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index f3a89ecac671..c7d612897e33 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -233,6 +233,61 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
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
 static struct ftrace_ops graph_ops = {
 	.func			= ftrace_stub,
 	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 7c7fd13d2373..0f9cbc30645d 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -90,61 +90,6 @@ static void
 print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
 
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
-- 
2.19.1


