Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B366C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68F2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE68F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeH1TpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1TpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893731993;
        Tue, 28 Aug 2018 08:52:47 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53CDF3F557;
        Tue, 28 Aug 2018 08:52:45 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 25/27] irqchip/gic-v3: Add base support for pseudo-NMI
Date:   Tue, 28 Aug 2018 16:51:35 +0100
Message-Id: <1535471497-38854-26-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a higher priority to be used for pseudo-NMIs. When such an
interrupt is received, enter the NMI state and prevent other NMIs to
be raised.

When returning from a pseudo-NMI, skip preemption and tracing if the
interrupted context has interrupts disabled.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   |  6 ++++++
 arch/arm64/include/asm/arch_gicv3.h |  6 ++++++
 arch/arm64/kernel/entry.S           | 43 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c        | 34 ++++++++++++++++++++++++++++-
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index b39d620..1ed0476 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -374,5 +374,11 @@ static inline void gic_start_pmr_masking(void)
 	WARN_ON(true);
 }
 
+static inline void gic_set_nmi_active(void)
+{
+	/* Should not get called */
+	WARN_ON(true);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index eb55da8..6213d6f 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -167,5 +167,11 @@ static inline void gic_start_pmr_masking(void)
 	asm volatile ("msr daifclr, #2" : : : "memory");
 }
 
+/* Notify an NMI is active, blocking other NMIs */
+static inline void gic_set_nmi_active(void)
+{
+	asm volatile ("msr daifset, #2" : : : "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 91e1e3d..39d6ef0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -411,6 +411,16 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	mov	sp, x19
 	.endm
 
+	/* Should be checked on return from irq handlers */
+	.macro	branch_if_was_nmi, tmp, target
+	alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	mrs	\tmp, daif
+	alternative_else
+	mov	\tmp, #0
+	alternative_endif
+	tbnz	\tmp, #7, \target // Exiting an NMI
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -631,12 +641,30 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_da_f
+
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	ldr	x20, [sp, #S_PMR_SAVE]
+	/* Irqs were disabled, don't trace */
+	tbz	x20, ICC_PMR_EL1_EN_SHIFT, 1f
+#endif
 	bl	trace_hardirqs_off
+1:
 #endif
 
 	irq_handler
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Irqs were disabled, we have an nmi.
+	 * We might have interrupted a context with interrupt disabled that set
+	 * NEED_RESCHED flag.
+	 * Skip preemption and irq tracing if needed.
+	 */
+	tbz	x20, ICC_PMR_EL1_EN_SHIFT, untraced_irq_exit
+	branch_if_was_nmi x0, skip_preempt
+#endif
+
 #ifdef CONFIG_PREEMPT
 	ldr	w24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
@@ -645,9 +673,13 @@ el1_irq:
 	bl	el1_preempt
 1:
 #endif
+
+skip_preempt:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
+
+untraced_irq_exit:
 	kernel_exit 1
 ENDPROC(el1_irq)
 
@@ -873,6 +905,9 @@ el0_irq_naked:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
+
+	branch_if_was_nmi x2, nmi_ret_to_user
+
 	b	ret_to_user
 ENDPROC(el0_irq)
 
@@ -1269,3 +1304,11 @@ alternative_else_nop_endif
 ENDPROC(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
 #endif /* CONFIG_ARM_SDE_INTERFACE */
+
+/*
+ * NMI return path to EL0
+ */
+nmi_ret_to_user:
+	ldr	x1, [tsk, #TSK_TI_FLAGS]
+	b	finish_ret_to_user
+ENDPROC(nmi_ret_to_user)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ffe98e8..1af2fcc 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI		0xa0
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -248,6 +250,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static inline bool gic_supports_nmi(void)
+{
+	return gic_prio_masking_enabled()
+	       && static_branch_likely(&have_non_secure_prio_view);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -381,6 +389,23 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
+		if (gic_supports_nmi()
+		    && unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+			/*
+			 * We need to prevent other NMIs to occur even after a
+			 * priority drop.
+			 * We keep I flag set until cpsr is restored from
+			 * kernel_exit.
+			 */
+			gic_set_nmi_active();
+
+			if (static_branch_likely(&supports_deactivate_key))
+				gic_write_eoir(irqnr);
+
+			err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+			return;
+		}
+
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
 		else if (!gic_prio_masking_enabled())
@@ -1119,6 +1144,11 @@ static int partition_domain_translate(struct irq_domain *d,
 	.select = gic_irq_domain_select,
 };
 
+static void gic_enable_nmi_support(void)
+{
+	static_branch_enable(&have_non_secure_prio_view);
+}
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1188,7 +1218,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	if (gic_prio_masking_enabled()) {
 		if (!gic_has_group0() || gic_dist_security_disabled())
-			static_branch_enable(&have_non_secure_prio_view);
+			gic_enable_nmi_support();
+		else
+			pr_warn("SCR_EL3.FIQ set, cannot enable use of pseudo-NMIs\n");
 	}
 
 	return 0;
-- 
1.9.1

