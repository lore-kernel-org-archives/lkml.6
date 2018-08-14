Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95132174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQPvt9U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95132174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeHNDP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:15:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:15:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7E0T3fo079954;
        Tue, 14 Aug 2018 00:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=mFNNuSRJx4KqAm0biANJWhUhWPT2qL5b9JLLxxfT67w=;
 b=dQPvt9U9vXb0orE+Ap1ijVaWHJX3OTK2WBPivSN/TilIj6BlukVbVbKsqc4rcyhtZhfw
 CcporJ5GyIkIBIKnX4jjZvFD9D/+O+wtscgEpHGD7MP7eQt8SoYyZI+O36GrTFcb5nLM
 yRsJhNW4vTPbiD6oDyGKC6ytWD0+hKg30r5A5+ihhxw1jBm5TARpFQGjZXnfqTeQwKyR
 jgjdPRT0NIqFSY+30wW2GQR1Icx62MJg+E3M1xDk0v58Bpuhcr7oMI9gwdA3V7kbAgoC
 0zK75AfKpsMkK4XEBE1TAwyU22GR2Qm4NdQBwQ5YKk7wM9/NyoP15HCQuJldFHnrMlhf Ig== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ksqrp6e1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 00:31:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7E0V2db005135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 00:31:03 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7E0V1NY011837;
        Tue, 14 Aug 2018 00:31:01 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 17:31:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] mm: migration: fix migration of huge PMD shared pages
Date:   Mon, 13 Aug 2018 17:30:58 -0700
Message-Id: <20180814003058.19732-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <201808131221.zDDttbc8%fengguang.wu@intel.com>
References: <201808131221.zDDttbc8%fengguang.wu@intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8984 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808140003
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

Fixes: 39dde65c9940 ("shared page table for hugetlb page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2: Fixed build issue for !CONFIG_HUGETLB_PAGE and typos in comment

 include/linux/hugetlb.h |  6 ++++++
 mm/rmap.c               | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 36fa6a2a82e3..7524663028ec 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -170,6 +170,12 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
 
+static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
+					pte_t *ptep)
+{
+	return 0;
+}
+
 #define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
diff --git a/mm/rmap.c b/mm/rmap.c
index 09a799c9aebd..cf2340adad10 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1409,6 +1409,27 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
 		address = pvmw.address;
 
+		/*
+		 * PMDs for hugetlbfs pages could be shared.  In this case,
+		 * pages with shared PMDs will have a mapcount of 1 no matter
+		 * how many times they are actually mapped.  Map counting for
+		 * PMD sharing is mostly done via the reference count on the
+		 * PMD page itself.  If the page we are trying to unmap is a
+		 * hugetlbfs page, attempt to 'unshare' at the PMD level.
+		 * huge_pmd_unshare clears the PUD and adjusts reference
+		 * counting on the PMD page which effectively unmaps the page.
+		 * Take care of flushing cache and TLB for page in this
+		 * specific mapping here.
+		 */
+		if (PageHuge(page) &&
+		    huge_pmd_unshare(mm, &address, pvmw.pte)) {
+			unsigned long end_add = address + vma_mmu_pagesize(vma);
+
+			flush_cache_range(vma, address, end_add);
+			flush_tlb_range(vma, address, end_add);
+			mmu_notifier_invalidate_range(mm, address, end_add);
+			continue;
+		}
 
 		if (IS_ENABLED(CONFIG_MIGRATION) &&
 		    (flags & TTU_MIGRATION) &&
-- 
2.17.1

