Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A9BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C0D2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C0D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbeKVMFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391367AbeKVMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950E720851;
        Thu, 22 Nov 2018 01:28:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmm-0005Ov-MF; Wed, 21 Nov 2018 20:28:04 -0500
Message-Id: <20181122012804.585039733@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:22 -0500
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
Subject: [RFC][PATCH 14/14] function_graph: Allow for more than one callback to be registered
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 50 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6e5efe1663b9..8a99eaa46b43 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -753,24 +753,27 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	register_pm_notifier(&ftrace_suspend_notifier);
 
 	ftrace_graph_active++;
-	ret = start_graph_tracing();
-	if (ret) {
-		ftrace_graph_active--;
-		goto out;
-	}
+	if (ftrace_graph_active == 1) {
+		ret = start_graph_tracing();
+		if (ret) {
+			ftrace_graph_active--;
+			goto out;
+		}
 
-	ftrace_graph_return = gops->retfunc;
-	/*
-	 * Update the indirect function to the entryfunc, and the
-	 * function that gets called to the entry_test first. Then
-	 * call the update fgraph entry function to determine if
-	 * the entryfunc should be called directly or not.
-	 */
-	__ftrace_graph_entry = gops->entryfunc;
-	ftrace_graph_entry = ftrace_graph_entry_test;
-	update_function_graph_func();
+		ftrace_graph_return = gops->retfunc;
 
-	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		/*
+		 * Update the indirect function to the entryfunc, and the
+		 * function that gets called to the entry_test first. Then
+		 * call the update fgraph entry function to determine if
+		 * the entryfunc should be called directly or not.
+		 */
+		__ftrace_graph_entry = gops->entryfunc;
+		ftrace_graph_entry = ftrace_graph_entry_test;
+		update_function_graph_func();
+
+		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	}
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -800,13 +803,14 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	}
 
 	ftrace_graph_active--;
-	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
-	ftrace_graph_entry = ftrace_graph_entry_stub;
-	__ftrace_graph_entry = ftrace_graph_entry_stub;
-	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-	unregister_pm_notifier(&ftrace_suspend_notifier);
-	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
-
+	if (ftrace_graph_active == 0) {
+		ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
+		ftrace_graph_entry = ftrace_graph_entry_stub;
+		__ftrace_graph_entry = ftrace_graph_entry_stub;
+		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
+		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	}
  out:
 	mutex_unlock(&ftrace_lock);
 }
-- 
2.19.1


