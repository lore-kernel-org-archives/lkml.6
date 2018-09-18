Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F2ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9E52146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9E52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeIRRbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:31:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbeIRRbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:31:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8IBrtNT035276
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:59:03 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mjxappw01-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:59:03 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 18 Sep 2018 07:59:02 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Sep 2018 07:59:00 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8IBwxa625624744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 11:58:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FF57AE05C;
        Tue, 18 Sep 2018 07:57:43 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B196AE060;
        Tue, 18 Sep 2018 07:57:40 -0400 (EDT)
Received: from skywalker.ibmuc.com (unknown [9.85.75.167])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 18 Sep 2018 07:57:40 -0400 (EDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V3 1/2] mm: Add get_user_pages_cma_migrate
Date:   Tue, 18 Sep 2018 17:28:38 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com>
References: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091811-0068-0000-0000-0000033D1946
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009728; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090083; UDB=6.00563121; IPR=6.00870103;
 MB=3.00023366; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-18 11:59:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091811-0069-0000-0000-000045C5F38A
Message-Id: <20180918115839.22154-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809180122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper does a get_user_pages_fast and if it find pages in the CMA area
it will try to migrate them before taking page reference. This makes sure that
we don't keep non-movable pages (due to page reference count) in the CMA area.
Not able to move pages out of CMA area result in CMA allocation failures.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/hugetlb.h |   2 +
 include/linux/migrate.h |   3 +
 mm/hugetlb.c            |   4 +-
 mm/migrate.c            | 132 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b68e345f0ca..1abccb1a1ecc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -357,6 +357,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
+struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+				     int nid, nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index f2b4abbca55e..d82b35afd2eb 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -286,6 +286,9 @@ static inline int migrate_vma(const struct migrate_vma_ops *ops,
 }
 #endif /* IS_ENABLED(CONFIG_MIGRATE_VMA_HELPER) */
 
+extern int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
+				      struct page **pages);
+
 #endif /* CONFIG_MIGRATION */
 
 #endif /* _LINUX_MIGRATE_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c21775f196b..1abbfcb84f66 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1585,8 +1585,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask)
+struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index d6a2e89b086a..2f92534ea7a1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3006,3 +3006,135 @@ int migrate_vma(const struct migrate_vma_ops *ops,
 }
 EXPORT_SYMBOL(migrate_vma);
 #endif /* defined(MIGRATE_VMA_HELPER) */
+
+static struct page *new_non_cma_page(struct page *page, unsigned long private)
+{
+	/*
+	 * We want to make sure we allocate the new page from the same node
+	 * as the source page.
+	 */
+	int nid = page_to_nid(page);
+	gfp_t gfp_mask = GFP_USER | __GFP_THISNODE;
+
+	if (PageHighMem(page))
+		gfp_mask |= __GFP_HIGHMEM;
+
+	if (PageTransHuge(page)) {
+		struct page *thp;
+		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_THISNODE;
+
+		/*
+		 * Remove the movable mask so that we don't allocate from
+		 * CMA area again.
+		 */
+		thp_gfpmask &= ~__GFP_MOVABLE;
+		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
+		if (!thp)
+			return NULL;
+		prep_transhuge_page(thp);
+		return thp;
+
+#ifdef  CONFIG_HUGETLB_PAGE
+	} else if (PageHuge(page)) {
+
+		struct hstate *h = page_hstate(page);
+		/*
+		 * We don't want to dequeue from the pool because pool pages will
+		 * mostly be from the CMA region.
+		 */
+		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+#endif
+	}
+
+	return __alloc_pages_node(nid, gfp_mask, 0);
+}
+
+/**
+ * get_user_pages_cma_migrate() - pin user pages in memory by migrating pages in CMA region
+ * @start:	starting user address
+ * @nr_pages:	number of pages from start to pin
+ * @write:	whether pages will be written to
+ * @pages:	array that receives pointers to the pages pinned.
+ *		Should be at least nr_pages long.
+ *
+ * Attempt to pin user pages in memory without taking mm->mmap_sem.
+ * If not successful, it will fall back to taking the lock and
+ * calling get_user_pages().
+ *
+ * If the pinned pages are backed by CMA region, we migrate those pages out,
+ * allocating new pages from non-CMA region. This helps in avoiding keeping
+ * pages pinned in the CMA region for a long time thereby resulting in
+ * CMA allocation failures.
+ *
+ * Returns number of pages pinned. This may be fewer than the number
+ * requested. If nr_pages is 0 or negative, returns 0. If no pages
+ * were pinned, returns -errno.
+ */
+
+int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
+			       struct page **pages)
+{
+	int i, ret;
+	bool drain_allow = true;
+	bool migrate_allow = true;
+	LIST_HEAD(cma_page_list);
+
+get_user_again:
+	ret = get_user_pages_fast(start, nr_pages, write, pages);
+	if (ret <= 0)
+		return ret;
+
+	for (i = 0; i < ret; ++i) {
+		/*
+		 * If we get a page from the CMA zone, since we are going to
+		 * be pinning these entries, we might as well move them out
+		 * of the CMA zone if possible.
+		 */
+		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
+			if (PageHuge(pages[i]))
+				isolate_huge_page(pages[i], &cma_page_list);
+			else {
+				struct page *head = compound_head(pages[i]);
+
+				if (!PageLRU(head) && drain_allow) {
+					lru_add_drain_all();
+					drain_allow = false;
+				}
+
+				if (!isolate_lru_page(head)) {
+					list_add_tail(&head->lru, &cma_page_list);
+					mod_node_page_state(page_pgdat(head),
+							    NR_ISOLATED_ANON +
+							    page_is_file_cache(head),
+							    hpage_nr_pages(head));
+				}
+			}
+		}
+	}
+	if (!list_empty(&cma_page_list)) {
+		/*
+		 * drop the above get_user_pages reference.
+		 */
+		for (i = 0; i < ret; ++i)
+			put_page(pages[i]);
+
+		if (migrate_pages(&cma_page_list, new_non_cma_page,
+				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+			/*
+			 * some of the pages failed migration. Do get_user_pages
+			 * without migration.
+			 */
+			migrate_allow = false;
+
+			if (!list_empty(&cma_page_list))
+				putback_movable_pages(&cma_page_list);
+		}
+		/*
+		 * We did migrate all the pages, Try to get the page references again
+		 * migrating any new CMA pages which we failed to isolate earlier.
+		 */
+		drain_allow = true;
+		goto get_user_again;
+	}
+	return ret;
+}
-- 
2.17.1

