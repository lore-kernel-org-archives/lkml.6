Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34301C43143
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D335A2077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D335A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeIBNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:44:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53961 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeIBNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:44:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwOgi-0008MU-4s; Sun, 02 Sep 2018 11:28:56 +0200
Subject: [GIT pull] x86 updates for 4.19
Message-ID: <153588048102.6192.3931925349692168658.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <153588048102.6192.18075264253310979408.tglx@nanos.tec.linutronix.de>
Date:   Sun, 02 Sep 2018 11:28:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus


x86 specific updates for 4.19:

 Speculation:
 
  - Make the micro code check more robust

  - Make the L1TF memory limit depend on the internal cache physical
    address space and not on the CPUID advertised physical address space,
    which might be significantly smaller. This avoids disabling L1TF on
    machines which utilize the full physical address space.

  - Fix the GDT mapping for EFI calls on 32bit PTI

  - Fix the MCE nospec implementation to prevent #GP

 Fixes and robustness:
 
  - Use the proper operand order for LSL in the VDSO

  - Prevent NMI uaccess race against CR3 switching

  - Add a lockdep check to verify that text_mutex is held in text_poke()
    functions

  - Repair the fallout of giving native_restore_fl() a prototype

  - Prevent kernel memory dumps based on usermode RIP

  - Wipe KASAN shadow stack before rewinding the stack to prevent false
    positives

  - Move the AMS GOTO enforcement to the actual build stage to allow user
    API header extraction without a compiler

  - Fix a section mismatch introduced by the on demand VDSO mapping change

 Miscelaneous:
 
  - Trivial typo, GCC quirk removal and CC_SET/OUT() cleanups.

Thanks,

	tglx

------------------>
Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andy Lutomirski (1):
      x86/nmi: Fix NMI uaccess race against CR3 switching

Ben Hutchings (1):
      x86: Allow generating user-space headers without a compiler

Jann Horn (2):
      x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()
      x86/dumpstack: Don't dump kernel memory based on usermode RIP

Jiri Kosina (1):
      x86/alternatives: Lockdep-enforce text_mutex in text_poke*()

Joerg Roedel (1):
      x86/efi: Load fixmap GDT in efi_call_phys_epilog()

Masahiro Yamada (1):
      x86/build: Remove jump label quirk for GCC older than 4.5.2

Nick Desaulniers (1):
      x86/irqflags: Mark native_restore_fl extern inline

Nikolas Nyby (1):
      x86/Kconfig: Fix trivial typo

Randy Dunlap (1):
      x86/pti: Fix section mismatch warning/error

Samuel Neves (1):
      x86/vdso: Fix lsl operand order

Tony Luck (1):
      x86/mce: Fix set_mce_nospec() to avoid #GP fault

Uros Bizjak (1):
      x86/asm: Use CC_SET()/CC_OUT() in __gen_sigismember()


 arch/x86/Kconfig                  |  2 +-
 arch/x86/Makefile                 | 23 ++++++--------------
 arch/x86/events/core.c            |  2 +-
 arch/x86/include/asm/irqflags.h   |  3 ++-
 arch/x86/include/asm/processor.h  |  4 +++-
 arch/x86/include/asm/signal.h     |  7 +++---
 arch/x86/include/asm/stacktrace.h |  2 +-
 arch/x86/include/asm/tlbflush.h   | 40 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vgtod.h      |  2 +-
 arch/x86/kernel/alternative.c     |  9 ++++----
 arch/x86/kernel/cpu/bugs.c        | 46 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/common.c      |  1 +
 arch/x86/kernel/cpu/intel.c       |  3 +++
 arch/x86/kernel/dumpstack.c       | 20 ++++++++++++++---
 arch/x86/lib/usercopy.c           |  5 +++++
 arch/x86/mm/fault.c               |  2 +-
 arch/x86/mm/pageattr.c            | 25 ++++++++++++++++++++-
 arch/x86/mm/pti.c                 |  2 +-
 arch/x86/mm/tlb.c                 |  7 ++++++
 arch/x86/platform/efi/efi_32.c    |  8 ++-----
 scripts/Kbuild.include            |  4 ----
 21 files changed, 167 insertions(+), 50 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5ff296bc5d1..1a0be022f91d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2843,7 +2843,7 @@ config X86_SYSFB
 	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
 	  framebuffers so the new generic system-framebuffer drivers can be
 	  used on x86. If the framebuffer is not compatible with the generic
-	  modes, it is adverticed as fallback platform framebuffer so legacy
+	  modes, it is advertised as fallback platform framebuffer so legacy
 	  drivers like efifb, vesafb and uvesafb can pick it up.
 	  If this option is not selected, all system framebuffers are always
 	  marked as fallback platform framebuffers as usual.
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94859241bc3e..8f6e7eb8ae9f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -175,22 +175,6 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 
-ifndef CC_HAVE_ASM_GOTO
-  $(error Compiler lacks asm-goto support.)
-endif
-
-#
-# Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
-# GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
-# to test for this bug at compile-time because the test case needs to execute,
-# which is a no-go for cross compilers.  So check the GCC version instead.
-#
-ifdef CONFIG_JUMP_LABEL
-  ifneq ($(ACCUMULATE_OUTGOING_ARGS), 1)
-	ACCUMULATE_OUTGOING_ARGS = $(call cc-if-fullversion, -lt, 040502, 1)
-  endif
-endif
-
 ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	# This compiler flag is not supported by Clang:
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
@@ -312,6 +296,13 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/vdso $@
 
+archprepare: checkbin
+checkbin:
+ifndef CC_HAVE_ASM_GOTO
+	@echo Compiler lacks asm-goto support.
+	@exit 1
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f10129..dfb2f7c0d019 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2465,7 +2465,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 
 	perf_callchain_store(entry, regs->ip);
 
-	if (!current->mm)
+	if (!nmi_uaccess_okay())
 		return;
 
 	if (perf_callchain_user32(regs, entry))
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c14f2a74b2be..15450a675031 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -33,7 +33,8 @@ extern inline unsigned long native_save_fl(void)
 	return flags;
 }
 
-static inline void native_restore_fl(unsigned long flags)
+extern inline void native_restore_fl(unsigned long flags);
+extern inline void native_restore_fl(unsigned long flags)
 {
 	asm volatile("push %0 ; popf"
 		     : /* no output */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c24297268ebc..d53c54b842da 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -132,6 +132,8 @@ struct cpuinfo_x86 {
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
+	/* Address space bits used by the cache internally */
+	u8			x86_cache_bits;
 	unsigned		initialized : 1;
 } __randomize_layout;
 
@@ -183,7 +185,7 @@ extern void cpu_detect(struct cpuinfo_x86 *c);
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 5f9012ff52ed..33d3c88a7225 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -39,6 +39,7 @@ extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
+#include <asm/asm.h>
 #include <uapi/asm/sigcontext.h>
 
 #ifdef __i386__
@@ -86,9 +87,9 @@ static inline int __const_sigismember(sigset_t *set, int _sig)
 
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
-	unsigned char ret;
-	asm("btl %2,%1\n\tsetc %0"
-	    : "=qm"(ret) : "m"(*set), "Ir"(_sig-1) : "cc");
+	bool ret;
+	asm("btl %2,%1" CC_SET(c)
+	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
 
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index b6dc698f992a..f335aad404a4 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
-void show_opcodes(u8 *rip, const char *loglvl);
+void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 29c9da6c62fc..58ce5288878e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -175,8 +175,16 @@ struct tlb_state {
 	 * are on.  This means that it may not match current->active_mm,
 	 * which will contain the previous user mm when we're in lazy TLB
 	 * mode even if we've already switched back to swapper_pg_dir.
+	 *
+	 * During switch_mm_irqs_off(), loaded_mm will be set to
+	 * LOADED_MM_SWITCHING during the brief interrupts-off window
+	 * when CR3 and loaded_mm would otherwise be inconsistent.  This
+	 * is for nmi_uaccess_okay()'s benefit.
 	 */
 	struct mm_struct *loaded_mm;
+
+#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
+
 	u16 loaded_mm_asid;
 	u16 next_asid;
 	/* last user mm's ctx id */
@@ -246,6 +254,38 @@ struct tlb_state {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 
+/*
+ * Blindly accessing user memory from NMI context can be dangerous
+ * if we're in the middle of switching the current user task or
+ * switching the loaded mm.  It can also be dangerous if we
+ * interrupted some kernel code that was temporarily using a
+ * different mm.
+ */
+static inline bool nmi_uaccess_okay(void)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	struct mm_struct *current_mm = current->mm;
+
+	VM_WARN_ON_ONCE(!loaded_mm);
+
+	/*
+	 * The condition we want to check is
+	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
+	 * if we're running in a VM with shadow paging, and nmi_uaccess_okay()
+	 * is supposed to be reasonably fast.
+	 *
+	 * Instead, we check the almost equivalent but somewhat conservative
+	 * condition below, and we rely on the fact that switch_mm_irqs_off()
+	 * sets loaded_mm to LOADED_MM_SWITCHING before writing to CR3.
+	 */
+	if (loaded_mm != current_mm)
+		return false;
+
+	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+
+	return true;
+}
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9f0449..53748541c487 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -93,7 +93,7 @@ static inline unsigned int __getcpu(void)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[p],%[seg]",
+	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
 			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 014f214da581..b9d5e7c9ef43 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -684,8 +684,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  * It means the size must be writable atomically and the address must be aligned
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
- *
- * Note: Must be called under text_mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
@@ -700,6 +698,8 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!after_bootmem);
 
+	lockdep_assert_held(&text_mutex);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
@@ -782,8 +782,6 @@ int poke_int3_handler(struct pt_regs *regs)
  *	- replace the first byte (int3) by the first byte of
  *	  replacing opcode
  *	- sync cores
- *
- * Note: must be called under text_mutex.
  */
 void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
@@ -792,6 +790,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	bp_int3_handler = handler;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	bp_patching_in_progress = true;
+
+	lockdep_assert_held(&text_mutex);
+
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * in_progress and handler are correctly ordered wrt. patching.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4c2313d0b9ca..40bdaea97fe7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -668,6 +668,45 @@ EXPORT_SYMBOL_GPL(l1tf_mitigation);
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
+/*
+ * These CPUs all support 44bits physical address space internally in the
+ * cache but CPUID can report a smaller number of physical address bits.
+ *
+ * The L1TF mitigation uses the top most address bit for the inversion of
+ * non present PTEs. When the installed memory reaches into the top most
+ * address bit due to memory holes, which has been observed on machines
+ * which report 36bits physical address bits and have 32G RAM installed,
+ * then the mitigation range check in l1tf_select_mitigation() triggers.
+ * This is a false positive because the mitigation is still possible due to
+ * the fact that the cache uses 44bit internally. Use the cache bits
+ * instead of the reported physical bits and adjust them on the affected
+ * machines to 44bit if the reported bits are less than 44.
+ */
+static void override_cache_bits(struct cpuinfo_x86 *c)
+{
+	if (c->x86 != 6)
+		return;
+
+	switch (c->x86_model) {
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		if (c->x86_cache_bits < 44)
+			c->x86_cache_bits = 44;
+		break;
+	}
+}
+
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -675,6 +714,8 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	override_cache_bits(&boot_cpu_data);
+
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
@@ -694,11 +735,6 @@ static void __init l1tf_select_mitigation(void)
 	return;
 #endif
 
-	/*
-	 * This is extremely unlikely to happen because almost all
-	 * systems have far more MAX_PA/2 than RAM can be fit into
-	 * DIMM slots.
-	 */
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 84dee5ab745a..44c4ef3d989b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -919,6 +919,7 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
 		c->x86_phys_bits = 36;
 #endif
+	c->x86_cache_bits = c->x86_phys_bits;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 401e8c133108..fc3c07fe7df5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -150,6 +150,9 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return false;
 
+	if (c->x86 != 6)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c8652974f8e..f56895106ccf 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/sysfs.h>
+#include <linux/kasan.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -89,14 +90,24 @@ static void printk_stack_address(unsigned long address, int reliable,
  * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
  * guesstimate in attempt to achieve all of the above.
  */
-void show_opcodes(u8 *rip, const char *loglvl)
+void show_opcodes(struct pt_regs *regs, const char *loglvl)
 {
 #define PROLOGUE_SIZE 42
 #define EPILOGUE_SIZE 21
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
+	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
+	bool bad_ip;
 
-	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	bad_ip = user_mode(regs) &&
+		__chk_range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+
+	if (bad_ip || probe_kernel_read(opcodes, (u8 *)prologue,
+					OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
@@ -112,7 +123,7 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 #else
 	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
 #endif
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 void show_iret_regs(struct pt_regs *regs)
@@ -346,7 +357,10 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	 * We're not going to return, but we might be on an IST stack or
 	 * have very little stack space left.  Rewind the stack and kill
 	 * the task.
+	 * Before we rewind the stack, we have to tell KASAN that we're going to
+	 * reuse the task stack and that existing poisons are invalid.
 	 */
+	kasan_unpoison_task_stack(current);
 	rewind_stack_do_exit(signr);
 }
 NOKPROBE_SYMBOL(oops_end);
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index c8c6ad0d58b8..3f435d7fca5e 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -7,6 +7,8 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 
+#include <asm/tlbflush.h>
+
 /*
  * We rely on the nested NMI work to allow atomic faults from the NMI path; the
  * nested NMI paths are careful to preserve CR2.
@@ -19,6 +21,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 	if (__range_not_ok(from, n, TASK_SIZE))
 		return n;
 
+	if (!nmi_uaccess_okay())
+		return n;
+
 	/*
 	 * Even though this function is typically called from NMI/IRQ context
 	 * disable pagefaults so that its behaviour is consistent even when
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..47bebfe6efa7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -837,7 +837,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 	printk(KERN_CONT "\n");
 
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 static void
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 8d6c34fe49be..51a5a69ecac9 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1420,6 +1420,29 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 	return 0;
 }
 
+/*
+ * Machine check recovery code needs to change cache mode of poisoned
+ * pages to UC to avoid speculative access logging another error. But
+ * passing the address of the 1:1 mapping to set_memory_uc() is a fine
+ * way to encourage a speculative access. So we cheat and flip the top
+ * bit of the address. This works fine for the code that updates the
+ * page tables. But at the end of the process we need to flush the cache
+ * and the non-canonical address causes a #GP fault when used by the
+ * CLFLUSH instruction.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long make_addr_canonical_again(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	return (long)(addr << 1) >> 1;
+#else
+	return addr;
+#endif
+}
+
+
 static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int force_split, int in_flag,
@@ -1465,7 +1488,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 		 * Save address for cache flush. *addr is modified in the call
 		 * to __change_page_attr_set_clr() below.
 		 */
-		baddr = *addr;
+		baddr = make_addr_canonical_again(*addr);
 	}
 
 	/* Must avoid aliasing mappings in the highmem code */
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 31341ae7309f..c1fc1ae6b429 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -248,7 +248,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9517d1b2a281..e96b99eb800c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -305,6 +305,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
+		/* Let nmi_uaccess_okay() know that we're changing CR3. */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		if (need_flush) {
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -335,6 +339,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		if (next != &init_mm)
 			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
 
+		/* Make sure we write CR3 before loaded_mm. */
+		barrier();
+
 		this_cpu_write(cpu_tlbstate.loaded_mm, next);
 		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 	}
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 324b93328b37..05ca14222463 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,14 +85,10 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
-	struct desc_ptr gdt_descr;
-
-	gdt_descr.address = (unsigned long)get_cpu_gdt_rw(0);
-	gdt_descr.size = GDT_SIZE - 1;
-	load_gdt(&gdt_descr);
-
 	load_cr3(save_pgd);
 	__flush_tlb_all();
+
+	load_fixmap_gdt(0);
 }
 
 void __init efi_runtime_update_mappings(void)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c75413d05a63..ce53639a864a 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -153,10 +153,6 @@ cc-fullversion = $(shell $(CONFIG_SHELL) \
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
 cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
 
-# cc-if-fullversion
-# Usage:  EXTRA_CFLAGS += $(call cc-if-fullversion, -lt, 040502, -O1)
-cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo $(4))
-
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
 cc-ldoption = $(call try-run,\

