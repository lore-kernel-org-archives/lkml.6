Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966331AbeBMXuz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:50:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:53398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966235AbeBMXtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822373"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH V2 21/22] mm/hugetlb: Enable large allocations through gigantic page API
Date: Tue, 13 Feb 2018 07:47:05 -0800
Message-Id: <cf48eb8469111b3dc5fa33735ff10965c4396a99.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocation within the kernel as supported by the SLAB allocators
is limited by the maximum allocatable page order. With the default
maximum page order of 11 it is not possible for the SLAB allocators to
allocate more than 4MB.

Large contiguous allocations are currently possible within the kernel
through the gigantic page support. The creation of which is currently
directed from userspace.

Expose the gigantic page support within the kernel to enable memory
allocations that cannot be fulfilled by the SLAB allocators.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>

---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 82a25880714a..8f2125dc8a86 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -349,6 +349,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
+struct page *alloc_gigantic_page(int nid, unsigned int order, gfp_t gfp_mask);
+void free_gigantic_page(struct page *page, unsigned int order);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a334f5fb730..f3f5e4ef3144 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1060,7 +1060,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+void free_gigantic_page(struct page *page, unsigned int order)
 {
 	free_contig_range(page_to_pfn(page), 1 << order);
 }
@@ -1108,17 +1108,15 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 	return zone_spans_pfn(zone, last_pfn);
 }
 
-static struct page *alloc_gigantic_page(int nid, struct hstate *h)
+struct page *alloc_gigantic_page(int nid, unsigned int order, gfp_t gfp_mask)
 {
-	unsigned int order = huge_page_order(h);
 	unsigned long nr_pages = 1 << order;
 	unsigned long ret, pfn, flags;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	gfp_t gfp_mask;
 
-	gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	gfp_mask = gfp_mask | __GFP_THISNODE;
 	zonelist = node_zonelist(nid, gfp_mask);
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
@@ -1155,7 +1153,7 @@ static struct page *alloc_fresh_gigantic_page_node(struct hstate *h, int nid)
 {
 	struct page *page;
 
-	page = alloc_gigantic_page(nid, h);
+	page = alloc_gigantic_page(nid, huge_page_order(h), htlb_alloc_mask(h));
 	if (page) {
 		prep_compound_gigantic_page(page, huge_page_order(h));
 		prep_new_huge_page(h, page, nid);
-- 
2.13.6
