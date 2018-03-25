Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCYJRt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 05:17:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40865 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbeCYJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 05:17:47 -0400
X-Google-Smtp-Source: AIpwx49rlNYindon5qCE2za69HeVaH7AIC9F6aCsQfM1J9t+Q0mn6i0E+yYi24cYtxvPwlCpnf0Nrg==
Date: Sun, 25 Mar 2018 11:17:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86 and PTI fixes
Message-ID: <20180325091742.7cu77urjb7j6b6pg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

   # HEAD: d8ba61ba58c88d5207c1ba2f7d9a2280e7d03be9 x86/entry/64: Don't use IST entry for #BP stack

Misc fixes:

 - fix EFI pagetables freeing
 - fix vsyscall pagetable setting on Xen PV guests
 - remove ancient CONFIG_X86_PPRO_FENCE=y - x86 is TSO again
 - fix two binutils (ld) development version related incompatibilities
 - clean up breakpoint handling
 - fix an x86 self-test

 Thanks,

	Ingo

------------------>
Andy Lutomirski (2):
      selftests/x86/ptrace_syscall: Fix for yet more glibc interference
      x86/entry/64: Don't use IST entry for #BP stack

Boris Ostrovsky (1):
      x86/vsyscall/64: Use proper accessor to update P4D entry

Christoph Hellwig (1):
      x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk

H.J. Lu (2):
      x86/build/64: Force the linker to use 2MB page size
      x86/boot/64: Verify alignment of the LOAD segment

Waiman Long (1):
      x86/efi: Free efi_pgd with free_pages()


 arch/x86/Kconfig.cpu                         | 13 ------------
 arch/x86/Makefile                            |  9 +++++++++
 arch/x86/boot/compressed/misc.c              |  4 ++++
 arch/x86/entry/entry_64.S                    |  2 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c  |  2 --
 arch/x86/entry/vsyscall/vsyscall_64.c        |  2 +-
 arch/x86/include/asm/barrier.h               | 30 ----------------------------
 arch/x86/include/asm/io.h                    | 15 --------------
 arch/x86/kernel/idt.c                        |  2 --
 arch/x86/kernel/pci-nommu.c                  | 19 ------------------
 arch/x86/kernel/traps.c                      | 15 +++++++-------
 arch/x86/platform/efi/efi_64.c               |  2 +-
 arch/x86/um/asm/barrier.h                    |  4 ----
 tools/testing/selftests/x86/ptrace_syscall.c |  8 ++++++--
 14 files changed, 30 insertions(+), 97 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 65a9a4716e34..f0c5ef578153 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -315,19 +315,6 @@ config X86_L1_CACHE_SHIFT
 	default "4" if MELAN || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
-config X86_PPRO_FENCE
-	bool "PentiumPro memory ordering errata workaround"
-	depends on M686 || M586MMX || M586TSC || M586 || M486 || MGEODEGX1
-	---help---
-	  Old PentiumPro multiprocessor systems had errata that could cause
-	  memory operations to violate the x86 ordering standard in rare cases.
-	  Enabling this option will attempt to work around some (but not all)
-	  occurrences of this problem, at the cost of much heavier spinlock and
-	  memory barrier operations.
-
-	  If unsure, say n here. Even distro kernels should think twice before
-	  enabling this: there are few systems, and an unlikely bug.
-
 config X86_F00F_BUG
 	def_bool y
 	depends on M586MMX || M586TSC || M586 || M486
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 498c1b812300..1c4d012550ec 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -223,6 +223,15 @@ KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr)
 
 LDFLAGS := -m elf_$(UTS_MACHINE)
 
+#
+# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
+# the linker to force 2MB page size regardless of the default page size used
+# by the linker.
+#
+ifdef CONFIG_X86_64
+LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
+endif
+
 # Speed up the build
 KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 98761a1576ce..252fee320816 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -309,6 +309,10 @@ static void parse_elf(void *output)
 
 		switch (phdr->p_type) {
 		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
 #ifdef CONFIG_RELOCATABLE
 			dest = output;
 			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d5c7f18f79ac..9b114675fbc0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1138,7 +1138,7 @@ apicinterrupt3 HYPERV_REENLIGHTENMENT_VECTOR \
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 7780bbfb06ef..9242b28418d5 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -5,8 +5,6 @@
 #undef CONFIG_OPTIMIZE_INLINING
 #endif
 
-#undef CONFIG_X86_PPRO_FENCE
-
 #ifdef CONFIG_X86_64
 
 /*
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 8560ef68a9d6..317be365bce3 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -347,7 +347,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
 #if CONFIG_PGTABLE_LEVELS >= 5
-	p4d->p4d |= _PAGE_USER;
+	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
 #endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index e1259f043ae9..042b5e892ed1 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -52,11 +52,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
 					   "lfence", X86_FEATURE_LFENCE_RDTSC)
 
-#ifdef CONFIG_X86_PPRO_FENCE
-#define dma_rmb()	rmb()
-#else
 #define dma_rmb()	barrier()
-#endif
 #define dma_wmb()	barrier()
 
 #ifdef CONFIG_X86_32
@@ -68,30 +64,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
 
-#if defined(CONFIG_X86_PPRO_FENCE)
-
-/*
- * For this option x86 doesn't have a strong TSO memory
- * model and we should fall back to full barriers.
- */
-
-#define __smp_store_release(p, v)					\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	__smp_mb();							\
-	WRITE_ONCE(*p, v);						\
-} while (0)
-
-#define __smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	__smp_mb();							\
-	___p1;								\
-})
-
-#else /* regular x86 TSO memory ordering */
-
 #define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
@@ -107,8 +79,6 @@ do {									\
 	___p1;								\
 })
 
-#endif
-
 /* Atomic operations are already serializing on x86 */
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 95e948627fd0..f6e5b9375d8c 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -232,21 +232,6 @@ extern void set_iounmap_nonlazy(void);
  */
 #define __ISA_IO_base ((char __iomem *)(PAGE_OFFSET))
 
-/*
- *	Cache management
- *
- *	This needed for two cases
- *	1. Out of order aware processors
- *	2. Accidentally out of order processors (PPro errata #51)
- */
-
-static inline void flush_write_buffers(void)
-{
-#if defined(CONFIG_X86_PPRO_FENCE)
-	asm volatile("lock; addl $0,0(%%esp)": : :"memory");
-#endif
-}
-
 #endif /* __KERNEL__ */
 
 extern void native_io_delay(void);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 56d99be3706a..50bee5fe1140 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -160,7 +160,6 @@ static const __initconst struct idt_data early_pf_idts[] = {
  */
 static const __initconst struct idt_data dbg_idts[] = {
 	INTG(X86_TRAP_DB,	debug),
-	INTG(X86_TRAP_BP,	int3),
 };
 #endif
 
@@ -183,7 +182,6 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	debug,		DEBUG_STACK),
 	ISTG(X86_TRAP_NMI,	nmi,		NMI_STACK),
-	SISTG(X86_TRAP_BP,	int3,		DEBUG_STACK),
 	ISTG(X86_TRAP_DF,	double_fault,	DOUBLEFAULT_STACK),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	&machine_check,	MCE_STACK),
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index 618285e475c6..ac7ea3a8242f 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -37,7 +37,6 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	WARN_ON(size == 0);
 	if (!check_addr("map_single", dev, bus, size))
 		return NOMMU_MAPPING_ERROR;
-	flush_write_buffers();
 	return bus;
 }
 
@@ -72,25 +71,9 @@ static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
 			return 0;
 		s->dma_length = s->length;
 	}
-	flush_write_buffers();
 	return nents;
 }
 
-static void nommu_sync_single_for_device(struct device *dev,
-			dma_addr_t addr, size_t size,
-			enum dma_data_direction dir)
-{
-	flush_write_buffers();
-}
-
-
-static void nommu_sync_sg_for_device(struct device *dev,
-			struct scatterlist *sg, int nelems,
-			enum dma_data_direction dir)
-{
-	flush_write_buffers();
-}
-
 static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == NOMMU_MAPPING_ERROR;
@@ -101,8 +84,6 @@ const struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
-	.sync_single_for_device = nommu_sync_single_for_device,
-	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
 	.mapping_error		= nommu_mapping_error,
 	.dma_supported		= x86_dma_supported,
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3d9b2308e7fa..03f3d7695dac 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -577,7 +577,6 @@ do_general_protection(struct pt_regs *regs, long error_code)
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -592,6 +591,13 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	if (poke_int3_handler(regs))
 		return;
 
+	/*
+	 * Use ist_enter despite the fact that we don't use an IST stack.
+	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
+	 * mode or even during context tracking state changes.
+	 *
+	 * This means that we can't schedule.  That's okay.
+	 */
 	ist_enter(regs);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
@@ -609,15 +615,10 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
 	cond_local_irq_enable(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
 	cond_local_irq_disable(regs);
-	debug_stack_usage_dec();
+
 exit:
 	ist_exit(regs);
 }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index c310a8284358..f9cfbc0d1f33 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -227,7 +227,7 @@ int __init efi_alloc_page_tables(void)
 	if (!pud) {
 		if (CONFIG_PGTABLE_LEVELS > 4)
 			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_page((unsigned long)efi_pgd);
+		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
 	}
 
diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index b7d73400ea29..f31e5d903161 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -30,11 +30,7 @@
 
 #endif /* CONFIG_X86_32 */
 
-#ifdef CONFIG_X86_PPRO_FENCE
-#define dma_rmb()	rmb()
-#else /* CONFIG_X86_PPRO_FENCE */
 #define dma_rmb()	barrier()
-#endif /* CONFIG_X86_PPRO_FENCE */
 #define dma_wmb()	barrier()
 
 #include <asm-generic/barrier.h>
diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 1ae1c5a7392e..6f22238f3217 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -183,8 +183,10 @@ static void test_ptrace_syscall_restart(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will make one syscall\n");
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
 		_exit(0);
@@ -301,9 +303,11 @@ static void test_restart_under_ptrace(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will take a nap until signaled\n");
 		setsigign(SIGUSR1, SA_RESTART);
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_pause, 0, 0, 0, 0, 0, 0);
 		_exit(0);
