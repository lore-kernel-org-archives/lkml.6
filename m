Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966291AbeEYJvB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:51:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966147AbeEYJuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:55 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 24/26] irqchip/gic-v3: Add base support for pseudo-NMI
Date: Fri, 25 May 2018 10:49:30 +0100
Message-Id: <1527241772-48007-25-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/irqchip/irq-gic-v3.c        | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

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
index 23c88ac0..3196cf1 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -166,5 +166,11 @@ static inline void gic_start_pmr_masking(void)
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
index f56f27e..0d0c829 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -391,6 +391,16 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
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
@@ -611,12 +621,30 @@ ENDPROC(el1_sync)
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
@@ -625,9 +653,13 @@ el1_irq:
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
 
@@ -858,6 +890,9 @@ el0_irq_naked:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
+
+	branch_if_was_nmi x2, nmi_ret_to_user
+
 	b	ret_to_user
 ENDPROC(el0_irq)
 
@@ -1353,3 +1388,11 @@ alternative_else_nop_endif
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
index b144f73..4be5996 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI		0xa0
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -253,6 +255,12 @@ static inline bool arch_uses_gic_prios(void)
 	return IS_ENABLED(CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS);
 }
 
+static inline bool gic_supports_nmi(void)
+{
+	return arch_uses_gic_prios()
+	       && static_branch_likely(&have_non_secure_prio_view);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -371,6 +379,20 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 	return aff;
 }
 
+static void do_handle_nmi(unsigned int hwirq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned int irq;
+
+	nmi_enter();
+
+	irq = irq_find_mapping(gic_data.domain, hwirq);
+	generic_handle_irq(irq);
+
+	nmi_exit();
+	set_irq_regs(old_regs);
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -386,6 +408,23 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
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
+			do_handle_nmi(irqnr, regs);
+			return;
+		}
+
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
 		else if (!arch_uses_gic_prios())
@@ -1183,6 +1222,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (arch_uses_gic_prios()) {
 		if (!gic_has_group0() || gic_dist_security_disabled())
 			static_branch_enable(&have_non_secure_prio_view);
+		else
+			pr_warn("SCR_EL3.FIQ set, cannot enable use of pseudo-NMIs\n");
 	}
 
 	return 0;
-- 
1.9.1
