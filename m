Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9549C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92B42089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546922718;
	bh=xQc/P7vx7xya8t6opXe7Oq8Ck8XsunNZuzE3auLwQUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1EIHzupkqEmRyu0sMdfbHNWIaSjuDcFuwaZ4Qg5ZFhTvXR09f8xtXVD0LKiYwgqEQ
	 K8al5Ru1ZUB6AgVzyI/qFGmKEmI5oTFm2q+0hHR/7XvWwRG+2I5lGQhdwSGCCa0EDq
	 KQoh0uzB8w8GvNxY+SM0MYhAO+M5hj3wTw7rY1/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfAHEpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHEpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:45:17 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5242087F;
        Tue,  8 Jan 2019 04:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546922716;
        bh=xQc/P7vx7xya8t6opXe7Oq8Ck8XsunNZuzE3auLwQUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqydPi1++5LoKCup+fATgNurvcabf9qr0D//ozxy2aTYMTJSD3a90Qj60AoP5mWu7
         N4yMEv3pcL712utM7pnk+MZyC5CFEcx0IsVWAM9mMyEN8AdmQwOy+2WS04IT5KRCsK
         y7dJFqRtigb5VBngpV0mcJO8G62wUBsJR67d9h10=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Tue,  8 Jan 2019 13:44:54 +0900
Message-Id: <154692269381.1133.17151202401532686704.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154692263564.1133.17363562046971295490.stgit@devbox>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
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
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Cc: stable@vger.kernel.org
---
 - Changes in v2:
   Fix to include kprobes.h (Thanks Andrea!)
---
 kernel/trace/ftrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f0ff24173a0b..b0774388d52b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -6250,7 +6251,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6310,11 +6311,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
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
@@ -6341,6 +6344,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call

