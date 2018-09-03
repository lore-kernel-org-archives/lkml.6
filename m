Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF18DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BA320862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BA320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeICTQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:16:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42209 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:16:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83EtXej3339810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:55:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83EtXiO3339807;
        Mon, 3 Sep 2018 07:55:33 -0700
Date:   Mon, 3 Sep 2018 07:55:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-f030aade9165080f3539fb86fc2ce9ffc391813c@git.kernel.org>
Cc:     mingo@kernel.org, jgross@suse.com, hpa@zytor.com,
        tglx@linutronix.de, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, boris.ostrovsky@oracle.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jgross@suse.com,
          hpa@zytor.com
In-Reply-To: <20180828074026.820-3-jgross@suse.com>
References: <20180828074026.820-3-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/xen: Move pv specific parts of
 arch/x86/xen/mmu.c to mmu_pv.c
Git-Commit-ID: f030aade9165080f3539fb86fc2ce9ffc391813c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f030aade9165080f3539fb86fc2ce9ffc391813c
Gitweb:     https://git.kernel.org/tip/f030aade9165080f3539fb86fc2ce9ffc391813c
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:33 +0200

x86/xen: Move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c

There are some PV specific functions in arch/x86/xen/mmu.c which can be
moved to mmu_pv.c. This in turn enables to build multicalls.c dependent
on CONFIG_XEN_PV.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-3-jgross@suse.com

---
 arch/arm/xen/enlighten.c       |  34 --------
 arch/x86/xen/Makefile          |   2 +-
 arch/x86/xen/mmu.c             | 186 -----------------------------------------
 arch/x86/xen/mmu_pv.c          | 138 ++++++++++++++++++++++++++++++
 include/xen/interface/memory.h |   6 --
 include/xen/xen-ops.h          | 133 +++++++++++++++++++----------
 6 files changed, 227 insertions(+), 272 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 07060e5b5864..17e478928276 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -62,29 +62,6 @@ static __read_mostly unsigned int xen_events_irq;
 uint32_t xen_start_flags;
 EXPORT_SYMBOL(xen_start_flags);
 
-int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t *gfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned domid,
-			       struct page **pages)
-{
-	return xen_xlate_remap_gfn_array(vma, addr, gfn, nr, err_ptr,
-					 prot, domid, pages);
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_array);
-
-/* Not used by XENFEAT_auto_translated guests. */
-int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
-                              unsigned long addr,
-                              xen_pfn_t gfn, int nr,
-                              pgprot_t prot, unsigned domid,
-                              struct page **pages)
-{
-	return -ENOSYS;
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_range);
-
 int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 			       int nr, struct page **pages)
 {
@@ -92,17 +69,6 @@ int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_unmap_domain_gfn_range);
 
-/* Not used by XENFEAT_auto_translated guests. */
-int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t *mfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned int domid, struct page **pages)
-{
-	return -ENOSYS;
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
-
 static void xen_read_wallclock(struct timespec64 *ts)
 {
 	u32 version;
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index f723b5aa8f74..a964f307a266 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -15,7 +15,6 @@ CFLAGS_enlighten_pv.o		:= $(nostackp)
 CFLAGS_mmu_pv.o			:= $(nostackp)
 
 obj-y				+= enlighten.o
-obj-y				+= multicalls.o
 obj-y				+= mmu.o
 obj-y				+= time.o
 obj-y				+= grant-table.o
@@ -34,6 +33,7 @@ obj-$(CONFIG_XEN_PV)		+= p2m.o
 obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
 obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
 obj-$(CONFIG_XEN_PV)		+= irq.o
+obj-$(CONFIG_XEN_PV)		+= multicalls.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
 
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 96fc2f0fdbfe..e0e13fe16d37 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -6,12 +6,6 @@
 #include "multicalls.h"
 #include "mmu.h"
 
-/*
- * Protects atomic reservation decrease/increase against concurrent increases.
- * Also protects non-atomic updates of current_pages and balloon lists.
- */
-DEFINE_SPINLOCK(xen_reservation_lock);
-
 unsigned long arbitrary_virt_to_mfn(void *vaddr)
 {
 	xmaddr_t maddr = arbitrary_virt_to_machine(vaddr);
@@ -42,186 +36,6 @@ xmaddr_t arbitrary_virt_to_machine(void *vaddr)
 }
 EXPORT_SYMBOL_GPL(arbitrary_virt_to_machine);
 
-static noinline void xen_flush_tlb_all(void)
-{
-	struct mmuext_op *op;
-	struct multicall_space mcs;
-
-	preempt_disable();
-
-	mcs = xen_mc_entry(sizeof(*op));
-
-	op = mcs.args;
-	op->cmd = MMUEXT_TLB_FLUSH_ALL;
-	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
-
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
-
-	preempt_enable();
-}
-
-#define REMAP_BATCH_SIZE 16
-
-struct remap_data {
-	xen_pfn_t *pfn;
-	bool contiguous;
-	bool no_translate;
-	pgprot_t prot;
-	struct mmu_update *mmu_update;
-};
-
-static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
-				 unsigned long addr, void *data)
-{
-	struct remap_data *rmd = data;
-	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
-
-	/*
-	 * If we have a contiguous range, just update the pfn itself,
-	 * else update pointer to be "next pfn".
-	 */
-	if (rmd->contiguous)
-		(*rmd->pfn)++;
-	else
-		rmd->pfn++;
-
-	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr;
-	rmd->mmu_update->ptr |= rmd->no_translate ?
-		MMU_PT_UPDATE_NO_TRANSLATE :
-		MMU_NORMAL_PT_UPDATE;
-	rmd->mmu_update->val = pte_val_ma(pte);
-	rmd->mmu_update++;
-
-	return 0;
-}
-
-static int do_remap_pfn(struct vm_area_struct *vma,
-			unsigned long addr,
-			xen_pfn_t *pfn, int nr,
-			int *err_ptr, pgprot_t prot,
-			unsigned int domid,
-			bool no_translate,
-			struct page **pages)
-{
-	int err = 0;
-	struct remap_data rmd;
-	struct mmu_update mmu_update[REMAP_BATCH_SIZE];
-	unsigned long range;
-	int mapped = 0;
-
-	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
-
-	rmd.pfn = pfn;
-	rmd.prot = prot;
-	/*
-	 * We use the err_ptr to indicate if there we are doing a contiguous
-	 * mapping or a discontigious mapping.
-	 */
-	rmd.contiguous = !err_ptr;
-	rmd.no_translate = no_translate;
-
-	while (nr) {
-		int index = 0;
-		int done = 0;
-		int batch = min(REMAP_BATCH_SIZE, nr);
-		int batch_left = batch;
-		range = (unsigned long)batch << PAGE_SHIFT;
-
-		rmd.mmu_update = mmu_update;
-		err = apply_to_page_range(vma->vm_mm, addr, range,
-					  remap_area_pfn_pte_fn, &rmd);
-		if (err)
-			goto out;
-
-		/* We record the error for each page that gives an error, but
-		 * continue mapping until the whole set is done */
-		do {
-			int i;
-
-			err = HYPERVISOR_mmu_update(&mmu_update[index],
-						    batch_left, &done, domid);
-
-			/*
-			 * @err_ptr may be the same buffer as @gfn, so
-			 * only clear it after each chunk of @gfn is
-			 * used.
-			 */
-			if (err_ptr) {
-				for (i = index; i < index + done; i++)
-					err_ptr[i] = 0;
-			}
-			if (err < 0) {
-				if (!err_ptr)
-					goto out;
-				err_ptr[i] = err;
-				done++; /* Skip failed frame. */
-			} else
-				mapped += done;
-			batch_left -= done;
-			index += done;
-		} while (batch_left);
-
-		nr -= batch;
-		addr += range;
-		if (err_ptr)
-			err_ptr += batch;
-		cond_resched();
-	}
-out:
-
-	xen_flush_tlb_all();
-
-	return err < 0 ? err : mapped;
-}
-
-int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t gfn, int nr,
-			       pgprot_t prot, unsigned domid,
-			       struct page **pages)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return -EOPNOTSUPP;
-
-	return do_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false,
-			    pages);
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_range);
-
-int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t *gfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned domid, struct page **pages)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return xen_xlate_remap_gfn_array(vma, addr, gfn, nr, err_ptr,
-						 prot, domid, pages);
-
-	/* We BUG_ON because it's a programmer error to pass a NULL err_ptr,
-	 * and the consequences later is quite hard to detect what the actual
-	 * cause of "wrong memory was mapped in".
-	 */
-	BUG_ON(err_ptr == NULL);
-	return do_remap_pfn(vma, addr, gfn, nr, err_ptr, prot, domid,
-			    false, pages);
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_array);
-
-int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t *mfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned int domid, struct page **pages)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return -EOPNOTSUPP;
-
-	return do_remap_pfn(vma, addr, mfn, nr, err_ptr, prot, domid,
-			    true, pages);
-}
-EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
-
 /* Returns: 0 success */
 int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 			       int nr, struct page **pages)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2fe5c9b1816b..b0691c7a3951 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -98,6 +98,12 @@ static RESERVE_BRK_ARRAY(pte_t, level1_ident_pgt, LEVEL1_IDENT_ENTRIES);
 static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
 #endif /* CONFIG_X86_64 */
 
+/*
+ * Protects atomic reservation decrease/increase against concurrent increases.
+ * Also protects non-atomic updates of current_pages and balloon lists.
+ */
+DEFINE_SPINLOCK(xen_reservation_lock);
+
 /*
  * Note about cr3 (pagetable base) values:
  *
@@ -2662,6 +2668,138 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
+static noinline void xen_flush_tlb_all(void)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs;
+
+	preempt_disable();
+
+	mcs = xen_mc_entry(sizeof(*op));
+
+	op = mcs.args;
+	op->cmd = MMUEXT_TLB_FLUSH_ALL;
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	xen_mc_issue(PARAVIRT_LAZY_MMU);
+
+	preempt_enable();
+}
+
+#define REMAP_BATCH_SIZE 16
+
+struct remap_data {
+	xen_pfn_t *pfn;
+	bool contiguous;
+	bool no_translate;
+	pgprot_t prot;
+	struct mmu_update *mmu_update;
+};
+
+static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
+				 unsigned long addr, void *data)
+{
+	struct remap_data *rmd = data;
+	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
+
+	/*
+	 * If we have a contiguous range, just update the pfn itself,
+	 * else update pointer to be "next pfn".
+	 */
+	if (rmd->contiguous)
+		(*rmd->pfn)++;
+	else
+		rmd->pfn++;
+
+	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr;
+	rmd->mmu_update->ptr |= rmd->no_translate ?
+		MMU_PT_UPDATE_NO_TRANSLATE :
+		MMU_NORMAL_PT_UPDATE;
+	rmd->mmu_update->val = pte_val_ma(pte);
+	rmd->mmu_update++;
+
+	return 0;
+}
+
+int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
+		  xen_pfn_t *pfn, int nr, int *err_ptr, pgprot_t prot,
+		  unsigned int domid, bool no_translate, struct page **pages)
+{
+	int err = 0;
+	struct remap_data rmd;
+	struct mmu_update mmu_update[REMAP_BATCH_SIZE];
+	unsigned long range;
+	int mapped = 0;
+
+	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
+
+	rmd.pfn = pfn;
+	rmd.prot = prot;
+	/*
+	 * We use the err_ptr to indicate if there we are doing a contiguous
+	 * mapping or a discontigious mapping.
+	 */
+	rmd.contiguous = !err_ptr;
+	rmd.no_translate = no_translate;
+
+	while (nr) {
+		int index = 0;
+		int done = 0;
+		int batch = min(REMAP_BATCH_SIZE, nr);
+		int batch_left = batch;
+
+		range = (unsigned long)batch << PAGE_SHIFT;
+
+		rmd.mmu_update = mmu_update;
+		err = apply_to_page_range(vma->vm_mm, addr, range,
+					  remap_area_pfn_pte_fn, &rmd);
+		if (err)
+			goto out;
+
+		/*
+		 * We record the error for each page that gives an error, but
+		 * continue mapping until the whole set is done
+		 */
+		do {
+			int i;
+
+			err = HYPERVISOR_mmu_update(&mmu_update[index],
+						    batch_left, &done, domid);
+
+			/*
+			 * @err_ptr may be the same buffer as @gfn, so
+			 * only clear it after each chunk of @gfn is
+			 * used.
+			 */
+			if (err_ptr) {
+				for (i = index; i < index + done; i++)
+					err_ptr[i] = 0;
+			}
+			if (err < 0) {
+				if (!err_ptr)
+					goto out;
+				err_ptr[i] = err;
+				done++; /* Skip failed frame. */
+			} else
+				mapped += done;
+			batch_left -= done;
+			index += done;
+		} while (batch_left);
+
+		nr -= batch;
+		addr += range;
+		if (err_ptr)
+			err_ptr += batch;
+		cond_resched();
+	}
+out:
+
+	xen_flush_tlb_all();
+
+	return err < 0 ? err : mapped;
+}
+EXPORT_SYMBOL_GPL(xen_remap_pfn);
+
 #ifdef CONFIG_KEXEC_CORE
 phys_addr_t paddr_vmcoreinfo_note(void)
 {
diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index 4c5751c26f87..447004861f00 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -244,12 +244,6 @@ DEFINE_GUEST_HANDLE_STRUCT(xen_memory_map);
 #define XENMEM_machine_memory_map   10
 
 
-/*
- * Prevent the balloon driver from changing the memory reservation
- * during a driver critical region.
- */
-extern spinlock_t xen_reservation_lock;
-
 /*
  * Unmaps the page appearing at a particular GPFN from the specified guest's
  * pseudophysical address space.
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index fd18c974a619..18803ff76e27 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/efi.h>
+#include <xen/features.h>
 #include <asm/xen/interface.h>
 #include <xen/interface/vcpu.h>
 
@@ -47,6 +48,10 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				dma_addr_t *dma_handle);
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order);
+
+int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
+		  xen_pfn_t *pfn, int nr, int *err_ptr, pgprot_t prot,
+		  unsigned int domid, bool no_translate, struct page **pages);
 #else
 static inline int xen_create_contiguous_region(phys_addr_t pstart,
 					       unsigned int order,
@@ -58,10 +63,50 @@ static inline int xen_create_contiguous_region(phys_addr_t pstart,
 
 static inline void xen_destroy_contiguous_region(phys_addr_t pstart,
 						 unsigned int order) { }
+
+static inline int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
+				xen_pfn_t *pfn, int nr, int *err_ptr,
+				pgprot_t prot,  unsigned int domid,
+				bool no_translate, struct page **pages)
+{
+	BUG();
+	return 0;
+}
 #endif
 
 struct vm_area_struct;
 
+#ifdef CONFIG_XEN_AUTO_XLATE
+int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
+			      unsigned long addr,
+			      xen_pfn_t *gfn, int nr,
+			      int *err_ptr, pgprot_t prot,
+			      unsigned int domid,
+			      struct page **pages);
+int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
+			      int nr, struct page **pages);
+#else
+/*
+ * These two functions are called from arch/x86/xen/mmu.c and so stubs
+ * are needed for a configuration not specifying CONFIG_XEN_AUTO_XLATE.
+ */
+static inline int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
+					    unsigned long addr,
+					    xen_pfn_t *gfn, int nr,
+					    int *err_ptr, pgprot_t prot,
+					    unsigned int domid,
+					    struct page **pages)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
+					    int nr, struct page **pages)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * xen_remap_domain_gfn_array() - map an array of foreign frames by gfn
  * @vma:     VMA to map the pages into
@@ -79,12 +124,25 @@ struct vm_area_struct;
  * Returns the number of successfully mapped frames, or a -ve error
  * code.
  */
-int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t *gfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned domid,
-			       struct page **pages);
+static inline int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
+					     unsigned long addr,
+					     xen_pfn_t *gfn, int nr,
+					     int *err_ptr, pgprot_t prot,
+					     unsigned int domid,
+					     struct page **pages)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return xen_xlate_remap_gfn_array(vma, addr, gfn, nr, err_ptr,
+						 prot, domid, pages);
+
+	/* We BUG_ON because it's a programmer error to pass a NULL err_ptr,
+	 * and the consequences later is quite hard to detect what the actual
+	 * cause of "wrong memory was mapped in".
+	 */
+	BUG_ON(err_ptr == NULL);
+	return xen_remap_pfn(vma, addr, gfn, nr, err_ptr, prot, domid,
+			     false, pages);
+}
 
 /*
  * xen_remap_domain_mfn_array() - map an array of foreign frames by mfn
@@ -103,10 +161,18 @@ int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
  * Returns the number of successfully mapped frames, or a -ve error
  * code.
  */
-int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
-			       unsigned long addr, xen_pfn_t *mfn, int nr,
-			       int *err_ptr, pgprot_t prot,
-			       unsigned int domid, struct page **pages);
+static inline int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
+					     unsigned long addr, xen_pfn_t *mfn,
+					     int nr, int *err_ptr,
+					     pgprot_t prot, unsigned int domid,
+					     struct page **pages)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return -EOPNOTSUPP;
+
+	return xen_remap_pfn(vma, addr, mfn, nr, err_ptr, prot, domid,
+			     true, pages);
+}
 
 /* xen_remap_domain_gfn_range() - map a range of foreign frames
  * @vma:     VMA to map the pages into
@@ -120,44 +186,21 @@ int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
  * Returns the number of successfully mapped frames, or a -ve error
  * code.
  */
-int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       xen_pfn_t gfn, int nr,
-			       pgprot_t prot, unsigned domid,
-			       struct page **pages);
-int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
-			       int numpgs, struct page **pages);
-
-#ifdef CONFIG_XEN_AUTO_XLATE
-int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
-			      unsigned long addr,
-			      xen_pfn_t *gfn, int nr,
-			      int *err_ptr, pgprot_t prot,
-			      unsigned domid,
-			      struct page **pages);
-int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
-			      int nr, struct page **pages);
-#else
-/*
- * These two functions are called from arch/x86/xen/mmu.c and so stubs
- * are needed for a configuration not specifying CONFIG_XEN_AUTO_XLATE.
- */
-static inline int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
-					    unsigned long addr,
-					    xen_pfn_t *gfn, int nr,
-					    int *err_ptr, pgprot_t prot,
-					    unsigned int domid,
-					    struct page **pages)
+static inline int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
+					     unsigned long addr,
+					     xen_pfn_t gfn, int nr,
+					     pgprot_t prot, unsigned int domid,
+					     struct page **pages)
 {
-	return -EOPNOTSUPP;
-}
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return -EOPNOTSUPP;
 
-static inline int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
-					    int nr, struct page **pages)
-{
-	return -EOPNOTSUPP;
+	return xen_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false,
+			     pages);
 }
-#endif
+
+int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
+			       int numpgs, struct page **pages);
 
 int xen_xlate_map_ballooned_pages(xen_pfn_t **pfns, void **vaddr,
 				  unsigned long nr_grant_frames);
