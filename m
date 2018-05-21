Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeEULf7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:35:59 -0400
Received: from foss.arm.com ([217.140.101.70]:47632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbeEULfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:52 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 6/6] arm64: Add support for pseudo-NMIs
Date: Mon, 21 May 2018 12:35:15 +0100
Message-Id: <1526902515-13769-7-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 does not provide native NMIs. Emulate the NMI behaviour using GIC
priorities.

Add the possibility to set an IRQ as an NMI and the handling of the NMI.

If the view of GIC priorities is the secure one
(i.e. SCR_EL3.FIQ == 0 && security enabled), do not allow the use of NMIs.
Emit a warning when attempting to set an IRQ as NMI under this scenario.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h |   5 ++
 arch/arm64/include/asm/irqflags.h   |   6 ++
 arch/arm64/kernel/entry.S           |  56 ++++++++++++++
 drivers/irqchip/irq-gic-v3.c        | 141 ++++++++++++++++++++++++++++++++++++
 include/linux/interrupt.h           |   1 +
 5 files changed, 209 insertions(+)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 6ee27ec..935511f 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -124,6 +124,11 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
 }

+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg_s(SYS_ICC_RPR_EL1);
+}
+
 #define gic_read_typer(c)		readq_relaxed(c)
 #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
 #define gic_read_lpir(c)		readq_relaxed(c)
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 3d5d443..d25e7ee 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -217,6 +217,12 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
 }

+/* Mask IRQs at CPU level instead of GIC level */
+static inline void arch_irqs_daif_disable(void)
+{
+	asm volatile ("msr daifset, #2" : : : "memory");
+}
+
 void maybe_switch_to_sysreg_gic_cpuif(void);

 #endif /* CONFIG_IRQFLAGS_GIC_MASKING */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7f753f..a52d5f8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -395,6 +395,18 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	mov	sp, x19
 	.endm

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Should be checked on return from irq handlers */
+	.macro	branch_if_was_nmi, tmp, target
+	alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	mrs	\tmp, daif
+	alternative_else
+	mov	\tmp, #0
+	alternative_endif
+	tbnz	\tmp, #7, \target // Exiting an NMI
+	.endm
+#endif
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -615,12 +627,30 @@ ENDPROC(el1_sync)
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
@@ -629,9 +659,13 @@ el1_irq:
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

@@ -862,6 +896,11 @@ el0_irq_naked:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	branch_if_was_nmi x2, nmi_ret_to_user
+#endif
+
 	b	ret_to_user
 ENDPROC(el0_irq)

@@ -1162,8 +1201,15 @@ ENTRY(cpu_switch_to)
 	ldp	x27, x28, [x8], #16
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mrs	x10, daif
+	msr	daifset, #2
+#endif
 	mov	sp, x9
 	msr	sp_el0, x1
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr	daif, x10
+#endif
 	ret
 ENDPROC(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -1357,3 +1403,13 @@ alternative_else_nop_endif
 ENDPROC(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
 #endif /* CONFIG_ARM_SDE_INTERFACE */
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * NMI return path to EL0
+ */
+nmi_ret_to_user:
+	ldr	x1, [tsk, #TSK_TI_FLAGS]
+	b	finish_ret_to_user
+ENDPROC(nmi_ret_to_user)
+#endif
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3c44918..6d25ead 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -34,6 +34,8 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>

+#include <trace/events/irq.h>
+
 #include <asm/cputype.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -41,6 +43,8 @@

 #include "irq-gic-common.h"

+#define GICD_INT_NMI_PRI		0xa0
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -247,6 +251,87 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * Chip flow handler for SPIs set as NMI
+ */
+static void handle_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, action->dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
+/*
+ * Chip flow handler for PPIs set as NMI
+ */
+static void handle_percpu_devid_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
+static int gic_irq_set_irqchip_prio(struct irq_data *d, bool val)
+{
+	u8 prio;
+	irq_flow_handler_t handler;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return -EPERM;
+	}
+
+	if (val) {
+		prio = GICD_INT_NMI_PRI;
+
+		if (gic_irq(d) < 32)
+			handler = handle_percpu_devid_nmi;
+		else
+			handler = handle_fasteoi_nmi;
+	} else {
+		prio = GICD_INT_DEF_PRI;
+
+		if (gic_irq(d) < 32)
+			handler = handle_percpu_devid_irq;
+		else
+			handler = handle_fasteoi_irq;
+	}
+
+	/*
+	 * Already in a locked context for the desc from calling
+	 * irq_set_irq_chip_state.
+	 * It should be safe to simply modify the handler.
+	 */
+	irq_to_desc(d->irq)->handle_irq = handler;
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), prio);
+
+	return 0;
+}
+#endif
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -268,6 +353,18 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 		reg = val ? GICD_ICENABLER : GICD_ISENABLER;
 		break;

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	case IRQCHIP_STATE_NMI:
+		if (static_branch_likely(&have_non_secure_prio_view)) {
+			return gic_irq_set_irqchip_prio(d, val);
+		} else if (val) {
+			pr_warn("Failed to set IRQ %u as NMI, NMIs are unsupported\n",
+				gic_irq(d));
+			return -EINVAL;
+		}
+		return 0;
+#endif
+
 	default:
 		return -EINVAL;
 	}
@@ -295,6 +392,13 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 		*val = !gic_peek_irq(d, GICD_ISENABLER);
 		break;

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	case IRQCHIP_STATE_NMI:
+		*val = (gic_get_irq_prio(gic_irq(d), gic_dist_base(d)) ==
+			GICD_INT_NMI_PRI);
+		break;
+#endif
+
 	default:
 		return -EINVAL;
 	}
@@ -365,6 +469,22 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 	return aff;
 }

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
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
+#endif
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -380,6 +500,25 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+		if (static_branch_likely(&have_non_secure_prio_view)
+		    && unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+			/*
+			 * We need to prevent other NMIs to occur even after a
+			 * priority drop.
+			 * We keep I flag set until cpsr is restored from
+			 * kernel_exit.
+			 */
+			arch_irqs_daif_disable();
+
+			if (static_branch_likely(&supports_deactivate_key))
+				gic_write_eoir(irqnr);
+
+			do_handle_nmi(irqnr, regs);
+			return;
+		}
+#endif
+
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
 		else {
@@ -1177,6 +1316,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 #ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	if (!gic_cpu_has_group0() || gic_dist_security_disabled())
 		static_branch_enable(&have_non_secure_prio_view);
+	else
+		pr_warn("SCR_EL3.FIQ set, cannot enable use of pseudo-NMIs\n");
 #endif

 	return 0;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627..02c794f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -419,6 +419,7 @@ enum irqchip_irq_state {
 	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
 	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
 	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
+	IRQCHIP_STATE_NMI,		/* Is IRQ an NMI? */
 };

 extern int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
--
1.9.1
