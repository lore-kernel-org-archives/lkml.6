Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C49C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7C62146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZWwq4b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7C62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeLDLYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeLDLBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420F32146D;
        Tue,  4 Dec 2018 11:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921272;
        bh=Dy4N09hWZG7HzmvzGgZrNQWuErPrcVRJJxwHLyM5hk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZWwq4b23EXmRmfmMK/7229ZI1KGs7Yz0804M0OIFkm82KI0ceYBtNA3VteRpNg0Q
         //tataX4BEDK223gJqfY368tnkkg2j+hjn5hGazPfrd4Z43ILGeXyCVRLgqT/oFLz+
         jW2ftpNAAwEKvXjZwRyWSDU4IbfpU58RRfiXrpBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 111/139] function_graph: Make ftrace_push_return_trace() static
Date:   Tue,  4 Dec 2018 11:49:52 +0100
Message-Id: <20181204103655.169239887@linuxfoundation.org>
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

commit d125f3f866df88da5a85df00291f88f0baa89f7c upstream.

As all architectures now call function_graph_enter() to do the entry work,
no architecture should ever call ftrace_push_return_trace(). Make it static.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ftrace.h               |    3 ---
 kernel/trace/trace_functions_graph.c |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -777,9 +777,6 @@ struct ftrace_ret_stack {
 extern void return_to_handler(void);
 
 extern int
-ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
-			 unsigned long frame_pointer, unsigned long *retp);
-extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -118,7 +118,7 @@ print_graph_duration(struct trace_array
 		     struct trace_seq *s, u32 flags);
 
 /* Add a function return address to the trace stack on thread info.*/
-int
+static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 			 unsigned long frame_pointer, unsigned long *retp)
 {


