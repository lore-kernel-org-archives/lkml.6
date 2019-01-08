Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9150C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776522089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546922690;
	bh=6ob0MKQGzxk8mYibWwfjZnQphFowS7y3JsRIT+9BqXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vp8vD4tey3RuKk1CjBAdafw0Z6lZp8HfBga9s0eClb6SLX3BAX4FP8f9t3x1+a+Xs
	 9wcyA5Yf2Ke++RP4fazY+4fUBbRthwnQl5EAxO0GjIBwjxyM1d70bHymVhjKDY9Mfs
	 QdtSAx63DoXcF19Lc8kgzAWBavEbfhQyPIp+5iZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfAHEot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfAHEot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:44:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD462087F;
        Tue,  8 Jan 2019 04:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546922688;
        bh=6ob0MKQGzxk8mYibWwfjZnQphFowS7y3JsRIT+9BqXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mf1khbeaHoRq40mNnjpy6rPeI5E52e/Fq3D3gEmE3gJTmI3b4ICzWTnSOu6LiKvL6
         XtSlBZp+cRgB8KLrk/Gfp+T9VLm58BZVWwtAzJSuRklSFaOvZSjS+VYZNaGMlewLgZ
         8RHzsAaVfBLs+bc13ova7g48HULeE9xAm8dHA3Ps=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] x86/kprobes: Verify stack frame on kretprobe
Date:   Tue,  8 Jan 2019 13:44:25 +0900
Message-Id: <154692266533.1133.6910955750800302479.stgit@devbox>
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

Verify the stack frame pointer on kretprobe trampoline handler,
If the stack frame pointer does not match, it skips the wrong
entry and tries to find correct one.

This can happen if user puts the kretprobe on the function
which can be used in the path of ftrace user-function call.
Such functions should not be probed, so this adds a warning
message that reports which function should be blacklisted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/core.c |   26 ++++++++++++++++++++++++++
 include/linux/kprobes.h        |    1 +
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4ba75afba527..69b6400d1ce2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -569,6 +569,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 	unsigned long *sara = stack_addr(regs);
 
 	ri->ret_addr = (kprobe_opcode_t *) *sara;
+	ri->fp = sara;
 
 	/* Replace the return addr with trampoline addr */
 	*sara = (unsigned long) &kretprobe_trampoline;
@@ -759,15 +760,21 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 	unsigned long flags, orig_ret_address = 0;
 	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
 	kprobe_opcode_t *correct_ret_addr = NULL;
+	void *frame_pointer;
+	bool skipped = false;
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
 #ifdef CONFIG_X86_64
 	regs->cs = __KERNEL_CS;
+	/* On x86-64, we use pt_regs->sp for return address holder. */
+	frame_pointer = &regs->sp;
 #else
 	regs->cs = __KERNEL_CS | get_kernel_rpl();
 	regs->gs = 0;
+	/* On x86-32, we use pt_regs->flags for return address holder. */
+	frame_pointer = &regs->flags;
 #endif
 	regs->ip = trampoline_address;
 	regs->orig_ax = ~0UL;
@@ -789,8 +796,25 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		/*
+		 * Return probes must be pushed on this hash list correct
+		 * order (same as return order) so that it can be poped
+		 * correctly. However, if we find it is pushed it incorrect
+		 * order, this means we find a function which should not be
+		 * probed, because the wrong order entry is pushed on the
+		 * path of processing other kretprobe itself.
+		 */
+		if (ri->fp != frame_pointer) {
+			if (!skipped)
+				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
+			skipped = true;
+			continue;
+		}
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
 
 		if (orig_ret_address != trampoline_address)
 			/*
@@ -808,6 +832,8 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		if (ri->fp != frame_pointer)
+			continue;
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e07e91daaacc..72ff78c33033 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -173,6 +173,7 @@ struct kretprobe_instance {
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
+	void *fp;
 	char data[0];
 };
 

