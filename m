Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeEULfv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:35:51 -0400
Received: from foss.arm.com ([217.140.101.70]:47582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbeEULfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:45 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 3/6] arm64: irqflags: Use ICC sysregs to implement IRQ masking
Date: Mon, 21 May 2018 12:35:12 +0100
Message-Id: <1526902515-13769-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently irqflags is implemented using the PSR's I bit. It is possible
to implement irqflags by using the co-processor interface to the GIC.
Using the co-processor interface makes it feasible to simulate NMIs
using GIC interrupt prioritization.

This patch changes the irqflags macros to modify, save and restore
ICC_PMR_EL1. This has a substantial knock on effect for the rest of
the kernel. There are four reasons for this:

1. The state of the PMR becomes part of the interrupt context and must be
   saved and restored during exceptions. It is saved on the stack as part
   of the saved context when an interrupt/exception is taken.

2. The hardware automatically masks the I bit (at boot, during traps, etc).
   When the I bit is set by hardware we must add code to switch from I
   bit masking and PMR masking:
       - For IRQs, this is done after the interrupt has been acknowledged
       	 avoiding the need to unmask.
       - For other exceptions, this is done right after saving the context.

3. Some instructions, such as wfi, require that the PMR not be used
   for interrupt masking. Before calling these instructions we must
   switch from PMR masking to I bit masking.
   This is also the case when KVM runs a guest, if the CPU receives
   an interrupt from the host, interrupts must not be masked in PMR
   otherwise the GIC will not signal it to the CPU.

4. We use the alternatives system to allow a single kernel to boot and
   be switched to the alternative masking approach at runtime.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry@arm.com: changes reflected in commit,
			 message, fixes, renaming]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig                     |  15 ++++
 arch/arm64/include/asm/arch_gicv3.h    |  20 ++++++
 arch/arm64/include/asm/assembler.h     |  25 ++++++-
 arch/arm64/include/asm/daifflags.h     |  36 +++++++---
 arch/arm64/include/asm/efi.h           |   5 ++
 arch/arm64/include/asm/irqflags.h      | 125 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h      |  14 ++++
 arch/arm64/include/asm/processor.h     |   4 ++
 arch/arm64/include/asm/ptrace.h        |  14 +++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/entry.S              |  28 ++++++--
 arch/arm64/kernel/head.S               |  37 ++++++++++
 arch/arm64/kernel/process.c            |   6 ++
 arch/arm64/kernel/smp.c                |   8 +++
 arch/arm64/kvm/hyp/switch.c            |  25 +++++++
 arch/arm64/mm/fault.c                  |   5 +-
 arch/arm64/mm/proc.S                   |  23 ++++++
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           |  82 +++++++++++----------
 include/linux/irqchip/arm-gic-common.h |   6 ++
 include/linux/irqchip/arm-gic.h        |   5 --
 21 files changed, 423 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..ab214b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -938,6 +938,21 @@ config HARDEN_EL2_VECTORS

 	  If unsure, say Y.

+config USE_ICC_SYSREGS_FOR_IRQFLAGS
+	bool "Use ICC system registers for IRQ masking"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Using the ICC system registers for IRQ masking makes it possible
+	  to simulate NMI on ARM64 systems. This allows several interesting
+	  features (especially debug features) to be used on these systems.
+
+	  Say Y here to implement IRQ masking using ICC system
+	  registers when the GIC System Registers are available. The changes
+	  are applied dynamically using the alternatives system so it is safe
+	  to enable this option on systems with older interrupt controllers.
+
+	  If unsure, say N
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index e278f94..6ee27ec 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -76,6 +76,16 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 	return irqstat;
 }

+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg_s(SYS_ICC_PMR_EL1);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg_s(val, SYS_ICC_PMR_EL1);
+}
+
 static inline void gic_write_ctlr(u32 val)
 {
 	write_sysreg_s(val, SYS_ICC_CTLR_EL1);
@@ -140,5 +150,15 @@ static inline void gic_write_bpr1(u32 val)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+static inline void gic_start_pmr_masking(void)
+{
+	if (cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF)) {
+		gic_write_pmr(ICC_PMR_EL1_MASKED);
+		asm volatile ("msr daifclr, #2" : : : "memory");
+	}
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98d..9da68d2 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H

+#include <asm/alternative.h>
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
@@ -62,12 +63,32 @@
 /*
  * Enable and disable interrupts.
  */
-	.macro	disable_irq
+	.macro	disable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifset, #2
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+alternative_endif
+#else
+	msr	daifset, #2
+#endif
 	.endm

-	.macro	enable_irq
+	.macro	enable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov     \tmp, #ICC_PMR_EL1_UNMASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifclr, #2
+	nop
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+	dsb	sy
+alternative_endif
+#else
+	msr	daifclr, #2
+#endif
 	.endm

 	.macro	save_and_disable_irq, flags
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 22e4c83..ba85822 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,9 +18,24 @@

 #include <linux/irqflags.h>

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT

+#else
+
+#define DAIF_PROCCTX							\
+	(cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF) ?		\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_UNMASKED) :		\
+		0)
+
+#define DAIF_PROCCTX_NOIRQ						\
+	(cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF) ?		\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_MASKED) :		\
+		PSR_I_BIT)
+#endif
+
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
 {
@@ -36,11 +51,8 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;

-	asm volatile(
-		"mrs	%0, daif		// local_daif_save\n"
-		: "=r" (flags)
-		:
-		: "memory");
+	flags = arch_local_save_flags();
+
 	local_daif_mask();

 	return flags;
@@ -54,17 +66,21 @@ static inline void local_daif_unmask(void)
 		:
 		:
 		: "memory");
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Unmask IRQs in PMR if needed */
+	if (cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF))
+		arch_local_irq_enable();
+#endif
 }

 static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
 		trace_hardirqs_on();
-	asm volatile(
-		"msr	daif, %0		// local_daif_restore"
-		:
-		: "r" (flags)
-		: "memory");
+
+	arch_local_irq_restore(flags);
+
 	if (arch_irqs_disabled_flags(flags))
 		trace_hardirqs_off();
 }
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 192d791..2c50025 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,7 +42,12 @@

 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+#define ARCH_EFI_IRQ_FLAGS_MASK \
+	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
+#else
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#endif

 /* arch specific definitions used by the stub code */

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..3d5d443 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,10 @@

 #ifdef __KERNEL__

+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>

 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -33,6 +36,7 @@
  * unmask it at all other times.
  */

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 /*
  * CPU interrupt mask handling.
  */
@@ -96,5 +100,126 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return flags & PSR_I_BIT;
 }
+
+static inline void maybe_switch_to_sysreg_gic_cpuif(void) {}
+
+#else /* CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS */
+
+#define ARCH_FLAG_PMR_EN 0x1
+
+#define MAKE_ARCH_FLAGS(daif, pmr)					\
+	((daif) | (((pmr) >> ICC_PMR_EL1_EN_SHIFT) & ARCH_FLAG_PMR_EN))
+
+#define ARCH_FLAGS_GET_PMR(flags)				\
+	((((flags) & ARCH_FLAG_PMR_EN) << ICC_PMR_EL1_EN_SHIFT) \
+		| ICC_PMR_EL1_MASKED)
+
+#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
+
+/*
+ * CPU interrupt mask handling.
+ */
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_irq_save\n"
+		"msr	daifset, #2\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		/* --- */
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1) "\n"
+		"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %2",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "=&r" (flags), "=&r" (pmr)
+		: "r" (masked)
+		: "memory");
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		:
+		: "r" (unmasked)
+		: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		:
+		: "r" (masked)
+		: "memory");
+}
+
+/*
+ * Save the current interrupt enable state.
+ */
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_save_flags\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1),
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "=r" (flags), "=r" (pmr)
+		:
+		: "memory");
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	unsigned long pmr = ARCH_FLAGS_GET_PMR(flags);
+
+	flags = ARCH_FLAGS_GET_DAIF(flags);
+
+	asm volatile(ALTERNATIVE(
+		"msr	daif, %0		// arch_local_irq_restore\n"
+		"nop\n"
+		"nop",
+		"msr	daif, %0\n"
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%1\n"
+		"dsb	sy",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+	:
+	: "r" (flags), "r" (pmr)
+	: "memory");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
+		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
+}
+
+void maybe_switch_to_sysreg_gic_cpuif(void);
+
+#endif /* CONFIG_IRQFLAGS_GIC_MASKING */
+
 #endif
 #endif
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 469de8a..1882534 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@

 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <asm/arch_gicv3.h>
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
@@ -433,6 +434,19 @@ static inline void kvm_fpsimd_flush_cpu_state(void)
 static inline void kvm_arm_vhe_guest_enter(void)
 {
 	local_daif_mask();
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Having IRQs masked via PMR when entering the guest means the GIC
+	 * will not signal the CPU of interrupts of lower priority, and the
+	 * only way to get out will be via guest exceptions.
+	 * Naturally, we want to avoid this.
+	 */
+	if (cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF)) {
+		gic_write_pmr(ICC_PMR_EL1_UNMASKED);
+		dsb(sy);
+	}
+#endif
 }

 static inline void kvm_arm_vhe_guest_exit(void)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7675989..5d3bed7 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -163,6 +163,10 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 	memset(regs, 0, sizeof(*regs));
 	forget_syscall(regs);
 	regs->pc = pc;
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Have IRQs enabled by default */
+	regs->pmr_save = ICC_PMR_EL1_UNMASKED;
+#endif
 }

 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 6069d66..aa1e948 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,12 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)

+/* PMR values used to mask/unmask interrupts */
+#define ICC_PMR_EL1_EN_SHIFT	6
+#define ICC_PMR_EL1_EN_BIT	(1 << ICC_PMR_EL1_EN_SHIFT) // PMR IRQ enable
+#define ICC_PMR_EL1_UNMASKED    0xf0
+#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_EN_BIT)
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
@@ -136,7 +142,7 @@ struct pt_regs {
 #endif

 	u64 orig_addr_limit;
-	u64 unused;	// maintain 16 byte alignment
+	u64 pmr_save;
 	u64 stackframe[2];
 };

@@ -171,8 +177,14 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 #define interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_I_BIT))
+#else
+#define interrupts_enabled(regs)	    \
+	((!((regs)->pstate & PSR_I_BIT)) && \
+	 ((regs)->pmr_save & ICC_PMR_EL1_EN_BIT))
+#endif

 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 5bdda65..1f6a0a9 100644
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
index ec2ee72..a7f753f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -20,6 +20,7 @@

 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>

 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -230,6 +231,16 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Save pmr */
+alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	mrs_s	x20, SYS_ICC_PMR_EL1
+alternative_else
+	mov	x20, #ICC_PMR_EL1_UNMASKED
+alternative_endif
+	str	x20, [sp, #S_PMR_SAVE]
+#endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -240,9 +251,9 @@ alternative_else_nop_endif
 	.endm

 	.macro	kernel_exit, el
-	.if	\el != 0
 	disable_daif

+	.if	\el != 0
 	/* Restore the task's original addr_limit. */
 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
 	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
@@ -250,6 +261,15 @@ alternative_else_nop_endif
 	/* No need to restore UAO, it will be restored from SPSR_EL1 */
 	.endif

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Restore pmr, ensuring IRQs are off before restoring context. */
+alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	ldr	x20, [sp, #S_PMR_SAVE]
+	msr_s	SYS_ICC_PMR_EL1, x20
+	dsb	sy
+alternative_else_nop_endif
+#endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
@@ -872,7 +892,7 @@ ENDPROC(el0_error)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_daif
+	disable_irq x21				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
@@ -882,7 +902,7 @@ ret_fast_syscall:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
-	enable_daif
+	enable_irq x0				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0

 /*
@@ -900,7 +920,7 @@ work_pending:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_daif
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b085306..47b2785 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -647,6 +647,43 @@ set_cpu_boot_mode_flag:
 	ret
 ENDPROC(set_cpu_boot_mode_flag)

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
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
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
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
+#endif
+
 /*
  * These values are written with the MMU off, but read with the MMU on.
  * Writers will invalidate the corresponding address, discarding up to a
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed..0be3d25 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -65,6 +65,8 @@
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif

+#include <asm/arch_gicv3.h>
+
 /*
  * Function pointers to optional machine specific functions
  */
@@ -230,6 +232,7 @@ void __show_regs(struct pt_regs *regs)
 	}

 	printk("sp : %016llx\n", sp);
+	printk("pmr_save: %08llx\n", regs->pmr_save);

 	i = top_reg;

@@ -355,6 +358,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+		childregs->pmr_save = ICC_PMR_EL1_UNMASKED;
+#endif
 		if (IS_ENABLED(CONFIG_ARM64_UAO) &&
 		    cpus_have_const_cap(ARM64_HAS_UAO))
 			childregs->pstate |= PSR_UAO_BIT;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b7fb909..6aa21fd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -185,6 +185,8 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;

+	maybe_switch_to_sysreg_gic_cpuif();
+
 	cpu = task_cpu(current);
 	set_my_cpu_offset(per_cpu_offset(cpu));

@@ -417,6 +419,12 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_boot_alternatives();
+
+	/*
+	 * Conditionally switch to GIC PMR for interrupt masking (this
+	 * will be a nop if we are using normal interrupt masking)
+	 */
+	maybe_switch_to_sysreg_gic_cpuif();
 }

 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index d964523..2c0f453 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -21,6 +21,9 @@

 #include <kvm/arm_psci.h>

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+#include <asm/arch_gicv3.h>
+#endif
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
@@ -442,6 +445,23 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt;
 	bool fp_enabled;
 	u64 exit_code;
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	u32 host_pmr = ICC_PMR_EL1_UNMASKED;
+#endif
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Having IRQs masked via PMR when entering the guest means the GIC
+	 * will not signal the CPU of interrupts of lower priority, and the
+	 * only way to get out will be via guest exceptions.
+	 * Naturally, we want to avoid this.
+	 */
+	if (cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF)) {
+		host_pmr = gic_read_pmr();
+		gic_write_pmr(ICC_PMR_EL1_UNMASKED);
+		dsb(sy);
+	}
+#endif

 	vcpu = kern_hyp_va(vcpu);

@@ -496,6 +516,11 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	 */
 	__debug_switch_to_host(vcpu);

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	if (cpus_have_const_cap(ARM64_HAS_SYSREG_GIC_CPUIF))
+		gic_write_pmr(host_pmr);
+#endif
+
 	return exit_code;
 }

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485..7a18634 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/sysreg.h>
@@ -712,7 +713,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();

-	local_irq_enable();
+	local_daif_restore(DAIF_PROCCTX);
 	do_mem_abort(addr, esr, regs);
 }

@@ -726,7 +727,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
-		local_irq_enable();
+		local_daif_restore(DAIF_PROCCTX);
 	}

 	info.si_signo = SIGBUS;
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a..7e74f06 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@

 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -53,11 +54,33 @@
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is set we must do additional
+ *	work to ensure that interrupts are not masked at the PMR (because the
+ *	core will not wake up if we block the wake up signal in the interrupt
+ *	controller).
  */
 ENTRY(cpu_do_idle)
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+#endif
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
+alternative_endif
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x2		// unmask at PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
+#endif
 ENDPROC(cpu_do_idle)

 #ifdef CONFIG_CPU_PM
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5416f2b..9ac146c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -62,7 +62,7 @@
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)

-#define LPI_PROP_DEFAULT_PRIO	0xa0
+#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI

 /*
  * Collection structure - just an ID, and a redistributor address to
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e5d1014..82cfacf 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -71,9 +71,6 @@ struct gic_chip_data {
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)

-/* Our default, arbitrary priority value. Linux only uses one anyway. */
-#define DEFAULT_PMR_VALUE	0xf0
-
 static inline unsigned int gic_irq(struct irq_data *d)
 {
 	return d->hwirq;
@@ -348,48 +345,55 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;

-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	isb();
+	/* Masking IRQs earlier would prevent to ack the current interrupt */
+	gic_start_pmr_masking();
+#endif
+
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;

-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+		else {
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+			isb();
+#endif
+		}

-			if (static_branch_likely(&supports_deactivate_key))
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_branch_likely(&supports_deactivate_key)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_branch_likely(&supports_deactivate_key)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_branch_likely(&supports_deactivate_key))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+		return;
+	}
 }

 static void __init gic_dist_init(void)
@@ -565,8 +569,10 @@ static void gic_cpu_sys_reg_init(void)
 	val = read_gicreg(ICC_PMR_EL1);
 	group0 = val != 0;

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	write_gicreg(ICC_PMR_EL1_UNMASKED, ICC_PMR_EL1);
+#endif

 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b43..2c9a4b3 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 #include <linux/ioport.h>

+#define GICD_INT_DEF_PRI		0xc0
+#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
+					(GICD_INT_DEF_PRI << 16) |\
+					(GICD_INT_DEF_PRI << 8) |\
+					GICD_INT_DEF_PRI)
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 68d8b1f..5f2129b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -65,11 +65,6 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)

 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
--
1.9.1
