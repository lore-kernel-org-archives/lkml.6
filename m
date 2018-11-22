Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92801C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581FF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581FF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbeKVLME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:10:18 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA4B206BA;
        Thu, 22 Nov 2018 00:33:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPcvz-0004PO-Ix; Wed, 21 Nov 2018 19:33:31 -0500
Message-Id: <20181122003331.479176746@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 19:28:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
Subject: [for-next][PATCH 01/18] function_graph: Create function_graph_enter() to consolidate
 architecture code
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently all the architectures do basically the same thing in preparing the
function graph tracer on entry to a function. This code can be pulled into a
generic location and then this will allow the function graph tracer to be
fixed, as well as extended.

Create a new function graph helper function_graph_enter() that will call the
hook function (ftrace_graph_entry) and the shadow stack operation
(ftrace_push_return_trace), and remove the need of the architecture code to
manage the shadow stack.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  3 +++
 kernel/trace/trace_functions_graph.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a397907e8d72..5717e8f81c59 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -779,6 +779,9 @@ extern void return_to_handler(void);
 extern int
 ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 			 unsigned long frame_pointer, unsigned long *retp);
+extern int
+function_graph_enter(unsigned long ret, unsigned long func,
+		     unsigned long frame_pointer, unsigned long *retp);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 169b3c44ee97..28f2602435d0 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -182,6 +182,22 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 	return 0;
 }
 
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp)
+{
+	struct ftrace_graph_ent trace;
+
+	trace.func = func;
+	trace.depth = current->curr_ret_stack + 1;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		return -EBUSY;
+
+	return ftrace_push_return_trace(ret, func, &trace.depth,
+					frame_pointer, retp);
+}
+
 /* Retrieve a function return address to the trace stack on thread info.*/
 static void
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-- 
2.19.1


