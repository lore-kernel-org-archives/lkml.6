Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966317AbeBMXuy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:50:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:53404 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966236AbeBMXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822378"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 22/22] x86/intel_rdt: Support contiguous memory of all sizes
Date: Tue, 13 Feb 2018 07:47:06 -0800
Message-Id: <1f495b99c766db9d7c942962bca138e695f4651c.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through "mm/hugetlb: Enable large allocations through gigantic page
API" we are able to allocate contiguous memory regions larger than what
the SLAB allocators can support.

Use the alloc_gigantic_page/free_gigantic_page API to support allocation
of large contiguous memory regions in order to support pseudo-locked
regions larger than 4MB.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 89 ++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 90f040166fcd..99918943a98a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
+#include <linux/hugetlb.h>
 #include <linux/kernfs.h>
 #include <linux/kref.h>
 #include <linux/kthread.h>
@@ -136,7 +137,7 @@ struct pseudo_lock_region {
 	bool			locked;
 	struct kref		refcount;
 	bool			deleted;
-	void			*kmem;
+	struct page		*kmem;
 #ifdef CONFIG_INTEL_RDT_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
@@ -202,12 +203,69 @@ static int pseudo_lock_clos_set(struct pseudo_lock_region *plr,
 	return ret;
 }
 
+/**
+ * contig_mem_alloc - Allocate contiguous memory for pseudo-locked region
+ * @plr: pseudo-locked region for which memory is requested
+ *
+ * In an effort to ensure best coverage of cache with allocated memory
+ * (fewest conflicting physical addresses) allocate contiguous memory
+ * that will be pseudo-locked. The SLAB allocators are restricted wrt
+ * the maximum memory it can allocate. If more memory is required than
+ * what can be requested from the SLAB allocators a gigantic page is
+ * requested instead.
+ */
+static int contig_mem_alloc(struct pseudo_lock_region *plr)
+{
+	void *kmem;
+
+	/*
+	 * We should not be allocating from the slab cache - we need whole
+	 * pages.
+	 */
+	if (plr->size < KMALLOC_MAX_CACHE_SIZE) {
+		rdt_last_cmd_puts("requested region smaller than page size\n");
+		return -EINVAL;
+	}
+
+	if (plr->size > KMALLOC_MAX_SIZE) {
+		plr->kmem = alloc_gigantic_page(cpu_to_node(plr->cpu),
+						get_order(plr->size),
+						GFP_KERNEL | __GFP_ZERO);
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
+	if (plr->size > KMALLOC_MAX_SIZE)
+		free_gigantic_page(plr->kmem, get_order(plr->size));
+	else
+		kfree(page_to_virt(plr->kmem));
+}
+
 static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 {
-	plr->size = 0;
 	plr->line_size = 0;
-	kfree(plr->kmem);
+	contig_mem_free(plr);
 	plr->kmem = NULL;
+	plr->size = 0;
 	plr->r = NULL;
 	plr->d = NULL;
 }
@@ -444,7 +502,7 @@ static int measure_cycles_hist_fn(void *_plr)
 	 * local register variable used for memory pointer.
 	 */
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	for (i = 0; i < plr->size; i += 32) {
 		start = rdtsc_ordered();
 		asm volatile("mov (%0,%1,1), %%eax\n\t"
@@ -568,7 +626,7 @@ static int measure_cycles_perf_fn(void *_plr)
 		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
 				      l3_miss_bits);
 	}
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	size = plr->size;
 	line_size = plr->line_size;
 	for (i = 0; i < size; i += line_size) {
@@ -912,20 +970,9 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr,
 		return -ENOSPC;
 	}
 
-	/*
-	 * We do not yet support contiguous regions larger than
-	 * KMALLOC_MAX_SIZE
-	 */
-	if (plr->size > KMALLOC_MAX_SIZE) {
-		rdt_last_cmd_puts("requested region exceeds maximum size\n");
-		return -E2BIG;
-	}
-
-	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
-	if (!plr->kmem) {
-		rdt_last_cmd_puts("unable to allocate memory\n");
+	ret = contig_mem_alloc(plr);
+	if (ret < 0)
 		return -ENOMEM;
-	}
 
 	plr->r = r;
 	plr->d = d;
@@ -996,7 +1043,7 @@ static int pseudo_lock_fn(void *_plr)
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 	closid_p = this_cpu_read(pqr_state.cur_closid);
 	rmid_p = this_cpu_read(pqr_state.cur_rmid);
-	mem_r = plr->kmem;
+	mem_r = page_to_virt(plr->kmem);
 	size = plr->size;
 	line_size = plr->line_size;
 	__wrmsr(IA32_PQR_ASSOC, rmid_p, plr->closid);
@@ -1630,7 +1677,7 @@ static int pseudo_lock_dev_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	physical = __pa(plr->kmem) >> PAGE_SHIFT;
+	physical = page_to_phys(plr->kmem) >> PAGE_SHIFT;
 	psize = plr->size - off;
 
 	if (off > plr->size) {
@@ -1652,7 +1699,7 @@ static int pseudo_lock_dev_mmap(struct file *file, struct vm_area_struct *vma)
 		return -ENOSPC;
 	}
 
-	memset(plr->kmem + off, 0, vsize);
+	memset(page_to_virt(plr->kmem) + off, 0, vsize);
 
 	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
 			    vsize, vma->vm_page_prot)) {
-- 
2.13.6
