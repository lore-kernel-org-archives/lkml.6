Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD58ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA9D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA9D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbeGWNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:25 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 152CFC9D;
        Mon, 23 Jul 2018 12:44:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        arjan.van.de.ven@intel.com, bp@alien8.de, dave.hansen@intel.com,
        jmattson@google.com, karahmed@amazon.de, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 041/107] x86/speculation: Use IBRS if available before calling into firmware
Date:   Mon, 23 Jul 2018 14:41:35 +0200
Message-Id: <20180723122414.934849031@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit dd84441a797150dcc49298ec95c459a8891d8bb1 upstream.

Retpoline means the kernel is safe because it has no indirect branches.
But firmware isn't, so use IBRS for firmware calls if it's available.

Block preemption while IBRS is set, although in practice the call sites
already had to be doing that.

Ignore hpwdt.c for now. It's taking spinlocks and calling into firmware
code, from an NMI handler. I don't want to touch that with a bargepole.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1519037457-7643-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Srivatsa: Backported to 4.4.y, patching the efi_call_virt() family of functions,
  which are the 4.4.y-equivalents of arch_efi_call_virt_setup()/teardown() ]
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/apm.h           |    6 +++++
 arch/x86/include/asm/cpufeatures.h   |    1 
 arch/x86/include/asm/efi.h           |    7 ++++++
 arch/x86/include/asm/nospec-branch.h |   39 ++++++++++++++++++++++++++---------
 arch/x86/kernel/cpu/bugs.c           |   12 +++++++++-
 arch/x86/platform/efi/efi_64.c       |    3 ++
 6 files changed, 58 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
+#include <asm/nospec-branch.h>
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -31,6 +33,7 @@ static inline void apm_bios_call_asm(u32
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -43,6 +46,7 @@ static inline void apm_bios_call_asm(u32
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 }
 
 static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -55,6 +59,7 @@ static inline u8 apm_bios_call_simple_as
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -67,6 +72,7 @@ static inline u8 apm_bios_call_simple_as
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -202,6 +202,7 @@
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
 #define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled*/
+#define X86_FEATURE_USE_IBRS_FW	( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -3,6 +3,7 @@
 
 #include <asm/fpu/api.h>
 #include <asm/pgtable.h>
+#include <asm/nospec-branch.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -39,8 +40,10 @@ extern unsigned long asmlinkage efi_call
 ({									\
 	efi_status_t __s;						\
 	kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 	__s = ((efi_##f##_t __attribute__((regparm(0)))*)		\
 		efi.systab->runtime->f)(args);				\
+	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 	__s;								\
 })
@@ -49,8 +52,10 @@ extern unsigned long asmlinkage efi_call
 #define __efi_call_virt(f, args...) \
 ({									\
 	kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 	((efi_##f##_t __attribute__((regparm(0)))*)			\
 		efi.systab->runtime->f)(args);				\
+	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 })
 
@@ -71,7 +76,9 @@ extern u64 asmlinkage efi_call(void *fp,
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 	__s = efi_call((void *)efi.systab->runtime->f, __VA_ARGS__);	\
+	firmware_restrict_branch_speculation_end();			\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
 	__s;								\
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -195,17 +195,38 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+#define alternative_msr_write(_msr, _val, _feature)		\
+	asm volatile(ALTERNATIVE("",				\
+				 "movl %[msr], %%ecx\n\t"	\
+				 "movl %[val], %%eax\n\t"	\
+				 "movl $0, %%edx\n\t"		\
+				 "wrmsr",			\
+				 _feature)			\
+		     : : [msr] "i" (_msr), [val] "i" (_val)	\
+		     : "eax", "ecx", "edx", "memory")
+
 static inline void indirect_branch_prediction_barrier(void)
 {
-	asm volatile(ALTERNATIVE("",
-				 "movl %[msr], %%ecx\n\t"
-				 "movl %[val], %%eax\n\t"
-				 "movl $0, %%edx\n\t"
-				 "wrmsr",
-				 X86_FEATURE_USE_IBPB)
-		     : : [msr] "i" (MSR_IA32_PRED_CMD),
-			 [val] "i" (PRED_CMD_IBPB)
-		     : "eax", "ecx", "edx", "memory");
+	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
+			      X86_FEATURE_USE_IBPB);
+}
+
+/*
+ * With retpoline, we must use IBRS to restrict branch prediction
+ * before calling into firmware.
+ */
+static inline void firmware_restrict_branch_speculation_start(void)
+{
+	preempt_disable();
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
+			      X86_FEATURE_USE_IBRS_FW);
+}
+
+static inline void firmware_restrict_branch_speculation_end(void)
+{
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
+			      X86_FEATURE_USE_IBRS_FW);
+	preempt_enable();
 }
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -300,6 +300,15 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
+
+	/*
+	 * Retpoline means the kernel is safe because it has no indirect
+	 * branches. But firmware isn't, so use IBRS to protect that.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
+		pr_info("Enabling Restricted Speculation for firmware calls\n");
+	}
 }
 
 #undef pr_fmt
@@ -326,8 +335,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 		       spectre_v2_module_string());
 }
 #endif
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -40,6 +40,7 @@
 #include <asm/fixmap.h>
 #include <asm/realmode.h>
 #include <asm/time.h>
+#include <asm/nospec-branch.h>
 
 /*
  * We allocate runtime services regions bottom-up, starting from -4G, i.e.
@@ -347,6 +348,7 @@ extern efi_status_t efi64_thunk(u32, ...
 									\
 	efi_sync_low_kernel_mappings();					\
 	local_irq_save(flags);						\
+	firmware_restrict_branch_speculation_start();			\
 									\
 	efi_scratch.prev_cr3 = read_cr3();				\
 	write_cr3((unsigned long)efi_scratch.efi_pgt);			\
@@ -357,6 +359,7 @@ extern efi_status_t efi64_thunk(u32, ...
 									\
 	write_cr3(efi_scratch.prev_cr3);				\
 	__flush_tlb_all();						\
+	firmware_restrict_branch_speculation_end();			\
 	local_irq_restore(flags);					\
 									\
 	__s;								\


