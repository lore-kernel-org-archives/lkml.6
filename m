Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeAaXOf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:14:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbeAaXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:04:39 -0500
From: daniel.m.jordan@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
Subject: [RFC PATCH v1 03/13] mm: add lock array to pgdat and batch fields to struct page
Date: Wed, 31 Jan 2018 18:04:03 -0500
Message-Id: <20180131230413.27653-4-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply adds the array of locks and struct page fields.
Ignore for now where the struct page fields are: we need to find a place
to put them that doesn't enlarge the struct.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/mm_types.h | 5 +++++
 include/linux/mmzone.h   | 7 +++++++
 mm/page_alloc.c          | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cfd0ac4e5e0e..6e9d26f0cecf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -190,6 +190,11 @@ struct page {
 		struct kmem_cache *slab_cache;	/* SL[AU]B: Pointer to slab */
 	};
 
+	struct {
+		unsigned lru_batch;
+		bool lru_sentinel;
+	};
+
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup *mem_cgroup;
 #endif
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c05529473b80..5ffb36b3f665 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -249,6 +249,11 @@ struct lruvec {
 #define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
 #define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
 
+#define NUM_LRU_BATCH_LOCKS 32
+struct lru_batch_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
 /* Isolate unmapped file */
 #define ISOLATE_UNMAPPED	((__force isolate_mode_t)0x2)
 /* Isolate for asynchronous migration */
@@ -715,6 +720,8 @@ typedef struct pglist_data {
 
 	unsigned long		flags;
 
+	struct lru_batch_lock lru_batch_locks[NUM_LRU_BATCH_LOCKS];
+
 	ZONE_PADDING(_pad2_)
 
 	/* Per-node vmstats */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d7078ed68b01..3248b48e11ca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6070,6 +6070,7 @@ static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
  */
 static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 {
+	size_t i;
 	enum zone_type j;
 	int nid = pgdat->node_id;
 
@@ -6092,6 +6093,8 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(node_lruvec(pgdat));
+	for (i = 0; i < NUM_LRU_BATCH_LOCKS; ++i)
+		spin_lock_init(&pgdat->lru_batch_locks[i].lock);
 
 	pgdat->per_cpu_nodestats = &boot_nodestats;
 
-- 
2.16.1
