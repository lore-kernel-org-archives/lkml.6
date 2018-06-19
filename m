Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270DC20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aupA+3vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270DC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966967AbeFSQHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:06:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24AF620652;
        Tue, 19 Jun 2018 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424417;
        bh=tk3jnTWiNULlDIDBoBbsCTQBvchGO6BjUAyC6GOMHv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aupA+3vtkzhKjVxtO8YyVtVuDrotvT3Ierpw9lWBxwDMxph2rNVe1+lJuQyWWGabF
         zsPexqNB60y5/0Y/r1mN4G3LxwkyN9A6OpGSPiUQz87sAROR411uBZgKesat2v27+8
         G0D2iOfyc8BS2yTWpmftxXMYvCOumE1RiKEln19I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -tip v6 05/27] ARM: kprobes: Remove jprobe arm implementation
Date:   Wed, 20 Jun 2018 01:06:34 +0900
Message-Id: <152942439350.15209.11127640848082283736.stgit@devbox>
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
from arch/arm.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/kprobes.h |    2 -
 arch/arm/include/asm/probes.h  |    1 
 arch/arm/probes/kprobes/core.c |  114 ----------------------------------------
 3 files changed, 117 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 59655459da59..82290f212d8e 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -44,8 +44,6 @@ struct prev_kprobe {
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
 	struct prev_kprobe prev_kprobe;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
index 1e5b9bb92270..991c9127c650 100644
--- a/arch/arm/include/asm/probes.h
+++ b/arch/arm/include/asm/probes.h
@@ -51,7 +51,6 @@ struct arch_probes_insn {
  * We assume one instruction can consume at most 64 bytes stack, which is
  * 'push {r0-r15}'. Instructions consume more or unknown stack space like
  * 'str r0, [sp, #-80]' and 'str r0, [sp, r1]' should be prohibit to probe.
- * Both kprobe and jprobe use this macro.
  */
 #define MAX_STACK_SIZE			64
 
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e90cc8a08186..23562111c511 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -47,9 +47,6 @@
 			   (unsigned long)(addr) +	\
 			   (size))
 
-/* Used as a marker in ARM_pc to note when we're in a jprobe. */
-#define JPROBE_MAGIC_ADDR		0xffffffff
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -521,117 +518,6 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long sp_addr = regs->ARM_sp;
-	long cpsr;
-
-	kcb->jprobe_saved_regs = *regs;
-	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
-	regs->ARM_pc = (long)jp->entry;
-
-	cpsr = regs->ARM_cpsr | PSR_I_BIT;
-#ifdef CONFIG_THUMB2_KERNEL
-	/* Set correct Thumb state in cpsr */
-	if (regs->ARM_pc & 1)
-		cpsr |= PSR_T_BIT;
-	else
-		cpsr &= ~PSR_T_BIT;
-#endif
-	regs->ARM_cpsr = cpsr;
-
-	preempt_disable();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	__asm__ __volatile__ (
-		/*
-		 * Setup an empty pt_regs. Fill SP and PC fields as
-		 * they're needed by longjmp_break_handler.
-		 *
-		 * We allocate some slack between the original SP and start of
-		 * our fabricated regs. To be precise we want to have worst case
-		 * covered which is STMFD with all 16 regs so we allocate 2 *
-		 * sizeof(struct_pt_regs)).
-		 *
-		 * This is to prevent any simulated instruction from writing
-		 * over the regs when they are accessing the stack.
-		 */
-#ifdef CONFIG_THUMB2_KERNEL
-		"sub    r0, %0, %1		\n\t"
-		"mov    sp, r0			\n\t"
-#else
-		"sub    sp, %0, %1		\n\t"
-#endif
-		"ldr    r0, ="__stringify(JPROBE_MAGIC_ADDR)"\n\t"
-		"str    %0, [sp, %2]		\n\t"
-		"str    r0, [sp, %3]		\n\t"
-		"mov    r0, sp			\n\t"
-		"bl     kprobe_handler		\n\t"
-
-		/*
-		 * Return to the context saved by setjmp_pre_handler
-		 * and restored by longjmp_break_handler.
-		 */
-#ifdef CONFIG_THUMB2_KERNEL
-		"ldr	lr, [sp, %2]		\n\t" /* lr = saved sp */
-		"ldrd	r0, r1, [sp, %5]	\n\t" /* r0,r1 = saved lr,pc */
-		"ldr	r2, [sp, %4]		\n\t" /* r2 = saved psr */
-		"stmdb	lr!, {r0, r1, r2}	\n\t" /* push saved lr and */
-						      /* rfe context */
-		"ldmia	sp, {r0 - r12}		\n\t"
-		"mov	sp, lr			\n\t"
-		"ldr	lr, [sp], #4		\n\t"
-		"rfeia	sp!			\n\t"
-#else
-		"ldr	r0, [sp, %4]		\n\t"
-		"msr	cpsr_cxsf, r0		\n\t"
-		"ldmia	sp, {r0 - pc}		\n\t"
-#endif
-		:
-		: "r" (kcb->jprobe_saved_regs.ARM_sp),
-		  "I" (sizeof(struct pt_regs) * 2),
-		  "J" (offsetof(struct pt_regs, ARM_sp)),
-		  "J" (offsetof(struct pt_regs, ARM_pc)),
-		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
-		  "J" (offsetof(struct pt_regs, ARM_lr))
-		: "memory", "cc");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.ARM_sp;
-	long orig_sp = regs->ARM_sp;
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-
-	if (regs->ARM_pc == JPROBE_MAGIC_ADDR) {
-		if (orig_sp != stack_addr) {
-			struct pt_regs *saved_regs =
-				(struct pt_regs *)kcb->jprobe_saved_regs.ARM_sp;
-			printk("current sp %lx does not match saved sp %lx\n",
-			       orig_sp, stack_addr);
-			printk("Saved registers for jprobe %p\n", jp);
-			show_regs(saved_regs);
-			printk("Current registers\n");
-			show_regs(regs);
-			BUG();
-		}
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)stack_addr, kcb->jprobes_stack,
-		       MIN_STACK_SIZE(stack_addr));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;

