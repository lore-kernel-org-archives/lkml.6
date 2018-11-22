Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDB3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98622208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98622208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390991AbeKVLKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390877AbeKVLKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:10:19 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5793214E0;
        Thu, 22 Nov 2018 00:33:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPcw0-0004UM-Sq; Wed, 21 Nov 2018 19:33:32 -0500
Message-Id: <20181122003332.793493004@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 19:28:11 -0500
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
        Frederic Weisbecker <frederic@kernel.org>,
        Greentime Hu <greentime@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>, stable@kernel.org
Subject: [for-next][PATCH 10/18] riscv/function_graph: Simplify with function_graph_entry()
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have riscv use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Greentime Hu <greentime@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/riscv/kernel/ftrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 1157b6b52d25..c433f6d3dd64 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
 	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
@@ -144,17 +143,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, parent);
-	if (err == -EBUSY)
-		return;
-	*parent = return_hooker;
+	if (function_graph_enter(old, self_addr, frame_pointer, parent))
+		*parent = return_hooker;
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.19.1


