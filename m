Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeDVLEZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 07:04:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeDVLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 07:04:22 -0400
Date: Sun, 22 Apr 2018 13:04:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fixes for 4.17
Message-ID: <alpine.DEB.2.21.1804221251260.6136@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A small set of fixes for x86:

 - Prevent X2APIC ID 0xFFFFFFFF from being treated as valid, which causes
   the possible CPU count to be wrong.

 - Prevent 32bit truncation in calc_hpet_ref() which causes the TSC
   calibration to fail

 - Fix the page table setup for temporary text mappings in the resume code
   which causes resume failures

 - Make the page table dump code handle HIGHPTE correctly instead of
   oopsing

 - Support for topologies where NUMA nodes share an LLC to prevent a
   invalid topology warning and further malfunction on such systems.

 - Remove the now unused pci-nommu code

 - Remove stale function declarations

Thanks,

	tglx

------------------>
Alison Schofield (1):
      x86,sched: Allow topologies where NUMA nodes share an LLC

Christoph Hellwig (1):
      x86: Remove pci-nommu.c

Dou Liyang (2):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
      x86/processor: Remove two unused function declarations

Joerg Roedel (2):
      x86/mm: Prevent kernel Oops in PTDUMP code with HIGHPTE=y
      x86/power/64: Fix page-table setup for temporary text mapping

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()


 arch/x86/include/asm/processor.h |  2 -
 arch/x86/kernel/acpi/boot.c      |  4 ++
 arch/x86/kernel/pci-nommu.c      | 90 ----------------------------------------
 arch/x86/kernel/smpboot.c        | 45 +++++++++++++++++---
 arch/x86/kernel/tsc.c            |  2 +-
 arch/x86/mm/dump_pagetables.c    | 11 ++---
 arch/x86/power/hibernate_64.c    |  2 +-
 7 files changed, 52 insertions(+), 104 deletions(-)
 delete mode 100644 arch/x86/kernel/pci-nommu.c

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4fa4206029e3..21a114914ba4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -749,13 +749,11 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-extern void early_trap_init(void);
 void early_trap_pf_init(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void cpu_set_gdt(int);
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dde444f932c1..3b20607d581b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -215,6 +215,10 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
+	/* Ignore invalid ID */
+	if (apic_id == 0xffffffff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
deleted file mode 100644
index ac7ea3a8242f..000000000000
--- a/arch/x86/kernel/pci-nommu.c
+++ /dev/null
@@ -1,90 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Fallback functions when the main IOMMU code is not compiled in. This
-   code is roughly equivalent to i386. */
-#include <linux/dma-direct.h>
-#include <linux/scatterlist.h>
-#include <linux/string.h>
-#include <linux/gfp.h>
-#include <linux/pci.h>
-#include <linux/mm.h>
-
-#include <asm/processor.h>
-#include <asm/iommu.h>
-#include <asm/dma.h>
-
-#define NOMMU_MAPPING_ERROR		0
-
-static int
-check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
-{
-	if (hwdev && !dma_capable(hwdev, bus, size)) {
-		if (*hwdev->dma_mask >= DMA_BIT_MASK(32))
-			printk(KERN_ERR
-			    "nommu_%s: overflow %Lx+%zu of device mask %Lx\n",
-				name, (long long)bus, size,
-				(long long)*hwdev->dma_mask);
-		return 0;
-	}
-	return 1;
-}
-
-static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	dma_addr_t bus = phys_to_dma(dev, page_to_phys(page)) + offset;
-	WARN_ON(size == 0);
-	if (!check_addr("map_single", dev, bus, size))
-		return NOMMU_MAPPING_ERROR;
-	return bus;
-}
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents == 0 || sg[0].length == 0);
-
-	for_each_sg(sg, s, nents, i) {
-		BUG_ON(!sg_page(s));
-		s->dma_address = sg_phys(s);
-		if (!check_addr("map_sg", hwdev, s->dma_address, s->length))
-			return 0;
-		s->dma_length = s->length;
-	}
-	return nents;
-}
-
-static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == NOMMU_MAPPING_ERROR;
-}
-
-const struct dma_map_ops nommu_dma_ops = {
-	.alloc			= dma_generic_alloc_coherent,
-	.free			= dma_generic_free_coherent,
-	.map_sg			= nommu_map_sg,
-	.map_page		= nommu_map_page,
-	.is_phys		= 1,
-	.mapping_error		= nommu_mapping_error,
-	.dma_supported		= x86_dma_supported,
-};
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..45175b81dd5b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -77,6 +77,8 @@
 #include <asm/i8259.h>
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
+#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -390,15 +392,47 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+/*
+ * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
+ *
+ * These are Intel CPUs that enumerate an LLC that is shared by
+ * multiple NUMA nodes. The LLC on these systems is shared for
+ * off-package data access but private to the NUMA node (half
+ * of the package) for on-package access.
+ *
+ * CPUID (the source of the information about the LLC) can only
+ * enumerate the cache as being shared *or* unshared, but not
+ * this particular configuration. The CPU in this case enumerates
+ * the cache to be shared across the entire package (spanning both
+ * NUMA nodes).
+ */
+
+static const struct x86_cpu_id snc_cpu[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X },
+	{}
+};
+
 static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
-	if (per_cpu(cpu_llc_id, cpu1) != BAD_APICID &&
-	    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2))
-		return topology_sane(c, o, "llc");
+	/* Do not match if we do not have a valid APICID for cpu: */
+	if (per_cpu(cpu_llc_id, cpu1) == BAD_APICID)
+		return false;
 
-	return false;
+	/* Do not match if LLC id does not match: */
+	if (per_cpu(cpu_llc_id, cpu1) != per_cpu(cpu_llc_id, cpu2))
+		return false;
+
+	/*
+	 * Allow the SNC topology without warning. Return of false
+	 * means 'c' does not share the LLC of 'o'. This will be
+	 * reflected to userspace.
+	 */
+	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+		return false;
+
+	return topology_sane(c, o, "llc");
 }
 
 /*
@@ -456,7 +490,8 @@ static struct sched_domain_topology_level x86_topology[] = {
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours and Intel Cluster-on-Die have this.
+ * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
+ * Sub-NUMA Clustering have this.
  */
 static bool x86_has_numa_in_package;
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ef32297ff17e..91e6da48cbb6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -317,7 +317,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64 hpet1, u64 hpet2)
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 62a7e9f65dec..cc7ff5957194 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
 
 #include <asm/pgtable.h>
 
@@ -334,16 +335,16 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
 			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
-	pte_t *start;
+	pte_t *pte;
 	pgprotval_t prot, eff;
 
-	start = (pte_t *)pmd_page_vaddr(addr);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		prot = pte_flags(*start);
-		eff = effective_prot(eff_in, prot);
 		st->current_address = normalize_addr(P + i * PTE_LEVEL_MULT);
+		pte = pte_offset_map(&addr, st->current_address);
+		prot = pte_flags(*pte);
+		eff = effective_prot(eff_in, prot);
 		note_page(m, st, __pgprot(prot), eff, 5);
-		start++;
+		pte_unmap(pte);
 	}
 }
 #ifdef CONFIG_KASAN
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 48b14b534897..ccf4a49bb065 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -98,7 +98,7 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	} else {
 		/* No p4d for 4-level paging: point the pgd to the pud page table */
-		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+		pgd_t new_pgd = __pgd(__pa(pud) | pgprot_val(pgtable_prot));
 		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	}
 
