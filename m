Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeBDG6b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 01:58:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbeBDG60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 01:58:26 -0500
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com
Subject: [PATCH] mm/migrate: Rename various page allocation helper functions
Date: Sun,  4 Feb 2018 12:28:16 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18020406-0020-0000-0000-000003F2123B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020406-0021-0000-0000-0000428482AA
Message-Id: <20180204065816.6885-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802040090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation helper functions for migrate_pages() remmain scattered with
similar names making them really confusing. Rename these functions based
on type of the intended migration. Function alloc_misplaced_dst_page()
remains unchanged as its highly specialized. The renamed functions are
listed below. Functionality of migration remains unchanged.

1. alloc_migrate_target -> new_page_alloc
2. new_node_page -> new_page_alloc_othernode
3. new_page -> new_page_alloc_keepnode
4. alloc_new_node_page -> new_page_alloc_node
5. new_page -> new_page_alloc_mempolicy

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
- Just renamed these function as suggested
- Previous RFC discussions (https://patchwork.kernel.org/patch/10191331/)

 include/linux/page-isolation.h |  2 +-
 mm/internal.h                  |  2 +-
 mm/memory-failure.c            | 11 ++++++-----
 mm/memory_hotplug.c            |  5 +++--
 mm/mempolicy.c                 | 15 +++++++++------
 mm/migrate.c                   |  2 +-
 mm/page_alloc.c                |  2 +-
 mm/page_isolation.c            |  2 +-
 8 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 4ae347cbc36d..2e77a88a37fc 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -63,6 +63,6 @@ undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			bool skip_hwpoisoned_pages);
 
-struct page *alloc_migrate_target(struct page *page, unsigned long private);
+struct page *new_page_alloc(struct page *page, unsigned long private);
 
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index 62d8c34e63d5..ef03f0eed209 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -540,5 +540,5 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+extern struct page *new_page_alloc_node(struct page *page, unsigned long node);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 264e020ef60c..30789042e3cd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1499,7 +1499,8 @@ int unpoison_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(unpoison_memory);
 
-static struct page *new_page(struct page *p, unsigned long private)
+static struct page *new_page_alloc_keepnode(struct page *p,
+					unsigned long private)
 {
 	int nid = page_to_nid(p);
 
@@ -1600,8 +1601,8 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		return -EBUSY;
 	}
 
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
+	ret = migrate_pages(&pagelist, new_page_alloc_keepnode, NULL,
+			MPOL_MF_MOVE_ALL, MIGRATE_SYNC, MR_MEMORY_FAILURE);
 	if (ret) {
 		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
 			pfn, ret, page->flags, &page->flags);
@@ -1678,8 +1679,8 @@ static int __soft_offline_page(struct page *page, int flags)
 			inc_node_page_state(page, NR_ISOLATED_ANON +
 						page_is_file_cache(page));
 		list_add(&page->lru, &pagelist);
-		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-					MIGRATE_SYNC, MR_MEMORY_FAILURE);
+		ret = migrate_pages(&pagelist, new_page_alloc_keepnode, NULL,
+			MPOL_MF_MOVE_ALL, MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (ret) {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6a9bee33ffa7..f1dc28f5057e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1341,7 +1341,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 	return 0;
 }
 
-static struct page *new_node_page(struct page *page, unsigned long private)
+static struct page *new_page_alloc_othernode(struct page *page,
+					unsigned long private)
 {
 	int nid = page_to_nid(page);
 	nodemask_t nmask = node_states[N_MEMORY];
@@ -1428,7 +1429,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		}
 
 		/* Allocate a new page from the nearest neighbor node */
-		ret = migrate_pages(&source, new_node_page, NULL, 0,
+		ret = migrate_pages(&source, new_page_alloc_othernode, NULL, 0,
 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret)
 			putback_movable_pages(&source);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a8b7d59002e8..fd3fd1de9b3d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -918,7 +918,7 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
 }
 
 /* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
+struct page *new_page_alloc_node(struct page *page, unsigned long node)
 {
 	if (PageHuge(page))
 		return alloc_huge_page_node(page_hstate(compound_head(page)),
@@ -962,7 +962,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
+		err = migrate_pages(&pagelist, new_page_alloc_node, NULL, dest,
 					MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
@@ -1083,7 +1083,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
  * list of pages handed to migrate_pages()--which is how we get here--
  * is in virtual address order.
  */
-static struct page *new_page(struct page *page, unsigned long start)
+static struct page *new_page_alloc_mempolicy(struct page *page,
+					unsigned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long uninitialized_var(address);
@@ -1128,7 +1129,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	return -ENOSYS;
 }
 
-static struct page *new_page(struct page *page, unsigned long start)
+static struct page *new_page_alloc_mempolicy(struct page *page,
+					unsigned long start)
 {
 	return NULL;
 }
@@ -1213,8 +1215,9 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
-			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+			nr_failed = migrate_pages(&pagelist,
+				new_page_alloc_mempolicy, NULL, start,
+				MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 5d0dc7b85f90..c39e73fa9223 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1465,7 +1465,7 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	if (list_empty(pagelist))
 		return 0;
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
+	err = migrate_pages(pagelist, new_page_alloc_node, NULL, node,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2b42f603b1a..ea4609275b67 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7622,7 +7622,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
-		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
+		ret = migrate_pages(&cc->migratepages, new_page_alloc,
 				    NULL, 0, cc->mode, MR_CMA);
 	}
 	if (ret < 0) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 53d801235e22..345c7b1bea99 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -293,7 +293,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	return pfn < end_pfn ? -EBUSY : 0;
 }
 
-struct page *alloc_migrate_target(struct page *page, unsigned long private)
+struct page *new_page_alloc(struct page *page, unsigned long private)
 {
 	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
 }
-- 
2.11.0
