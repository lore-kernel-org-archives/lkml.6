Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB674206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550940618;
	bh=luoJzQx1Rr+Zzz6+8I4d7Yg0BT4wLw+nYvSqY57lQJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ijo8NcYunfGCO9ULBTRoOPoRNTsO5qkAQiQAnbk6OIV82/BZO5d/GqaIQYqsYyLEW
	 /5WS2Zj9utkEflZgsP/FDp9q36JBxAa9OkiCr+POMF4mt0TzqFFM9OQ2+lyG2f1NV9
	 g85ysI5N6s5pMcf1j2nbtenXOG61UP0cIxXsTZI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBWQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBWQuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:50:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6D4206A3;
        Sat, 23 Feb 2019 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550940615;
        bh=luoJzQx1Rr+Zzz6+8I4d7Yg0BT4wLw+nYvSqY57lQJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/9H1k06mdQfhP08isEE9ReDWXeECBVJAkykYXR+veaKAJKHhb9JK4HGyTcEDcVe0
         d6Zw7PYqxNOqMQ+YVMDPTbBgy5NcGgIC+52azkk/7R0ekeRaOysDUNW4gEJtVFjjQu
         8MjGm9HxX3oD6J9mALGSsFYTjQniahyYjvKmj62U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH -tip v3 1/3] x86/kprobes: Verify stack frame on kretprobe
Date:   Sun, 24 Feb 2019 01:49:52 +0900
Message-Id: <155094059185.6137.15527904013362842072.stgit@devbox>
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
index a034cb808e7e..18fbe9be2d68 100644
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
index 201f0f2683f2..9a897256e481 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -173,6 +173,7 @@ struct kretprobe_instance {
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
+	void *fp;
 	char data[0];
 };
 

