Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932757AbeBLWXt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:23:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58354 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeBLWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:48 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 2/3] mm: add find_alloc_contig_pages() interface
Date: Mon, 12 Feb 2018 14:20:55 -0800
Message-Id: <20180212222056.9735-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212222056.9735-1-mike.kravetz@oracle.com>
References: <20180212222056.9735-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_alloc_contig_pages() is a new interface that attempts to locate
and allocate a contiguous range of pages.  It is provided as a more
convenient interface to the existing alloc_contig_range() interface
which is used by CMA, memory hotplug and gigantic huge pages.

When attempting to allocate a range of pages, migration is employed
if possible.  There is no guarantee that the routine will succeed.
So, the user must be prepared for failure and have a fall back plan.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/gfp.h | 12 ++++++++
 mm/page_alloc.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b44d32..456979022956 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
 extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
+extern struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
+						int nid, nodemask_t *nodemask);
+extern void free_contig_pages(struct page *page, unsigned nr_pages);
+#else
+static inline page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
+						int nid, nodemask_t *nodemask)
+{
+	return NULL;
+}
+static void free_contig_pages(struct page *page, unsigned nr_pages)
+{
+}
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 064458f317bf..0a5a547acdbf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
+#include <linux/mmzone.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1873,9 +1874,13 @@ static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 {
 	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
 }
+#define contig_alloc_migratetype_ok(migratetype) \
+	((migratetype) == MIGRATE_CMA || (migratetype) == MIGRATE_MOVABLE)
 #else
 static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 					unsigned int order) { return NULL; }
+#define contig_alloc_migratetype_ok(migratetype) \
+	((migratetype) == MIGRATE_MOVABLE)
 #endif
 
 /*
@@ -7633,6 +7638,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	if (!contig_alloc_migratetype_ok(migratetype))
+		return -EINVAL;
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
@@ -7723,8 +7731,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, false)) {
-		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
-			__func__, outer_start, end);
+		if (!(migratetype == MIGRATE_MOVABLE)) /* only print for CMA */
+			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
+				__func__, outer_start, end);
 		ret = -EBUSY;
 		goto done;
 	}
@@ -7760,6 +7769,82 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
 	}
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
+
+static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
+					unsigned long nr_pages)
+{
+	unsigned long i, end_pfn = start_pfn + nr_pages;
+	struct page *page;
+
+	for (i = start_pfn; i < end_pfn; i++) {
+		if (!pfn_valid(i))
+			return false;
+
+		page = pfn_to_page(i);
+
+		if (page_zone(page) != z)
+			return false;
+
+	}
+
+	return true;
+}
+
+/**
+ * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
+ *				range of pages
+ * @order:	number of pages
+ * @gfp:	gfp mask used to limit search as well as during compaction
+ * @nid:	target node
+ * @nodemask:	mask of other possible nodes
+ *
+ * Returns pointer to 'order' pages on success, or NULL if not successful.
+ *
+ * Pages can be freed with a call to free_contig_pages(), or by manually
+ * calling __free_page() for each page allocated.
+ */
+struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
+					int nid, nodemask_t *nodemask)
+{
+	unsigned long pfn, nr_pages, flags;
+	struct page *ret_page = NULL;
+	struct zonelist *zonelist;
+	struct zoneref *z;
+	struct zone *zone;
+	int rc;
+
+	nr_pages = 1 << order;
+	zonelist = node_zonelist(nid, gfp);
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
+					nodemask) {
+		spin_lock_irqsave(&zone->lock, flags);
+		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
+		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
+			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
+				spin_unlock_irqrestore(&zone->lock, flags);
+
+				rc = alloc_contig_range(pfn, pfn + nr_pages,
+							MIGRATE_MOVABLE, gfp);
+				if (!rc) {
+					ret_page = pfn_to_page(pfn);
+					return ret_page;
+				}
+				spin_lock_irqsave(&zone->lock, flags);
+			}
+			pfn += nr_pages;
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	return ret_page;
+}
+EXPORT_SYMBOL_GPL(find_alloc_contig_pages);
+
+void free_contig_pages(struct page *page, unsigned nr_pages)
+{
+	free_contig_range(page_to_pfn(page), nr_pages);
+}
+EXPORT_SYMBOL_GPL(free_contig_pages);
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.13.6
