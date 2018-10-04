Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEEC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8486A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8486A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:54:24 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:22186 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbeJDLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:54:24 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 22:02:46 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id AFE0D40787;
        Wed,  3 Oct 2018 22:02:53 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Date:   Wed, 3 Oct 2018 21:59:48 -0700
Message-ID: <20181004045948.129142-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC proposes to return part of the entry-area back to the fixmap to
improve system-call performance. Currently, since the entry-area is
mapped far (more than 2GB) away from the kernel text, an indirect branch
is needed to jump from the trampoline into the kernel. Due to Spectre
v2, vulnerable CPUs need to use a retpoline, which introduces an
overhead of >20 cycles.

Commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
moved the CPU entry area, as its name indicate, out of the fixmap, since
it became too big. This patch proposes to do something different: break
it into two. One part holds code+data that is needed for the entry
(trampoline code, entry stack and TSS), which is mapped in the fixmap.
The other part holds the exception_stacks, debug store and buffers, and
is left in its current (new) position.

The entry area is mapped in a different address on each CPU, so we need
to patch the relative address of the branch that jumps into the kernel.
To avoid any improper interaction with jump_labels and friends, which
might modify the entry code-page, another adjacent per-CPU code page is
used for the patched branch (and nothing else). So two direct jumps are
done on entry: one to the CPU trampoline, and then one using the patched
branch into the kernel.

Benchmarks (lmbench) show that a NULL system call is shortened from
266ns to 254ns, and others are shortened similarly. The size of the area
that is mapped into the fixmap with 8192 cores is <200MB, which is
arguably reasonable.

This RFC would probably fail on x86-32 or no PTI setups. The name
"cpu_entry_area_aux" for the second area is awful (ideas are welcomed),
it is too big to be a single patch, and the RFC is also missing some
additional parts to be a patch. It seems reasonable to ask first for
comments before putting an effort into shaping it up.

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/entry_64.S               | 34 +++++------
 arch/x86/events/intel/ds.c              | 10 ++--
 arch/x86/include/asm/cpu_entry_area.h   | 38 +++++++-----
 arch/x86/include/asm/desc.h             |  2 +-
 arch/x86/include/asm/fixmap.h           | 23 ++++++++
 arch/x86/include/asm/pgtable_32_types.h |  6 +-
 arch/x86/include/asm/pgtable_64_types.h |  6 +-
 arch/x86/kernel/cpu/common.c            |  2 +-
 arch/x86/kernel/traps.c                 |  4 +-
 arch/x86/kernel/vmlinux.lds.S           |  6 ++
 arch/x86/mm/cpu_entry_area.c            | 77 +++++++++++++++++++++----
 arch/x86/mm/dump_pagetables.c           | 16 +++--
 arch/x86/mm/kasan_init_64.c             | 33 +++++++----
 arch/x86/mm/kaslr.c                     |  6 +-
 arch/x86/mm/pti.c                       |  7 ++-
 arch/x86/xen/mmu_pv.c                   |  1 +
 16 files changed, 194 insertions(+), 77 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..093243e35615 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -142,6 +142,22 @@ END(native_usergs_sysret64)
  * with them due to bugs in both AMD and Intel CPUs.
  */
 
+	.pushsection .entry_cpu_trampoline, "ax"
+
+ENTRY(entry_rel_trampoline)
+	UNWIND_HINT_EMPTY
+	.byte 0xe9
+
+.global entry_rel_trampoline_rel
+entry_rel_trampoline_rel:
+	.long -5
+
+.global entry_rel_trampoline_end
+entry_rel_trampoline_end:
+END(entry_rel_trampoline)
+
+	.popsection
+
 	.pushsection .entry_trampoline, "ax"
 
 /*
@@ -183,26 +199,10 @@ ENTRY(entry_SYSCALL_64_trampoline)
 	pushq	$__USER_CS			/* pt_regs->cs */
 	pushq	%rcx				/* pt_regs->ip */
 
-	/*
-	 * x86 lacks a near absolute jump, and we can't jump to the real
-	 * entry text with a relative jump.  We could push the target
-	 * address and then use retq, but this destroys the pipeline on
-	 * many CPUs (wasting over 20 cycles on Sandy Bridge).  Instead,
-	 * spill RDI and restore it in a second-stage trampoline.
-	 */
-	pushq	%rdi
-	movq	$entry_SYSCALL_64_stage2, %rdi
-	JMP_NOSPEC %rdi
 END(entry_SYSCALL_64_trampoline)
-
+	jmp entry_rel_trampoline
 	.popsection
 
-ENTRY(entry_SYSCALL_64_stage2)
-	UNWIND_HINT_EMPTY
-	popq	%rdi
-	jmp	entry_SYSCALL_64_after_hwframe
-END(entry_SYSCALL_64_stage2)
-
 ENTRY(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b7b01d762d32..329724ccce42 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -360,7 +360,7 @@ static int alloc_pebs_buffer(int cpu)
 	}
 	hwev->ds_pebs_vaddr = buffer;
 	/* Update the cpu entry area mapping */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds->pebs_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, bsiz, PAGE_KERNEL);
 	ds->pebs_index = ds->pebs_buffer_base;
@@ -381,7 +381,7 @@ static void release_pebs_buffer(int cpu)
 	per_cpu(insn_buffer, cpu) = NULL;
 
 	/* Clear the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
 	dsfree_pages(hwev->ds_pebs_vaddr, x86_pmu.pebs_buffer_size);
 	hwev->ds_pebs_vaddr = NULL;
@@ -404,7 +404,7 @@ static int alloc_bts_buffer(int cpu)
 	}
 	hwev->ds_bts_vaddr = buffer;
 	/* Update the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_buffers.bts_buffer;
 	ds->bts_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
 	ds->bts_index = ds->bts_buffer_base;
@@ -425,7 +425,7 @@ static void release_bts_buffer(int cpu)
 		return;
 
 	/* Clear the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_buffers.bts_buffer;
 	ds_clear_cea(cea, BTS_BUFFER_SIZE);
 	dsfree_pages(hwev->ds_bts_vaddr, BTS_BUFFER_SIZE);
 	hwev->ds_bts_vaddr = NULL;
@@ -433,7 +433,7 @@ static void release_bts_buffer(int cpu)
 
 static int alloc_ds_buffer(int cpu)
 {
-	struct debug_store *ds = &get_cpu_entry_area(cpu)->cpu_debug_store;
+	struct debug_store *ds = &get_cpu_entry_area_aux(cpu)->cpu_debug_store;
 
 	memset(ds, 0, sizeof(*ds));
 	per_cpu(cpu_hw_events, cpu).ds = ds;
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 4a7884b8dca5..993ac827d164 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -16,11 +16,8 @@
  * There is no direct allocation of a struct cpu_entry_area.
  */
 struct cpu_entry_area {
-	char gdt[PAGE_SIZE];
-
 	/*
-	 * The GDT is just below entry_stack and thus serves (on x86_64) as
-	 * a a read-only guard page.
+	 * The entry_trampoline of the previous CPU will serve as a guard page.
 	 */
 	struct entry_stack_page entry_stack_page;
 
@@ -30,8 +27,12 @@ struct cpu_entry_area {
 	 */
 	struct tss_struct tss;
 
+	char entry_cpu_trampoline[PAGE_SIZE];
 	char entry_trampoline[PAGE_SIZE];
+};
 
+struct cpu_entry_area_aux {
+	char gdt[PAGE_SIZE];
 #ifdef CONFIG_X86_64
 	/*
 	 * Exception stacks used for IST entries.
@@ -55,27 +56,36 @@ struct cpu_entry_area {
 #endif
 };
 
-#define CPU_ENTRY_AREA_SIZE	(sizeof(struct cpu_entry_area))
-#define CPU_ENTRY_AREA_TOT_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
+#define CPU_ENTRY_AREA_SIZE		(sizeof(struct cpu_entry_area))
+#define CPU_ENTRY_AREA_PAGES		(CPU_ENTRY_AREA_SIZE / PAGE_SIZE)
+#define CPU_ENTRY_AREA_TOT_SIZE		(CPU_ENTRY_AREA_SIZE * NR_CPUS)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 
 extern void setup_cpu_entry_areas(void);
+extern void setup_cpu_entry_pti_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
+extern unsigned long cpu_entry_area_base;
 
-#define	CPU_ENTRY_AREA_RO_IDT		CPU_ENTRY_AREA_BASE
-#define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)
+#define CPU_ENTRY_AREA_BASE		(__fix_to_virt(FIX_CPU_ENTRY_AREA_BOTTOM))
 
-#define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
+#define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_BASE)
 
 #define CPU_ENTRY_AREA_MAP_SIZE			\
 	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOT_SIZE - CPU_ENTRY_AREA_BASE)
 
-extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
+#define CPU_ENTRY_AREA_AUX_SIZE		(sizeof(struct cpu_entry_area_aux))
+#define CPU_ENTRY_AREA_AUX_TOT_SIZE	(CPU_ENTRY_AREA_AUX_SIZE * NR_CPUS)
+DECLARE_PER_CPU(struct cpu_entry_area_aux *, cpu_entry_area_aux);
+
+#define CPU_ENTRY_AREA_AUX_RO_IDT	CPU_ENTRY_AREA_AUX_BASE
+#define CPU_ENTRY_AREA_AUX_PER_CPU	(CPU_ENTRY_AREA_AUX_RO_IDT + PAGE_SIZE)
+#define CPU_ENTRY_AREA_AUX_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_AUX_RO_IDT)
+#define CPU_ENTRY_AREA_AUX_MAP_SIZE			\
+	(CPU_ENTRY_AREA_AUX_PER_CPU + CPU_ENTRY_AREA_AUX_TOT_SIZE -	\
+	 CPU_ENTRY_AREA_AUX_BASE)
+
 
-static inline struct entry_stack *cpu_entry_stack(int cpu)
-{
-	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
-}
+extern struct cpu_entry_area_aux *get_cpu_entry_area_aux(int cpu);
 
 #endif
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 13c5ee878a47..69afe5937933 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -66,7 +66,7 @@ static inline struct desc_struct *get_current_gdt_rw(void)
 /* Provide the fixmap address of the remapped GDT */
 static inline struct desc_struct *get_cpu_gdt_ro(int cpu)
 {
-	return (struct desc_struct *)&get_cpu_entry_area(cpu)->gdt;
+	return (struct desc_struct *)&get_cpu_entry_area_aux(cpu)->gdt;
 }
 
 /* Provide the current read-only GDT */
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 6390bd8c141b..e7979ebe7e50 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -35,6 +35,7 @@
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
+#include <asm/cpu_entry_area.h>
 
 /*
  * We can't declare FIXADDR_TOP as variable for x86_64 because vsyscall
@@ -141,6 +142,16 @@ enum fixed_addresses {
 #ifdef CONFIG_INTEL_TXT
 	FIX_TBOOT_BASE,
 #endif
+	/*
+	 * Fixmap entries to remap the entry area, one per processor. We put
+	 * them first (or last, since these are inverted) in order to make sure
+	 * they are aligned.
+	 */
+	FIX_CPU_ENTRY_AREA_TOP = ALIGN(FIX_TBOOT_BASE + 1, PMD_SIZE/PAGE_SIZE),
+	FIX_CPU_ENTRY_AREA_BOTTOM = ALIGN(FIX_CPU_ENTRY_AREA_TOP +
+					(CPU_ENTRY_AREA_PAGES * NR_CPUS),
+					PMD_SIZE/PAGE_SIZE) - 1,
+
 	__end_of_fixed_addresses
 };
 
@@ -198,5 +209,17 @@ void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 void __early_set_fixmap(enum fixed_addresses idx,
 			phys_addr_t phys, pgprot_t flags);
 
+static inline struct cpu_entry_area *get_cpu_entry_area(int cpu)
+{
+	int idx = FIX_CPU_ENTRY_AREA_BOTTOM - cpu * CPU_ENTRY_AREA_PAGES;
+
+	return (struct cpu_entry_area *)__fix_to_virt(idx);
+}
+
+static inline struct entry_stack *cpu_entry_stack(int cpu)
+{
+	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_FIXMAP_H */
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index b0bc0fff5f1f..b405b1f824f2 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,10 +44,10 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_AUX_PAGES	(NR_CPUS * 40)
 
-#define CPU_ENTRY_AREA_BASE						\
-	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
+#define CPU_ENTRY_AREA_AUX_BASE						\
+	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_AUX_PAGES + 1))   \
 	 & PMD_MASK)
 
 #define LDT_BASE_ADDR		\
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04edd2d58211..66ffdde47ff2 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -140,14 +140,14 @@ extern unsigned int ptrs_per_p4d;
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
-#define MODULES_END		_AC(0xffffffffff000000, UL)
+#define MODULES_END		__fix_to_virt(__end_of_fixed_addresses + 1)
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
 
-#define CPU_ENTRY_AREA_PGD	_AC(-4, UL)
-#define CPU_ENTRY_AREA_BASE	(CPU_ENTRY_AREA_PGD << P4D_SHIFT)
+#define CPU_ENTRY_AREA_AUX_PGD	_AC(-4, UL)
+#define CPU_ENTRY_AREA_AUX_BASE	(CPU_ENTRY_AREA_AUX_PGD << P4D_SHIFT)
 
 #define EFI_VA_START		( -4 * (_AC(1, UL) << 30))
 #define EFI_VA_END		(-68 * (_AC(1, UL) << 30))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 44c4ef3d989b..1588177d4160 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1737,7 +1737,7 @@ void cpu_init(void)
 	 * set up and load the per-CPU TSS
 	 */
 	if (!oist->ist[0]) {
-		char *estacks = get_cpu_entry_area(cpu)->exception_stacks;
+		char *estacks = get_cpu_entry_area_aux(cpu)->exception_stacks;
 
 		for (v = 0; v < N_EXCEPTION_STACKS; v++) {
 			estacks += exception_stack_sizes[v];
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..07ab35680a10 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -958,9 +958,9 @@ void __init trap_init(void)
 	 * "sidt" instruction will not leak the location of the kernel, and
 	 * to defend the IDT against arbitrary memory write vulnerabilities.
 	 * It will be reloaded in cpu_init() */
-	cea_set_pte(CPU_ENTRY_AREA_RO_IDT_VADDR, __pa_symbol(idt_table),
+	cea_set_pte(CPU_ENTRY_AREA_AUX_RO_IDT_VADDR, __pa_symbol(idt_table),
 		    PAGE_KERNEL_RO);
-	idt_descr.address = CPU_ENTRY_AREA_RO_IDT;
+	idt_descr.address = CPU_ENTRY_AREA_AUX_RO_IDT;
 
 	/*
 	 * Should be a barrier for any external CPU state:
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5dd3317d761f..4037b1d872bc 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -138,6 +138,12 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
+		__entry_cpu_trampoline_start = .;
+		_entry_cpu_trampoline = .;
+		*(.entry_cpu_trampoline)
+		. = ALIGN(PAGE_SIZE);
+		__entry_cpu_trampoline_end = .;
+		ASSERT(. - _entry_cpu_trampoline == PAGE_SIZE, "entry cpu trampoline is too big");
 		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 076ebdce9bd4..483e76979cd1 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -4,11 +4,13 @@
 #include <linux/percpu.h>
 #include <linux/kallsyms.h>
 #include <linux/kcore.h>
+#include <linux/mm.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
 #include <asm/desc.h>
+#include <asm/sections.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -18,14 +20,15 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
 static DEFINE_PER_CPU(struct kcore_list, kcore_entry_trampoline);
 #endif
 
-struct cpu_entry_area *get_cpu_entry_area(int cpu)
+struct cpu_entry_area_aux *get_cpu_entry_area_aux(int cpu)
 {
-	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cpu * CPU_ENTRY_AREA_SIZE;
-	BUILD_BUG_ON(sizeof(struct cpu_entry_area) % PAGE_SIZE != 0);
+	unsigned long va = CPU_ENTRY_AREA_AUX_PER_CPU +
+		cpu * CPU_ENTRY_AREA_SIZE;
+	BUILD_BUG_ON(sizeof(struct cpu_entry_area_aux) % PAGE_SIZE != 0);
 
-	return (struct cpu_entry_area *) va;
+	return (struct cpu_entry_area_aux *) va;
 }
-EXPORT_SYMBOL(get_cpu_entry_area);
+EXPORT_SYMBOL(get_cpu_entry_area_aux);
 
 void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 {
@@ -62,13 +65,13 @@ static void percpu_setup_debug_store(int cpu)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_store;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_store;
 	npages = sizeof(struct debug_store) / PAGE_SIZE;
 	BUILD_BUG_ON(sizeof(struct debug_store) % PAGE_SIZE != 0);
 	cea_map_percpu_pages(cea, &per_cpu(cpu_debug_store, cpu), npages,
 			     PAGE_KERNEL);
 
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers;
+	cea = &get_cpu_entry_area_aux(cpu)->cpu_debug_buffers;
 	/*
 	 * Force the population of PMDs for not yet allocated per cpu
 	 * memory like debug store buffers.
@@ -104,7 +107,7 @@ static void __init setup_cpu_entry_area(int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-	cea_set_pte(&get_cpu_entry_area(cpu)->gdt, get_cpu_gdt_paddr(cpu),
+	cea_set_pte(&get_cpu_entry_area_aux(cpu)->gdt, get_cpu_gdt_paddr(cpu),
 		    gdt_prot);
 
 	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->entry_stack_page,
@@ -142,8 +145,8 @@ static void __init setup_cpu_entry_area(int cpu)
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
 	BUILD_BUG_ON(sizeof(exception_stacks) !=
-		     sizeof(((struct cpu_entry_area *)0)->exception_stacks));
-	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->exception_stacks,
+		     sizeof(((struct cpu_entry_area_aux *)0)->exception_stacks));
+	cea_map_percpu_pages(&get_cpu_entry_area_aux(cpu)->exception_stacks,
 			     &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
 
@@ -200,6 +203,46 @@ static __init void setup_cpu_entry_area_ptes(void)
 #endif
 }
 
+#ifdef CONFIG_X86_64
+static void __init setup_cpu_entry_pti_area(int cpu)
+{
+	extern void *entry_SYSCALL_64_after_hwframe, *entry_rel_trampoline_end;
+	extern int32_t entry_rel_trampoline_rel;
+	extern char _entry_cpu_trampoline[];
+	struct page *page;
+	char *p;
+
+	/*
+	 * We do not preallocate the memory since this is done only if PTI is
+	 * on.
+	 */
+	page = alloc_page(GFP_KERNEL);
+
+	/*
+	 * We are about to patch the code, but first play it safe and copy the
+	 * original one.
+	 */
+	copy_page(page_address(page), &_entry_cpu_trampoline);
+
+	/*
+	 * Patch in the correct offset for the trampoline for this CPU.
+	 */
+	p = page_address(page);
+	*(int32_t *)(&p[offset_in_page(&entry_rel_trampoline_rel)]) =
+		(int32_t)
+		(unsigned long)&entry_SYSCALL_64_after_hwframe -
+		(unsigned long)&get_cpu_entry_area(cpu)->entry_cpu_trampoline -
+		offset_in_page(&entry_rel_trampoline_end);
+
+	cea_set_pte(&get_cpu_entry_area(cpu)->entry_cpu_trampoline,
+		    page_to_phys(page), PAGE_KERNEL_RX);
+}
+#else /* !CONFIG_X86_64 */
+static void __init setup_cpu_entry_area(int cpu)
+{
+}
+#endif
+
 void __init setup_cpu_entry_areas(void)
 {
 	unsigned int cpu;
@@ -211,7 +254,19 @@ void __init setup_cpu_entry_areas(void)
 
 	/*
 	 * This is the last essential update to swapper_pgdir which needs
-	 * to be synchronized to initial_page_table on 32bit.
+	 * to be synchronized to initial_page_table on 32bit. If PTI is enabled,
+	 * then another sync will be done soon after.
 	 */
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		sync_initial_page_table();
+}
+
+void __init setup_cpu_entry_pti_areas(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		setup_cpu_entry_pti_area(cpu);
+
 	sync_initial_page_table();
 }
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a12afff146d1..eb82de473344 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/highmem.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
 
 /*
@@ -63,7 +64,7 @@ enum address_markers_idx {
 	KASAN_SHADOW_START_NR,
 	KASAN_SHADOW_END_NR,
 #endif
-	CPU_ENTRY_AREA_NR,
+	CPU_ENTRY_AREA_AUX_NR,
 #if defined(CONFIG_MODIFY_LDT_SYSCALL) && !defined(CONFIG_X86_5LEVEL)
 	LDT_NR,
 #endif
@@ -76,6 +77,7 @@ enum address_markers_idx {
 	HIGH_KERNEL_NR,
 	MODULES_VADDR_NR,
 	MODULES_END_NR,
+	CPU_ENTRY_AREA_NR,
 	FIXADDR_START_NR,
 	END_OF_SPACE_NR,
 };
@@ -97,7 +99,8 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	[LDT_NR]		= { 0UL,		"LDT remap" },
 #endif
-	[CPU_ENTRY_AREA_NR]	= { CPU_ENTRY_AREA_BASE,"CPU entry Area" },
+	[CPU_ENTRY_AREA_AUX_NR]	= { CPU_ENTRY_AREA_AUX_BASE,
+							"Auxilary CPU entry Area" },
 #ifdef CONFIG_X86_ESPFIX64
 	[ESPFIX_START_NR]	= { ESPFIX_BASE_ADDR,	"ESPfix Area", 16 },
 #endif
@@ -106,7 +109,8 @@ static struct addr_marker address_markers[] = {
 #endif
 	[HIGH_KERNEL_NR]	= { __START_KERNEL_map,	"High Kernel Mapping" },
 	[MODULES_VADDR_NR]	= { MODULES_VADDR,	"Modules" },
-	[MODULES_END_NR]	= { MODULES_END,	"End Modules" },
+	[CPU_ENTRY_AREA_NR]	= { CPU_ENTRY_AREA_BASE,
+							"CPU entry area" },
 	[FIXADDR_START_NR]	= { FIXADDR_START,	"Fixmap Area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
@@ -126,7 +130,7 @@ enum address_markers_idx {
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	LDT_NR,
 #endif
-	CPU_ENTRY_AREA_NR,
+	CPU_ENTRY_AREA_AUX_NR,
 	FIXADDR_START_NR,
 	END_OF_SPACE_NR,
 };
@@ -142,7 +146,8 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	[LDT_NR]		= { 0UL,		"LDT remap" },
 #endif
-	[CPU_ENTRY_AREA_NR]	= { 0UL,		"CPU entry area" },
+	[CPU_ENTRY_AREA_AUX_NR]	= { CPU_ENTRY_AREA_AUX_BASE,
+							"Auxilary CPU entry area" },
 	[FIXADDR_START_NR]	= { 0UL,		"Fixmap area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
@@ -614,7 +619,6 @@ static int __init pt_dump_init(void)
 	address_markers[PKMAP_BASE_NR].start_address = PKMAP_BASE;
 # endif
 	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
-	address_markers[CPU_ENTRY_AREA_NR].start_address = CPU_ENTRY_AREA_BASE;
 # ifdef CONFIG_MODIFY_LDT_SYSCALL
 	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
 # endif
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index e3e77527f8df..87467ae1f38d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -293,6 +293,7 @@ void __init kasan_init(void)
 {
 	int i;
 	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
+	void *shadow_cpu_entry_aux_begin, *shadow_cpu_entry_aux_end;
 
 #ifdef CONFIG_KASAN_INLINE
 	register_die_notifier(&kasan_die_notifier);
@@ -337,27 +338,37 @@ void __init kasan_init(void)
 		map_range(&pfn_mapped[i]);
 	}
 
-	shadow_cpu_entry_begin = (void *)CPU_ENTRY_AREA_BASE;
-	shadow_cpu_entry_begin = kasan_mem_to_shadow(shadow_cpu_entry_begin);
-	shadow_cpu_entry_begin = (void *)round_down((unsigned long)shadow_cpu_entry_begin,
+	shadow_cpu_entry_aux_begin = (void *)CPU_ENTRY_AREA_AUX_BASE;
+	shadow_cpu_entry_aux_begin = kasan_mem_to_shadow(shadow_cpu_entry_aux_begin);
+	shadow_cpu_entry_aux_begin = (void *)round_down((unsigned long)shadow_cpu_entry_aux_begin,
 						PAGE_SIZE);
 
-	shadow_cpu_entry_end = (void *)(CPU_ENTRY_AREA_BASE +
-					CPU_ENTRY_AREA_MAP_SIZE);
-	shadow_cpu_entry_end = kasan_mem_to_shadow(shadow_cpu_entry_end);
-	shadow_cpu_entry_end = (void *)round_up((unsigned long)shadow_cpu_entry_end,
+	shadow_cpu_entry_aux_end = (void *)(CPU_ENTRY_AREA_AUX_BASE +
+					CPU_ENTRY_AREA_AUX_MAP_SIZE);
+	shadow_cpu_entry_aux_end = kasan_mem_to_shadow(shadow_cpu_entry_aux_end);
+	shadow_cpu_entry_aux_end = (void *)round_up((unsigned long)shadow_cpu_entry_aux_end,
 					PAGE_SIZE);
 
 	kasan_populate_zero_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
-		shadow_cpu_entry_begin);
+		shadow_cpu_entry_aux_begin);
 
-	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
-			      (unsigned long)shadow_cpu_entry_end, 0);
+	kasan_populate_shadow((unsigned long)shadow_cpu_entry_aux_begin,
+			      (unsigned long)shadow_cpu_entry_aux_end, 0);
 
-	kasan_populate_zero_shadow(shadow_cpu_entry_end,
+	kasan_populate_zero_shadow(shadow_cpu_entry_end_aux,
 				kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
+	shadow_cpu_entry_begin = (void *)__fix_to_virt(FIX_CPU_ENTRY_AREA_BOTTOM);
+	shadow_cpu_entry_begin = kasan_mem_to_shadow(shadow_cpu_entry_begin);
+	shadow_cpu_entry_begin = (void *)round_down((unsigned long)shadow_cpu_entry_begin,
+						PAGE_SIZE);
+
+	shadow_cpu_entry_end = (void *)(__fix_to_virt(FIX_CPU_ENTRY_AREA_TOP) + PAGE_SIZE);
+	shadow_cpu_entry_end = kasan_mem_to_shadow(shadow_cpu_entry_end);
+	shadow_cpu_entry_end = (void *)round_up((unsigned long)shadow_cpu_entry_end,
+					PAGE_SIZE);
+
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
 			      (unsigned long)kasan_mem_to_shadow(_end),
 			      early_pfn_to_nid(__pa(_stext)));
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b0eda9..d634a18fd393 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -33,12 +33,14 @@
 
 #define TB_SHIFT 40
 
+#define KASLR_END		(0xfffffe0000000000ULL)
+
 /*
  * The end address could depend on more configuration options to make the
  * highest amount of space for randomization available, but that's too hard
  * to keep straight and caused issues already.
  */
-static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
+static const unsigned long vaddr_end = KASLR_END;
 
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
@@ -87,7 +89,7 @@ void __init kernel_randomize_memory(void)
 	 * limited....
 	 */
 	BUILD_BUG_ON(vaddr_start >= vaddr_end);
-	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
+	BUILD_BUG_ON(vaddr_end != KASLR_END);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
 	if (!kaslr_memory_enabled())
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index c1fc1ae6b429..aefa9af16db3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/sections.h>
+#include <asm/cpu_entry_area.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -438,7 +439,10 @@ static void __init pti_clone_p4d(unsigned long addr)
  */
 static void __init pti_clone_user_shared(void)
 {
-	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
+	pti_clone_p4d(CPU_ENTRY_AREA_AUX_BASE);
+	BUILD_BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
+	pti_clone_pgtable(CPU_ENTRY_AREA_BASE,
+		CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE, PTI_CLONE_PMD);
 }
 
 #else /* CONFIG_X86_64 */
@@ -621,6 +625,7 @@ void __init pti_init(void)
 		printk(KERN_WARNING "************************************************************\n");
 	}
 #endif
+	setup_cpu_entry_pti_areas();
 
 	pti_clone_user_shared();
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index dd461c0167ef..ab67b0f1bb40 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2312,6 +2312,7 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 #endif
 	case FIX_TEXT_POKE0:
 	case FIX_TEXT_POKE1:
+	case FIX_CPU_ENTRY_AREA_TOP ... FIX_CPU_ENTRY_AREA_BOTTOM:
 		/* All local page mappings */
 		pte = pfn_pte(phys, prot);
 		break;
-- 
2.17.1

