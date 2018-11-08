Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2635ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE842089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snsq0ZLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE842089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKIHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeKIHeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC81C20989;
        Thu,  8 Nov 2018 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714238;
        bh=K+2Iq0G/k3IXzsQ0SAXDVcx3jT80DMv1XTVuijL7ZdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Snsq0ZLfdJf+tqKgiNVU66Nzmy7QqQj5rrEbhVoKublh00yxAhk2UDZ/ceWU+bsiu
         hqMU/f1Y7ooVr5Unc2x2oup3bLBXbFr9hnMLvadQau0/Q0tt5/YVhUCZ5thXeGbmHT
         RVQzvSqJemDi10v19P4wxVC7Bz4Jhad4DB7AkugU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 130/144] mremap: properly flush TLB before releasing the page
Date:   Thu,  8 Nov 2018 13:51:41 -0800
Message-Id: <20181108215107.526160296@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.

This is a backport to stable 3.18.y, based on Will Deacon's 4.4.y
backport.

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
[will: backport to 4.4 stable]
Signed-off-by: Will Deacon <will.deacon@arm.com>
[ghackmann@google.com: adjust context]
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    6 +++++-
 mm/mremap.c      |   21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1462,7 +1462,7 @@ int move_huge_pmd(struct vm_area_struct
 	spinlock_t *old_ptl, *new_ptl;
 	int ret = 0;
 	pmd_t pmd;
-
+	bool force_flush = false;
 	struct mm_struct *mm = vma->vm_mm;
 
 	if ((old_addr & ~HPAGE_PMD_MASK) ||
@@ -1490,6 +1490,8 @@ int move_huge_pmd(struct vm_area_struct
 		if (new_ptl != old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd = pmdp_get_and_clear(mm, old_addr, old_pmd);
+		if (pmd_present(pmd))
+			force_flush = true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
 		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
@@ -1498,6 +1500,8 @@ int move_huge_pmd(struct vm_area_struct
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
@@ -97,6 +97,8 @@ static void move_ptes(struct vm_area_str
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
+	bool force_flush = false;
+	unsigned long len = old_end - old_addr;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_mutex and anon_vma
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
 


