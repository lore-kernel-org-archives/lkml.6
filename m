Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeCPTOs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:14:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752829AbeCPTOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:14:24 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 08/14] mm/hmm: cleanup special vma handling (VM_SPECIAL)
Date: Fri, 16 Mar 2018 15:14:13 -0400
Message-Id: <20180316191414.3223-9-jglisse@redhat.com>
In-Reply-To: <20180316191414.3223-1-jglisse@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Special vma (one with any of the VM_SPECIAL flags) can not be access by
device because there is no consistent model accross device drivers on
those vma and their backing memory.

This patch directly use hmm_range struct for hmm_pfns_special() argument
as it is always affecting the whole vma and thus the whole range.

It also make behavior consistent after this patch both hmm_vma_fault()
and hmm_vma_get_pfns() returns -EINVAL when facing such vma. Previously
hmm_vma_fault() returned 0 and hmm_vma_get_pfns() return -EINVAL but
both were filling the HMM pfn array with special entry.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f674b73e7f4a..04595a994542 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -281,14 +281,6 @@ static int hmm_vma_do_fault(struct mm_walk *walk,
 	return -EAGAIN;
 }
 
-static void hmm_pfns_special(uint64_t *pfns,
-			     unsigned long addr,
-			     unsigned long end)
-{
-	for (; addr < end; addr += PAGE_SIZE, pfns++)
-		*pfns = HMM_PFN_SPECIAL;
-}
-
 static int hmm_pfns_bad(unsigned long addr,
 			unsigned long end,
 			struct mm_walk *walk)
@@ -486,6 +478,14 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
+static void hmm_pfns_special(struct hmm_range *range)
+{
+	unsigned long addr = range->start, i = 0;
+
+	for (; addr < range->end; addr += PAGE_SIZE, i++)
+		range->pfns[i] = HMM_PFN_SPECIAL;
+}
+
 /*
  * hmm_vma_get_pfns() - snapshot CPU page table for a range of virtual addresses
  * @range: range being snapshoted and all needed informations
@@ -509,12 +509,6 @@ int hmm_vma_get_pfns(struct hmm_range *range)
 	struct mm_walk mm_walk;
 	struct hmm *hmm;
 
-	/* FIXME support hugetlb fs */
-	if (is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL)) {
-		hmm_pfns_special(range->pfns, range->start, range->end);
-		return -EINVAL;
-	}
-
 	/* Sanity check, this really should not happen ! */
 	if (range->start < vma->vm_start || range->start >= vma->vm_end)
 		return -EINVAL;
@@ -528,6 +522,12 @@ int hmm_vma_get_pfns(struct hmm_range *range)
 	if (!hmm->mmu_notifier.ops)
 		return -EINVAL;
 
+	/* FIXME support hugetlb fs */
+	if (is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL)) {
+		hmm_pfns_special(range);
+		return -EINVAL;
+	}
+
 	/* Initialize range to track CPU page table update */
 	spin_lock(&hmm->lock);
 	range->valid = true;
@@ -693,6 +693,12 @@ int hmm_vma_fault(struct hmm_range *range, bool write, bool block)
 	if (!hmm->mmu_notifier.ops)
 		return -EINVAL;
 
+	/* FIXME support hugetlb fs */
+	if (is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL)) {
+		hmm_pfns_special(range);
+		return -EINVAL;
+	}
+
 	/* Initialize range to track CPU page table update */
 	spin_lock(&hmm->lock);
 	range->valid = true;
@@ -710,12 +716,6 @@ int hmm_vma_fault(struct hmm_range *range, bool write, bool block)
 		return 0;
 	}
 
-	/* FIXME support hugetlb fs */
-	if (is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL)) {
-		hmm_pfns_special(range->pfns, range->start, range->end);
-		return 0;
-	}
-
 	hmm_vma_walk.fault = true;
 	hmm_vma_walk.write = write;
 	hmm_vma_walk.block = block;
-- 
2.14.3
