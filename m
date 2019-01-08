Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73814C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412472087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfAHEvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:51:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727684AbfAHEvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:51:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x084n5fP050850
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 23:51:38 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvn5pr2f7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 23:51:38 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 8 Jan 2019 04:51:37 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 04:51:34 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x084pXTk24182942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 04:51:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 772ADB2065;
        Tue,  8 Jan 2019 04:51:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B61DB205F;
        Tue,  8 Jan 2019 04:51:30 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.75.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 04:51:30 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V6 3/4] powerpc/mm/iommu: Allow migration of cma allocated pages during mm_iommu_get
Date:   Tue,  8 Jan 2019 10:21:09 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010804-0064-0000-0000-000003923B03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010364; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000273; SDB=6.01143338; UDB=6.00595222; IPR=6.00923595;
 MB=3.00025025; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-08 04:51:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010804-0065-0000-0000-00003BF2E2EB
Message-Id: <20190108045110.28597-4-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code doesn't do page migration if the page allocated is a compound page.
With HugeTLB migration support, we can end up allocating hugetlb pages from
CMA region. Also THP pages can be allocated from CMA region. This patch updates
the code to handle compound pages correctly.

This use the new helper get_user_pages_cma_migrate. It does single get_user_pages
with right count, instead of doing one get_user_pages per page. That avoids
reading page table multiple times.

The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
We use the same storage location to store pointers to struct page. We cannot
update all the code path use struct page *, because we access hpas in real mode
and we can't do that struct page * to pfn conversion in real mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/mmu_context_iommu.c | 124 +++++++++-------------------
 1 file changed, 37 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index a712a650a8b6..52ccab294b47 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -21,6 +21,7 @@
 #include <linux/sizes.h>
 #include <asm/mmu_context.h>
 #include <asm/pte-walk.h>
+#include <linux/mm_inline.h>
 
 static DEFINE_MUTEX(mem_list_mutex);
 
@@ -34,8 +35,18 @@ struct mm_iommu_table_group_mem_t {
 	atomic64_t mapped;
 	unsigned int pageshift;
 	u64 ua;			/* userspace address */
-	u64 entries;		/* number of entries in hpas[] */
-	u64 *hpas;		/* vmalloc'ed */
+	u64 entries;		/* number of entries in hpas/hpages[] */
+	/*
+	 * in mm_iommu_get we temporarily use this to store
+	 * struct page address.
+	 *
+	 * We need to convert ua to hpa in real mode. Make it
+	 * simpler by storing physical address.
+	 */
+	union {
+		struct page **hpages;	/* vmalloc'ed */
+		phys_addr_t *hpas;
+	};
 #define MM_IOMMU_TABLE_INVALID_HPA	((uint64_t)-1)
 	u64 dev_hpa;		/* Device memory base address */
 };
@@ -80,64 +91,15 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
-/*
- * Taken from alloc_migrate_target with changes to remove CMA allocations
- */
-struct page *new_iommu_non_cma_page(struct page *page, unsigned long private)
-{
-	gfp_t gfp_mask = GFP_USER;
-	struct page *new_page;
-
-	if (PageCompound(page))
-		return NULL;
-
-	if (PageHighMem(page))
-		gfp_mask |= __GFP_HIGHMEM;
-
-	/*
-	 * We don't want the allocation to force an OOM if possibe
-	 */
-	new_page = alloc_page(gfp_mask | __GFP_NORETRY | __GFP_NOWARN);
-	return new_page;
-}
-
-static int mm_iommu_move_page_from_cma(struct page *page)
-{
-	int ret = 0;
-	LIST_HEAD(cma_migrate_pages);
-
-	/* Ignore huge pages for now */
-	if (PageCompound(page))
-		return -EBUSY;
-
-	lru_add_drain();
-	ret = isolate_lru_page(page);
-	if (ret)
-		return ret;
-
-	list_add(&page->lru, &cma_migrate_pages);
-	put_page(page); /* Drop the gup reference */
-
-	ret = migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
-				NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE);
-	if (ret) {
-		if (!list_empty(&cma_migrate_pages))
-			putback_movable_pages(&cma_migrate_pages);
-	}
-
-	return 0;
-}
-
 static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
-		unsigned long entries, unsigned long dev_hpa,
-		struct mm_iommu_table_group_mem_t **pmem)
+			      unsigned long entries, unsigned long dev_hpa,
+			      struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
-	long i, j, ret = 0, locked_entries = 0;
+	long i, ret = 0, locked_entries = 0;
 	unsigned int pageshift;
 	unsigned long flags;
 	unsigned long cur_ua;
-	struct page *page = NULL;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -187,41 +149,25 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		goto unlock_exit;
 	}
 
+	ret = get_user_pages_cma_migrate(ua, entries, 1, mem->hpages);
+	if (ret != entries) {
+		/* free the reference taken */
+		for (i = 0; i < ret; i++)
+			put_page(mem->hpages[i]);
+
+		vfree(mem->hpas);
+		kfree(mem);
+		ret = -EFAULT;
+		goto unlock_exit;
+	} else {
+		ret = 0;
+	}
+
+	pageshift = PAGE_SHIFT;
 	for (i = 0; i < entries; ++i) {
+		struct page *page = mem->hpages[i];
+
 		cur_ua = ua + (i << PAGE_SHIFT);
-		if (1 != get_user_pages_fast(cur_ua,
-					1/* pages */, 1/* iswrite */, &page)) {
-			ret = -EFAULT;
-			for (j = 0; j < i; ++j)
-				put_page(pfn_to_page(mem->hpas[j] >>
-						PAGE_SHIFT));
-			vfree(mem->hpas);
-			kfree(mem);
-			goto unlock_exit;
-		}
-		/*
-		 * If we get a page from the CMA zone, since we are going to
-		 * be pinning these entries, we might as well move them out
-		 * of the CMA zone if possible. NOTE: faulting in + migration
-		 * can be expensive. Batching can be considered later
-		 */
-		if (is_migrate_cma_page(page)) {
-			if (mm_iommu_move_page_from_cma(page))
-				goto populate;
-			if (1 != get_user_pages_fast(cur_ua,
-						1/* pages */, 1/* iswrite */,
-						&page)) {
-				ret = -EFAULT;
-				for (j = 0; j < i; ++j)
-					put_page(pfn_to_page(mem->hpas[j] >>
-								PAGE_SHIFT));
-				vfree(mem->hpas);
-				kfree(mem);
-				goto unlock_exit;
-			}
-		}
-populate:
-		pageshift = PAGE_SHIFT;
 		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
 			pte_t *pte;
 			struct page *head = compound_head(page);
@@ -239,6 +185,10 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 			local_irq_restore(flags);
 		}
 		mem->pageshift = min(mem->pageshift, pageshift);
+		/*
+		 * We don't need struct page reference any more, switch
+		 * to physical address.
+		 */
 		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
 	}
 
-- 
2.20.1

