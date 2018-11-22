Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8068C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8F320878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8F320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbeKVMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391364AbeKVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57537214F1;
        Thu, 22 Nov 2018 01:28:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmm-0005Nr-CX; Wed, 21 Nov 2018 20:28:04 -0500
Message-Id: <20181122012804.285675886@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:20 -0500
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
Subject: [RFC][PATCH 12/14] function_graph: Add an array structure that will allow multiple
 callbacks
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add an array structure that will eventually allow the function graph tracer
to have up to 16 simultaneous callbacks attached. It's an array of 16
fgraph_ops pointers, that is assigned when one is registered. On entry of a
function the entry of the first item in the array is called, and if it
returns zero, then the callback returns non zero if it wants the return
callback to be called on exit of the function.

The array will simplify the process of having more than one callback
attached to the same function, as its index into the array can be stored on
the shadow stack. We need to only save the index, because this will allow
the fgraph_ops to be freed before the function returns (which may happen if
the function call schedule for a long time).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1389fe39f64c..826fa158f9b7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -37,6 +37,14 @@
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
+#define FGRAPH_ARRAY_SIZE	16
+
+#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH *			\
+	(sizeof(struct ftrace_ret_stack) +				\
+	FGRAPH_ARRAY_SIZE * sizeof(long)))
+
+static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -123,7 +131,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		goto out;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
+	if (!fgraph_array[0]->entryfunc(&trace))
 		goto out_ret;
 
 	return 0;
@@ -231,7 +239,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
-	ftrace_graph_return(&trace);
+	fgraph_array[0]->retfunc(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
@@ -343,6 +351,11 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
 	return 0;
 }
 
+static struct fgraph_ops fgraph_stub = {
+	.entryfunc = ftrace_graph_entry_stub,
+	.retfunc = (trace_func_graph_ret_t)ftrace_stub,
+};
+
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return =
 			(trace_func_graph_ret_t)ftrace_stub;
@@ -575,15 +588,29 @@ static int start_graph_tracing(void)
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
+	int i;
 
 	mutex_lock(&ftrace_lock);
 
-	/* we currently allow only one tracer registered at a time */
-	if (ftrace_graph_active) {
+	if (!fgraph_array[0]) {
+		/* The array must always have real data on it */
+		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+			fgraph_array[i] = &fgraph_stub;
+		}
+	}
+
+	/* Look for an available spot */
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		if (fgraph_array[i] == &fgraph_stub)
+			break;
+	}
+	if (i >= FGRAPH_ARRAY_SIZE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
+	fgraph_array[i] = gops;
+
 	register_pm_notifier(&ftrace_suspend_notifier);
 
 	ftrace_graph_active++;
@@ -594,7 +621,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	}
 
 	ftrace_graph_return = gops->retfunc;
-
 	/*
 	 * Update the indirect function to the entryfunc, and the
 	 * function that gets called to the entry_test first. Then
@@ -613,11 +639,23 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int i;
+
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
+	/* Look for an available spot */
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		if (fgraph_array[i] == gops)
+			break;
+	}
+	if (i == FGRAPH_ARRAY_SIZE)
+		goto out;
+
+	fgraph_array[i] = &fgraph_stub;
+
 	ftrace_graph_active--;
 	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
 	ftrace_graph_entry = ftrace_graph_entry_stub;
-- 
2.19.1


