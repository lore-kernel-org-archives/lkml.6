Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeCTLal (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:30:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:12415 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeCTLak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:30:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="27257190"
Date: Tue, 20 Mar 2018 19:31:46 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH v4 3/3 update2] mm/free_pcppages_bulk: prefetch buddy while
 not holding lock
Message-ID: <20180320113146.GB24737@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301160950.b561d6b8b561217bad511229@linux-foundation.org>
 <20180302082756.GC6356@intel.com>
 <20180309082431.GB30868@intel.com>
 <988ce376-bdc4-0989-5133-612bfa3f7c45@intel.com>
 <20180313033519.GC13782@intel.com>
 <20180313070404.GA7501@intel.com>
 <5600c827-d22b-136c-6b90-a4b52f40af31@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5600c827-d22b-136c-6b90-a4b52f40af31@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:50:18AM +0100, Vlastimil Babka wrote:
> On 03/13/2018 08:04 AM, Aaron Lu wrote:
> > I tried to avoid adding one more local variable but looks like it caused
> > a lot of pain. What about the following? It doesn't use count any more
> > but prefetch_nr to indicate how many prefetches have happened.
> > 
> > Also, I think it's not worth the risk of disordering pages in free_list
> > by changing list_add_tail() to list_add() as Andrew reminded so I
> > dropped that change too.
> 
> Looks fine, you can add
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, here is the updated patch.

From: Aaron Lu <aaron.lu@intel.com>
Date: Thu, 18 Jan 2018 11:19:59 +0800
Subject: [PATCH v4 3/3 update2] mm/free_pcppages_bulk: prefetch buddy while not holding lock

When a page is freed back to the global pool, its buddy will be checked
to see if it's possible to do a merge. This requires accessing buddy's
page structure and that access could take a long time if it's cache cold.

This patch adds a prefetch to the to-be-freed page's buddy outside of
zone->lock in hope of accessing buddy's page structure later under
zone->lock will be faster. Since we *always* do buddy merging and check
an order-0 page's buddy to try to merge it when it goes into the main
allocator, the cacheline will always come in, i.e. the prefetched data
will never be unused.

Normally, the number of prefetch will be pcp->batch(default=31 and has
an upper limit of (PAGE_SHIFT * 8)=96 on x86_64) but in the case of
pcp's pages get all drained, it will be pcp->count which has an upper
limit of pcp->high. pcp->high, although has a default value of 186
(pcp->batch=31 * 6), can be changed by user through
/proc/sys/vm/percpu_pagelist_fraction and there is no software upper
limit so could be large, like several thousand. For this reason, only
the first pcp->batch number of page's buddy structure is prefetched to
avoid excessive prefetching.

In the meantime, there are two concerns:
1 the prefetch could potentially evict existing cachelines, especially
  for L1D cache since it is not huge;
2 there is some additional instruction overhead, namely calculating
  buddy pfn twice.

For 1, it's hard to say, this microbenchmark though shows good result but
the actual benefit of this patch will be workload/CPU dependant;
For 2, since the calculation is a XOR on two local variables, it's expected
in many cases that cycles spent will be offset by reduced memory latency
later. This is especially true for NUMA machines where multiple CPUs are
contending on zone->lock and the most time consuming part under zone->lock
is the wait of 'struct page' cacheline of the to-be-freed pages and their
buddies.

Test with will-it-scale/page_fault1 full load:

kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
v4.16-rc2+  9034215        7971818       13667135       15677465
patch2/3    9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
this patch 10180856 +6.8%  8506369 +2.3% 14756865 +4.9% 17325324 +3.9%
Note: this patch's performance improvement percent is against patch2/3.

(Changelog stolen from Dave Hansen and Mel Gorman's comments at
http://lkml.kernel.org/r/148a42d8-8306-2f2f-7f7c-86bc118f8ccd@intel.com)

Link: http://lkml.kernel.org/r/20180301062845.26038-4-aaron.lu@intel.com
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
---
update2:
Use a helper function to prefetch buddy as suggested by Dave Hansen.
Drop the change of list_add_tail() to avoid disordering page.

 mm/page_alloc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dafdcdec9c1f..00ea4483f679 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1099,6 +1099,15 @@ static bool bulkfree_pcp_prepare(struct page *page)
 }
 #endif /* CONFIG_DEBUG_VM */
 
+static inline void prefetch_buddy(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long buddy_pfn = __find_buddy_pfn(pfn, 0);
+	struct page *buddy = page + (buddy_pfn - pfn);
+
+	prefetch(buddy);
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone, and of same order.
@@ -1115,6 +1124,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 {
 	int migratetype = 0;
 	int batch_free = 0;
+	int prefetch_nr = 0;
 	bool isolated_pageblocks;
 	struct page *page, *tmp;
 	LIST_HEAD(head);
@@ -1150,6 +1160,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				continue;
 
 			list_add_tail(&page->lru, &head);
+
+			/*
+			 * We are going to put the page back to the global
+			 * pool, prefetch its buddy to speed up later access
+			 * under zone->lock. It is believed the overhead of
+			 * an additional test and calculating buddy_pfn here
+			 * can be offset by reduced memory latency later. To
+			 * avoid excessive prefetching due to large count, only
+			 * prefetch buddy for the first pcp->batch nr of pages.
+			 */
+			if (prefetch_nr++ < pcp->batch)
+				prefetch_buddy(page);
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
-- 
2.14.3
