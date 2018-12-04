Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F220851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYRX2EjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07F220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeLDLZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeLDLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D49214DA;
        Tue,  4 Dec 2018 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921254;
        bh=CLhMEYKS/c3Vm4RCRhIOOGXfyDFPMmrmnE662oN1uIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYRX2EjToPY5/uZLdmQMLTR4PVmOrnLVg8kNr9xo25HbiACeSz6zAOXFFsghanW50
         mr4SMqs4Kt03CQT34Nhnf4GLf9J6d5yRxjYmAzhey1F9ATq4eV5QbgUstp8EFyvcuw
         Di1PGvzhtz2bfukgDtc+DA1tcFmdUMI+FjBhMCuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 114/139] function_graph: Move return callback before update of curr_ret_stack
Date:   Tue,  4 Dec 2018 11:49:55 +0100
Message-Id: <20181204103655.307040607@linuxfoundation.org>
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

commit 552701dd0fa7c3d448142e87210590ba424694a0 upstream.

In the past, curr_ret_stack had two functions. One was to denote the depth
of the call graph, the other is to keep track of where on the ret_stack the
data is used. Although they may be slightly related, there are two cases
where they need to be used differently.

The one case is that it keeps the ret_stack data from being corrupted by an
interrupt coming in and overwriting the data still in use. The other is just
to know where the depth of the stack currently is.

The function profiler uses the ret_stack to save a "subtime" variable that
is part of the data on the ret_stack. If curr_ret_stack is modified too
early, then this variable can be corrupted.

The "max_depth" option, when set to 1, will record the first functions going
into the kernel. To see all top functions (when dealing with timings), the
depth variable needs to be lowered before calling the return hook. But by
lowering the curr_ret_stack, it makes the data on the ret_stack still being
used by the return hook susceptible to being overwritten.

Now that there's two variables to handle both cases (curr_ret_depth), we can
move them to the locations where they can handle both cases.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_functions_graph.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -261,7 +261,13 @@ ftrace_pop_return_trace(struct ftrace_gr
 	trace->func = current->ret_stack[index].func;
 	trace->calltime = current->ret_stack[index].calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth;
+	trace->depth = current->curr_ret_depth--;
+	/*
+	 * We still want to trace interrupts coming in if
+	 * max_depth is set to 1. Make sure the decrement is
+	 * seen before ftrace_graph_return.
+	 */
+	barrier();
 }
 
 /*
@@ -275,9 +281,14 @@ unsigned long ftrace_return_to_handler(u
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
+	ftrace_graph_return(&trace);
+	/*
+	 * The ftrace_graph_return() may still access the current
+	 * ret_stack structure, we need to make sure the update of
+	 * curr_ret_stack is after that.
+	 */
 	barrier();
 	current->curr_ret_stack--;
-	current->curr_ret_depth--;
 	/*
 	 * The curr_ret_stack can be less than -1 only if it was
 	 * filtered out and it's about to return from the function.
@@ -288,13 +299,6 @@ unsigned long ftrace_return_to_handler(u
 		return ret;
 	}
 
-	/*
-	 * The trace should run after decrementing the ret counter
-	 * in case an interrupt were to come in. We don't want to
-	 * lose the interrupt if max_depth is set.
-	 */
-	ftrace_graph_return(&trace);
-
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
 		WARN_ON(1);


