Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0AFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA542084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA542084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeLJTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbeLJTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B1720989;
        Mon, 10 Dec 2018 19:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWRJ9-0002sO-CL; Mon, 10 Dec 2018 14:33:35 -0500
Message-Id: <20181210193335.284057850@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 14:30:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH 5/6] sh: ftrace: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
References: <20181210193007.655970639@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[
  Folks, I'm working on rewriting the function graph tracer. In order to
  do so, some changes need to be done that affect architecture specific
  code. I'm only able to compile test these changes. I would like to
  have folks check out my repo and give them a test.

    git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  ftrace/core

  Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4
]

The structure of the ret_stack array on the task struct is going to
change, and accessing it directly via the curr_ret_stack index will no
longer give the ret_stack entry that holds the return address. To access
that, architectures must now use ftrace_graph_get_ret_stack() to get the
associated ret_stack that matches the saved return address.

Cc: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sh/kernel/dumpstack.c | 11 +++++++----
 arch/sh/kernel/dwarf.c     |  9 +++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index b564b1eae4ae..2c2e151bf39e 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -59,17 +59,20 @@ print_ftrace_graph_addr(unsigned long addr, void *data,
 			struct thread_info *tinfo, int *graph)
 {
 	struct task_struct *task = tinfo->task;
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long ret_addr;
-	int index = task->curr_ret_stack;
 
 	if (addr != (unsigned long)return_to_handler)
 		return;
 
-	if (!task->ret_stack || index < *graph)
+	if (!task->ret_stack)
 		return;
 
-	index -= *graph;
-	ret_addr = task->ret_stack[index].ret;
+	ret_stack = ftrace_graph_get_ret_stack(task, *graph);
+	if (!ret_stack)
+		return;
+
+	ret_addr = ret_stack->ret;
 
 	ops->address(data, ret_addr, 1);
 
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bb511e2d9d68..df0fd6efe758 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -608,17 +608,18 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * expected to find the real return address.
 	 */
 	if (pc == (unsigned long)&return_to_handler) {
-		int index = current->curr_ret_stack;
+		struct ftrace_ret_stack *ret_stack;
 
+		ret_stack = ftrace_graph_get_ret_stack(current, 0);
+		if (ret_stack)
+			pc = ret_stack->ret;
 		/*
 		 * We currently have no way of tracking how many
 		 * return_to_handler()'s we've seen. If there is more
 		 * than one patched return address on our stack,
 		 * complain loudly.
 		 */
-		WARN_ON(index > 0);
-
-		pc = current->ret_stack[index].ret;
+		WARN_ON(ftrace_graph_get_ret_stack(current, 1);
 	}
 #endif
 
-- 
2.19.1


