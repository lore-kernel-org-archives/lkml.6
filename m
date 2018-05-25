Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966144AbeEYJui (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:38 -0400
Received: from foss.arm.com ([217.140.101.70]:57552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966084AbeEYJuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:32 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v4 15/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
Date: Fri, 25 May 2018 10:49:21 +0100
Message-Id: <1527241772-48007-16-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead disabling interrupts by setting the PSR.I bit, use a priority
higher than the one used for interrupts to mask them via PMR.

The value chosen for PMR to enable/disable interrupts encodes the status
of interrupts on a single bit. This information is stored in the irqflags
values used when saving/restoring IRQ status.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/arm64/include/asm/assembler.h | 17 ++++++-
 arch/arm64/include/asm/efi.h       |  3 +-
 arch/arm64/include/asm/irqflags.h  | 97 ++++++++++++++++++++++++++++++--------
 arch/arm64/include/asm/ptrace.h    | 10 ++--
 arch/arm64/kernel/entry.S          |  6 +--
 5 files changed, 104 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98d..0b2dcfd 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/alternative.h>
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
@@ -62,12 +63,24 @@
 /*
  * Enable and disable interrupts.
  */
-	.macro	disable_irq
+	.macro	disable_irq, tmp
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
 	msr	daifset, #2
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+alternative_endif
 	.endm
 
-	.macro	enable_irq
+	.macro	enable_irq, tmp
+	mov     \tmp, #ICC_PMR_EL1_UNMASKED
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
 	msr	daifclr, #2
+	nop
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+	dsb	sy
+alternative_endif
 	.endm
 
 	.macro	save_and_disable_irq, flags
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 192d791..a4e0730 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,7 +42,8 @@
 
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
-#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#define ARCH_EFI_IRQ_FLAGS_MASK \
+	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
 
 /* arch specific definitions used by the stub code */
 
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..193cfd0 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,27 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+
+/*
+ * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
+ * whether the normal interrupts are masked is kept along with the daif
+ * flags.
+ */
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
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -38,31 +58,50 @@
  */
 static inline unsigned long arch_local_irq_save(void)
 {
-	unsigned long flags;
-	asm volatile(
+	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
 		"mrs	%0, daif		// arch_local_irq_save\n"
-		"msr	daifset, #2"
-		: "=r" (flags)
-		:
+		"msr	daifset, #2\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		/* --- */
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1) "\n"
+		"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %2",
+		ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (flags), "=&r" (pmr)
+		: "r" (masked)
 		: "memory");
-	return flags;
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
 }
 
 static inline void arch_local_irq_enable(void)
 {
-	asm volatile(
-		"msr	daifclr, #2		// arch_local_irq_enable"
-		:
+	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (unmasked)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
-	asm volatile(
-		"msr	daifset, #2		// arch_local_irq_disable"
-		:
+	unsigned long masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (masked)
 		: "memory");
 }
 
@@ -72,12 +111,19 @@ static inline void arch_local_irq_disable(void)
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_save_flags\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1),
+		ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=r" (flags), "=r" (pmr)
 		:
 		: "memory");
-	return flags;
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
 }
 
 /*
@@ -85,16 +131,27 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"msr	daif, %0		// arch_local_irq_restore"
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
+		ARM64_HAS_IRQ_PRIO_MASKING)
 	:
-	: "r" (flags)
+	: "r" (flags), "r" (pmr)
 	: "memory");
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
+		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
 }
 #endif
 #endif
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e87aef7..3ec58a4 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,8 +25,11 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
-/* PMR value use to unmask interrupts */
+/* PMR values used to mask/unmask interrupts */
 #define ICC_PMR_EL1_UNMASKED    0xf0
+#define ICC_PMR_EL1_EN_SHIFT	6
+#define ICC_PMR_EL1_EN_BIT	(1 << ICC_PMR_EL1_EN_SHIFT) // PMR IRQ enable
+#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_EN_BIT)
 
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
@@ -174,8 +177,9 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)
 
-#define interrupts_enabled(regs) \
-	(!((regs)->pstate & PSR_I_BIT))
+#define interrupts_enabled(regs)			\
+	((!((regs)->pstate & PSR_I_BIT)) &&		\
+	 ((regs)->pmr_save & ICC_PMR_EL1_EN_BIT))
 
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 78e4ff4..f56f27e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -888,7 +888,7 @@ ENDPROC(el0_error)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
@@ -898,7 +898,7 @@ ret_fast_syscall:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
-	enable_irq				// enable interrupts
+	enable_irq x0				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0
 
 /*
@@ -916,7 +916,7 @@ work_pending:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
-- 
1.9.1
