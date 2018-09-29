Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19BDC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D5E2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D5E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeI3EXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51946 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728716AbeI3ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H3-Pk; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006tC-0y; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Felipe Balbi" <balbi@ti.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.689508170@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 054/131] mm: drop support of non-linear mapping from
 unmap/zap codepath
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 8a5f14a23177061ec11daeaa3d09d0765d785c47 upstream.

We have remap_file_pages(2) emulation in -mm tree for few release cycles
and we plan to have it mainline in v3.20. This patchset removes rest of
VM_NONLINEAR infrastructure.

Patches 1-8 take care about generic code. They are pretty
straight-forward and can be applied without other of patches.

Rest patches removes pte_file()-related stuff from architecture-specific
code. It usually frees up one bit in non-present pte. I've tried to reuse
that bit for swap offset, where I was able to figure out how to do that.

For obvious reason I cannot test all that arch-specific code and would
like to see acks from maintainers.

In total, remap_file_pages(2) required about 1.4K lines of not-so-trivial
kernel code. That's too much for functionality nobody uses.

Tested-by: Felipe Balbi <balbi@ti.com>

This patch (of 38):

We don't create non-linear mappings anymore. Let's drop code which
handles them on unmap/zap.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/mm.h |  1 -
 mm/madvise.c       |  9 +----
 mm/memory.c        | 82 ++++++++++++----------------------------------
 3 files changed, 22 insertions(+), 70 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1103,7 +1103,6 @@ extern void user_shm_unlock(size_t, stru
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct vm_area_struct *nonlinear_vma;	/* Check page->index if set */
 	struct address_space *check_mapping;	/* Check page->mapping if set */
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -277,14 +277,7 @@ static long madvise_dontneed(struct vm_a
 	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
 		return -EINVAL;
 
-	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
-		struct zap_details details = {
-			.nonlinear_vma = vma,
-			.last_index = ULONG_MAX,
-		};
-		zap_page_range(vma, start, end - start, &details);
-	} else
-		zap_page_range(vma, start, end - start, NULL);
+	zap_page_range(vma, start, end - start, NULL);
 	return 0;
 }
 
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1081,6 +1081,7 @@ static unsigned long zap_pte_range(struc
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
+	swp_entry_t entry;
 
 again:
 	init_rss_vec(rss);
@@ -1106,28 +1107,12 @@ again:
 				if (details->check_mapping &&
 				    details->check_mapping != page->mapping)
 					continue;
-				/*
-				 * Each page->index must be checked when
-				 * invalidating or truncating nonlinear.
-				 */
-				if (details->nonlinear_vma &&
-				    (page->index < details->first_index ||
-				     page->index > details->last_index))
-					continue;
 			}
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
-			if (unlikely(details) && details->nonlinear_vma
-			    && linear_page_index(details->nonlinear_vma,
-						addr) != page->index) {
-				pte_t ptfile = pgoff_to_pte(page->index);
-				if (pte_soft_dirty(ptent))
-					ptfile = pte_file_mksoft_dirty(ptfile);
-				set_pte_at(mm, addr, pte, ptfile);
-			}
 			if (PageAnon(page))
 				rss[MM_ANONPAGES]--;
 			else {
@@ -1150,33 +1135,25 @@ again:
 			}
 			continue;
 		}
-		/*
-		 * If details->check_mapping, we leave swap entries;
-		 * if details->nonlinear_vma, we leave file entries.
-		 */
+		/* If details->check_mapping, we leave swap entries. */
 		if (unlikely(details))
 			continue;
-		if (pte_file(ptent)) {
-			if (unlikely(!(vma->vm_flags & VM_NONLINEAR)))
-				print_bad_pte(vma, addr, ptent, NULL);
-		} else {
-			swp_entry_t entry = pte_to_swp_entry(ptent);
-
-			if (!non_swap_entry(entry))
-				rss[MM_SWAPENTS]--;
-			else if (is_migration_entry(entry)) {
-				struct page *page;
-
-				page = migration_entry_to_page(entry);
-
-				if (PageAnon(page))
-					rss[MM_ANONPAGES]--;
-				else
-					rss[MM_FILEPAGES]--;
-			}
-			if (unlikely(!free_swap_and_cache(entry)))
-				print_bad_pte(vma, addr, ptent, NULL);
+
+		entry = pte_to_swp_entry(ptent);
+		if (!non_swap_entry(entry))
+			rss[MM_SWAPENTS]--;
+		else if (is_migration_entry(entry)) {
+			struct page *page;
+
+			page = migration_entry_to_page(entry);
+
+			if (PageAnon(page))
+				rss[MM_ANONPAGES]--;
+			else
+				rss[MM_FILEPAGES]--;
 		}
+		if (unlikely(!free_swap_and_cache(entry)))
+			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
@@ -1288,7 +1265,7 @@ static void unmap_page_range(struct mmu_
 	pgd_t *pgd;
 	unsigned long next;
 
-	if (details && !details->check_mapping && !details->nonlinear_vma)
+	if (details && !details->check_mapping)
 		details = NULL;
 
 	BUG_ON(addr >= end);
@@ -1384,7 +1361,7 @@ void unmap_vmas(struct mmu_gather *tlb,
  * @vma: vm_area_struct holding the applicable pages
  * @start: starting address of pages to zap
  * @size: number of bytes to zap
- * @details: details of nonlinear truncation or shared cache invalidation
+ * @details: details of shared cache invalidation
  *
  * Caller must protect the VMA list
  */
@@ -1410,7 +1387,7 @@ void zap_page_range(struct vm_area_struc
  * @vma: vm_area_struct holding the applicable pages
  * @address: starting address of pages to zap
  * @size: number of bytes to zap
- * @details: details of nonlinear truncation or shared cache invalidation
+ * @details: details of shared cache invalidation
  *
  * The range must fit into one VMA.
  */
@@ -2340,25 +2317,11 @@ static inline void unmap_mapping_range_t
 	}
 }
 
-static inline void unmap_mapping_range_list(struct list_head *head,
-					    struct zap_details *details)
-{
-	struct vm_area_struct *vma;
-
-	/*
-	 * In nonlinear VMAs there is no correspondence between virtual address
-	 * offset and file offset.  So we must perform an exhaustive search
-	 * across *all* the pages in each nonlinear VMA, not just the pages
-	 * whose virtual address lies outside the file truncation point.
-	 */
-	list_for_each_entry(vma, head, shared.nonlinear) {
-		details->nonlinear_vma = vma;
-		unmap_mapping_range_vma(vma, vma->vm_start, vma->vm_end, details);
-	}
-}
-
 /**
- * unmap_mapping_range - unmap the portion of all mmaps in the specified address_space corresponding to the specified page range in the underlying file.
+ * unmap_mapping_range - unmap the portion of all mmaps in the specified
+ * address_space corresponding to the specified page range in the underlying
+ * file.
+ *
  * @mapping: the address space containing mmaps to be unmapped.
  * @holebegin: byte in first page to unmap, relative to the start of
  * the underlying file.  This will be rounded down to a PAGE_SIZE
@@ -2387,7 +2350,6 @@ void unmap_mapping_range(struct address_
 	}
 
 	details.check_mapping = even_cows? NULL: mapping;
-	details.nonlinear_vma = NULL;
 	details.first_index = hba;
 	details.last_index = hba + hlen - 1;
 	if (details.last_index < details.first_index)
@@ -2397,8 +2359,6 @@ void unmap_mapping_range(struct address_
 	mutex_lock(&mapping->i_mmap_mutex);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap)))
 		unmap_mapping_range_tree(&mapping->i_mmap, &details);
-	if (unlikely(!list_empty(&mapping->i_mmap_nonlinear)))
-		unmap_mapping_range_list(&mapping->i_mmap_nonlinear, &details);
 	mutex_unlock(&mapping->i_mmap_mutex);
 }
 EXPORT_SYMBOL(unmap_mapping_range);

