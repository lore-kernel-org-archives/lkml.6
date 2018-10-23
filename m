Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30628C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDB720824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDB720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeJXDID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:55091 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726590"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 08/12] x86/fsgsbase/64: Use the per-CPU base as GSBASE at the paranoid_entry
Date:   Tue, 23 Oct 2018 11:42:30 -0700
Message-Id: <20181023184234.14025-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSGSBASE instructions allow fast accesses on GSBASE.  Now, at the
paranoid_entry, the per-CPU base value can be always copied to GSBASE.
And the original GSBASE value will be restored at the exit.

So far, GSBASE modification has not been directly allowed from userspace.
So, swapping GSBASE has been conditionally executed according to the
kernel-enforced convention that a negative GSBASE indicates a kernel value.
But when FSGSBASE is enabled, userspace can put an arbitrary value in
GSBASE. The change will secure a correct GSBASE value with FSGSBASE.

Also, factor out the RDMSR-based GSBASE read into a new macro,
READ_MSR_GSBASE.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S       | 73 ++++++++++++++++++++++++++-------
 arch/x86/include/asm/fsgsbase.h |  9 ++++
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 16427981f222..8c7a4949395b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -928,10 +929,14 @@ ENTRY(\sym)
 	addq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
 	.endif
 
-	/* these procedures expect "no swapgs" flag in ebx */
 	.if \paranoid
+	/*
+	 * With FSGSBASE, original GSBASE is stored in %rbx
+	 * Without FSGSBASE, expect "no swapgs" flag in %ebx
+	 */
 	jmp	paranoid_exit
 	.else
+	/* Expect "no swapgs" flag in %ebx */
 	jmp	error_exit
 	.endif
 
@@ -1144,26 +1149,57 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs.
+ *
+ * When FSGSBASE enabled, current GSBASE is always copied to %rbx.
+ *
+ * Without FSGSBASE, SWAPGS is needed when entering from userspace.
+ * A positive GSBASE means it is a user value and a negative GSBASE
+ * means it is a kernel value.
+ *
+ * Return:
+ * 	With FSGSBASE, %rbx has current GSBASE.
+ * 	Without that,
+ *		%ebx=0: need SWAPGS on exit, %ebx=1: otherwise
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
+	 * As long as this PTI macro doesn't depend on kernel GSBASE,
+	 * we can do it early. This is because FIND_PERCPU_BASE
+	 * references data in kernel space.
+	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/*
+	 * Read GSBASE by RDGSBASE. Kernel GSBASE is found
+	 * from the per-CPU offset table with a CPU NR.
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
+	 * convention that a negative GSBASE indicates a kernel value.
+	 */
+	READ_MSR_GSBASE save_reg=%edx
+	testl	%edx, %edx	/* Negative -> in kernel */
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+	xorl	%ebx, %ebx
 	ret
 END(paranoid_entry)
 
@@ -1177,12 +1213,21 @@ END(paranoid_entry)
  * be complicated.  Fortunately, we there's no good reason
  * to try to handle preemption here.
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ * On entry,
+ *	With FSGSBASE,
+ *		%rbx is original GSBASE that needs to be restored on the exit
+ *	Without that,
+ * 		%ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
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
@@ -1193,7 +1238,7 @@ ENTRY(paranoid_exit)
 	TRACE_IRQS_IRETQ_DEBUG
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
-	jmp restore_regs_and_return_to_kernel
+	jmp	restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
 /*
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 0c2d7d8a8c01..c5bbd40454b8 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -163,6 +163,15 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_SMP */
 
+.macro READ_MSR_GSBASE save_reg:req
+	movl	$MSR_GS_BASE, %ecx
+	/* Read MSR specified by %ecx into %edx:%eax */
+	rdmsr
+	.ifnc \save_reg, %edx
+	movl	%edx, \save_reg
+	.endif
+.endm
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
-- 
2.19.1

