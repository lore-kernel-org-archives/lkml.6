Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28982C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADEC2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADEC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeI3EXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51925 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728701AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H2-PB; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006tH-2D; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.239210527@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/131] mm: drop support of non-linear mapping from
 fault codepath
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

commit 9b4bdd2ffab9557ac43af7dff02e7dab1c8c58bd upstream.

We don't create non-linear mappings anymore.  Let's drop code which
handles them on page fault.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/mm.h | 16 +++++-------
 mm/memory.c        | 65 +++++++---------------------------------------
 2 files changed, 16 insertions(+), 65 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -187,21 +187,19 @@ extern unsigned int kobjsize(const void
 extern pgprot_t protection_map[16];
 
 #define FAULT_FLAG_WRITE	0x01	/* Fault was a write access */
-#define FAULT_FLAG_NONLINEAR	0x02	/* Fault was via a nonlinear mapping */
-#define FAULT_FLAG_MKWRITE	0x04	/* Fault was mkwrite of existing pte */
-#define FAULT_FLAG_ALLOW_RETRY	0x08	/* Retry fault if blocking */
-#define FAULT_FLAG_RETRY_NOWAIT	0x10	/* Don't drop mmap_sem and wait when retrying */
-#define FAULT_FLAG_KILLABLE	0x20	/* The fault task is in SIGKILL killable region */
-#define FAULT_FLAG_TRIED	0x40	/* second try */
-#define FAULT_FLAG_USER		0x80	/* The fault originated in userspace */
+#define FAULT_FLAG_MKWRITE	0x02	/* Fault was mkwrite of existing pte */
+#define FAULT_FLAG_ALLOW_RETRY	0x04	/* Retry fault if blocking */
+#define FAULT_FLAG_RETRY_NOWAIT	0x08	/* Don't drop mmap_sem and wait when retrying */
+#define FAULT_FLAG_KILLABLE	0x10	/* The fault task is in SIGKILL killable region */
+#define FAULT_FLAG_TRIED	0x20	/* Second try */
+#define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
 
 /*
  * vm_fault is filled by the the pagefault handler and passed to the vma's
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
  * of VM_FAULT_xxx flags that give details about how the fault was handled.
  *
- * pgoff should be used in favour of virtual_address, if possible. If pgoff
- * is used, one may implement ->remap_pages to get nonlinear mapping support.
+ * pgoff should be used in favour of virtual_address, if possible.
  */
 struct vm_fault {
 	unsigned int flags;		/* FAULT_FLAG_xxx flags */
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1912,12 +1912,11 @@ int apply_to_page_range(struct mm_struct
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
 /*
- * handle_pte_fault chooses page fault handler according to an entry
- * which was read non-atomically.  Before making any commitment, on
- * those architectures or configurations (e.g. i386 with PAE) which
- * might give a mix of unmatched parts, do_swap_page and do_nonlinear_fault
- * must check under lock before unmapping the pte and proceeding
- * (but do_wp_page is only called after already making such a check;
+ * handle_pte_fault chooses page fault handler according to an entry which was
+ * read non-atomically.  Before making any commitment, on those architectures
+ * or configurations (e.g. i386 with PAE) which might give a mix of unmatched
+ * parts, do_swap_page must check under lock before unmapping the pte and
+ * proceeding (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page can safely check later on).
  */
 static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
@@ -2676,8 +2675,6 @@ void do_set_pte(struct vm_area_struct *v
 	entry = mk_pte(page, vma->vm_page_prot);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	else if (pte_file(*pte) && pte_file_soft_dirty(*pte))
-		pte_mksoft_dirty(entry);
 	if (anon) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, address);
@@ -2818,8 +2815,7 @@ static int do_read_fault(struct mm_struc
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && !(flags & FAULT_FLAG_NONLINEAR) &&
-	    fault_around_pages() > 1) {
+	if (vma->vm_ops->map_pages && fault_around_pages() > 1) {
 		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 		do_fault_around(vma, address, pte, pgoff, flags);
 		if (!pte_same(*pte, orig_pte))
@@ -2949,7 +2945,7 @@ static int do_shared_fault(struct mm_str
 	return ret;
 }
 
-static int do_linear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+static int do_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		unsigned int flags, pte_t orig_pte)
 {
@@ -2969,44 +2965,6 @@ static int do_linear_fault(struct mm_str
 	return do_shared_fault(mm, vma, address, pmd, pgoff, flags, orig_pte);
 }
 
-/*
- * Fault of a previously existing named mapping. Repopulate the pte
- * from the encoded file_pte if possible. This enables swappable
- * nonlinear vmas.
- *
- * We enter with non-exclusive mmap_sem (to exclude vma changes,
- * but allow concurrent faults), and pte mapped but not yet locked.
- * We return with mmap_sem still held, but pte unmapped and unlocked.
- */
-static int do_nonlinear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long address, pte_t *page_table, pmd_t *pmd,
-		unsigned int flags, pte_t orig_pte)
-{
-	pgoff_t pgoff;
-
-	flags |= FAULT_FLAG_NONLINEAR;
-
-	if (!pte_unmap_same(mm, pmd, page_table, orig_pte))
-		return 0;
-
-	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
-		/*
-		 * Page table corrupted: show pte and kill process.
-		 */
-		print_bad_pte(vma, address, orig_pte, NULL);
-		return VM_FAULT_SIGBUS;
-	}
-
-	pgoff = pte_to_pgoff(orig_pte);
-	if (!(flags & FAULT_FLAG_WRITE))
-		return do_read_fault(mm, vma, address, pmd, pgoff, flags,
-				orig_pte);
-	if (!(vma->vm_flags & VM_SHARED))
-		return do_cow_fault(mm, vma, address, pmd, pgoff, flags,
-				orig_pte);
-	return do_shared_fault(mm, vma, address, pmd, pgoff, flags, orig_pte);
-}
-
 static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 				unsigned long addr, int page_nid,
 				int *flags)
@@ -3121,15 +3079,12 @@ static int handle_pte_fault(struct mm_st
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (vma->vm_ops)
-				return do_linear_fault(mm, vma, address,
-						pte, pmd, flags, entry);
+				return do_fault(mm, vma, address, pte,
+						pmd, flags, entry);
 
 			return do_anonymous_page(mm, vma, address,
 						 pte, pmd, flags);
 		}
-		if (pte_file(entry))
-			return do_nonlinear_fault(mm, vma, address,
-					pte, pmd, flags, entry);
 		return do_swap_page(mm, vma, address,
 					pte, pmd, flags, entry);
 	}

