Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BAC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF5421568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Df1fEfMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF5421568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHXAbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:31:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeHXAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:31:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7NKwZAp129318;
        Thu, 23 Aug 2018 20:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=OY3fa08GAEfmN9mjSUjHXL5yBA1fSuN/Cv5FlT6QjAU=;
 b=Df1fEfMJnNxf8PWYr6nLc/grZ2EAWlz7MlxiOIEF2Lw6QDb3vx086Shqdqg/WhuLnAlb
 Ccn2kdtCnmU5KpRFl4+cgHffVCjMnIp2DoQIDfVaAsSRXv2MyI18PF0m+9/xsV+obnWN
 G2aXd2BDOST198aC5RO4cXUz1lkPzlxp3O8Zw+K42bAglzlM88DbDBokiAvvfabaeqhl
 9Qt0bEAn/XC1glricLvppZkTkBstJ5o6mT0vooPnkGCZBpLJce1vO1xLI+WEJpmlE8xo
 pDArIavazDKaPO67m9+Bk4zJP7y1denDn2d2ki/AQ5WklX0/ReLc2I89AItkdM8J9wuc 9w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3r3pf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 20:59:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7NKxQtl021972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 20:59:26 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7NKxPtI002480;
        Thu, 23 Aug 2018 20:59:25 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 13:59:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared pages
Date:   Thu, 23 Aug 2018 13:59:16 -0700
Message-Id: <20180823205917.16297-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180823205917.16297-1-mike.kravetz@oracle.com>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page migration code employs try_to_unmap() to try and unmap the
source page.  This is accomplished by using rmap_walk to find all
vmas where the page is mapped.  This search stops when page mapcount
is zero.  For shared PMD huge pages, the page map count is always 1
no matter the number of mappings.  Shared mappings are tracked via
the reference count of the PMD page.  Therefore, try_to_unmap stops
prematurely and does not completely unmap all mappings of the source
page.

This problem can result is data corruption as writes to the original
source page can happen after contents of the page are copied to the
target page.  Hence, data is lost.

This problem was originally seen as DB corruption of shared global
areas after a huge page was soft offlined due to ECC memory errors.
DB developers noticed they could reproduce the issue by (hotplug)
offlining memory used to back huge pages.  A simple testcase can
reproduce the problem by creating a shared PMD mapping (note that
this must be at least PUD_SIZE in size and PUD_SIZE aligned (1GB on
x86)), and using migrate_pages() to migrate process pages between
nodes while continually writing to the huge pages being migrated.

To fix, have the try_to_unmap_one routine check for huge PMD sharing
by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
shared mapping it will be 'unshared' which removes the page table
entry and drops the reference on the PMD page.  After this, flush
caches and TLB.

mmu notifiers are called before locking page tables, but we can not
be sure of PMD sharing until page tables are locked.  Therefore,
check for the possibility of PMD sharing before locking so that
notifiers can prepare for the worst possible case.

Fixes: 39dde65c9940 ("shared page table for hugetlb page")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 14 ++++++++++++++
 mm/hugetlb.c            | 40 +++++++++++++++++++++++++++++++++++++--
 mm/rmap.c               | 42 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 36fa6a2a82e3..4ee95d8c8413 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -140,6 +140,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write);
 struct page *follow_huge_pd(struct vm_area_struct *vma,
@@ -170,6 +172,18 @@ static inline unsigned long hugetlb_total_pages(void)
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3103099f64fd..a73c5728e961 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4548,6 +4548,9 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
+#define _range_in_vma(vma, start, end) \
+	((vma)->vm_start <= (start) && (end) <= (vma)->vm_end)
+
 static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 {
 	unsigned long base = addr & PUD_MASK;
@@ -4556,12 +4559,40 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE &&
-	    vma->vm_start <= base && end <= vma->vm_end)
+	if (vma->vm_flags & VM_MAYSHARE && _range_in_vma(vma, base, end))
 		return true;
 	return false;
 }
 
+/*
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
+		if (_range_in_vma(vma, a_start, a_end)) {
+			if (a_start < *start)
+				*start = a_start;
+			if (a_end > *end)
+				*end = a_end;
+		}
+	}
+}
+
 /*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
@@ -4659,6 +4690,11 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
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
 
diff --git a/mm/rmap.c b/mm/rmap.c
index eb477809a5c0..1e79fac3186b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
@@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
-- 
2.17.1

