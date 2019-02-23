Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0FC10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B504D206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550940645;
	bh=Gpg17YXb2rq3o6zGYZvcvJp44uyHCY5NKkIAFxkUz3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qs5+HzpUFm9oVJM//IH+BRDMyteVoZAd2bh5XWr4/8zQyK2afWKcJj5Waoe1RMRIC
	 VArbHznSSBYPJja2hXo9MAIyFrj0riJ3aOEnjXkPAlvApHnfq7bz3Y+32xcp8ygb+K
	 0GBnEgt9NmkEFvvP6W2gz2a9oaB/PQZC1gz/iOvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBWQuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBWQuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:50:44 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D3E206A3;
        Sat, 23 Feb 2019 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550940643;
        bh=Gpg17YXb2rq3o6zGYZvcvJp44uyHCY5NKkIAFxkUz3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raXlqdP4gsHaiRTpHBK+trk7Ty3XVLSC9SuRVlXlPq7wRrnfsSc/Go2Q8sPxLDAFc
         9/CsVg3Cs4L4rk8X/uKWBKGNYwBOY6p2Wc1Br7PPu6KnJ0jKxC0JVEcqq9fie0vKeT
         3Jy2YGwPHvvbfZFZ6CB/AlT09QXNq1g3a0GTOcFU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH -tip v3 2/3] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Sun, 24 Feb 2019 01:50:20 +0900
Message-Id: <155094062044.6137.6419622920568680640.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155094056180.6137.4208463927265038015.stgit@devbox>
References: <155094056180.6137.4208463927265038015.stgit@devbox>
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

Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
---
 - Changes in v2:
   Fix to include kprobes.h (Thanks Andrea!)
---
 kernel/trace/ftrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index aac7847c0214..f546ae5102e0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -6216,7 +6217,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6276,11 +6277,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
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
@@ -6307,6 +6310,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call

