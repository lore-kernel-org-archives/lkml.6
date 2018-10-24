Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4742C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D4206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7D4206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJXL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:58:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:25503 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeJXL6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:58:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 20:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="275060897"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2018 20:31:43 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V6 00/21] swap: Swapout/swapin THP in one piece
References: <20181010071924.18767-1-ying.huang@intel.com>
        <20181023122738.a5j2vk554tsx4f6i@ca-dmjordan1.us.oracle.com>
Date:   Wed, 24 Oct 2018 11:31:42 +0800
In-Reply-To: <20181023122738.a5j2vk554tsx4f6i@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 23 Oct 2018 05:27:38 -0700")
Message-ID: <87sh0wuijl.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 10, 2018 at 03:19:03PM +0800, Huang Ying wrote:
>> And for all, Any comment is welcome!
>> 
>> This patchset is based on the 2018-10-3 head of mmotm/master.
>
> There seems to be some infrequent memory corruption with THPs that have been
> swapped out: page contents differ after swapin.

Thanks a lot for testing this!  I know there were big effort behind this
and it definitely will improve the quality of the patchset greatly!

> Reproducer at the bottom.  Part of some tests I'm writing, had to separate it a
> little hack-ily.  Basically it writes the word offset _at_ each word offset in
> a memory blob, tries to push it to swap, and verifies the offset is the same
> after swapin.
>
> I ran with THP enabled=always.  THP swapin_enabled could be always or never, it
> happened with both.  Every time swapping occurred, a single THP-sized chunk in
> the middle of the blob had different offsets.  Example:
>
> ** > word corruption gap
> ** corruption detected 14929920 bytes in (got 15179776, expected 14929920) **
> ** corruption detected 14929928 bytes in (got 15179784, expected 14929928) **
> ** corruption detected 14929936 bytes in (got 15179792, expected 14929936) **
> ...pattern continues...
> ** corruption detected 17027048 bytes in (got 15179752, expected 17027048) **
> ** corruption detected 17027056 bytes in (got 15179760, expected 17027056) **
> ** corruption detected 17027064 bytes in (got 15179768, expected 17027064) **

15179776 < 15179xxx <= 17027064

15179776 % 4096 = 0

And 15179776 = 15179768 + 8

So I guess we have some alignment bug.  Could you try the patches
attached?  It deal with some alignment issue.

> 100.0% of memory was swapped out at mincore time
> 0.00305% of pages were corrupted (first corrupt word 14929920, last corrupt word 17027064)
>
> The problem goes away with THP enabled=never, and I don't see it on 2018-10-3
> mmotm/master with THP enabled=always.
>
> The server had an NVMe swap device and ~760G memory over two nodes, and the
> program was always run like this:  swap-verify -s $((64 * 2**30))
>
> The kernels had one extra patch, Alexander Duyck's
> "dma-direct: Fix return value of dma_direct_supported", which was required to
> get them to build.
>

Thanks again!

Best Regards,
Huang, Ying

---------------------------------->8-----------------------------
From e1c3e4f565deeb8245bdc4ee53a1f1e4188b6d4a Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 24 Oct 2018 11:24:15 +0800
Subject: [PATCH] Fix alignment bug

---
 include/linux/huge_mm.h | 6 ++----
 mm/huge_memory.c        | 9 ++++-----
 mm/swap_state.c         | 2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 96baae08f47c..e7b3527bc493 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -379,8 +379,7 @@ struct page_vma_mapped_walk;
 
 #ifdef CONFIG_THP_SWAP
 extern void __split_huge_swap_pmd(struct vm_area_struct *vma,
-				  unsigned long haddr,
-				  pmd_t *pmd);
+				  unsigned long addr, pmd_t *pmd);
 extern int split_huge_swap_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			       unsigned long address, pmd_t orig_pmd);
 extern int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd);
@@ -411,8 +410,7 @@ static inline bool transparent_hugepage_swapin_enabled(
 }
 #else /* CONFIG_THP_SWAP */
 static inline void __split_huge_swap_pmd(struct vm_area_struct *vma,
-					 unsigned long haddr,
-					 pmd_t *pmd)
+					 unsigned long addr, pmd_t *pmd)
 {
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ed64266b63dc..b2af3bff7624 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1731,10 +1731,11 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 #ifdef CONFIG_THP_SWAP
 /* Convert a PMD swap mapping to a set of PTE swap mappings */
 void __split_huge_swap_pmd(struct vm_area_struct *vma,
-			   unsigned long haddr,
+			   unsigned long addr,
 			   pmd_t *pmd)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	pgtable_t pgtable;
 	pmd_t _pmd;
 	swp_entry_t entry;
@@ -1772,7 +1773,7 @@ int split_huge_swap_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 	ptl = pmd_lock(mm, pmd);
 	if (pmd_same(*pmd, orig_pmd))
-		__split_huge_swap_pmd(vma, address & HPAGE_PMD_MASK, pmd);
+		__split_huge_swap_pmd(vma, address, pmd);
 	else
 		ret = -ENOENT;
 	spin_unlock(ptl);
@@ -2013,9 +2014,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 * swap mapping and operate on the PTEs
 			 */
 			if (next - addr != HPAGE_PMD_SIZE) {
-				unsigned long haddr = addr & HPAGE_PMD_MASK;
-
-				__split_huge_swap_pmd(vma, haddr, pmd);
+				__split_huge_swap_pmd(vma, addr, pmd);
 				goto out;
 			}
 			free_swap_and_cache(entry, HPAGE_PMD_NR);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 784ad6388da0..fd143ef82351 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -451,7 +451,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
-		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
+		err = add_to_swap_cache(new_page, hentry, gfp_mask & GFP_KERNEL);
 		if (likely(!err)) {
 			/* Initiate read into locked page */
 			SetPageWorkingset(new_page);
-- 
2.18.1

