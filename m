Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032381AbeBOAp6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:45:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53562 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOAp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:45:56 -0500
X-Google-Smtp-Source: AH8x227cnMuXS6r/RvsAlDUBeprANIETE33YPbFbDJGYzhNfMNbZZFiZfQ2JufPcUI5FFYYdfkOqCA==
Date: Thu, 15 Feb 2018 01:45:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20180215004551.22jnlxsf3xqpyrmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: fd0e786d9d09024f67bd71ec094b110237dc3840 x86/mm, mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages

Misc fixes all across the map:

 - /proc/kcore vsyscall related fixes
 - LTO fix
 - build warning fix
 - CPU hotplug fix
 - Kconfig NR_CPUS cleanups
 - cpu_has() cleanups/robustification
 - .gitignore fix
 - memory-failure unmapping fix
 - UV platform fix

  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  fs/proc/kcore.c                    # 595dd46ebfc1: vfs/proc/kcore, x86/mm/kcore
  include/linux/kcore.h              # 595dd46ebfc1: vfs/proc/kcore, x86/mm/kcore
  include/linux/mm_inline.h          # fd0e786d9d09: x86/mm, mm/hwpoison: Don't u
  mm/memory-failure.c                # fd0e786d9d09: x86/mm, mm/hwpoison: Don't u

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/error_inject: Make just_return_func() globally visible

Borislav Petkov (1):
      x86/MCE: Fix build warning introduced by "x86: do not use print_symbol()"

Ingo Molnar (1):
      x86/Kconfig: Further simplify the NR_CPUS config

Jia Zhang (2):
      vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page
      x86/mm/kcore: Add vsyscall page to /proc/kcore conditionally

Masayoshi Mizuma (1):
      x86/smpboot: Fix uncore_pci_remove() indexing bug when hot-removing a physical CPU

Peter Zijlstra (2):
      x86/cpufeature: Reindent _static_cpu_has()
      x86/cpufeature: Update _static_cpu_has() to use all named variables

Progyan Bhattacharya (1):
      x86/build: Add arch/x86/tools/insn_decoder_test to .gitignore

Randy Dunlap (1):
      x86/Kconfig: Simplify NR_CPUS config

Tony Luck (1):
      x86/mm, mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages

mike.travis@hpe.com (1):
      x86/platform/UV: Fix GAM Range Table entries less than 1GB


 arch/x86/.gitignore                       |  1 +
 arch/x86/Kconfig                          | 75 ++++++++++++++++++++++-------
 arch/x86/include/asm/cpufeature.h         | 79 ++++++++++++++++---------------
 arch/x86/include/asm/page_64.h            |  4 --
 arch/x86/kernel/apic/x2apic_uv_x.c        | 15 ++++--
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 15 ++++++
 arch/x86/kernel/cpu/mcheck/mce.c          | 19 +++++---
 arch/x86/kernel/smpboot.c                 |  1 -
 arch/x86/lib/error-inject.c               |  1 +
 arch/x86/mm/init_64.c                     |  4 +-
 fs/proc/kcore.c                           |  4 ++
 include/linux/kcore.h                     |  1 +
 include/linux/mm_inline.h                 |  6 ---
 mm/memory-failure.c                       |  2 -
 14 files changed, 146 insertions(+), 81 deletions(-)

diff --git a/arch/x86/.gitignore b/arch/x86/.gitignore
index aff152c87cf4..5a82bac5e0bc 100644
--- a/arch/x86/.gitignore
+++ b/arch/x86/.gitignore
@@ -1,6 +1,7 @@
 boot/compressed/vmlinux
 tools/test_get_len
 tools/insn_sanity
+tools/insn_decoder_test
 purgatory/kexec-purgatory.c
 purgatory/purgatory.ro
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 63bf349b2b24..a528c14d45a5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -423,12 +423,6 @@ config X86_MPPARSE
 	  For old smp systems that do not have proper acpi support. Newer systems
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
-config X86_BIGSMP
-	bool "Support for big SMP systems with more than 8 CPUs"
-	depends on X86_32 && SMP
-	---help---
-	  This option is needed for the systems that have more than 8 CPUs
-
 config GOLDFISH
        def_bool y
        depends on X86_GOLDFISH
@@ -460,6 +454,12 @@ config INTEL_RDT
 	  Say N if unsure.
 
 if X86_32
+config X86_BIGSMP
+	bool "Support for big SMP systems with more than 8 CPUs"
+	depends on SMP
+	---help---
+	  This option is needed for the systems that have more than 8 CPUs
+
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
 	default y
@@ -949,25 +949,66 @@ config MAXSMP
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
 
+#
+# The maximum number of CPUs supported:
+#
+# The main config value is NR_CPUS, which defaults to NR_CPUS_DEFAULT,
+# and which can be configured interactively in the
+# [NR_CPUS_RANGE_BEGIN ... NR_CPUS_RANGE_END] range.
+#
+# The ranges are different on 32-bit and 64-bit kernels, depending on
+# hardware capabilities and scalability features of the kernel.
+#
+# ( If MAXSMP is enabled we just use the highest possible value and disable
+#   interactive configuration. )
+#
+
+config NR_CPUS_RANGE_BEGIN
+	int
+	default NR_CPUS_RANGE_END if MAXSMP
+	default    1 if !SMP
+	default    2
+
+config NR_CPUS_RANGE_END
+	int
+	depends on X86_32
+	default   64 if  SMP &&  X86_BIGSMP
+	default    8 if  SMP && !X86_BIGSMP
+	default    1 if !SMP
+
+config NR_CPUS_RANGE_END
+	int
+	depends on X86_64
+	default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
+	default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
+	default    1 if !SMP
+
+config NR_CPUS_DEFAULT
+	int
+	depends on X86_32
+	default   32 if  X86_BIGSMP
+	default    8 if  SMP
+	default    1 if !SMP
+
+config NR_CPUS_DEFAULT
+	int
+	depends on X86_64
+	default 8192 if  MAXSMP
+	default   64 if  SMP
+	default    1 if !SMP
+
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP && !MAXSMP
-	range 2 8 if SMP && X86_32 && !X86_BIGSMP
-	range 2 64 if SMP && X86_32 && X86_BIGSMP
-	range 2 512 if SMP && !MAXSMP && !CPUMASK_OFFSTACK && X86_64
-	range 2 8192 if SMP && !MAXSMP && CPUMASK_OFFSTACK && X86_64
-	default "1" if !SMP
-	default "8192" if MAXSMP
-	default "32" if SMP && X86_BIGSMP
-	default "8" if SMP && X86_32
-	default "64" if SMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
 	---help---
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
 	  supported value is 8192, otherwise the maximum value is 512.  The
 	  minimum value which makes sense is 2.
 
-	  This is purely to save memory - each supported CPU adds
-	  approximately eight kilobytes to the kernel image.
+	  This is purely to save memory: each supported CPU adds about 8KB
+	  to the kernel image.
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 70eddb3922ff..736771c9822e 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -148,45 +148,46 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-		asm_volatile_goto("1: jmp 6f\n"
-			 "2:\n"
-			 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
-			         "((5f-4f) - (2b-1b)),0x90\n"
-			 "3:\n"
-			 ".section .altinstructions,\"a\"\n"
-			 " .long 1b - .\n"		/* src offset */
-			 " .long 4f - .\n"		/* repl offset */
-			 " .word %P1\n"			/* always replace */
-			 " .byte 3b - 1b\n"		/* src len */
-			 " .byte 5f - 4f\n"		/* repl len */
-			 " .byte 3b - 2b\n"		/* pad len */
-			 ".previous\n"
-			 ".section .altinstr_replacement,\"ax\"\n"
-			 "4: jmp %l[t_no]\n"
-			 "5:\n"
-			 ".previous\n"
-			 ".section .altinstructions,\"a\"\n"
-			 " .long 1b - .\n"		/* src offset */
-			 " .long 0\n"			/* no replacement */
-			 " .word %P0\n"			/* feature bit */
-			 " .byte 3b - 1b\n"		/* src len */
-			 " .byte 0\n"			/* repl len */
-			 " .byte 0\n"			/* pad len */
-			 ".previous\n"
-			 ".section .altinstr_aux,\"ax\"\n"
-			 "6:\n"
-			 " testb %[bitnum],%[cap_byte]\n"
-			 " jnz %l[t_yes]\n"
-			 " jmp %l[t_no]\n"
-			 ".previous\n"
-			 : : "i" (bit), "i" (X86_FEATURE_ALWAYS),
-			     [bitnum] "i" (1 << (bit & 7)),
-			     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
-			 : : t_yes, t_no);
-	t_yes:
-		return true;
-	t_no:
-		return false;
+	asm_volatile_goto("1: jmp 6f\n"
+		 "2:\n"
+		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
+			 "((5f-4f) - (2b-1b)),0x90\n"
+		 "3:\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 4f - .\n"		/* repl offset */
+		 " .word %P[always]\n"		/* always replace */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 5f - 4f\n"		/* repl len */
+		 " .byte 3b - 2b\n"		/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_replacement,\"ax\"\n"
+		 "4: jmp %l[t_no]\n"
+		 "5:\n"
+		 ".previous\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 0\n"			/* no replacement */
+		 " .word %P[feature]\n"		/* feature bit */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 0\n"			/* repl len */
+		 " .byte 0\n"			/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_aux,\"ax\"\n"
+		 "6:\n"
+		 " testb %[bitnum],%[cap_byte]\n"
+		 " jnz %l[t_yes]\n"
+		 " jmp %l[t_no]\n"
+		 ".previous\n"
+		 : : [feature]  "i" (bit),
+		     [always]   "i" (X86_FEATURE_ALWAYS),
+		     [bitnum]   "i" (1 << (bit & 7)),
+		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+		 : : t_yes, t_no);
+t_yes:
+	return true;
+t_no:
+	return false;
 }
 
 #define static_cpu_has(bit)					\
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4baa6bceb232..d652a3808065 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -52,10 +52,6 @@ static inline void clear_page(void *page)
 
 void copy_page(void *to, void *from);
 
-#ifdef CONFIG_X86_MCE
-#define arch_unmap_kpfn arch_unmap_kpfn
-#endif
-
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 46b675aaf20b..f11910b44638 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1176,16 +1176,25 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 
 	uv_gre_table = gre;
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
+		unsigned long size = ((unsigned long)(gre->limit - lgre)
+					<< UV_GAM_RANGE_SHFT);
+		int order = 0;
+		char suffix[] = " KMGTPE";
+
+		while (size > 9999 && order < sizeof(suffix)) {
+			size /= 1024;
+			order++;
+		}
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
 			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5luG %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			((unsigned long)(gre->limit - lgre)) >>
-				(30 - UV_GAM_RANGE_SHFT), /* 64M -> 1G */
+			size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
 		lgre = gre->limit;
diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mcheck/mce-internal.h
index aa0d5df9dc60..e956eb267061 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -115,4 +115,19 @@ static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
 
 extern struct mca_config mca_cfg;
 
+#ifndef CONFIG_X86_64
+/*
+ * On 32-bit systems it would be difficult to safely unmap a poison page
+ * from the kernel 1:1 map because there are no non-canonical addresses that
+ * we can use to refer to the address without risking a speculative access.
+ * However, this isn't much of an issue because:
+ * 1) Few unmappable pages are in the 1:1 map. Most are in HIGHMEM which
+ *    are only mapped into the kernel as needed
+ * 2) Few people would run a 32-bit kernel on a machine that supports
+ *    recoverable errors because they have too much memory to boot 32-bit.
+ */
+static inline void mce_unmap_kpfn(unsigned long pfn) {}
+#define mce_unmap_kpfn mce_unmap_kpfn
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3a8e88a611eb..8ff94d1e2dce 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -105,6 +105,10 @@ static struct irq_work mce_irq_work;
 
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn);
+#endif
+
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -234,7 +238,7 @@ static void __print_mce(struct mce *m)
 			m->cs, m->ip);
 
 		if (m->cs == __KERNEL_CS)
-			pr_cont("{%pS}", (void *)m->ip);
+			pr_cont("{%pS}", (void *)(unsigned long)m->ip);
 		pr_cont("\n");
 	}
 
@@ -590,7 +594,8 @@ static int srao_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
 		pfn = mce->addr >> PAGE_SHIFT;
-		memory_failure(pfn, 0);
+		if (!memory_failure(pfn, 0))
+			mce_unmap_kpfn(pfn);
 	}
 
 	return NOTIFY_OK;
@@ -1057,12 +1062,13 @@ static int do_memory_failure(struct mce *m)
 	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
 	if (ret)
 		pr_err("Memory error not recovered");
+	else
+		mce_unmap_kpfn(m->addr >> PAGE_SHIFT);
 	return ret;
 }
 
-#if defined(arch_unmap_kpfn) && defined(CONFIG_MEMORY_FAILURE)
-
-void arch_unmap_kpfn(unsigned long pfn)
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 
@@ -1073,7 +1079,7 @@ void arch_unmap_kpfn(unsigned long pfn)
 	 * We would like to just call:
 	 *	set_memory_np((unsigned long)pfn_to_kaddr(pfn), 1);
 	 * but doing that would radically increase the odds of a
-	 * speculative access to the posion page because we'd have
+	 * speculative access to the poison page because we'd have
 	 * the virtual address of the kernel 1:1 mapping sitting
 	 * around in registers.
 	 * Instead we get tricky.  We create a non-canonical address
@@ -1098,7 +1104,6 @@ void arch_unmap_kpfn(unsigned long pfn)
 
 	if (set_memory_np(decoy_addr, 1))
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-
 }
 #endif
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6f27facbaa9b..cfc61e1d45e2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1430,7 +1430,6 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-	c->phys_proc_id = 0;
 	c->cpu_core_id = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 7b881d03d0dd..3cdf06128d13 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -7,6 +7,7 @@ asmlinkage void just_return_func(void);
 
 asm(
 	".type just_return_func, @function\n"
+	".globl just_return_func\n"
 	"just_return_func:\n"
 	"	ret\n"
 	".size just_return_func, .-just_return_func\n"
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1ab42c852069..8ba9c3128947 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1193,8 +1193,8 @@ void __init mem_init(void)
 	register_page_bootmem_info();
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+	if (get_gate_vma(&init_mm))
+		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e8a93bc8285d..d1e82761de81 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -510,6 +510,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz))
 				return -EFAULT;
+		} else if (m->type == KCORE_USER) {
+			/* User page is handled prior to normal kernel page: */
+			if (copy_to_user(buffer, (char *)start, tsz))
+				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
 				/*
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 7ff25a808fef..80db19d3a505 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -10,6 +10,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index c30b32e3c862..10191c28fc04 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -127,10 +127,4 @@ static __always_inline enum lru_list page_lru(struct page *page)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
 
-#ifdef arch_unmap_kpfn
-extern void arch_unmap_kpfn(unsigned long pfn);
-#else
-static __always_inline void arch_unmap_kpfn(unsigned long pfn) { }
-#endif
-
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4b80ccee4535..8291b75f42c8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1139,8 +1139,6 @@ int memory_failure(unsigned long pfn, int flags)
 		return 0;
 	}
 
-	arch_unmap_kpfn(pfn);
-
 	orig_head = hpage = compound_head(p);
 	num_poisoned_pages_inc();
 
