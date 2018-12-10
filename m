Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeLJTdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbeLJTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD8720880;
        Mon, 10 Dec 2018 19:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWRJ9-0002rK-32; Mon, 10 Dec 2018 14:33:35 -0500
Message-Id: <20181210193334.998050515@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 14:30:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/frace: Use ftrace_graph_get_ret_stack() instead of
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/kernel/process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..ce393df243aa 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2061,9 +2061,10 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int count = 0;
 	int firstframe = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	int curr_frame = current->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack;
 	extern void return_to_handler(void);
 	unsigned long rth = (unsigned long)return_to_handler;
+	int curr_frame = 0;
 #endif
 
 	sp = (unsigned long) stack;
@@ -2089,9 +2090,13 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
-				pr_cont(" (%pS)",
-				       (void *)current->ret_stack[curr_frame].ret);
-				curr_frame--;
+				ret_stack = ftrace_graph_get_ret_stack(current,
+								  curr_frame++);
+				if (ret_stack)
+					pr_cont(" (%pS)",
+						(void *)ret_stack->ret);
+				else
+					curr_frame = -1;
 			}
 #endif
 			if (firstframe)
-- 
2.19.1


