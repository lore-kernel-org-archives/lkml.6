Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCDEC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244272087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244272087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeI3E00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51740 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbeI3ES1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:27 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gw-Tl; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006xI-V4; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Cyrill Gorcunov" <gorcunov@openvz.org>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Pavel Emelyanov" <xemul@parallels.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.486071534@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 105/131] pagewalk: improve vma handling
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit fafaa4264eba49fd10695c193a82760558d093f4 upstream.

Current implementation of page table walker has a fundamental problem in
vma handling, which started when we tried to handle vma(VM_HUGETLB).
Because it's done in pgd loop, considering vma boundary makes code
complicated and bug-prone.

=46romthe users viewpoint, some user checks some vma-related condition to
determine whether the user really does page walk over the vma.

In order to solve these, this patch moves vma check outside pgd loop and
introduce a new callback ->test_walk().

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pavel Emelyanov <xemul@parallels.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16 as dependency of L1TF mitigation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/mm.h |  15 +++-
 mm/pagewalk.c      | 206 +++++++++++++++++++++++++--------------------
 2 files changed, 129 insertions(+), 92 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1121,10 +1121,16 @@ void unmap_vmas(struct mmu_gather *tlb,
  * @pte_entry: if set, called for each non-empty PTE (4th-level) entry
  * @pte_hole: if set, called for each hole at all levels
  * @hugetlb_entry: if set, called for each hugetlb entry
- *		   *Caution*: The caller must hold mmap_sem() if @hugetlb_entry
- * 			      is used.
+ * @test_walk: caller specific callback function to determine whether
+ *             we walk over the current vma or not. A positive returned
+ *             value means "do page table walk over the current vma,"
+ *             and a negative one means "abort current page table walk
+ *             right now." 0 means "skip the current vma."
+ * @mm:        mm_struct representing the target process of page table walk
+ * @vma:       vma currently walked (NULL if walking outside vmas)
+ * @private:   private data for callbacks' usage
  *
- * (see walk_page_range for more details)
+ * (see the comment on walk_page_range() for more details)
  */
 struct mm_walk {
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
@@ -1136,7 +1142,10 @@ struct mm_walk {
 	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
 			     unsigned long addr, unsigned long next,
 			     struct mm_walk *walk);
+	int (*test_walk)(unsigned long addr, unsigned long next,
+			struct mm_walk *walk);
 	struct mm_struct *mm;
+	struct vm_area_struct *vma;
 	void *private;
 };
 
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -59,7 +59,7 @@ again:
 			continue;
 
 		split_huge_page_pmd_mm(walk->mm, addr, pmd);
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+		if (pmd_trans_unstable(pmd))
 			goto again;
 		err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
@@ -95,6 +95,32 @@ static int walk_pud_range(pgd_t *pgd, un
 	return err;
 }
 
+static int walk_pgd_range(unsigned long addr, unsigned long end,
+			  struct mm_walk *walk)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	int err = 0;
+
+	pgd = pgd_offset(walk->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd)) {
+			if (walk->pte_hole)
+				err = walk->pte_hole(addr, next, walk);
+			if (err)
+				break;
+			continue;
+		}
+		if (walk->pmd_entry || walk->pte_entry)
+			err = walk_pud_range(pgd, addr, next, walk);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+
+	return err;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 static unsigned long hugetlb_entry_end(struct hstate *h, unsigned long addr,
 				       unsigned long end)
@@ -103,10 +129,10 @@ static unsigned long hugetlb_entry_end(s
 	return boundary < end ? boundary : end;
 }
 
-static int walk_hugetlb_range(struct vm_area_struct *vma,
-			      unsigned long addr, unsigned long end,
+static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
+	struct vm_area_struct *vma = walk->vma;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long next;
 	unsigned long hmask = huge_page_mask(h);
@@ -119,15 +145,14 @@ static int walk_hugetlb_range(struct vm_
 		if (pte && walk->hugetlb_entry)
 			err = walk->hugetlb_entry(pte, hmask, addr, next, walk);
 		if (err)
-			return err;
+			break;
 	} while (addr = next, addr != end);
 
-	return 0;
+	return err;
 }
 
 #else /* CONFIG_HUGETLB_PAGE */
-static int walk_hugetlb_range(struct vm_area_struct *vma,
-			      unsigned long addr, unsigned long end,
+static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
 	return 0;
@@ -135,112 +160,115 @@ static int walk_hugetlb_range(struct vm_
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
+/*
+ * Decide whether we really walk over the current vma on [@start, @end)
+ * or skip it via the returned value. Return 0 if we do walk over the
+ * current vma, and return 1 if we skip the vma. Negative values means
+ * error, where we abort the current walk.
+ *
+ * Default check (only VM_PFNMAP check for now) is used when the caller
+ * doesn't define test_walk() callback.
+ */
+static int walk_page_test(unsigned long start, unsigned long end,
+			struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
 
+	if (walk->test_walk)
+		return walk->test_walk(start, end, walk);
+
+	/*
+	 * Do not walk over vma(VM_PFNMAP), because we have no valid struct
+	 * page backing a VM_PFNMAP range. See also commit a9ff785e4437.
+	 */
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+	return 0;
+}
+
+static int __walk_page_range(unsigned long start, unsigned long end,
+			struct mm_walk *walk)
+{
+	int err = 0;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (vma && is_vm_hugetlb_page(vma)) {
+		if (walk->hugetlb_entry)
+			err = walk_hugetlb_range(start, end, walk);
+	} else
+		err = walk_pgd_range(start, end, walk);
+
+	return err;
+}
 
 /**
- * walk_page_range - walk a memory map's page tables with a callback
- * @addr: starting address
- * @end: ending address
- * @walk: set of callbacks to invoke for each level of the tree
+ * walk_page_range - walk page table with caller specific callbacks
  *
- * Recursively walk the page table for the memory area in a VMA,
- * calling supplied callbacks. Callbacks are called in-order (first
- * PGD, first PUD, first PMD, first PTE, second PTE... second PMD,
- * etc.). If lower-level callbacks are omitted, walking depth is reduced.
+ * Recursively walk the page table tree of the process represented by @walk->mm
+ * within the virtual address range [@start, @end). During walking, we can do
+ * some caller-specific works for each entry, by setting up pmd_entry(),
+ * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
+ * callbacks, the associated entries/pages are just ignored.
+ * The return values of these callbacks are commonly defined like below:
+ *  - 0  : succeeded to handle the current entry, and if you don't reach the
+ *         end address yet, continue to walk.
+ *  - >0 : succeeded to handle the current entry, and return to the caller
+ *         with caller specific value.
+ *  - <0 : failed to handle the current entry, and return to the caller
+ *         with error code.
  *
- * Each callback receives an entry pointer and the start and end of the
- * associated range, and a copy of the original mm_walk for access to
- * the ->private or ->mm fields.
+ * Before starting to walk page table, some callers want to check whether
+ * they really want to walk over the current vma, typically by checking
+ * its vm_flags. walk_page_test() and @walk->test_walk() are used for this
+ * purpose.
  *
- * Usually no locks are taken, but splitting transparent huge page may
- * take page table lock. And the bottom level iterator will map PTE
- * directories from highmem if necessary.
+ * struct mm_walk keeps current values of some common data like vma and pmd,
+ * which are useful for the access from callbacks. If you want to pass some
+ * caller-specific data to callbacks, @walk->private should be helpful.
  *
- * If any callback returns a non-zero value, the walk is aborted and
- * the return value is propagated back to the caller. Otherwise 0 is returned.
- *
- * walk->mm->mmap_sem must be held for at least read if walk->hugetlb_entry
- * is !NULL.
+ * Locking:
+ *   Callers of walk_page_range() and walk_page_vma() should hold
+ *   @walk->mm->mmap_sem, because these function traverse vma list and/or
+ *   access to vma's data.
  */
-int walk_page_range(unsigned long addr, unsigned long end,
+int walk_page_range(unsigned long start, unsigned long end,
 		    struct mm_walk *walk)
 {
-	pgd_t *pgd;
-	unsigned long next;
 	int err = 0;
+	unsigned long next;
+	struct vm_area_struct *vma;
 
-	if (addr >= end)
-		return err;
+	if (start >= end)
+		return -EINVAL;
 
 	if (!walk->mm)
 		return -EINVAL;
 
 	VM_BUG_ON(!rwsem_is_locked(&walk->mm->mmap_sem));
 
-	pgd = pgd_offset(walk->mm, addr);
+	vma = find_vma(walk->mm, start);
 	do {
-		struct vm_area_struct *vma = NULL;
-
-		next = pgd_addr_end(addr, end);
+		if (!vma) { /* after the last vma */
+			walk->vma = NULL;
+			next = end;
+		} else if (start < vma->vm_start) { /* outside vma */
+			walk->vma = NULL;
+			next = min(end, vma->vm_start);
+		} else { /* inside vma */
+			walk->vma = vma;
+			next = min(end, vma->vm_end);
+			vma = vma->vm_next;
 
-		/*
-		 * This function was not intended to be vma based.
-		 * But there are vma special cases to be handled:
-		 * - hugetlb vma's
-		 * - VM_PFNMAP vma's
-		 */
-		vma = find_vma(walk->mm, addr);
-		if (vma) {
-			/*
-			 * There are no page structures backing a VM_PFNMAP
-			 * range, so do not allow split_huge_page_pmd().
-			 */
-			if ((vma->vm_start <= addr) &&
-			    (vma->vm_flags & VM_PFNMAP)) {
-				if (walk->pte_hole)
-					err = walk->pte_hole(addr, next, walk);
-				if (err)
-					break;
-				pgd = pgd_offset(walk->mm, next);
-				continue;
-			}
-			/*
-			 * Handle hugetlb vma individually because pagetable
-			 * walk for the hugetlb page is dependent on the
-			 * architecture and we can't handled it in the same
-			 * manner as non-huge pages.
-			 */
-			if (walk->hugetlb_entry && (vma->vm_start <= addr) &&
-			    is_vm_hugetlb_page(vma)) {
-				if (vma->vm_end < next)
-					next = vma->vm_end;
-				/*
-				 * Hugepage is very tightly coupled with vma,
-				 * so walk through hugetlb entries within a
-				 * given vma.
-				 */
-				err = walk_hugetlb_range(vma, addr, next, walk);
-				if (err)
-					break;
-				pgd = pgd_offset(walk->mm, next);
+			err = walk_page_test(start, next, walk);
+			if (err > 0)
 				continue;
-			}
-		}
-
-		if (pgd_none_or_clear_bad(pgd)) {
-			if (walk->pte_hole)
-				err = walk->pte_hole(addr, next, walk);
-			if (err)
+			if (err < 0)
 				break;
-			pgd++;
-			continue;
 		}
-		if (walk->pmd_entry || walk->pte_entry)
-			err = walk_pud_range(pgd, addr, next, walk);
+		if (walk->vma || walk->pte_hole)
+			err = __walk_page_range(start, next, walk);
 		if (err)
 			break;
-		pgd++;
-	} while (addr = next, addr < end);
-
+	} while (start = next, start < end);
 	return err;
 }

