Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528BC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABEB2098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABEB2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHZNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 09:21:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeHZNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 09:21:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftrW1-0000H6-CE; Sun, 26 Aug 2018 11:39:25 +0200
Subject: [GIT pull] x86 updates for 4.19
Message-ID: <153527451524.1785.7313731649360975643.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
Date:   Sun, 26 Aug 2018 11:39:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A pile of x86 fixes:

 - Correct the L!TF fallout on 32bit and the off by one in the 'too much
   RAM for protection' calculation.

 - Add a helpful kernel message for the 'too much RAM' case

 - Unbreak the VDSO in case that the compiler desides to use indirect
   jumps/calls and emits retpolines which cannot be resolved because the
   kernel uses its own thunks, which does not work for the VDSO. Make it
   use the builtin thunks.

 - Re-export start_thread() which was unexported when the 32/64bit
   implementation was unified. start_thread() is required by modular binfmt
   handlers.

 - Trivial cleanups

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/vdso: Fix vDSO build if a retpoline is emitted

Arnd Bergmann (1):
      x86/mce: Add notifier_block forward declaration

Josh Poimboeuf (1):
      x86/kvm/vmx: Remove duplicate l1d flush definitions

Rian Hunter (1):
      x86/process: Re-export start_thread()

Vlastimil Babka (3):
      x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
      x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM
      x86/speculation/l1tf: Suggest what to do on systems with too much RAM


 Makefile                         | 4 ++++
 arch/x86/entry/vdso/Makefile     | 6 ++++--
 arch/x86/include/asm/mce.h       | 1 +
 arch/x86/include/asm/processor.h | 4 ++--
 arch/x86/kernel/cpu/bugs.c       | 4 ++++
 arch/x86/kernel/process_64.c     | 1 +
 arch/x86/kvm/vmx.c               | 3 ---
 arch/x86/mm/init.c               | 4 ++--
 arch/x86/mm/mmap.c               | 2 +-
 9 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index a0650bf79606..7bab2e90e4e1 100644
--- a/Makefile
+++ b/Makefile
@@ -507,9 +507,13 @@ KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
 RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
 export RETPOLINE_CFLAGS
+export RETPOLINE_VDSO_CFLAGS
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 9f695f517747..fa3f439f0a92 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -68,9 +68,9 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
-       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
+       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -132,11 +132,13 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
 $(obj)/vdso32.so.dbg: FORCE \
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8c7b3e5a2d01..3a17107594c8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -148,6 +148,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_LOWEST		= 0,
 };
 
+struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 682286aca881..c24297268ebc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -181,9 +181,9 @@ extern const struct seq_operations cpuinfo_op;
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
 
-static inline unsigned long l1tf_pfn_limit(void)
+static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb4a16292aa7..4c2313d0b9ca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -702,6 +702,10 @@ static void __init l1tf_select_mitigation(void)
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
+		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
+				half_pa);
+		pr_info("However, doing so will make a part of your RAM unusable.\n");
+		pr_info("Reading https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html might help you decide.\n");
 		return;
 	}
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 476e3ddf8890..a451bc374b9b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -384,6 +384,7 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
 void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 46b428c0990e..4be481c72f60 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9726,9 +9726,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
  * information but as all relevant affected CPUs have 32KiB L1D cache size
  * there is no point in doing so.
  */
-#define L1D_CACHE_ORDER 4
-static void *vmx_l1d_flush_pages;
-
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index acfab322fbe0..63a6f9fcaf20 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -923,7 +923,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit();
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
@@ -931,7 +931,7 @@ unsigned long max_swapfile_size(void)
 #if CONFIG_PGTABLE_LEVELS > 2
 		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
 #endif
-		pages = min_t(unsigned long, l1tf_limit, pages);
+		pages = min_t(unsigned long long, l1tf_limit, pages);
 	}
 	return pages;
 }
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index f40ab8185d94..1e95d57760cf 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -257,7 +257,7 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 	/* If it's real memory always allow */
 	if (pfn_valid(pfn))
 		return true;
-	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
+	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
 		return false;
 	return true;
 }

