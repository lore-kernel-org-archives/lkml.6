Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9CECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF45921480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vjJCmF0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF45921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeJSCFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbeJSCFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBCC21479;
        Thu, 18 Oct 2018 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885804;
        bh=Q9jPhXpdu9GRXV6mQZfBtBcLNx0FvFfR+S3UZwQwmEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjJCmF0ckhgpgMff/8Qj6A7l86Qar0ciGCYpJWS0n4r/rOUR3sX9YmtT77azYTzEH
         d4rxiilk9I+y5SqeydIPt9jvAMKu7/p7/lQl3Kf21Yw5NEGh1BwAHHsNCHz4Nc86gu
         UTsApWtDF7sjYnRNGG90MiNrtilmRWw1ySUjtLIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 23/35] mremap: properly flush TLB before releasing the page
Date:   Thu, 18 Oct 2018 19:54:52 +0200
Message-Id: <20181018175426.083869179@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/huge_mm.h |    2 +-
 mm/huge_memory.c        |   10 ++++------
 mm/mremap.c             |   30 +++++++++++++-----------------
 3 files changed, 18 insertions(+), 24 deletions(-)

--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -22,7 +22,7 @@ extern int mincore_huge_pmd(struct vm_ar
 			unsigned char *vec);
 extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			 unsigned long new_addr, unsigned long old_end,
-			 pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush);
+			 pmd_t *old_pmd, pmd_t *new_pmd);
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
 			int prot_numa);
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1445,7 +1445,7 @@ int zap_huge_pmd(struct mmu_gather *tlb,
 
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, unsigned long old_end,
-		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
+		  pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
 	pmd_t pmd;
@@ -1476,7 +1476,7 @@ bool move_huge_pmd(struct vm_area_struct
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
-		if (pmd_present(pmd) && pmd_dirty(pmd))
+		if (pmd_present(pmd))
 			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
@@ -1487,12 +1487,10 @@ bool move_huge_pmd(struct vm_area_struct
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
-		if (new_ptl != old_ptl)
-			spin_unlock(new_ptl);
 		if (force_flush)
 			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
-		else
-			*need_flush = true;
+		if (new_ptl != old_ptl)
+			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
 		return true;
 	}
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -104,7 +104,7 @@ static pte_t move_soft_dirty_pte(pte_t p
 static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		unsigned long old_addr, unsigned long old_end,
 		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks, bool *need_flush)
+		unsigned long new_addr, bool need_rmap_locks)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
@@ -152,15 +152,17 @@ static void move_ptes(struct vm_area_str
 
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
 		/*
-		 * If we are remapping a dirty PTE, make sure
+		 * If we are remapping a valid PTE, make sure
 		 * to flush TLB before we drop the PTL for the
-		 * old PTE or we may race with page_mkclean().
+		 * PTE.
 		 *
-		 * This check has to be done after we removed the
-		 * old PTE from page tables or another thread may
-		 * dirty it after the check and before the removal.
+		 * NOTE! Both old and new PTL matter: the old one
+		 * for racing with page_mkclean(), the new one to
+		 * make sure the physical page stays valid until
+		 * the TLB entry for the old mapping has been
+		 * flushed.
 		 */
-		if (pte_present(pte) && pte_dirty(pte))
+		if (pte_present(pte))
 			force_flush = true;
 		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
@@ -168,13 +170,11 @@ static void move_ptes(struct vm_area_str
 	}
 
 	arch_leave_lazy_mmu_mode();
+	if (force_flush)
+		flush_tlb_range(vma, old_end - len, old_end);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
-	if (force_flush)
-		flush_tlb_range(vma, old_end - len, old_end);
-	else
-		*need_flush = true;
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
@@ -189,7 +189,6 @@ unsigned long move_page_tables(struct vm
 {
 	unsigned long extent, next, old_end;
 	pmd_t *old_pmd, *new_pmd;
-	bool need_flush = false;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
@@ -220,8 +219,7 @@ unsigned long move_page_tables(struct vm
 				if (need_rmap_locks)
 					take_rmap_locks(vma);
 				moved = move_huge_pmd(vma, old_addr, new_addr,
-						    old_end, old_pmd, new_pmd,
-						    &need_flush);
+						    old_end, old_pmd, new_pmd);
 				if (need_rmap_locks)
 					drop_rmap_locks(vma);
 				if (moved)
@@ -239,10 +237,8 @@ unsigned long move_page_tables(struct vm
 		if (extent > LATENCY_LIMIT)
 			extent = LATENCY_LIMIT;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
-			  new_pmd, new_addr, need_rmap_locks, &need_flush);
+			  new_pmd, new_addr, need_rmap_locks);
 	}
-	if (need_flush)
-		flush_tlb_range(vma, old_end-len, old_addr);
 
 	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
 


