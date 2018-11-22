Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B372080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B372080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbeKVLLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390895AbeKVLKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:10:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0FAA2087E;
        Thu, 22 Nov 2018 00:33:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPcw1-0004Y6-Vp; Wed, 21 Nov 2018 19:33:33 -0500
Message-Id: <20181122003333.880108256@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 19:28:18 -0500
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
Subject: [for-next][PATCH 17/18] function_graph: Reverse the order of pushing the ret_stack and the
 callback
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function graph profiler uses the ret_stack to store the "subtime" and
reuse it by nested functions and also on the return. But the current logic
has the profiler callback called before the ret_stack is updated, and it is
just modifying the ret_stack that will later be allocated (it's just lucky
that the "subtime" is not touched when it is allocated).

This could also cause a crash if we are at the end of the ret_stack when
this happens.

By reversing the order of the allocating the ret_stack and then calling the
callbacks attached to a function being traced, the ret_stack entry is no
longer used before it is allocated.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4f0d72ae6362..2561460d7baf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -188,15 +188,17 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-
 	if (ftrace_push_return_trace(ret, func,
 				     frame_pointer, retp))
 		goto out;
 
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		goto out_ret;
+
 	return 0;
+ out_ret:
+	current->curr_ret_stack--;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
-- 
2.19.1


