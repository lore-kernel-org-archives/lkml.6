Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBDAC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B062084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B062084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeLLQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:48:11 -0500
Received: from foss.arm.com ([217.140.101.70]:44540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeLLQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:48:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A473F15AD;
        Wed, 12 Dec 2018 08:48:06 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FDD73F575;
        Wed, 12 Dec 2018 08:48:04 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v7 08/25] arm64: Make PMR part of task context
Date:   Wed, 12 Dec 2018 16:47:08 +0000
Message-Id: <1544633245-6036-9-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace PSR.I interrupt disabling/enabling with ICC_PMR_EL1
interrupt masking, ICC_PMR_EL1 needs to be saved/restored when
taking/returning from an exception. This mimics the way hardware saves
and restores PSR.I bit in spsr_el1 for exceptions and ERET.

Add PMR to the registers to save in the pt_regs struct upon kernel entry,
and restore it before ERET. Also, initialize it to a sane value when
creating new tasks.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  3 +++
 arch/arm64/include/asm/ptrace.h    | 14 +++++++++++---
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kernel/entry.S          | 14 ++++++++++++++
 arch/arm64/kernel/process.c        |  6 ++++++
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6b0d4df..27c5618 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -168,6 +168,9 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 	memset(regs, 0, sizeof(*regs));
 	forget_syscall(regs);
 	regs->pc = pc;
+
+	if (system_uses_irq_prio_masking())
+		regs->pmr_save = GIC_PRIO_IRQON;
 }
 
 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 05cf913..43e5df5 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PTRACE_H
 #define __ASM_PTRACE_H
 
+#include <asm/cpufeature.h>
+
 #include <uapi/asm/ptrace.h>
 
 /* Current Exception Level values, as contained in CurrentEL */
@@ -179,7 +181,8 @@ struct pt_regs {
 #endif
 
 	u64 orig_addr_limit;
-	u64 unused;	// maintain 16 byte alignment
+	/* Only valid when ARM64_HAS_IRQ_PRIO_MASKING is enabled. */
+	u64 pmr_save;
 	u64 stackframe[2];
 };
 
@@ -214,8 +217,13 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)
 
-#define interrupts_enabled(regs) \
-	(!((regs)->pstate & PSR_I_BIT))
+#define irqs_priority_unmasked(regs)					\
+	(system_uses_irq_prio_masking() ?				\
+		(regs)->pmr_save == GIC_PRIO_IRQON :			\
+		true)
+
+#define interrupts_enabled(regs)			\
+	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
 
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5..bab4122 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -78,6 +78,7 @@ int main(void)
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
+  DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 039144e..2804c81 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -249,6 +249,12 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif
 
+	/* Save pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	mrs_s	x20, SYS_ICC_PMR_EL1
+	str	x20, [sp, #S_PMR_SAVE]
+alternative_else_nop_endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -269,6 +275,14 @@ alternative_else_nop_endif
 	/* No need to restore UAO, it will be restored from SPSR_EL1 */
 	.endif
 
+	/* Restore pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+	msr_s	SYS_ICC_PMR_EL1, x20
+	/* Ensure priority change is seen by redistributor */
+	dsb	sy
+alternative_else_nop_endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d..34f495b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -231,6 +231,9 @@ void __show_regs(struct pt_regs *regs)
 
 	printk("sp : %016llx\n", sp);
 
+	if (system_uses_irq_prio_masking())
+		printk("pmr_save: %08llx\n", regs->pmr_save);
+
 	i = top_reg;
 
 	while (i >= 0) {
@@ -362,6 +365,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
 			childregs->pstate |= PSR_SSBS_BIT;
 
+		if (system_uses_irq_prio_masking())
+			childregs->pmr_save = GIC_PRIO_IRQON;
+
 		p->thread.cpu_context.x19 = stack_start;
 		p->thread.cpu_context.x20 = stk_sz;
 	}
-- 
1.9.1

