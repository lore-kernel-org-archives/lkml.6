Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A33C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DA5206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DA5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeJKDXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:23:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:49799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeJKDXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:23:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 13:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="77808492"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 10 Oct 2018 12:59:58 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4] mm/gup: Cache dev_pagemap while pinning pages
Date:   Wed, 10 Oct 2018 13:56:42 -0600
Message-Id: <20181010195642.10736-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinning pages from ZONE_DEVICE memory needs to check the backing device's
live-ness, which is tracked in the device's dev_pagemap metadata. This
metadata is stored in a radix tree and looking it up adds measurable
software overhead.

This patch avoids repeating this relatively costly operation when
dev_pagemap is used by caching the last dev_pagemap while getting use
pages. The gup_benchmark kernel self test reports this reduces time to
get user pages to as low as 1/3 the previous time.

Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v3 -> v4: 

  Split the kernel patch out from the self tests patch series.

  Moved function definitions out of header so the new struct
  'follow_page_context' can be a private definition.

  Maintain reference to dev_pagemap in follow_page_pte, the same
  optimization this patch adds to pud and pmd.

 include/linux/huge_mm.h |   8 ++--
 include/linux/mm.h      |  12 +----
 mm/gup.c                | 113 +++++++++++++++++++++++++++++-------------------
 mm/huge_memory.c        |  16 +++----
 mm/nommu.c              |   6 +--
 5 files changed, 82 insertions(+), 73 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 99c19b06d9a4..5cbabdebe9af 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -213,9 +213,9 @@ static inline int hpage_nr_pages(struct page *page)
 }
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags);
+		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags);
+		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
 extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
 
@@ -344,13 +344,13 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
 }
 
 static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmd, int flags)
+	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
 {
 	return NULL;
 }
 
 static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
-		unsigned long addr, pud_t *pud, int flags)
+	unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
 {
 	return NULL;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..0ea2405240a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2540,16 +2540,8 @@ static inline vm_fault_t vmf_error(int err)
 	return VM_FAULT_SIGBUS;
 }
 
-struct page *follow_page_mask(struct vm_area_struct *vma,
-			      unsigned long address, unsigned int foll_flags,
-			      unsigned int *page_mask);
-
-static inline struct page *follow_page(struct vm_area_struct *vma,
-		unsigned long address, unsigned int foll_flags)
-{
-	unsigned int unused_page_mask;
-	return follow_page_mask(vma, address, foll_flags, &unused_page_mask);
-}
+struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
+			 unsigned int foll_flags);
 
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..d2700dff6f66 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -20,6 +20,11 @@
 
 #include "internal.h"
 
+struct follow_page_context {
+	struct dev_pagemap *pgmap;
+	unsigned int page_mask;
+};
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 		unsigned int flags)
 {
@@ -71,10 +76,10 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags)
+		unsigned long address, pmd_t *pmd, unsigned int flags,
+		struct dev_pagemap **pgmap)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct dev_pagemap *pgmap = NULL;
 	struct page *page;
 	spinlock_t *ptl;
 	pte_t *ptep, pte;
@@ -116,8 +121,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 * Only return device mapping pages in the FOLL_GET case since
 		 * they are only valid while holding the pgmap reference.
 		 */
-		pgmap = get_dev_pagemap(pte_pfn(pte), NULL);
-		if (pgmap)
+		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
+		if (*pgmap)
 			page = pte_page(pte);
 		else
 			goto no_page;
@@ -152,15 +157,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto retry;
 	}
 
-	if (flags & FOLL_GET) {
+	if (flags & FOLL_GET)
 		get_page(page);
-
-		/* drop the pgmap reference now that we hold the page */
-		if (pgmap) {
-			put_dev_pagemap(pgmap);
-			pgmap = NULL;
-		}
-	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
 		    !pte_dirty(pte) && !PageDirty(page))
@@ -210,7 +208,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 				    unsigned long address, pud_t *pudp,
-				    unsigned int flags, unsigned int *page_mask)
+				    unsigned int flags,
+				    struct follow_page_context *ctx)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
@@ -258,13 +257,13 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags);
+		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
 		spin_unlock(ptl);
 		if (page)
 			return page;
 	}
 	if (likely(!pmd_trans_huge(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags);
+		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
 	if ((flags & FOLL_NUMA) && pmd_protnone(pmdval))
 		return no_page_table(vma, flags);
@@ -284,7 +283,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (unlikely(!pmd_trans_huge(*pmd))) {
 		spin_unlock(ptl);
-		return follow_page_pte(vma, address, pmd, flags);
+		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	if (flags & FOLL_SPLIT) {
 		int ret;
@@ -307,18 +306,18 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		}
 
 		return ret ? ERR_PTR(ret) :
-			follow_page_pte(vma, address, pmd, flags);
+			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
-	*page_mask = HPAGE_PMD_NR - 1;
+	ctx->page_mask = HPAGE_PMD_NR - 1;
 	return page;
 }
 
-
 static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    unsigned long address, p4d_t *p4dp,
-				    unsigned int flags, unsigned int *page_mask)
+				    unsigned int flags,
+				    struct follow_page_context *ctx)
 {
 	pud_t *pud;
 	spinlock_t *ptl;
@@ -344,7 +343,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	}
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags);
+		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -352,13 +351,13 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
 
-	return follow_pmd_mask(vma, address, pud, flags, page_mask);
+	return follow_pmd_mask(vma, address, pud, flags, ctx);
 }
 
-
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned long address, pgd_t *pgdp,
-				    unsigned int flags, unsigned int *page_mask)
+				    unsigned int flags,
+				    struct follow_page_context *ctx)
 {
 	p4d_t *p4d;
 	struct page *page;
@@ -378,7 +377,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 			return page;
 		return no_page_table(vma, flags);
 	}
-	return follow_pud_mask(vma, address, p4d, flags, page_mask);
+	return follow_pud_mask(vma, address, p4d, flags, ctx);
 }
 
 /**
@@ -396,13 +395,13 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  */
 struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
-			      unsigned int *page_mask)
+			      struct follow_page_context *ctx)
 {
 	pgd_t *pgd;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
-	*page_mask = 0;
+	ctx->page_mask = 0;
 
 	/* make this handle hugepd */
 	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
@@ -431,7 +430,22 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags);
 	}
 
-	return follow_p4d_mask(vma, address, pgd, flags, page_mask);
+	return follow_p4d_mask(vma, address, pgd, flags, ctx);
+}
+
+struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
+			 unsigned int foll_flags)
+{
+	struct page *page;
+	struct follow_page_context ctx = {
+		.pgmap = NULL,
+		.page_mask = 0,
+	};
+
+	page = follow_page_mask(vma, address, foll_flags, &ctx);
+	if (ctx.pgmap)
+		put_dev_pagemap(ctx.pgmap);
+	return page;
 }
 
 static int get_gate_page(struct mm_struct *mm, unsigned long address,
@@ -659,9 +673,9 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
-	long i = 0;
-	unsigned int page_mask;
+	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
+	struct follow_page_context ctx = {};
 
 	if (!nr_pages)
 		return 0;
@@ -691,12 +705,14 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 						pages ? &pages[i] : NULL);
 				if (ret)
 					return i ? : ret;
-				page_mask = 0;
+				ctx.page_mask = 0;
 				goto next_page;
 			}
 
-			if (!vma || check_vma_flags(vma, gup_flags))
-				return i ? : -EFAULT;
+			if (!vma || check_vma_flags(vma, gup_flags)) {
+				ret = -EFAULT;
+				goto out;
+			}
 			if (is_vm_hugetlb_page(vma)) {
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
@@ -709,23 +725,26 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		 * If we have a pending SIGKILL, don't keep faulting pages and
 		 * potentially allocating memory.
 		 */
-		if (unlikely(fatal_signal_pending(current)))
-			return i ? i : -ERESTARTSYS;
+		if (unlikely(fatal_signal_pending(current))) {
+			ret = -ERESTARTSYS;
+			goto out;
+		}
 		cond_resched();
-		page = follow_page_mask(vma, start, foll_flags, &page_mask);
+
+		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
-			int ret;
 			ret = faultin_page(tsk, vma, start, &foll_flags,
 					nonblocking);
 			switch (ret) {
 			case 0:
 				goto retry;
+			case -EBUSY:
+				ret = 0;
+				/* FALLTHRU */
 			case -EFAULT:
 			case -ENOMEM:
 			case -EHWPOISON:
-				return i ? i : ret;
-			case -EBUSY:
-				return i;
+				goto out;
 			case -ENOENT:
 				goto next_page;
 			}
@@ -737,27 +756,31 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			 */
 			goto next_page;
 		} else if (IS_ERR(page)) {
-			return i ? i : PTR_ERR(page);
+			ret = PTR_ERR(page);
+			goto out;
 		}
 		if (pages) {
 			pages[i] = page;
 			flush_anon_page(vma, page, start);
 			flush_dcache_page(page);
-			page_mask = 0;
+			ctx.page_mask = 0;
 		}
 next_page:
 		if (vmas) {
 			vmas[i] = vma;
-			page_mask = 0;
+			ctx.page_mask = 0;
 		}
-		page_increm = 1 + (~(start >> PAGE_SHIFT) & page_mask);
+		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
 		i += page_increm;
 		start += page_increm * PAGE_SIZE;
 		nr_pages -= page_increm;
 	} while (nr_pages);
-	return i;
+out:
+	if (ctx.pgmap)
+		put_dev_pagemap(ctx.pgmap);
+	return i ? i : ret;
 }
 
 static bool vma_permits_fault(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 00704060b7f7..b4a5191e1146 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -852,11 +852,10 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags)
+		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
 {
 	unsigned long pfn = pmd_pfn(*pmd);
 	struct mm_struct *mm = vma->vm_mm;
-	struct dev_pagemap *pgmap;
 	struct page *page;
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
@@ -886,12 +885,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	pgmap = get_dev_pagemap(pfn, NULL);
-	if (!pgmap)
+	*pgmap = get_dev_pagemap(pfn, *pgmap);
+	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	get_page(page);
-	put_dev_pagemap(pgmap);
 
 	return page;
 }
@@ -1000,11 +998,10 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 }
 
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags)
+		pud_t *pud, int flags, struct dev_pagemap **pgmap)
 {
 	unsigned long pfn = pud_pfn(*pud);
 	struct mm_struct *mm = vma->vm_mm;
-	struct dev_pagemap *pgmap;
 	struct page *page;
 
 	assert_spin_locked(pud_lockptr(mm, pud));
@@ -1028,12 +1025,11 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	pgmap = get_dev_pagemap(pfn, NULL);
-	if (!pgmap)
+	*pgmap = get_dev_pagemap(pfn, *pgmap);
+	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	get_page(page);
-	put_dev_pagemap(pgmap);
 
 	return page;
 }
diff --git a/mm/nommu.c b/mm/nommu.c
index e4aac33216ae..ca13fec7884a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1709,11 +1709,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	return ret;
 }
 
-struct page *follow_page_mask(struct vm_area_struct *vma,
-			      unsigned long address, unsigned int flags,
-			      unsigned int *page_mask)
+struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
+			 unsigned int foll_flags);
 {
-	*page_mask = 0;
 	return NULL;
 }
 
-- 
2.14.4

