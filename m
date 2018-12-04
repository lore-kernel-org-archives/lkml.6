Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE21B214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SolievR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE21B214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLDLBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbeLDLA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB4C214C1;
        Tue,  4 Dec 2018 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921257;
        bh=kiKN8juHzsOtpLvErzq1OqBEv5xMBxqSuBMzf0v/XLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SolievR+Yb0kpxVZHGkcRUi2enxgIWb2uJi57mv9434KbAAZ181u3Smw8VyHaHjE5
         ik9ECp09bsg3sQMJtgVdpI8XvsZ320YFL2yOHn+6JuTZy7cj6V9BtACTT45KUr6JsY
         prCeRr2QuI/dysikP4GuvWCGJEudJT8XmBURAfGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 115/139] function_graph: Reverse the order of pushing the ret_stack and the callback
Date:   Tue,  4 Dec 2018 11:49:56 +0100
Message-Id: <20181204103655.349825042@linuxfoundation.org>
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

commit 7c6ea35ef50810aa12ab26f21cb858d980881576 upstream.

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
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_functions_graph.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -188,15 +188,17 @@ int function_graph_enter(unsigned long r
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


