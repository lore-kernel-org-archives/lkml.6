Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089CB21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867949;
	bh=upSAVVBINLDaCCAR42l1E3Ud7pOlMm7G7Jd4VEqYi7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlexDPEvEthVlVgRxKNLlADiwM+HS1ZAyY4CnS2GEw6e+0CS14OCs3HWmiYewBpqa
	 vhkB11KzKiweYdNAyL98KQyhgXLoqzln/d3YCN2+651spJXEdeNbVbPpgl/vt/R0Eh
	 A5BPdI6RIEWTon5RBQKxyKl4k1g19EdIG7Pxy8X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfAGNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAGNc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:32:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF3F206B6;
        Mon,  7 Jan 2019 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546867946;
        bh=upSAVVBINLDaCCAR42l1E3Ud7pOlMm7G7Jd4VEqYi7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtTj9SSb82T0Hsn+bVOcCCSSVxL0f46t2KgUYtULgzGp5SlaCYUTQhst6c3eO1kLP
         Jf4jztelKbxXTt35ykaLUKtEoXFcMQ9qGHXumiKU9WGTV5erMS5hOE1ILHfZwhOFTt
         qs7JOb6+L3enYZYMw7L1w7XH2tzEMwffdNZzZ+qw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] x86/kprobes: Verify stack frame on kretprobe
Date:   Mon,  7 Jan 2019 22:32:03 +0900
Message-Id: <154686792365.15479.4125763601617196113.stgit@devbox>
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

Verify the stack frame pointer on kretprobe trampoline handler,
If the stack frame pointer does not match, it skips the wrong
entry and tries to find correct one.

This can happen if user puts the kretprobe on the function
which can be used in the path of ftrace user-function call.
Such functions should not be probed, so this adds a warning
message that reports which function should be blacklisted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
 

