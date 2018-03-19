Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971742AbeCSUzs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:55:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:62511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968547AbeCSSIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330603"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on paranoid_entry
Date: Mon, 19 Mar 2018 10:49:25 -0700
Message-Id: <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FSGSBASE is enabled, SWAPGS needs if and only if (current)
GS base is not the kernel's.

FSGSBASE instructions allow user to write any value on GS base;
even negative. Sign check on the current GS base is not
sufficient. Fortunately, reading GS base is fast. Kernel GS
base is also known from the offset table with the CPU number.

GS-compatible RDPID macro is included.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/entry/entry_64.S       | 54 ++++++++++++++++++++++++++++++++---------
 arch/x86/include/asm/fsgsbase.h | 49 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h     | 15 ++++++++++++
 3 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 805f527..51ad17e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -1159,26 +1160,57 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs.
+ *
+ * SWAPGS needs when it comes from user space. To check where-it-from,
+ * read GS base from RDMSR/MSR_GS_BASE and check if negative or not.
+ * This works without FSGSBASE.
+ *
+ * When FSGSBASE enabled, arbitrary GS base can be put by a user-level
+ * task, which means negative value is possible. Direct comparison
+ * between the current and kernel GS bases determines the necessity of
+ * SWAPGS; do if and only if unmatched.
+ *
+ * Return: ebx=0: need SWAPGS on exit, ebx=1: otherwise
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
+	 * we can do it early. This is because READ_KERNEL_GSBASE
+	 * references data in kernel space.
+	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	movl	$1, %ebx
+	/*
+	 * Read current GS base with RDGSBASE. Kernel GS base is found
+	 * by CPU number and its offset value.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	\
+		"RDGSBASE %rdx", X86_FEATURE_FSGSBASE
+	READ_KERNEL_GSBASE %rax
+	cmpq	%rdx, %rax
+	jne	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_no_fsgsbase:
+	/*
+	 * A (slow) RDMSR is surefire without FSGSBASE.
+	 * The READ_MSR_GSBASE macro scratches %ecx, %eax, and %edx.
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
 
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 8936b7f..76d3457 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -140,6 +140,55 @@ void  write_shadow_gsbase(unsigned long gsbase);
 	MODRM 0xd0 wrgsbase_opd 1
 .endm
 
+#if CONFIG_SMP
+
+.macro READ_KERNEL_GSBASE_RDPID reg:req
+	RDPID	\reg
+
+	/*
+	 * processor id is written during vDSO (virtual dynamic shared object)
+	 * initialization. 12 bits for the CPU and 8 bits for the node.
+	 */
+	andq	$0xFFF, \reg
+	/*
+	 * Kernel GS base is looked up from the __per_cpu_offset list with
+	 * the CPU number (processor id).
+	 */
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+.macro READ_KERNEL_GSBASE_CPU_SEG_LIMIT reg:req
+	/* CPU number is found from the limit of PER_CPU entry in GDT */
+	movq	$__PER_CPU_SEG, \reg
+	lsl	\reg, \reg
+
+	/* Same as READ_KERNEL_GSBASE_RDPID */
+	andq	$0xFFF, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+.macro READ_KERNEL_GSBASE reg:req
+	ALTERNATIVE "READ_KERNEL_GSBASE_CPU_SEG_LIMIT \reg", \
+		"READ_KERNEL_GSBASE_RDPID \reg", X86_FEATURE_RDPID
+.endm
+
+#else
+
+.macro READ_KERNEL_GSBASE reg:req
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
