Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5228CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FBC2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FBC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeKBW3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:29:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBW3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:29:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E43CA78;
        Fri,  2 Nov 2018 06:22:36 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFA073F71D;
        Fri,  2 Nov 2018 06:22:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3FBC61AE0D51; Fri,  2 Nov 2018 13:22:44 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH] mremap: properly flush TLB before releasing the page
Date:   Fri,  2 Nov 2018 13:22:42 +0000
Message-Id: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.

This is a backport to stable 4.4.y.

Jann Horn points out that our TLB flushing was subtly wrong for the
mremap() case.  What makes mremap() special is that we don't follow the
usual "add page to list of pages to be freed, then flush tlb, and then
free pages".  No, mremap() obviously just _moves_ the page from one page
table location to another.

That matters, because mremap() thus doesn't directly control the
lifetime of the moved page with a freelist: instead, the lifetime of the
page is controlled by the page table locking, that serializes access to
the entry.

As a result, we need to flush the TLB not just before releasing the lock
for the source location (to avoid any concurrent accesses to the entry),
but also before we release the destination page table lock (to avoid the
TLB being flushed after somebody else has already done something to that
page).

This also makes the whole "need_flush" logic unnecessary, since we now
always end up flushing the TLB for every valid entry.

Reported-and-tested-by: Jann Horn <jannh@google.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[will: backport to 4.4 stable]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 mm/huge_memory.c |  6 +++++-
 mm/mremap.c      | 21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c4ea57ee2fd1..465786cd6490 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1511,7 +1511,7 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
 	spinlock_t *old_ptl, *new_ptl;
 	int ret = 0;
 	pmd_t pmd;
-
+	bool force_flush = false;
 	struct mm_struct *mm = vma->vm_mm;
 
 	if ((old_addr & ~HPAGE_PMD_MASK) ||
@@ -1539,6 +1539,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
+		if (pmd_present(pmd))
+			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
 		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
@@ -1547,6 +1549,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
+		if (force_flush)
+			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 		if (new_ptl != old_ptl)
 			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
diff --git a/mm/mremap.c b/mm/mremap.c
index fe7b7f65f4f4..450b306d473e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -96,6 +96,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
+	bool force_flush = false;
+	unsigned long len = old_end - old_addr;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -143,12 +145,26 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		if (pte_none(*old_pte))
 			continue;
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
+		/*
+		 * If we are remapping a valid PTE, make sure
+		 * to flush TLB before we drop the PTL for the PTE.
+		 *
+		 * NOTE! Both old and new PTL matter: the old one
+		 * for racing with page_mkclean(), the new one to
+		 * make sure the physical page stays valid until
+		 * the TLB entry for the old mapping has been
+		 * flushed.
+		 */
+		if (pte_present(pte))
+			force_flush = true;
 		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
 	}
 
 	arch_leave_lazy_mmu_mode();
+	if (force_flush)
+		flush_tlb_range(vma, old_end - len, old_end);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
@@ -168,7 +184,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 {
 	unsigned long extent, next, old_end;
 	pmd_t *old_pmd, *new_pmd;
-	bool need_flush = false;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
@@ -207,7 +222,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 					anon_vma_unlock_write(vma->anon_vma);
 			}
 			if (err > 0) {
-				need_flush = true;
 				continue;
 			} else if (!err) {
 				split_huge_page_pmd(vma, old_addr, old_pmd);
@@ -224,10 +238,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			extent = LATENCY_LIMIT;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			  new_vma, new_pmd, new_addr, need_rmap_locks);
-		need_flush = true;
 	}
-	if (likely(need_flush))
-		flush_tlb_range(vma, old_end-len, old_addr);
 
 	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
 
-- 
2.1.4

