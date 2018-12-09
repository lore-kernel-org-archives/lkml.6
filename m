Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA4CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFD120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeLIWTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002ij-GA; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hm-V2; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Will Deacon" <will.deacon@arm.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.128341885@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 326/328] mremap: properly flush TLB before releasing
 the page
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/huge_memory.c |  6 +++++-
 mm/mremap.c      | 21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1452,7 +1452,7 @@ int move_huge_pmd(struct vm_area_struct
 	spinlock_t *old_ptl, *new_ptl;
 	int ret = 0;
 	pmd_t pmd;
-
+	bool force_flush = false;
 	struct mm_struct *mm = vma->vm_mm;
 
 	if ((old_addr & ~HPAGE_PMD_MASK) ||
@@ -1480,6 +1480,8 @@ int move_huge_pmd(struct vm_area_struct
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_get_and_clear(mm, old_addr, old_pmd);
+		if (pmd_present(pmd))
+			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
 		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
@@ -1488,6 +1490,8 @@ int move_huge_pmd(struct vm_area_struct
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
+		if (force_flush)
+			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 		if (new_ptl != old_ptl)
 			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -95,6 +95,8 @@ static void move_ptes(struct vm_area_str
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
+	bool force_flush = false;
+	unsigned long len = old_end - old_addr;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_mutex and anon_vma
@@ -141,12 +143,26 @@ static void move_ptes(struct vm_area_str
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
@@ -166,7 +182,6 @@ unsigned long move_page_tables(struct vm
 {
 	unsigned long extent, next, old_end;
 	pmd_t *old_pmd, *new_pmd;
-	bool need_flush = false;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
@@ -204,7 +219,6 @@ unsigned long move_page_tables(struct vm
 					anon_vma_unlock_write(vma->anon_vma);
 			}
 			if (err > 0) {
-				need_flush = true;
 				continue;
 			} else if (!err) {
 				split_huge_page_pmd(vma, old_addr, old_pmd);
@@ -221,10 +235,7 @@ unsigned long move_page_tables(struct vm
 			extent = LATENCY_LIMIT;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			  new_vma, new_pmd, new_addr, need_rmap_locks);
-		need_flush = true;
 	}
-	if (likely(need_flush))
-		flush_tlb_range(vma, old_end-len, old_addr);
 
 	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
 

