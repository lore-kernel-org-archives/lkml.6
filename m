Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08682C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A862087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A862087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJJNd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:33:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:7191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbeJJNd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:33:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 23:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,363,1534834800"; 
   d="scan'208";a="76837209"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 09 Oct 2018 23:13:12 -0700
Subject: [PATCH v3 1/3] mm: Shuffle initial free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Tue, 09 Oct 2018 23:01:25 -0700
Message-ID: <153915128508.632221.16699296364733623799.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153915127964.632221.6049959208915289294.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153915127964.632221.6049959208915289294.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some data exfiltration and return-oriented-programming attacks rely on
the ability to infer the location of sensitive data objects. The kernel
page allocator, especially early in system boot, has predictable
first-in-first out behavior for physical pages. Pages are freed in
physical address order when first onlined.

Introduce shuffle_free_memory(), and its helper shuffle_zone(), to
perform a Fisher-Yates shuffle of the page allocator 'free_area' lists
when they are initially populated with free memory at boot and at
hotplug time.

Quoting Kees:
    "While we already have a base-address randomization
     (CONFIG_RANDOMIZE_MEMORY), attacks against the same hardware and
     memory layouts would certainly be using the predictability of
     allocation ordering (i.e. for attacks where the base address isn't
     important: only the relative positions between allocated memory).
     This is common in lots of heap-style attacks. They try to gain
     control over ordering by spraying allocations, etc.

     I'd really like to see this because it gives us something similar
     to CONFIG_SLAB_FREELIST_RANDOM but for the page allocator."

Another motivation for this change is performance in the presence of a
memory-side cache. In the future, memory-side-cache technology will be
available on generally available server platforms. The proposed
randomization approach has been measured to improve the cache conflict
rate by a factor of 2.5X on a well-known Java benchmark. It avoids
performance peaks and valleys to provide more predictable performance.

While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
caches it leaves vast bulk of memory to be predictably in order
allocated. That ordering can be detected by a memory side-cache.

The shuffling is done in terms of 'shuffle_page_order' sized free pages
where the default shuffle_page_order is MAX_ORDER-1 i.e. 10, 4MB this
trades off randomization granularity for time spent shuffling.
MAX_ORDER-1 was chosen to be minimally invasive to the page allocator
while still showing memory-side cache behavior improvements.

The performance impact of the shuffling appears to be in the noise
compared to other memory initialization work. Also the bulk of the work
is done in the background as a part of deferred_init_memmap().

This initial randomization can be undone over time so a follow-on patch
is introduced to inject entropy on page free decisions. It is reasonable
to ask if the page free entropy is sufficientm but not enough is due to
the in-order initial freeing of pages. At the start of that process
putting page1 in front or behind page0 still keeps them close together,
page2 is still near page1 and has a high chance of being adjacent. As
more pages are added ordering diversity improves, but there is still
high page locality for the low address pages and this leads to no
significant impact to the cache conflict rate.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/list.h   |   17 +++++
 include/linux/mm.h     |    5 +
 include/linux/mmzone.h |    4 +
 mm/memblock.c          |    9 ++-
 mm/memory_hotplug.c    |    2 +
 mm/page_alloc.c        |  172 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index de04cc5ed536..43f963328d7c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -150,6 +150,23 @@ static inline void list_replace_init(struct list_head *old,
 	INIT_LIST_HEAD(old);
 }
 
+/**
+ * list_swap - replace entry1 with entry2 and re-add entry1 at entry2's position
+ * @entry1: the location to place entry2
+ * @entry2: the location to place entry1
+ */
+static inline void list_swap(struct list_head *entry1,
+			     struct list_head *entry2)
+{
+	struct list_head *pos = entry2->prev;
+
+	list_del(entry2);
+	list_replace(entry1, entry2);
+	if (pos == entry1)
+		pos = entry2;
+	list_add(entry1, pos);
+}
+
 /**
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 273d4dbd3883..1692c1a36883 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2042,7 +2042,10 @@ extern void adjust_managed_page_count(struct page *page, long count);
 extern void mem_init_print_info(const char *str);
 
 extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
-
+extern void shuffle_free_memory(pg_data_t *pgdat, unsigned long start_pfn,
+		unsigned long end_pfn);
+extern void shuffle_zone(struct zone *z, unsigned long start_pfn,
+		unsigned long end_pfn);
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void __free_reserved_page(struct page *page)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ea29f7081f9d..15029fedbfe6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1273,6 +1273,10 @@ void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
 #define sparse_index_init(_sec, _nid)  do {} while (0)
+static inline int pfn_present(unsigned long pfn)
+{
+	return 1;
+}
 #endif /* CONFIG_SPARSEMEM */
 
 /*
diff --git a/mm/memblock.c b/mm/memblock.c
index b0ebca546ba1..5b57964352a4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1985,9 +1985,16 @@ static unsigned long __init free_low_memory_core_early(void)
 	 *  low ram will be on Node1
 	 */
 	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
-				NULL)
+				NULL) {
+		pg_data_t *pgdat;
+
 		count += __free_memory_core(start, end);
 
+		for_each_online_pgdat(pgdat)
+			shuffle_free_memory(pgdat, PHYS_PFN(start),
+					PHYS_PFN(end));
+	}
+
 	return count;
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 61972da38d93..34c9b6eb3159 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -894,6 +894,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	zone->zone_pgdat->node_present_pages += onlined_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
+	shuffle_zone(zone, pfn, zone_end_pfn(zone));
+
 	if (onlined_pages) {
 		node_states_set_node(nid, &arg);
 		if (need_zonelists_rebuild)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a02ce11c49f2..14a9a8273ab9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -54,6 +54,7 @@
 #include <trace/events/kmem.h>
 #include <trace/events/oom.h>
 #include <linux/prefetch.h>
+#include <linux/random.h>
 #include <linux/mm_inline.h>
 #include <linux/migrate.h>
 #include <linux/hugetlb.h>
@@ -72,6 +73,13 @@
 #include <asm/div64.h>
 #include "internal.h"
 
+/*
+ * page_alloc.shuffle_page_order gates which page orders are shuffled by
+ * shuffle_zone() during memory initialization.
+ */
+static int __read_mostly shuffle_page_order = MAX_ORDER-1;
+module_param(shuffle_page_order, int, 0444);
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -1042,6 +1050,168 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	return true;
 }
 
+/*
+ * For two pages to be swapped in the shuffle, they must be free (on a
+ * 'free_area' lru), have the same order, and have the same migratetype.
+ */
+static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order)
+{
+	struct page *page;
+
+	/*
+	 * Given we're dealing with randomly selected pfns in a zone we
+	 * need to ask questions like...
+	 */
+
+	/* ...is the pfn even in the memmap? */
+	if (!pfn_valid_within(pfn))
+		return NULL;
+
+	/* ...is the pfn in a present section or a hole? */
+	if (!pfn_present(pfn))
+		return NULL;
+
+	/* ...is the page free and currently on a free_area list? */
+	page = pfn_to_page(pfn);
+	if (!PageBuddy(page))
+		return NULL;
+
+	/*
+	 * ...is the page on the same list as the page we will
+	 * shuffle it with?
+	 */
+	if (page_order(page) != order)
+		return NULL;
+
+	return page;
+}
+
+/*
+ * Fisher-Yates shuffle the freelist which prescribes iterating through
+ * an array, pfns in this case, and randomly swapping each entry with
+ * another in the span, end_pfn - start_pfn.
+ *
+ * To keep the implementation simple it does not attempt to correct for
+ * sources of bias in the distribution, like modulo bias or
+ * pseudo-random number generator bias. I.e. the expectation is that
+ * this shuffling raises the bar for attacks that exploit the
+ * predictability of page allocations, but need not be a perfect
+ * shuffle.
+ *
+ * Note that we don't use @z->zone_start_pfn and zone_end_pfn(@z)
+ * directly since the caller may be aware of holes in the zone and can
+ * improve the accuracy of the random pfn selection.
+ */
+#define SHUFFLE_RETRY 10
+static void __meminit shuffle_zone_order(struct zone *z, unsigned long start_pfn,
+		unsigned long end_pfn, const int order)
+{
+	unsigned long i, flags;
+	const int order_pages = 1 << order;
+
+	if (start_pfn < z->zone_start_pfn)
+		start_pfn = z->zone_start_pfn;
+	if (end_pfn > zone_end_pfn(z))
+		end_pfn = zone_end_pfn(z);
+
+	/* probably means that start/end were outside the zone */
+	if (end_pfn <= start_pfn)
+		return;
+	spin_lock_irqsave(&z->lock, flags);
+	start_pfn = ALIGN(start_pfn, order_pages);
+	for (i = start_pfn; i < end_pfn; i += order_pages) {
+		unsigned long j;
+		int migratetype, retry;
+		struct page *page_i, *page_j;
+
+		/*
+		 * We expect page_i, in the sub-range of a zone being
+		 * added (@start_pfn to @end_pfn), to more likely be
+		 * valid compared to page_j randomly selected in the
+		 * span @zone_start_pfn to @spanned_pages.
+		 */
+		page_i = shuffle_valid_page(i, order);
+		if (!page_i)
+			continue;
+
+		for (retry = 0; retry < SHUFFLE_RETRY; retry++) {
+			/*
+			 * Pick a random order aligned page from the
+			 * start of the zone. Use the *whole* zone here
+			 * so that if it is freed in tiny pieces that we
+			 * randomize in the whole zone, not just within
+			 * those fragments.
+			 *
+			 * Since page_j comes from a potentially sparse
+			 * address range we want to try a bit harder to
+			 * find a shuffle point for page_i.
+			 */
+			j = z->zone_start_pfn +
+				ALIGN_DOWN(get_random_long() % z->spanned_pages,
+						order_pages);
+			page_j = shuffle_valid_page(j, order);
+			if (page_j && page_j != page_i)
+				break;
+		}
+		if (retry >= SHUFFLE_RETRY) {
+			pr_debug("%s: failed to swap %#lx\n", __func__, i);
+			continue;
+		}
+
+		/*
+		 * Each migratetype corresponds to its own list, make
+		 * sure the types match otherwise we're moving pages to
+		 * lists where they do not belong.
+		 */
+		migratetype = get_pageblock_migratetype(page_i);
+		if (get_pageblock_migratetype(page_j) != migratetype) {
+			pr_debug("%s: migratetype mismatch %#lx\n", __func__, i);
+			continue;
+		}
+
+		list_swap(&page_i->lru, &page_j->lru);
+
+		pr_debug("%s: swap: %#lx -> %#lx\n", __func__, i, j);
+
+		/* take it easy on the zone lock */
+		if ((i % (100 * order_pages)) == 0) {
+			spin_unlock_irqrestore(&z->lock, flags);
+			cond_resched();
+			spin_lock_irqsave(&z->lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&z->lock, flags);
+}
+
+void __meminit shuffle_zone(struct zone *z, unsigned long start_pfn,
+               unsigned long end_pfn)
+{
+       int i;
+
+       /* shuffle all the orders at the specified order and higher */
+       for (i = shuffle_page_order; i < MAX_ORDER; i++)
+               shuffle_zone_order(z, start_pfn, end_pfn, i);
+}
+
+/**
+ * shuffle_free_memory - reduce the predictability of the page allocator
+ * @pgdat: node page data
+ * @start_pfn: Limit the shuffle to the greater of this value or zone start
+ * @end_pfn: Limit the shuffle to the less of this value or zone end
+ *
+ * While shuffle_zone() attempts to avoid holes with pfn_valid() and
+ * pfn_present() they can not report sub-section sized holes. @start_pfn
+ * and @end_pfn limit the shuffle to the exact memory pages being freed.
+ */
+void __meminit shuffle_free_memory(pg_data_t *pgdat, unsigned long start_pfn,
+		unsigned long end_pfn)
+{
+	struct zone *z;
+
+	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
+		shuffle_zone(z, start_pfn, end_pfn);
+}
+
 #ifdef CONFIG_DEBUG_VM
 static inline bool free_pcp_prepare(struct page *page)
 {
@@ -1595,6 +1765,8 @@ static int __init deferred_init_memmap(void *data)
 	}
 	pgdat_resize_unlock(pgdat, &flags);
 
+	shuffle_zone(zone, first_init_pfn, zone_end_pfn(zone));
+
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
 

