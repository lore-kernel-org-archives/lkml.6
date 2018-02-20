Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeBTKec (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:34:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeBTKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:34:30 -0500
Date: Tue, 20 Feb 2018 02:29:07 -0800
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-dd84441a797150dcc49298ec95c459a8891d8bb1@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, dwmw@amazon.co.uk,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        dwmw@amazon.co.uk, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org
In-Reply-To: <1519037457-7643-2-git-send-email-dwmw@amazon.co.uk>
References: <1519037457-7643-2-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Use IBRS if available before calling
 into firmware
Git-Commit-ID: dd84441a797150dcc49298ec95c459a8891d8bb1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dd84441a797150dcc49298ec95c459a8891d8bb1
Gitweb:     https://git.kernel.org/tip/dd84441a797150dcc49298ec95c459a8891d8bb1
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Mon, 19 Feb 2018 10:50:54 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:38:33 +0100

x86/speculation: Use IBRS if available before calling into firmware

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
---
 arch/x86/include/asm/apm.h           |  6 ++++++
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/efi.h           | 17 ++++++++++++++--
 arch/x86/include/asm/nospec-branch.h | 39 +++++++++++++++++++++++++++---------
 arch/x86/kernel/cpu/bugs.c           | 12 ++++++++++-
 5 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/apm.h b/arch/x86/include/asm/apm.h
index 4d4015d..c356098 100644
--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
+#include <asm/nospec-branch.h>
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -32,6 +34,7 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -44,6 +47,7 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 }
 
 static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -56,6 +60,7 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -68,6 +73,7 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0dfe4d3..f41079d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -213,6 +213,7 @@
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 85f6ccb..a399c1e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -6,6 +6,7 @@
 #include <asm/pgtable.h>
 #include <asm/processor-flags.h>
 #include <asm/tlb.h>
+#include <asm/nospec-branch.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -36,8 +37,18 @@
 
 extern asmlinkage unsigned long efi_call_phys(void *, ...);
 
-#define arch_efi_call_virt_setup()	kernel_fpu_begin()
-#define arch_efi_call_virt_teardown()	kernel_fpu_end()
+#define arch_efi_call_virt_setup()					\
+({									\
+	kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
+})
+
+#define arch_efi_call_virt_teardown()					\
+({									\
+	firmware_restrict_branch_speculation_end();			\
+	kernel_fpu_end();						\
+})
+
 
 /*
  * Wrap all the virtual calls in a way that forces the parameters on the stack.
@@ -73,6 +84,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 									\
 	if (efi_scratch.use_pgd) {					\
 		efi_scratch.prev_cr3 = __read_cr3();			\
@@ -91,6 +103,7 @@ struct efi_scratch {
 		__flush_tlb_all();					\
 	}								\
 									\
+	firmware_restrict_branch_speculation_end();			\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
 })
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index af34b1e..ec90c32 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -219,17 +219,38 @@ static inline void vmexit_fill_RSB(void)
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
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d71c8b5..bfca937 100644
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
@@ -326,8 +335,9 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 		       spectre_v2_module_string());
 }
 #endif
