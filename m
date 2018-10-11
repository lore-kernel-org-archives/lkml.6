Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CFC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F482098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1h5cZO72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F482098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeJKXNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeJKXNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806E12085B;
        Thu, 11 Oct 2018 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272733;
        bh=s8jB6ydVRUap2fzhjuTEUMvwnzgVFjNTbxy2VY+V9to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1h5cZO72gbvqYiCcis9q7+OtHRRYKTNzg81buYBpGI4RZ89zSBj0V+3nwW9Vi9v40
         aP11W73pD8KjhHB0cCfze/wVo1QV0gfktaE0DRkpx+pltyXXsM5UbCX8irhO5ZSsDT
         yRvZ0b1kcf/4XZEX/0eHWrVqtvsdWHTEKGYganf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 02/45] mm: migration: fix migration of huge PMD shared pages
Date:   Thu, 11 Oct 2018 17:39:29 +0200
Message-Id: <20181011152508.978032962@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 017b1660df89f5fb4bfe66c34e35f7d2031100c7 upstream.

The page migration code employs try_to_unmap() to try and unmap the source
page.  This is accomplished by using rmap_walk to find all vmas where the
page is mapped.  This search stops when page mapcount is zero.  For shared
PMD huge pages, the page map count is always 1 no matter the number of
mappings.  Shared mappings are tracked via the reference count of the PMD
page.  Therefore, try_to_unmap stops prematurely and does not completely
unmap all mappings of the source page.

This problem can result is data corruption as writes to the original
source page can happen after contents of the page are copied to the target
page.  Hence, data is lost.

This problem was originally seen as DB corruption of shared global areas
after a huge page was soft offlined due to ECC memory errors.  DB
developers noticed they could reproduce the issue by (hotplug) offlining
memory used to back huge pages.  A simple testcase can reproduce the
problem by creating a shared PMD mapping (note that this must be at least
PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
migrate_pages() to migrate process pages between nodes while continually
writing to the huge pages being migrated.

To fix, have the try_to_unmap_one routine check for huge PMD sharing by
calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a shared
mapping it will be 'unshared' which removes the page table entry and drops
the reference on the PMD page.  After this, flush caches and TLB.

mmu notifiers are called before locking page tables, but we can not be
sure of PMD sharing until page tables are locked.  Therefore, check for
the possibility of PMD sharing before locking so that notifiers can
prepare for the worst possible case.

Link: http://lkml.kernel.org/r/20180823205917.16297-2-mike.kravetz@oracle.com
[mike.kravetz@oracle.com: make _range_in_vma() a static inline]
  Link: http://lkml.kernel.org/r/6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com
Fixes: 39dde65c9940 ("shared page table for hugetlb page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/hugetlb.h |   14 ++++++++++++++
 include/linux/mm.h      |    6 ++++++
 mm/hugetlb.c            |   37 +++++++++++++++++++++++++++++++++++--
 mm/rmap.c               |   42 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 94 insertions(+), 5 deletions(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -140,6 +140,8 @@ pte_t *huge_pte_alloc(struct mm_struct *
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write);
 struct page *follow_huge_pd(struct vm_area_struct *vma,
@@ -169,6 +171,18 @@ static inline unsigned long hugetlb_tota
 	return 0;
 }
 
+static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
+					pte_t *ptep)
+{
+	return 0;
+}
+
+static inline void adjust_range_if_pmd_sharing_possible(
+				struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
+
 #define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2322,6 +2322,12 @@ static inline struct vm_area_struct *fin
 	return vma;
 }
 
+static inline bool range_in_vma(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	return (vma && vma->vm_start <= start && end <= vma->vm_end);
+}
+
 #ifdef CONFIG_MMU
 pgprot_t vm_get_page_prot(unsigned long vm_flags);
 void vma_set_page_prot(struct vm_area_struct *vma);
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4517,13 +4517,41 @@ static bool vma_shareable(struct vm_area
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE &&
-	    vma->vm_start <= base && end <= vma->vm_end)
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
 		return true;
 	return false;
 }
 
 /*
+ * Determine if start,end range within vma could be mapped by shared pmd.
+ * If yes, adjust start and end to cover range associated with possible
+ * shared pmd mappings.
+ */
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+	unsigned long check_addr = *start;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
+		unsigned long a_start = check_addr & PUD_MASK;
+		unsigned long a_end = a_start + PUD_SIZE;
+
+		/*
+		 * If sharing is possible, adjust start/end if necessary.
+		 */
+		if (range_in_vma(vma, a_start, a_end)) {
+			if (a_start < *start)
+				*start = a_start;
+			if (a_end > *end)
+				*end = a_end;
+		}
+	}
+}
+
+/*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
@@ -4620,6 +4648,11 @@ int huge_pmd_unshare(struct mm_struct *m
 {
 	return 0;
 }
+
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
 #define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1358,11 +1358,21 @@ static bool try_to_unmap_one(struct page
 	}
 
 	/*
-	 * We have to assume the worse case ie pmd for invalidation. Note that
-	 * the page can not be free in this function as call of try_to_unmap()
-	 * must hold a reference on the page.
+	 * For THP, we have to assume the worse case ie pmd for invalidation.
+	 * For hugetlb, it could be much worse if we need to do pud
+	 * invalidation in the case of pmd sharing.
+	 *
+	 * Note that the page can not be free in this function as call of
+	 * try_to_unmap() must hold a reference on the page.
 	 */
 	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
+	if (PageHuge(page)) {
+		/*
+		 * If sharing is possible, start and end will be adjusted
+		 * accordingly.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &start, &end);
+	}
 	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
 
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -1408,6 +1418,32 @@ static bool try_to_unmap_one(struct page
 		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
 		address = pvmw.address;
 
+		if (PageHuge(page)) {
+			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
+				/*
+				 * huge_pmd_unshare unmapped an entire PMD
+				 * page.  There is no way of knowing exactly
+				 * which PMDs may be cached for this mm, so
+				 * we must flush them all.  start/end were
+				 * already adjusted above to cover this range.
+				 */
+				flush_cache_range(vma, start, end);
+				flush_tlb_range(vma, start, end);
+				mmu_notifier_invalidate_range(mm, start, end);
+
+				/*
+				 * The ref count of the PMD page was dropped
+				 * which is part of the way map counting
+				 * is done for shared PMDs.  Return 'true'
+				 * here.  When there is no other sharing,
+				 * huge_pmd_unshare returns false and we will
+				 * unmap the actual page and drop map count
+				 * to zero.
+				 */
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
+		}
 
 		if (IS_ENABLED(CONFIG_MIGRATION) &&
 		    (flags & TTU_MIGRATION) &&


