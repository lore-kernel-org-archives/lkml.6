Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE509C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5106220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5106220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeIFKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeIFKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:17:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w865hf3J099935
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 01:44:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2max9x830p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:44:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 6 Sep 2018 01:44:03 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 01:43:59 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w865hw5X46989384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 05:43:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB6A124058;
        Thu,  6 Sep 2018 02:44:27 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78042124055;
        Thu,  6 Sep 2018 02:44:25 -0400 (EDT)
Received: from skywalker.ibmuc.com (unknown [9.102.0.183])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 02:44:25 -0400 (EDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH V2 2/4] mm: Add get_user_pages_cma_migrate
Date:   Thu,  6 Sep 2018 11:13:40 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090605-2213-0000-0000-000002E8E385
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084227; UDB=6.00559595; IPR=6.00864226;
 MB=3.00023138; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 05:44:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090605-2214-0000-0000-00005B754B87
Message-Id: <20180906054342.25094-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060061
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
 include/linux/migrate.h |   3 ++
 mm/migrate.c            | 108 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

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
diff --git a/mm/migrate.c b/mm/migrate.c
index c27e97b5b69d..c26288d407ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3008,3 +3008,111 @@ int migrate_vma(const struct migrate_vma_ops *ops,
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
+	if (PageHuge(page)) {
+
+		struct hstate *h = page_hstate(page);
+		/*
+		 * We don't want to dequeue from the pool because pool pages will
+		 * mostly be from the CMA region.
+		 */
+		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+
+	} else if (PageTransHuge(page)) {
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
+	}
+
+	return __alloc_pages_node(nid, gfp_mask, 0);
+}
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

