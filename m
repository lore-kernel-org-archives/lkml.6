Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966128AbeEYJxd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:53:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966178AbeEYJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:45 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 20/26] arm64: Switch to PMR masking when starting CPUs
Date: Fri, 25 May 2018 10:49:26 +0100
Message-Id: <1527241772-48007-21-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the boot CPU has been prepared or a new secondary CPU has been
brought up, use ICC_PMR_EL1 to mask interrupts on that CPU and clear
PSR.I bit.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/irqflags.h |  3 +++
 arch/arm64/kernel/head.S          | 35 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 193cfd0..d31e9b6 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -153,5 +153,8 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
 		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
 }
+
+void maybe_switch_to_sysreg_gic_cpuif(void);
+
 #endif
 #endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b085306..ba73690 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -648,6 +648,41 @@ set_cpu_boot_mode_flag:
 ENDPROC(set_cpu_boot_mode_flag)
 
 /*
+ * void maybe_switch_to_sysreg_gic_cpuif(void)
+ *
+ * Enable interrupt controller system register access if this feature
+ * has been detected by the alternatives system.
+ *
+ * Before we jump into generic code we must enable interrupt controller system
+ * register access because this is required by the irqflags macros.  We must
+ * also mask interrupts at the PMR and unmask them within the PSR. That leaves
+ * us set up and ready for the kernel to make its first call to
+ * arch_local_irq_enable().
+ *
+ */
+ENTRY(maybe_switch_to_sysreg_gic_cpuif)
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
+	b	1f
+alternative_else
+	mrs_s	x0, SYS_ICC_SRE_EL1
+alternative_endif
+	orr	x0, x0, #1
+	msr_s	SYS_ICC_SRE_EL1, x0	// Set ICC_SRE_EL1.SRE==1
+	isb				// Make sure SRE is now set
+	mrs	x0, daif
+	tbz	x0, #7, no_mask_pmr	// Are interrupts on?
+	mov	x0, ICC_PMR_EL1_MASKED
+	msr_s	SYS_ICC_PMR_EL1, x0	// Prepare for unmask of I bit
+	msr	daifclr, #2		// Clear the I bit
+	b	1f
+no_mask_pmr:
+	mov	x0, ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x0
+1:
+	ret
+ENDPROC(maybe_switch_to_sysreg_gic_cpuif)
+
+/*
  * These values are written with the MMU off, but read with the MMU on.
  * Writers will invalidate the corresponding address, discarding up to a
  * 'Cache Writeback Granule' (CWG) worth of data. The linker script ensures
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b7fb909..3f39d8c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -185,6 +185,8 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
+	maybe_switch_to_sysreg_gic_cpuif();
+
 	cpu = task_cpu(current);
 	set_my_cpu_offset(per_cpu_offset(cpu));
 
@@ -417,6 +419,9 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_boot_alternatives();
+
+	/* Conditionally switch to GIC PMR for interrupt masking */
+	maybe_switch_to_sysreg_gic_cpuif();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
1.9.1
