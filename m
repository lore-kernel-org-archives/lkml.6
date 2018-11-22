Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AD32075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AD32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391516AbeKVMGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391362AbeKVMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:02 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B96208E3;
        Thu, 22 Nov 2018 01:28:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmm-0005Mn-2T; Wed, 21 Nov 2018 20:28:04 -0500
Message-Id: <20181122012803.976067055@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:18 -0500
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
Subject: [RFC][PATCH 10/14] function_graph: Have profiler use new helper
 ftrace_graph_get_ret_stack()
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ret_stack processing is going to change, and that is going
to break anything that is accessing the ret_stack directly. One user is the
function graph profiler. By using the ftrace_graph_get_ret_stack() helper
function, the profiler can access the ret_stack entry without relying on the
implementation details of the stack itself.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  3 +++
 kernel/trace/fgraph.c  | 11 +++++++++++
 kernel/trace/ftrace.c  | 21 +++++++++++----------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 5544df21a886..36a0fd1316dd 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -792,6 +792,9 @@ extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
+struct ftrace_ret_stack *
+ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
+
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c7d612897e33..9b85638ecded 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -233,6 +233,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+struct ftrace_ret_stack *
+ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
+{
+	idx = current->curr_ret_stack - idx;
+
+	if (idx >= 0 && idx <= task->curr_ret_stack)
+		return &current->ret_stack[idx];
+
+	return NULL;
+}
+
 /**
  * ftrace_graph_ret_addr - convert a potentially modified stack return address
  *			   to its original value
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d057dde081e7..05568ad4e590 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -792,7 +792,7 @@ void ftrace_graph_graph_time_control(bool enable)
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
-	int index = current->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -800,14 +800,16 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace)
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
@@ -825,16 +827,15 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
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
-- 
2.19.1


