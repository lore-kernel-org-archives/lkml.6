Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932841AbeEaSAJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:00:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:18561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755824AbeEaR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:59:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725540"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/15] x86/fsgsbase/64: Use per-CPU base as GS base on paranoid_entry
Date: Thu, 31 May 2018 10:58:42 -0700
Message-Id: <1527789525-8857-13-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSGSBASE allows fast access on GS base. With that, per-CPU
base is always copied to GS base on paranoid entry. The
current GS base value is restored on the exit.

Currently, userspace can't modify GS base and the kernel's
conventions are that a negative GS base means it is a kernel
value and a positive GS base means it is a user value. But,
with FSGSBASE enabled, userspace can put arbitrary data in
there. This behavior will be the same with the patch.

Per-CPU base can be found from per_cpu_offset table with CPU
number, which is in the (per-CPU) segment limit or obtained
by RDPID instruction.

GAS-compatible RDPID macro is included.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S       | 74 +++++++++++++++++++++++++++++++++--------
 arch/x86/include/asm/fsgsbase.h | 57 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h     | 15 +++++++++
 3 files changed, 132 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3166b96..cfac4c0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,8 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/vdso.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -954,10 +956,14 @@ ENTRY(\sym)
 	addq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
 	.endif
 
-	/* these procedures expect "no swapgs" flag in ebx */
 	.if \paranoid
+	/*
+	 * With FSGSBASE, original GS base is stored in rbx
+	 * Without FSGSBASE, expect "no swapgs" flag in ebx
+	 */
 	jmp	paranoid_exit
 	.else
+	/* expect "no swapgs" flag in ebx */
 	jmp	error_exit
 	.endif
 
@@ -1168,26 +1174,57 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs.
+ *
+ * When FSGSBASE enabled, current GS base is always copied to rbx.
+ *
+ * Without FSGSBASE, SWAPGS is needed when entering from userspace.
+ * A positive GS base means it is a user value and a negative GS
+ * base means it is a kernel value.
+ *
+ * Return:
+ * 	With FSGSBASE, rbx has current GS base.
+ * 	Without that,
+ *		ebx=0: need SWAPGS on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
-1:
+	/*
+	 * As long as this PTI macro doesn't depend on kernel GS base,
+	 * we can do it early. This is because FIND_PERCPU_BASE
+	 * references data in kernel space.
+	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/*
+	 * Read GS base by RDGSBASE. Kernel GS base is found
+	 * from the per-CPU offset table with CPU number.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	"",\
+		X86_FEATURE_FSGSBASE
+	RDGSBASE	%rbx
+	FIND_PERCPU_BASE	%rax
+	WRGSBASE	%rax
+	ret
+
+.Lparanoid_entry_no_fsgsbase:
+	movl	$1, %ebx
+	/*
+	 * FSGSBASE is not in use, so depend on the kernel-enforced
+	 * convention that a negative GS base indicates a kernel value.
+	 */
+	READ_MSR_GSBASE save_reg=%edx
+	testl	%edx, %edx	/* negative -> in kernel */
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+	xorl	%ebx, %ebx
 	ret
 END(paranoid_entry)
 
@@ -1201,12 +1238,21 @@ END(paranoid_entry)
  * be complicated.  Fortunately, we there's no good reason
  * to try to handle preemption here.
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ * On entry,
+ *	With FSGSBASE,
+ *		rbx is original GS base that needs to be restored on the exit
+ *	Without that,
+ * 		ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
  */
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
+	ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",	"nop",\
+		X86_FEATURE_FSGSBASE
+	WRGSBASE	%rbx
+	jmp	.Lparanoid_exit_no_swapgs;
+.Lparanoid_exit_no_fsgsbase:
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
@@ -1217,7 +1263,7 @@ ENTRY(paranoid_exit)
 	TRACE_IRQS_IRETQ_DEBUG
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
-	jmp restore_regs_and_return_to_kernel
+	jmp	restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
 /*
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 903c7a0..3a5e1ec 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -107,6 +107,63 @@ void  write_inactive_gsbase(unsigned long gsbase);
 	MODRM 0xd0 wrgsbase_opd 1
 .endm
 
+#if CONFIG_SMP
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %GS for accessing per-CPU data, but we are setting up
+ * %GS here and obviously can not use %GS itself to access per-CPU data.
+ */
+.macro FIND_PERCPU_BASE_RDPID reg:req
+	RDPID	\reg
+
+	/*
+	 * CPU number is written before IST initialization. Later,
+	 * processor id is (also) written during vDSO initialization,
+	 * with 12 bits for the CPU and 8 bits for the node.
+	 */
+	andq	$PERCPU_CPU_MASK, \reg
+	/*
+	 * Kernel GS base is looked up from the __per_cpu_offset list with
+	 * the CPU number (processor id).
+	 */
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+.macro FIND_PERCPU_BASE_SEG_LIMIT reg:req
+	/* CPU number is found from the limit of PER_CPU entry in GDT */
+	movq	$__PER_CPU_SEG, \reg
+	lsl	\reg, \reg
+
+	/* Same as FIND_PERCPU_BASE_RDPID */
+	andq	$PERCPU_CPU_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+.macro FIND_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"FIND_PERCPU_BASE_SEG_LIMIT \reg", \
+		"FIND_PERCPU_BASE_RDPID \reg", \
+		X86_FEATURE_RDPID
+.endm
+
+#else
+
+.macro FIND_PERCPU_BASE reg:req
+	/* Tracking the base offset value */
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
+
+.macro READ_MSR_GSBASE save_reg:req
+	movl	$MSR_GS_BASE, %ecx
+	/* Read MSR specified by %ecx into %edx:%eax */
+	rdmsr
+	.ifnc \save_reg, %edx
+	movl	%edx, \save_reg
+	.endif
+.endm
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796d..d063841 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
-- 
2.7.4
