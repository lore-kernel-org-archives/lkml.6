Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE26C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617CB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHKuavhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617CB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLDK7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeLDK7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA9420878;
        Tue,  4 Dec 2018 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921145;
        bh=Otkclb+QcbCvkVUa9dq/BC19nECr3Efghy3FUhMYg0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHKuavhBhRi04XOVO7waYQZT8k5kUXqC0kTjzgzFrYHcyRAsLPNAGMet8roYSuiPk
         ZooofTVWtWYiDVuO7s1CutNGcRxXiuSJdMZ9IGYUfZSIvqHx1brFdTPTUlPdHpMYUk
         fkACySy/gqfsVBx2Xj3WJNkR0gjHOYzZLxfz0ZWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 098/139] function_graph: Create function_graph_enter() to consolidate architecture code
Date:   Tue,  4 Dec 2018 11:49:39 +0100
Message-Id: <20181204103654.446058411@linuxfoundation.org>
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

commit 8114865ff82e200b383e46821c25cb0625b842b5 upstream.

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
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ftrace.h               |    3 +++
 kernel/trace/trace_functions_graph.c |   16 ++++++++++++++++
 2 files changed, 19 insertions(+)

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
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -182,6 +182,22 @@ ftrace_push_return_trace(unsigned long r
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


