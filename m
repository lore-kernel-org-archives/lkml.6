Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8334C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F5120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic3PIoCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F5120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966954AbeFSQGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:05:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9FD20652;
        Tue, 19 Jun 2018 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424359;
        bh=lu9iYXuGcefb1xnz0gwfrqXvnr6/KuvjRt7kCevFdRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ic3PIoCEJU+6M1TCdb4BVFotvB2PZp/ryX++DXcjtgV4l3SPbiFTvJiwnfz7rlzlZ
         WJaAnucnXqAqwH7quZS9qIIFj8VY5e/sBUk3LkCEaDBlNpE0Jah2HiTEp5T00rZAy/
         vpoDPtdaqbQU4buRQrPZ5XRLIcD8HQqriTBVZVGI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH -tip v6 03/27] kprobes/x86: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:05:35 +0900
Message-Id: <152942433578.15209.14034551799624757792.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/kprobes.h |    3 -
 arch/x86/kernel/kprobes/core.c |   96 +---------------------------------------
 2 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 367d99cff426..06782c2efa04 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -111,9 +111,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_old_flags;
 	unsigned long kprobe_saved_flags;
-	unsigned long *jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6f4d42377fe5..1b2d1acba810 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -66,8 +66,6 @@
 
 #include "common.h"
 
-void jprobe_return_end(void);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -690,10 +688,9 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			/*
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry
-			 * for jprobe processing, so get out doing nothing
-			 * more here.
+			 * pre-handler and it returned non-zero, that means
+			 * user handler setup registers to exit to another
+			 * instruction, we must skip the single stepping.
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
@@ -1083,93 +1080,6 @@ int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = stack_addr(regs);
-	addr = (unsigned long)(kcb->jprobe_saved_sp);
-
-	/*
-	 * As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 * Use __memcpy() to avoid KASAN stack out-of-bounds reports as we copy
-	 * raw stack chunk with redzones:
-	 */
-	__memcpy(kcb->jprobes_stack, (kprobe_opcode_t *)addr, MIN_STACK_SIZE(addr));
-	regs->ip = (unsigned long)(jp->entry);
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer to get messed up.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/* Unpoison stack redzones in the frames we are going to jump over. */
-	kasan_unpoison_stack_above_sp_to(kcb->jprobe_saved_sp);
-
-	asm volatile (
-#ifdef CONFIG_X86_64
-			"       xchg   %%rbx,%%rsp	\n"
-#else
-			"       xchgl   %%ebx,%%esp	\n"
-#endif
-			"       int3			\n"
-			"       .globl jprobe_return_end\n"
-			"       jprobe_return_end:	\n"
-			"       nop			\n"::"b"
-			(kcb->jprobe_saved_sp):"memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-NOKPROBE_SYMBOL(jprobe_return_end);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	u8 *addr = (u8 *) (regs->ip - 1);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	void *saved_sp = kcb->jprobe_saved_sp;
-
-	if ((addr > (u8 *) jprobe_return) &&
-	    (addr < (u8 *) jprobe_return_end)) {
-		if (stack_addr(regs) != saved_sp) {
-			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
-			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
-			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
-			show_regs(regs);
-			BUG();
-		}
-		/* It's OK to start function graph tracing again */
-		unpause_graph_tracing();
-		*regs = kcb->jprobe_saved_regs;
-		__memcpy(saved_sp, kcb->jprobes_stack, MIN_STACK_SIZE(saved_sp));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	bool is_in_entry_trampoline_section = false;

