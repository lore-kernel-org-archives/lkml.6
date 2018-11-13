Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2E22510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xsZ4/kt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2E22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbeKMPrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731518AbeKMPrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:09 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0886922513;
        Tue, 13 Nov 2018 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088242;
        bh=1ETzTESbvEClI5d80nlOgMP1/waz9WQGINDIDavNRic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsZ4/kt0Ozao8cBCgLt5SiUt+TQFgVdgQQwntKj0ffO55+YJhZQzUtrYtvjJ6DO7s
         9e0dA4LQyo+hj5izxlt28oNASCJFoSwiLUfG1RYUGeYplNfaUWa2FcaCwXTJbKTGkJ
         rNR4xFLWm//qkDrM2ARMIKFd+fSiJAhkJAbQXmNk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 38/44] mm: thp: fix mmu_notifier in migrate_misplaced_transhuge_page()
Date:   Tue, 13 Nov 2018 00:49:44 -0500
Message-Id: <20181113054950.77898-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

[ Upstream commit 7066f0f933a1fd707bb38781866657769cff7efc ]

change_huge_pmd() after arming the numa/protnone pmd doesn't flush the TLB
right away.  do_huge_pmd_numa_page() flushes the TLB before calling
migrate_misplaced_transhuge_page().  By the time do_huge_pmd_numa_page()
runs some CPU could still access the page through the TLB.

change_huge_pmd() before arming the numa/protnone transhuge pmd calls
mmu_notifier_invalidate_range_start().  So there's no need of
mmu_notifier_invalidate_range_start()/mmu_notifier_invalidate_range_only_end()
sequence in migrate_misplaced_transhuge_page() too, because by the time
migrate_misplaced_transhuge_page() runs, the pmd mapping has already been
invalidated in the secondary MMUs.  It has to or if a secondary MMU can
still write to the page, the migrate_page_copy() would lose data.

However an explicit mmu_notifier_invalidate_range() is needed before
migrate_misplaced_transhuge_page() starts copying the data of the
transhuge page or the below can happen for MMU notifier users sharing the
primary MMU pagetables and only implementing ->invalidate_range:

CPU0		CPU1		GPU sharing linux pagetables using
                                only ->invalidate_range
-----------	------------	---------
				GPU secondary MMU writes to the page
				mapped by the transhuge pmd
change_pmd_range()
mmu..._range_start()
->invalidate_range_start() noop
change_huge_pmd()
set_pmd_at(numa/protnone)
pmd_unlock()
		do_huge_pmd_numa_page()
		CPU TLB flush globally (1)
		CPU cannot write to page
		migrate_misplaced_transhuge_page()
				GPU writes to the page...
		migrate_page_copy()
				...GPU stops writing to the page
CPU TLB flush (2)
mmu..._range_end() (3)
->invalidate_range_stop() noop
->invalidate_range()
				GPU secondary MMU is invalidated
				and cannot write to the page anymore
				(too late)

Just like we need a CPU TLB flush (1) because the TLB flush (2) arrives
too late, we also need a mmu_notifier_invalidate_range() before calling
migrate_misplaced_transhuge_page(), because the ->invalidate_range() in
(3) also arrives too late.

This requirement is the result of the lazy optimization in
change_huge_pmd() that releases the pmd_lock without first flushing the
TLB and without first calling mmu_notifier_invalidate_range().

Even converting the removed mmu_notifier_invalidate_range_only_end() into
a mmu_notifier_invalidate_range_end() would not have been enough to fix
this, because it run after migrate_page_copy().

After the hugepage data copy is done migrate_misplaced_transhuge_page()
can proceed and call set_pmd_at without having to flush the TLB nor any
secondary MMUs because the secondary MMU invalidate, just like the CPU TLB
flush, has to happen before the migrate_page_copy() is called or it would
be a bug in the first place (and it was for drivers using
->invalidate_range()).

KVM is unaffected because it doesn't implement ->invalidate_range().

The standard PAGE_SIZEd migrate_misplaced_page is less accelerated and
uses the generic migrate_pages which transitions the pte from
numa/protnone to a migration entry in try_to_unmap_one() and flushes TLBs
and all mmu notifiers there before copying the page.

Link: http://lkml.kernel.org/r/20181013002430.698-3-aarcange@redhat.com
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 14 +++++++++++++-
 mm/migrate.c     | 19 ++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index deed97fba979..a71a5172104c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1562,8 +1562,20 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * We are not sure a pending tlb flush here is for a huge page
 	 * mapping or not. Hence use the tlb range variant
 	 */
-	if (mm_tlb_flush_pending(vma->vm_mm))
+	if (mm_tlb_flush_pending(vma->vm_mm)) {
 		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
+		/*
+		 * change_huge_pmd() released the pmd lock before
+		 * invalidating the secondary MMUs sharing the primary
+		 * MMU pagetables (with ->invalidate_range()). The
+		 * mmu_notifier_invalidate_range_end() (which
+		 * internally calls ->invalidate_range()) in
+		 * change_pmd_range() will run after us, so we can't
+		 * rely on it here and we need an explicit invalidate.
+		 */
+		mmu_notifier_invalidate_range(vma->vm_mm, haddr,
+					      haddr + HPAGE_PMD_SIZE);
+	}
 
 	/*
 	 * Migrate the THP to the requested node, returns with page unlocked
diff --git a/mm/migrate.c b/mm/migrate.c
index 1f634b1563b6..1637a32f3dd7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1973,8 +1973,8 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int isolated = 0;
 	struct page *new_page = NULL;
 	int page_lru = page_is_file_cache(page);
-	unsigned long mmun_start = address & HPAGE_PMD_MASK;
-	unsigned long mmun_end = mmun_start + HPAGE_PMD_SIZE;
+	unsigned long start = address & HPAGE_PMD_MASK;
+	unsigned long end = start + HPAGE_PMD_SIZE;
 
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
@@ -2001,11 +2001,9 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	WARN_ON(PageLRU(new_page));
 
 	/* Recheck the target PMD */
-	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 	ptl = pmd_lock(mm, pmd);
 	if (unlikely(!pmd_same(*pmd, entry) || !page_ref_freeze(page, 2))) {
 		spin_unlock(ptl);
-		mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 
 		/* Reverse changes made by migrate_page_copy() */
 		if (TestClearPageActive(new_page))
@@ -2036,8 +2034,8 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * new page and page_add_new_anon_rmap guarantee the copy is
 	 * visible before the pagetable update.
 	 */
-	flush_cache_range(vma, mmun_start, mmun_end);
-	page_add_anon_rmap(new_page, vma, mmun_start, true);
+	flush_cache_range(vma, start, end);
+	page_add_anon_rmap(new_page, vma, start, true);
 	/*
 	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
 	 * has already been flushed globally.  So no TLB can be currently
@@ -2049,7 +2047,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * MADV_DONTNEED won't wait on the pmd lock and it'll skip clearing this
 	 * pmd.
 	 */
-	set_pmd_at(mm, mmun_start, pmd, entry);
+	set_pmd_at(mm, start, pmd, entry);
 	update_mmu_cache_pmd(vma, address, &entry);
 
 	page_ref_unfreeze(page, 2);
@@ -2058,11 +2056,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	set_page_owner_migrate_reason(new_page, MR_NUMA_MISPLACED);
 
 	spin_unlock(ptl);
-	/*
-	 * No need to double call mmu_notifier->invalidate_range() callback as
-	 * the above pmdp_huge_clear_flush_notify() did already call it.
-	 */
-	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 
 	/* Take an "isolate" reference and put new page on the LRU. */
 	get_page(new_page);
@@ -2086,7 +2079,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	ptl = pmd_lock(mm, pmd);
 	if (pmd_same(*pmd, entry)) {
 		entry = pmd_modify(entry, vma->vm_page_prot);
-		set_pmd_at(mm, mmun_start, pmd, entry);
+		set_pmd_at(mm, start, pmd, entry);
 		update_mmu_cache_pmd(vma, address, &entry);
 	}
 	spin_unlock(ptl);
-- 
2.17.1

