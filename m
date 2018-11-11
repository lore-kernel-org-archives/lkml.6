Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A996EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675512087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675512087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeKKR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:59:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeKKR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:59:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gLkpo-00073F-Vb; Sun, 11 Nov 2018 09:11:09 +0100
Subject: [GIT pull] x86 fixes for 4.20
Message-ID: <154192381794.5458.10890229157221223080.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
Date:   Sun, 11 Nov 2018 09:11:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of x86 fixes:

  - Cure the LDT remapping to user space on 5 level paging which ended up
    in the KASLR space

  - Remove LDT mapping before freeing the LDT pages

  - Make NFIT MCE handling more robust

  - Unbreak the VSMP build by removing the dependency on paravirt ops

  - Support broken PIT emulation on  Microsoft hyperV

  - Don't trace vmware_sched_clock() to avoid tracer recursion

  - Remove -pipe from KBUILD CFLAGS which breaks clang and is also slower
    on GCC

  - Trivial coding style and typo fixes


Thanks,

	tglx

------------------>
Eial Czerwacki (1):
      x86/vsmp: Remove dependency on pv_irq_ops

Kirill A. Shutemov (3):
      x86/mm: Move LDT remap out of KASLR region on 5-level paging
      x86/ldt: Unmap PTEs for the slot before freeing LDT pages
      x86/ldt: Remove unused variable in map_ldt_struct()

Michael Kelley (2):
      clockevents/drivers/i8253: Add support for PIT shutdown quirk
      x86/hyper-v: Enable PIT shutdown quirk

Nathan Chancellor (1):
      x86/build: Remove -pipe from KBUILD_CFLAGS

Randy Dunlap (1):
      Documentation/x86: Fix typo in zero-page.txt

Steven Rostedt (VMware) (1):
      x86/cpu/vmware: Do not trace vmware_sched_clock()

Vishal Verma (2):
      acpi/nfit, x86/mce: Handle only uncorrectable machine checks
      acpi/nfit, x86/mce: Validate a MCE's address before using it

Yi Wang (1):
      x86/hyper-v: Fix indentation in hv_do_fast_hypercall16()


 Documentation/x86/x86_64/mm.txt         | 34 ++++++-------
 Documentation/x86/zero-page.txt         |  2 +-
 arch/x86/Kconfig                        |  1 -
 arch/x86/Makefile                       |  4 +-
 arch/x86/include/asm/mce.h              |  2 +
 arch/x86/include/asm/mshyperv.h         |  2 +-
 arch/x86/include/asm/page_64_types.h    | 12 +++--
 arch/x86/include/asm/pgtable_64_types.h |  4 +-
 arch/x86/kernel/cpu/mcheck/mce.c        |  6 ++-
 arch/x86/kernel/cpu/mshyperv.c          | 11 +++++
 arch/x86/kernel/cpu/vmware.c            |  2 +-
 arch/x86/kernel/ldt.c                   | 59 ++++++++++++++---------
 arch/x86/kernel/vsmp_64.c               | 84 +++------------------------------
 arch/x86/xen/mmu_pv.c                   |  6 +--
 drivers/acpi/nfit/mce.c                 |  8 +++-
 drivers/clocksource/i8253.c             | 14 +++++-
 include/linux/i8253.h                   |  1 +
 17 files changed, 114 insertions(+), 138 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 73aaaa3da436..804f9426ed17 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -34,23 +34,24 @@ __________________|____________|__________________|_________|___________________
 ____________________________________________________________|___________________________________________________________
                   |            |                  |         |
  ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
- ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
- ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
+ ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI
+ ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
+ ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole
  ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
  ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
  ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
  ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
  ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
 __________________|____________|__________________|_________|____________________________________________________________
                                                             |
-                                                            | Identical layout to the 47-bit one from here on:
+                                                            | Identical layout to the 56-bit one from here on:
 ____________________________________________________________|____________________________________________________________
                   |            |                  |         |
+ fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                  |            |                  |         | vaddr_end for KASLR
+ fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
+ fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+ ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
  ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
  ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
  ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
@@ -83,7 +84,7 @@ Notes:
 __________________|____________|__________________|_________|___________________________________________________________
                   |            |                  |         |
  0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
-                  |            |                  |         |     virtual memory addresses up to the -128 TB
+                  |            |                  |         |     virtual memory addresses up to the -64 PB
                   |            |                  |         |     starting offset of kernel mappings.
 __________________|____________|__________________|_________|___________________________________________________________
                                                             |
@@ -91,23 +92,24 @@ __________________|____________|__________________|_________|___________________
 ____________________________________________________________|___________________________________________________________
                   |            |                  |         |
  ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
- ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
- ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
+ ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI
+ ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
+ ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole
  ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
  ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
  ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
  ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
  ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
 __________________|____________|__________________|_________|____________________________________________________________
                                                             |
                                                             | Identical layout to the 47-bit one from here on:
 ____________________________________________________________|____________________________________________________________
                   |            |                  |         |
+ fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
+                  |            |                  |         | vaddr_end for KASLR
+ fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
+ fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+ ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
  ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
  ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
  ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
index 97b7adbceda4..68aed077f7b6 100644
--- a/Documentation/x86/zero-page.txt
+++ b/Documentation/x86/zero-page.txt
@@ -25,7 +25,7 @@ Offset	Proto	Name		Meaning
 0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
 140/080	ALL	edid_info	Video mode setup (struct edid_info)
 1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alk_mem_k	Alternative mem check, in KB
+1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
 1E4/004	ALL	scratch		Scratch field for the kernel setup code
 1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
 1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..9d734f3c8234 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -525,7 +525,6 @@ config X86_VSMP
 	bool "ScaleMP vSMP"
 	select HYPERVISOR_GUEST
 	select PARAVIRT
-	select PARAVIRT_XXL
 	depends on X86_64 && PCI
 	depends on X86_EXTENDED_PLATFORM
 	depends on SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b562e464009..88398fdf8129 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
-# Speed up the build
-KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -239,7 +237,7 @@ archheaders:
 archmacros:
 	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
 
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
 
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4da9b1c58d28..c1a812bd5a27 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,6 +221,8 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return mce_am
 
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
+bool mce_is_correctable(struct mce *m);
+int mce_usable_address(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d6271cce198..1d0a7778e163 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -232,7 +232,7 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 				      : "cc");
 	}
 #endif
-		return hv_status;
+	return hv_status;
 }
 
 /*
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index cd0cf1c568b4..8f657286d599 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -33,12 +33,14 @@
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
- * PGDIR_SIZE*16 (pgd slot 272).  The gap is to allow a space for a
- * hypervisor to fit.  Choosing 16 slots here is arbitrary, but it's
- * what Xen requires.
+ * PGDIR_SIZE*17 (pgd slot 273).
+ *
+ * The gap is to allow a space for LDT remap for PTI (1 pgd slot) and space for
+ * a hypervisor (16 slots). Choosing 16 slots for a hypervisor is arbitrary,
+ * but it's what Xen requires.
  */
-#define __PAGE_OFFSET_BASE_L5	_AC(0xff10000000000000, UL)
-#define __PAGE_OFFSET_BASE_L4	_AC(0xffff880000000000, UL)
+#define __PAGE_OFFSET_BASE_L5	_AC(0xff11000000000000, UL)
+#define __PAGE_OFFSET_BASE_L4	_AC(0xffff888000000000, UL)
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04edd2d58211..84bd9bdc1987 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -111,9 +111,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define MAXMEM			(1UL << MAX_PHYSMEM_BITS)
 
-#define LDT_PGD_ENTRY_L4	-3UL
-#define LDT_PGD_ENTRY_L5	-112UL
-#define LDT_PGD_ENTRY		(pgtable_l5_enabled() ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
+#define LDT_PGD_ENTRY		-240UL
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8c66d2fc8f81..36d2696c9563 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -485,7 +485,7 @@ static void mce_report_event(struct pt_regs *regs)
  * be somewhat complicated (e.g. segment offset would require an instruction
  * parser). So only support physical addresses up to page granuality for now.
  */
-static int mce_usable_address(struct mce *m)
+int mce_usable_address(struct mce *m)
 {
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
@@ -505,6 +505,7 @@ static int mce_usable_address(struct mce *m)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(mce_usable_address);
 
 bool mce_is_memory_error(struct mce *m)
 {
@@ -534,7 +535,7 @@ bool mce_is_memory_error(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
-static bool mce_is_correctable(struct mce *m)
+bool mce_is_correctable(struct mce *m)
 {
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
@@ -547,6 +548,7 @@ static bool mce_is_correctable(struct mce *m)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(mce_is_correctable);
 
 static bool cec_add_mce(struct mce *m)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 1c72f3819eb1..e81a2db42df7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -295,6 +296,16 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
+	/*
+	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
+	 * counter register during PIT shutdown restarts the PIT. So it
+	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
+	 * to false tells pit_shutdown() not to zero the counter so that
+	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
+	 * and setting this value has no effect.
+	 */
+	i8253_clear_counter_on_shutdown = false;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d9ab49bed8af..0eda91f8eeac 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -77,7 +77,7 @@ static __init int setup_vmw_sched_clock(char *s)
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
-static unsigned long long vmware_sched_clock(void)
+static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index ab18e0884dc6..6135ae8ce036 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -199,14 +199,6 @@ static void sanity_check_ldt_mapping(struct mm_struct *mm)
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
- *
- * There is no corresponding unmap function.  Even if the LDT is freed, we
- * leave the PTEs around until the slot is reused or the mm is destroyed.
- * This is harmless: the LDT is always in ordinary memory, and no one will
- * access the freed slot.
- *
- * If we wanted to unmap freed LDTs, we'd also need to do a flush to make
- * it useful, and the flush would slow down modify_ldt().
  */
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
@@ -214,8 +206,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	unsigned long va;
 	bool is_vmalloc;
 	spinlock_t *ptl;
-	pgd_t *pgd;
-	int i;
+	int i, nr_pages;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -229,16 +220,11 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Check if the current mappings are sane */
 	sanity_check_ldt_mapping(mm);
 
-	/*
-	 * Did we already have the top level entry allocated?  We can't
-	 * use pgd_none() for this because it doens't do anything on
-	 * 4-level page table kernels.
-	 */
-	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
-	for (i = 0; i * PAGE_SIZE < ldt->nr_entries * LDT_ENTRY_SIZE; i++) {
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
@@ -272,13 +258,39 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Propagate LDT mapping to the user page-table */
 	map_ldt_struct_to_user(mm);
 
-	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, PAGE_SHIFT, false);
-
 	ldt->slot = slot;
 	return 0;
 }
 
+static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+	unsigned long va;
+	int i, nr_pages;
+
+	if (!ldt)
+		return;
+
+	/* LDT map/unmap is only required for PTI */
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT;
+		spinlock_t *ptl;
+		pte_t *ptep;
+
+		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
+		ptep = get_locked_pte(mm, va, &ptl);
+		pte_clear(mm, va, ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	va = (unsigned long)ldt_slot_va(ldt->slot);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
+}
+
 #else /* !CONFIG_PAGE_TABLE_ISOLATION */
 
 static int
@@ -286,6 +298,10 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 {
 	return 0;
 }
+
+static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 static void free_ldt_pgtables(struct mm_struct *mm)
@@ -524,6 +540,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 	}
 
 	install_ldt(mm, new_ldt);
+	unmap_ldt_struct(mm, old_ldt);
 	free_ldt_struct(old_ldt);
 	error = 0;
 
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 1eae5af491c2..891a75dbc131 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -26,65 +26,8 @@
 
 #define TOPOLOGY_REGISTER_OFFSET 0x10
 
-#if defined CONFIG_PCI && defined CONFIG_PARAVIRT_XXL
-/*
- * Interrupt control on vSMPowered systems:
- * ~AC is a shadow of IF.  If IF is 'on' AC should be 'off'
- * and vice versa.
- */
-
-asmlinkage __visible unsigned long vsmp_save_fl(void)
-{
-	unsigned long flags = native_save_fl();
-
-	if (!(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC))
-		flags &= ~X86_EFLAGS_IF;
-	return flags;
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_save_fl);
-
-__visible void vsmp_restore_fl(unsigned long flags)
-{
-	if (flags & X86_EFLAGS_IF)
-		flags &= ~X86_EFLAGS_AC;
-	else
-		flags |= X86_EFLAGS_AC;
-	native_restore_fl(flags);
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_restore_fl);
-
-asmlinkage __visible void vsmp_irq_disable(void)
-{
-	unsigned long flags = native_save_fl();
-
-	native_restore_fl((flags & ~X86_EFLAGS_IF) | X86_EFLAGS_AC);
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_disable);
-
-asmlinkage __visible void vsmp_irq_enable(void)
-{
-	unsigned long flags = native_save_fl();
-
-	native_restore_fl((flags | X86_EFLAGS_IF) & (~X86_EFLAGS_AC));
-}
-PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_enable);
-
-static unsigned __init vsmp_patch(u8 type, void *ibuf,
-				  unsigned long addr, unsigned len)
-{
-	switch (type) {
-	case PARAVIRT_PATCH(irq.irq_enable):
-	case PARAVIRT_PATCH(irq.irq_disable):
-	case PARAVIRT_PATCH(irq.save_fl):
-	case PARAVIRT_PATCH(irq.restore_fl):
-		return paravirt_patch_default(type, ibuf, addr, len);
-	default:
-		return native_patch(type, ibuf, addr, len);
-	}
-
-}
-
-static void __init set_vsmp_pv_ops(void)
+#ifdef CONFIG_PCI
+static void __init set_vsmp_ctl(void)
 {
 	void __iomem *address;
 	unsigned int cap, ctl, cfg;
@@ -109,28 +52,12 @@ static void __init set_vsmp_pv_ops(void)
 	}
 #endif
 
-	if (cap & ctl & (1 << 4)) {
-		/* Setup irq ops and turn on vSMP  IRQ fastpath handling */
-		pv_ops.irq.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
-		pv_ops.irq.irq_enable = PV_CALLEE_SAVE(vsmp_irq_enable);
-		pv_ops.irq.save_fl = PV_CALLEE_SAVE(vsmp_save_fl);
-		pv_ops.irq.restore_fl = PV_CALLEE_SAVE(vsmp_restore_fl);
-		pv_ops.init.patch = vsmp_patch;
-		ctl &= ~(1 << 4);
-	}
 	writel(ctl, address + 4);
 	ctl = readl(address + 4);
 	pr_info("vSMP CTL: control set to:0x%08x\n", ctl);
 
 	early_iounmap(address, 8);
 }
-#else
-static void __init set_vsmp_pv_ops(void)
-{
-}
-#endif
-
-#ifdef CONFIG_PCI
 static int is_vsmp = -1;
 
 static void __init detect_vsmp_box(void)
@@ -164,11 +91,14 @@ static int is_vsmp_box(void)
 {
 	return 0;
 }
+static void __init set_vsmp_ctl(void)
+{
+}
 #endif
 
 static void __init vsmp_cap_cpus(void)
 {
-#if !defined(CONFIG_X86_VSMP) && defined(CONFIG_SMP)
+#if !defined(CONFIG_X86_VSMP) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 	void __iomem *address;
 	unsigned int cfg, topology, node_shift, maxcpus;
 
@@ -221,6 +151,6 @@ void __init vsmp_init(void)
 
 	vsmp_cap_cpus();
 
-	set_vsmp_pv_ops();
+	set_vsmp_ctl();
 	return;
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 0d7b3ae4960b..a5d7ed125337 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1905,7 +1905,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	init_top_pgt[0] = __pgd(0);
 
 	/* Pre-constructed entries are in pfn, so convert to mfn */
-	/* L4[272] -> level3_ident_pgt  */
+	/* L4[273] -> level3_ident_pgt  */
 	/* L4[511] -> level3_kernel_pgt */
 	convert_pfn_mfn(init_top_pgt);
 
@@ -1925,8 +1925,8 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	addr[0] = (unsigned long)pgd;
 	addr[1] = (unsigned long)l3;
 	addr[2] = (unsigned long)l2;
-	/* Graft it onto L4[272][0]. Note that we creating an aliasing problem:
-	 * Both L4[272][0] and L4[511][510] have entries that point to the same
+	/* Graft it onto L4[273][0]. Note that we creating an aliasing problem:
+	 * Both L4[273][0] and L4[511][510] have entries that point to the same
 	 * L2 (PMD) tables. Meaning that if you modify it in __va space
 	 * it will be also modified in the __ka space! (But if you just
 	 * modify the PMD table to point to other PTE's or none, then you
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index e9626bf6ca29..d6c1b10f6c25 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -25,8 +25,12 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_spa *nfit_spa;
 
-	/* We only care about memory errors */
-	if (!mce_is_memory_error(mce))
+	/* We only care about uncorrectable memory errors */
+	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
+		return NOTIFY_DONE;
+
+	/* Verify the address reported in the MCE is valid. */
+	if (!mce_usable_address(mce))
 		return NOTIFY_DONE;
 
 	/*
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895542f4..d4350bb10b83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,6 +20,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown __ro_after_init = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -109,8 +116,11 @@ static int pit_shutdown(struct clock_event_device *evt)
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	if (i8253_clear_counter_on_shutdown) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
 
 	raw_spin_unlock(&i8253_lock);
 	return 0;
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index e6bb36a97519..8336b2f6f834 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 

