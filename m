Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36583C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A97217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfBCQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:16:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfBCQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:16:10 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqKRD-0004Kg-Lh; Sun, 03 Feb 2019 17:16:07 +0100
Subject: [GIT pull] x86 updates for 5.0
Message-ID: <154921049412.12839.11774598804715206628.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
Date:   Sun, 03 Feb 2019 17:16:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A few updates for x86:

 - Fix an unintended sign extension issue in the fault handling code

 - Rename the new resource control config switch so it's less confusing

 - Avoid setting up EFI info in kexec when the EFI runtime is disabled.

 - Fix the microcode version check in the AMD microcode loader so it only
   loads higher version numbers and never downgrades

 - Set EFER.LME in the 32bit trampoline before returning to long mode to
   handle older AMD/KVM behaviour properly.

 - Add Darren and Andy as x86/platform reviewers.


Thanks,

	tglx

------------------>
Borislav Petkov (1):
      MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers

Colin Ian King (1):
      x86/fault: Fix sign-extend unintended sign extension

Johannes Weiner (1):
      x86/resctrl: Avoid confusion over the new X86_RESCTRL config

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Kan Liang (1):
      x86/cpu: Add Atom Tremont (Jacobsville)

Thomas Lendacky (1):
      x86/microcode/amd: Don't falsely trick the late loading mechanism

Wei Huang (1):
      x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode


 Documentation/x86/resctrl_ui.txt     | 2 +-
 MAINTAINERS                          | 9 +++++++++
 arch/x86/Kconfig                     | 6 +++---
 arch/x86/boot/compressed/head_64.S   | 8 ++++++++
 arch/x86/boot/compressed/pgtable.h   | 2 +-
 arch/x86/include/asm/intel-family.h  | 3 ++-
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/Makefile | 4 ++--
 arch/x86/kernel/kexec-bzimage64.c    | 3 +++
 arch/x86/mm/fault.c                  | 2 +-
 include/linux/sched.h                | 2 +-
 13 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.txt
index e8e8d14d3c4e..c1f95b59e14d 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -9,7 +9,7 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
 
-This feature is enabled by the CONFIG_X86_RESCTRL and the x86 /proc/cpuinfo
+This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..a98a7325df8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16631,6 +16631,15 @@ S:	Maintained
 F:	drivers/platform/x86/
 F:	drivers/platform/olpc/
 
+X86 PLATFORM DRIVERS - ARCH
+R:	Darren Hart <dvhart@infradead.org>
+R:	Andy Shevchenko <andy@infradead.org>
+L:	platform-driver-x86@vger.kernel.org
+L:	x86@kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
+S:	Maintained
+F:	arch/x86/platform
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..68261430fe6e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -446,12 +446,12 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config X86_RESCTRL
-	bool "Resource Control support"
+config X86_CPU_RESCTRL
+	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Enable Resource Control support.
+	  Enable x86 CPU resource control support.
 
 	  Provide support for the allocation and monitoring of system resources
 	  usage by the CPU.
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b085..f105ae8651c9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -600,6 +600,14 @@ ENTRY(trampoline_32bit_src)
 	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
 	movl	%eax, %cr3
 3:
+	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
+	pushl	%ecx
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+	popl	%ecx
+
 	/* Enable PAE and LA57 (if required) paging modes */
 	movl	$X86_CR4_PAE, %eax
 	cmpl	$0, %edx
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91f75638f6e6..6ff7e81b5628 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0dd6b0f4000e..d9a9993af882 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -6,7 +6,7 @@
  * "Big Core" Processors (Branded as Core, Xeon, etc...)
  *
  * The "_X" parts are generally the EP and EX Xeons, or the
- * "Extreme" ones, like Broadwell-E.
+ * "Extreme" ones, like Broadwell-E, or Atom microserver.
  *
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
@@ -71,6 +71,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+#define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
 
 /* Xeon Phi */
 
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 40ebddde6ac2..f6b7fe2833cc 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
 
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
 
 static inline void resctrl_sched_in(void) {}
 
-#endif /* CONFIG_X86_RESCTRL */
+#endif /* CONFIG_X86_CPU_RESCTRL */
 
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index b6fa0869f7aa..cfd24f9f7614 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
-obj-$(CONFIG_X86_RESCTRL)		+= resctrl/
+obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 51adde0a0f1a..e1f3ba19ba54 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -855,7 +855,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 	if (!p) {
 		return ret;
 	} else {
-		if (boot_cpu_data.microcode == p->patch_id)
+		if (boot_cpu_data.microcode >= p->patch_id)
 			return ret;
 
 		ret = UCODE_NEW;
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 1cabe6fd8e11..4a06c37b9cf1 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_X86_RESCTRL)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_X86_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 0d5efa34f359..53917a3ebf94 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..9d5c75f02295 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -595,7 +595,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		return;
 	}
 
-	addr = desc.base0 | (desc.base1 << 16) | (desc.base2 << 24);
+	addr = desc.base0 | (desc.base1 << 16) | ((unsigned long)desc.base2 << 24);
 #ifdef CONFIG_X86_64
 	addr |= ((u64)desc.base3 << 32);
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 224666226e87..8c328b14c424 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -995,7 +995,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif

