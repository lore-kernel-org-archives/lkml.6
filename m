Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5686CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CDD21019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1M0VqFN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CDD21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbeKIHia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbeKIHia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:30 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD4F20892;
        Thu,  8 Nov 2018 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714461;
        bh=KTC0HapOIpY91OaCWbHZKr2fZ2fv4buoK8yW1C3/71c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1M0VqFN/Uy5+K6pxEdgw9qM496YQ/ao4Nvh5sbi5Aeo8h1OfrzPoBxxrNm/tghIYC
         1VYhEHrb1LGoVU7XVv+P7W7c+idDQkv/Rvaxa07ud5o5B7ymJKId9mT3bQp+tzqR9k
         +qscOxpfPTLcvzcNeaypxmDKJPVS0MU1QxhvDX3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com,
        mingo@kernel.org, peterz@infradead.org, torvalds@linux-foundation.org,
        Will Deacon" <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.4 101/114] mremap: properly flush TLB before releasing the page
Date:   Thu,  8 Nov 2018 13:51:56 -0800
Message-Id: <20181108215109.820959929@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/huge_memory.c |    6 +++++-
 mm/mremap.c      |   21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1511,7 +1511,7 @@ int move_huge_pmd(struct vm_area_struct
 	spinlock_t *old_ptl, *new_ptl;
 	int ret = 0;
 	pmd_t pmd;
-
+	bool force_flush = false;
 	struct mm_struct *mm = vma->vm_mm;
 
 	if ((old_addr & ~HPAGE_PMD_MASK) ||
@@ -1539,6 +1539,8 @@ int move_huge_pmd(struct vm_area_struct
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
+		if (pmd_present(pmd))
+			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
 		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
@@ -1547,6 +1549,8 @@ int move_huge_pmd(struct vm_area_struct
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
@@ -96,6 +96,8 @@ static void move_ptes(struct vm_area_str
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
+	bool force_flush = false;
+	unsigned long len = old_end - old_addr;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -143,12 +145,26 @@ static void move_ptes(struct vm_area_str
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
@@ -168,7 +184,6 @@ unsigned long move_page_tables(struct vm
 {
 	unsigned long extent, next, old_end;
 	pmd_t *old_pmd, *new_pmd;
-	bool need_flush = false;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
@@ -207,7 +222,6 @@ unsigned long move_page_tables(struct vm
 					anon_vma_unlock_write(vma->anon_vma);
 			}
 			if (err > 0) {
-				need_flush = true;
 				continue;
 			} else if (!err) {
 				split_huge_page_pmd(vma, old_addr, old_pmd);
@@ -224,10 +238,7 @@ unsigned long move_page_tables(struct vm
 			extent = LATENCY_LIMIT;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			  new_vma, new_pmd, new_addr, need_rmap_locks);
-		need_flush = true;
 	}
-	if (likely(need_flush))
-		flush_tlb_range(vma, old_end-len, old_addr);
 
 	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
 


