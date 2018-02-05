Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeBEBlZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:41:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:44112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbeBEB2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:22 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/64] mm: huge pagecache: do not check mmap_sem state
Date: Mon,  5 Feb 2018 02:27:13 +0100
Message-Id: <20180205012754.23615-24-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

*THIS IS A HACK*

By dropping the rwsem_is_locked checks in zap_pmd_range()
and zap_pud_range() we can avoid having to teach
file_operations about mmrange. For example in xfs:
iomap_dio_rw() is called by .read_iter file callbacks.

No-Yet-Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7c69674cd9da..598a8c69e3d3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1422,8 +1422,6 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
-				VM_BUG_ON_VMA(vma_is_anonymous(vma) &&
-				    !rwsem_is_locked(&tlb->mm->mmap_sem), vma);
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
@@ -1459,7 +1457,6 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
-- 
2.13.6
