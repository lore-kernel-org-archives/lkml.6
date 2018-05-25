Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965627AbeEYJu2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966026AbeEYJuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:23 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Oleg Nesterov <oleg@redhat.com>, Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v4 11/26] arm64: Make PMR part of task context
Date: Fri, 25 May 2018 10:49:17 +0100
Message-Id: <1527241772-48007-12-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ICC_PMR_EL1 is used to mask interrupts, its value should be
saved/restored whenever a task is context switched out/in or
gets an exception.

Add PMR to the registers to save in the pt_regs struct upon kernel entry,
and restore it before ERET. Also, initialize it to a sane value when
creating new tasks.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/include/asm/ptrace.h    |  5 ++++-
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kernel/entry.S          | 16 ++++++++++++++++
 arch/arm64/kernel/process.c        |  2 ++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7675989..40bd0e1 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -163,6 +163,7 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 	memset(regs, 0, sizeof(*regs));
 	forget_syscall(regs);
 	regs->pc = pc;
+	regs->pmr_save = ICC_PMR_EL1_UNMASKED;
 }
 
 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 6069d66..e87aef7 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,9 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
+/* PMR value use to unmask interrupts */
+#define ICC_PMR_EL1_UNMASKED    0xf0
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
@@ -136,7 +139,7 @@ struct pt_regs {
 #endif
 
 	u64 orig_addr_limit;
-	u64 unused;	// maintain 16 byte alignment
+	u64 pmr_save;
 	u64 stackframe[2];
 };
 
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
index 20252d5..78e4ff4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -230,6 +230,15 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif
 
+	/* Save pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	mrs_s	x20, SYS_ICC_PMR_EL1
+alternative_else
+	/* Keep a sane value in the task context */
+	mov	x20, ICC_PMR_EL1_UNMASKED
+alternative_endif
+	str	x20, [sp, #S_PMR_SAVE]
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -250,6 +259,13 @@ alternative_else_nop_endif
 	/* No need to restore UAO, it will be restored from SPSR_EL1 */
 	.endif
 
+	/* Restore pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+	msr_s	SYS_ICC_PMR_EL1, x20
+	dsb	sy
+alternative_else_nop_endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed..fbc9886 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -230,6 +230,7 @@ void __show_regs(struct pt_regs *regs)
 	}
 
 	printk("sp : %016llx\n", sp);
+	printk("pmr_save: %08llx\n", regs->pmr_save);
 
 	i = top_reg;
 
@@ -355,6 +356,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
+		childregs->pmr_save = ICC_PMR_EL1_UNMASKED;
 		if (IS_ENABLED(CONFIG_ARM64_UAO) &&
 		    cpus_have_const_cap(ARM64_HAS_UAO))
 			childregs->pstate |= PSR_UAO_BIT;
-- 
1.9.1
