Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEKQcR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:32:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46979 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:32:15 -0400
X-Google-Smtp-Source: AB8JxZog89q/0cKn+v2ADTpkV1vQqR/DXc+qTz0j/EUBmIhbgXkqnIwA8cleIxK0IVZUAGVtKzyzjQ==
Date: Fri, 11 May 2018 22:04:21 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: willy@infradead.org, dan.j.williams@intel.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        zi.yan@cs.rutgers.edu, ross.zwisler@linux.intel.com,
        ying.huang@intel.com, mhocko@suse.com, peterz@infradead.org,
        aneesh.kumar@linux.vnet.ibm.com, rientjes@google.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] dax: Change return type to vm_fault_t
Message-ID: <20180511163421.GA32728@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_mixed() returns err which driver
mapped into VM_FAULT_* type. The new function 
vmf_insert_mixed() will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
v2: Modified the change log

v3: Updated the change log and
    added Ross in review list

v4: Addressed David's comment.
    Changes in huge_memory.c put
    together in a single patch that
    it is bisectable in furture

 drivers/dax/device.c    | 26 +++++++++++---------------
 include/linux/huge_mm.h |  5 +++--
 mm/huge_memory.c        |  4 ++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2137dbc..a122701 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -243,11 +243,11 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static int __dev_dax_pte_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
+static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
+				struct vm_fault *vmf)
 {
 	struct device *dev = &dev_dax->dev;
 	struct dax_region *dax_region;
-	int rc = VM_FAULT_SIGBUS;
 	phys_addr_t phys;
 	pfn_t pfn;
 	unsigned int fault_size = PAGE_SIZE;
@@ -274,17 +274,11 @@ static int __dev_dax_pte_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
 
 	pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
 
-	rc = vm_insert_mixed(vmf->vma, vmf->address, pfn);
-
-	if (rc == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (rc < 0 && rc != -EBUSY)
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
 }
 
-static int __dev_dax_pmd_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
+static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
+				struct vm_fault *vmf)
 {
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	struct device *dev = &dev_dax->dev;
@@ -335,7 +329,8 @@ static int __dev_dax_pmd_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static int __dev_dax_pud_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
+static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
+				struct vm_fault *vmf)
 {
 	unsigned long pud_addr = vmf->address & PUD_MASK;
 	struct device *dev = &dev_dax->dev;
@@ -386,13 +381,14 @@ static int __dev_dax_pud_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
 			vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
-static int __dev_dax_pud_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
+static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
+				struct vm_fault *vmf)
 {
 	return VM_FAULT_FALLBACK;
 }
 #endif /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-static int dev_dax_huge_fault(struct vm_fault *vmf,
+static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
 	int rc, id;
@@ -423,7 +419,7 @@ static int dev_dax_huge_fault(struct vm_fault *vmf,
 	return rc;
 }
 
-static int dev_dax_fault(struct vm_fault *vmf)
+static vm_fault_t dev_dax_fault(struct vm_fault *vmf)
 {
 	return dev_dax_huge_fault(vmf, PE_SIZE_PTE);
 }
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a8a1262..d3bbf6b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_HUGE_MM_H
 
 #include <linux/sched/coredump.h>
+#include <linux/mm_types.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 
@@ -46,9 +47,9 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
 			int prot_numa);
-int vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmd, pfn_t pfn, bool write);
-int vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 			pud_t *pud, pfn_t pfn, bool write);
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_FLAG,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87ab9b8..1fe4705 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -755,7 +755,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spin_unlock(ptl);
 }
 
-int vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmd, pfn_t pfn, bool write)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
@@ -815,7 +815,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	spin_unlock(ptl);
 }
 
-int vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 			pud_t *pud, pfn_t pfn, bool write)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
-- 
1.9.1
