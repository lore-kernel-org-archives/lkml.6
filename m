Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756111AbeDYSNm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:34637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756072AbeDYSNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:13:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243795"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 39/39] x86/intel_rdt: Support contiguous memory of all sizes
Date: Wed, 25 Apr 2018 03:10:15 -0700
Message-Id: <906243e8103b9a4965cb0379061163210d1e6296.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new calls find_alloc_contig_pages() and free_contig_pages()
it is possible to allocate contiguous memory regions larger than what
the SLAB allocators can support.

Use the new API to support allocation of large contiguous memory regions
in order to support pseudo-locked regions larger than 4MB.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 85 ++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index fc9959cba9bf..65ae77e0f65d 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -152,7 +152,7 @@ struct pseudo_lock_region {
 	int			cpu;
 	unsigned int		line_size;
 	unsigned int		size;
-	void			*kmem;
+	struct page		*kmem;
 	unsigned int		minor;
 #ifdef CONFIG_INTEL_RDT_DEBUGFS
 	struct dentry		*debugfs_dir;
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 845344e77390..a219d530c577 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -299,6 +299,63 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 }
 
 /**
+ * contig_mem_alloc - Allocate contiguous memory for pseudo-locked region
+ * @plr: pseudo-locked region for which memory is requested
+ *
+ * In an effort to ensure best coverage of cache with allocated memory
+ * (fewest conflicting physical addresses) allocate contiguous memory
+ * that will be pseudo-locked. The SLAB allocators are restricted wrt
+ * the maximum memory it can allocate. If more memory is required than
+ * what can be requested from the SLAB allocators find_alloc_contig_pages()
+ * is used instead.
+ */
+static int contig_mem_alloc(struct pseudo_lock_region *plr)
+{
+	void *kmem;
+
+	/* Do not allocate from the slab cache - whole pages are needed. */
+	if (plr->size < KMALLOC_MAX_CACHE_SIZE) {
+		rdt_last_cmd_puts("requested region smaller than page size\n");
+		return -EINVAL;
+	}
+
+	if (plr->size > KMALLOC_MAX_SIZE) {
+		plr->kmem = find_alloc_contig_pages(get_order(plr->size),
+						    GFP_KERNEL | __GFP_ZERO,
+						    cpu_to_node(plr->cpu),
+						    NULL);
+		if (!plr->kmem) {
+			rdt_last_cmd_puts("unable to allocate gigantic page\n");
+			return -ENOMEM;
+		}
+	} else {
+		kmem = kzalloc(plr->size, GFP_KERNEL);
+		if (!kmem) {
+			rdt_last_cmd_puts("unable to allocate memory\n");
+			return -ENOMEM;
+		}
+
+		if (!PAGE_ALIGNED(kmem)) {
+			rdt_last_cmd_puts("received unaligned memory\n");
+			kfree(kmem);
+			return -ENOMEM;
+		}
+		plr->kmem = virt_to_page(kmem);
+	}
+	return 0;
+}
+
+static void contig_mem_free(struct pseudo_lock_region *plr)
+{
+	if (plr->kmem) {
+		if (plr->size > KMALLOC_MAX_SIZE)
+			free_contig_pages(plr->kmem, 1 << get_order(plr->size));
+		else
+			kfree(page_to_virt(plr->kmem));
+	}
+}
+
+/**
  * pseudo_lock_init - Initialize a pseudo-lock region
  * @rdtgrp: resource group to which new pseudo-locked region will belong
  *
@@ -334,10 +391,10 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
  */
 static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 {
-	plr->size = 0;
 	plr->line_size = 0;
-	kfree(plr->kmem);
+	contig_mem_free(plr);
 	plr->kmem = NULL;
+	plr->size = 0;
 	plr->r = NULL;
 	if (plr->d)
 		plr->d->plr = NULL;
@@ -366,18 +423,8 @@ static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * We do not yet support contiguous regions larger than
-	 * KMALLOC_MAX_SIZE.
-	 */
-	if (plr->size > KMALLOC_MAX_SIZE) {
-		rdt_last_cmd_puts("requested region exceeds maximum size\n");
-		return -E2BIG;
-	}
-
-	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
-	if (!plr->kmem) {
-		rdt_last_cmd_puts("unable to allocate memory\n");
+	if (contig_mem_alloc(plr)) {
+		pseudo_lock_region_clear(plr);
 		return -ENOMEM;
 	}
 
@@ -476,7 +523,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 	closid_p = this_cpu_read(pqr_state.cur_closid);
 	rmid_p = this_cpu_read(pqr_state.cur_rmid);
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	size = plr->size;
 	line_size = plr->line_size;
 	/*
@@ -888,7 +935,7 @@ static int measure_cycles_lat_fn(void *_plr)
 	 * local register variable used for memory pointer.
 	 */
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	/*
 	 * Dummy execute of the time measurement to load the needed
 	 * instructions into the L1 instruction cache.
@@ -1014,7 +1061,7 @@ static int measure_cycles_perf_fn(void *_plr)
 		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
 				      l3_miss_bits);
 	}
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	size = plr->size;
 	line_size = plr->line_size;
 	for (i = 0; i < size; i += line_size) {
@@ -1431,7 +1478,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	physical = __pa(plr->kmem) >> PAGE_SHIFT;
+	physical = page_to_phys(plr->kmem) >> PAGE_SHIFT;
 	psize = plr->size - off;
 
 	if (off > plr->size) {
@@ -1453,7 +1500,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -ENOSPC;
 	}
 
-	memset(plr->kmem + off, 0, vsize);
+	memset(page_to_virt(plr->kmem) + off, 0, vsize);
 
 	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
 			    vsize, vma->vm_page_prot)) {
-- 
2.13.6
