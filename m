Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81413C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE8206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867977;
	bh=rrcpYg/T65LaTQ1muj1zktdfO/LkzJyePhGsS3iiJI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eosuap2U1PSDTRjXZd4nOyQ3FSee1K+uulEl6RsUOGky0Od7chPmfZRDAhn2/XYjI
	 DzswtJeNqzXfFUL6WvWWIZ4FxxyYgdjoi6wkV7R1rTlv6kpCjeHFL/ZudnIvr+1300
	 14N+ZRufbQT6EkHcDaA7HrizpI/Fbw/QrJsFbGgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfAGNc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAGNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:32:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19686206B6;
        Mon,  7 Jan 2019 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546867975;
        bh=rrcpYg/T65LaTQ1muj1zktdfO/LkzJyePhGsS3iiJI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HE3ENubCiPlXNJhUlhH29+0DIzy7vWBnKTkJ/BPFGpdxd7sX9+ExWpC9RAuD3aPMm
         3xJCf5woRU3pDXeOT1zYnnsIaSO4OdquCJfzeWjLrwQRqZwUUXxjqxPrlfT085AFZK
         b7uyxkxhkDdskH7wMdmWsrLUjJW+Y7sBpKl5iY9M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Mon,  7 Jan 2019 22:32:32 +0900
Message-Id: <154686795211.15479.15577152313750689302.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154686789378.15479.2886543882215785247.stgit@devbox>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark ftrace mcount handler functions nokprobe since
probing on these functions with kretprobe pushes
return address incorrectly on kretprobe shadow stack.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
 kernel/trace/ftrace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f0ff24173a0b..ad4babad4a03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6250,7 +6250,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6310,11 +6310,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
 }
+NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
 }
+NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 #endif
 
 /*
@@ -6341,6 +6343,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call

