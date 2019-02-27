Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A546C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61EA2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfB0OsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:48:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfB0OsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:48:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1REmB9f133979
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:48:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwupbbcp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:48:13 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 27 Feb 2019 14:48:08 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 14:48:04 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1REm38L64159882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:48:04 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB755C6055;
        Wed, 27 Feb 2019 14:48:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FB33C605A;
        Wed, 27 Feb 2019 14:48:00 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.49.135])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 14:48:00 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v8 2/4] mm: Update get_user_pages_longterm to migrate pages allocated from CMA region
Date:   Wed, 27 Feb 2019 20:17:34 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
References: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022714-8235-0000-0000-00000E66128C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010674; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167143; UDB=6.00609716; IPR=6.00947753;
 MB=3.00025765; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 14:48:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022714-8236-0000-0000-0000449E73B8
Message-Id: <20190227144736.5872-3-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates get_user_pages_longterm to migrate pages allocated out
of CMA region. This makes sure that we don't keep non-movable pages (due to page
reference count) in the CMA area.

This will be used by ppc64 in a later patch to avoid pinning pages in the CMA
region. ppc64 uses CMA region for allocation of the hardware page table (hash page
table) and not able to migrate pages out of CMA region results in page table
allocation failures.

One case where we hit this easy is when a guest using a VFIO passthrough device.
VFIO locks all the guest's memory and if the guest memory is backed by CMA
region, it becomes unmovable resulting in fragmenting the CMA and possibly
preventing other guests from allocation a large enough hash page table.

NOTE: We allocate the new page without using __GFP_THISNODE

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/hugetlb.h |   2 +
 include/linux/mm.h      |   3 +-
 mm/gup.c                | 200 +++++++++++++++++++++++++++++++++++-----
 mm/hugetlb.c            |   4 +-
 4 files changed, 182 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f48c91..1eed0cdaec0e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -371,6 +371,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
+struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+				     int nid, nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb6408fe73..20ec56f8e2bb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1536,7 +1536,8 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
-#ifdef CONFIG_FS_DAX
+
+#if defined(CONFIG_FS_DAX) || defined(CONFIG_CMA)
 long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
diff --git a/mm/gup.c b/mm/gup.c
index 75029649baca..22291db50013 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -13,6 +13,9 @@
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
 #include <linux/hugetlb.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/sched/mm.h>
 
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
@@ -1126,7 +1129,167 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
+#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
+
 #ifdef CONFIG_FS_DAX
+static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	long i;
+	struct vm_area_struct *vma_prev = NULL;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct vm_area_struct *vma = vmas[i];
+
+		if (vma == vma_prev)
+			continue;
+
+		vma_prev = vma;
+
+		if (vma_is_fsdax(vma))
+			return true;
+	}
+	return false;
+}
+#else
+static inline bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_CMA
+static struct page *new_non_cma_page(struct page *page, unsigned long private)
+{
+	/*
+	 * We want to make sure we allocate the new page from the same node
+	 * as the source page.
+	 */
+	int nid = page_to_nid(page);
+	/*
+	 * Trying to allocate a page for migration. Ignore allocation
+	 * failure warnings. We don't force __GFP_THISNODE here because
+	 * this node here is the node where we have CMA reservation and
+	 * in some case these nodes will have really less non movable
+	 * allocation memory.
+	 */
+	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
+
+	if (PageHighMem(page))
+		gfp_mask |= __GFP_HIGHMEM;
+
+#ifdef CONFIG_HUGETLB_PAGE
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(page);
+		/*
+		 * We don't want to dequeue from the pool because pool pages will
+		 * mostly be from the CMA region.
+		 */
+		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+	}
+#endif
+	if (PageTransHuge(page)) {
+		struct page *thp;
+		/*
+		 * ignore allocation failure warnings
+		 */
+		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
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
+static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
+					unsigned int gup_flags,
+					struct page **pages,
+					struct vm_area_struct **vmas)
+{
+	long i;
+	bool drain_allow = true;
+	bool migrate_allow = true;
+	LIST_HEAD(cma_page_list);
+
+check_again:
+	for (i = 0; i < nr_pages; i++) {
+		/*
+		 * If we get a page from the CMA zone, since we are going to
+		 * be pinning these entries, we might as well move them out
+		 * of the CMA zone if possible.
+		 */
+		if (is_migrate_cma_page(pages[i])) {
+
+			struct page *head = compound_head(pages[i]);
+
+			if (PageHuge(head)) {
+				isolate_huge_page(head, &cma_page_list);
+			} else {
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
+
+	if (!list_empty(&cma_page_list)) {
+		/*
+		 * drop the above get_user_pages reference.
+		 */
+		for (i = 0; i < nr_pages; i++)
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
+		nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+		if ((nr_pages > 0) && migrate_allow) {
+			drain_allow = true;
+			goto check_again;
+		}
+	}
+
+	return nr_pages;
+}
+#else
+static inline long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
+					       unsigned int gup_flags,
+					       struct page **pages,
+					       struct vm_area_struct **vmas)
+{
+	return nr_pages;
+}
+#endif
+
 /*
  * This is the same as get_user_pages() in that it assumes we are
  * operating on the current task's mm, but it goes further to validate
@@ -1140,11 +1303,11 @@ EXPORT_SYMBOL(get_user_pages);
  * Contrast this to iov_iter_get_pages() usages which are transient.
  */
 long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
-		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas_arg)
+			     unsigned int gup_flags, struct page **pages,
+			     struct vm_area_struct **vmas_arg)
 {
 	struct vm_area_struct **vmas = vmas_arg;
-	struct vm_area_struct *vma_prev = NULL;
+	unsigned long flags;
 	long rc, i;
 
 	if (!pages)
@@ -1157,31 +1320,20 @@ long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
 			return -ENOMEM;
 	}
 
+	flags = memalloc_nocma_save();
 	rc = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+	memalloc_nocma_restore(flags);
+	if (rc < 0)
+		goto out;
 
-	for (i = 0; i < rc; i++) {
-		struct vm_area_struct *vma = vmas[i];
-
-		if (vma == vma_prev)
-			continue;
-
-		vma_prev = vma;
-
-		if (vma_is_fsdax(vma))
-			break;
-	}
-
-	/*
-	 * Either get_user_pages() failed, or the vma validation
-	 * succeeded, in either case we don't need to put_page() before
-	 * returning.
-	 */
-	if (i >= rc)
+	if (check_dax_vmas(vmas, rc)) {
+		for (i = 0; i < rc; i++)
+			put_page(pages[i]);
+		rc = -EOPNOTSUPP;
 		goto out;
+	}
 
-	for (i = 0; i < rc; i++)
-		put_page(pages[i]);
-	rc = -EOPNOTSUPP;
+	rc = check_and_migrate_cma_pages(start, rc, gup_flags, pages, vmas);
 out:
 	if (vmas != vmas_arg)
 		kfree(vmas);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index afef61656c1e..c80f0c16a226 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1586,8 +1586,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask)
+struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
 
-- 
2.20.1

