Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED634C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D10240ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D10240ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeGEG7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:59:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:57026 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeGEG7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:59:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="54179621"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2018 23:59:04 -0700
Subject: [PATCH 01/13] mm: Plumb dev_pagemap instead of vmem_altmap to
 memmap_init_zone()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        vishal.l.verma@intel.com, hch@lst.de, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 23:49:07 -0700
Message-ID: <153077334720.40830.5284059575516542524.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for teaching memmap_init_zone() how to initialize
ZONE_DEVICE pages, pass in dev_pagemap.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memory_hotplug.h |    3 ++-
 include/linux/mm.h             |    2 +-
 kernel/memremap.c              |    2 +-
 mm/memory_hotplug.c            |    4 ++--
 mm/page_alloc.c                |    5 ++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 4e9828cda7a2..e60085b2824d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -14,6 +14,7 @@ struct mem_section;
 struct memory_block;
 struct resource;
 struct vmem_altmap;
+struct dev_pagemap;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
@@ -326,7 +327,7 @@ extern int add_memory_resource(int nid, struct resource *resource, bool online);
 extern int arch_add_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap, bool want_memblock);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap);
+		unsigned long nr_pages, struct dev_pagemap *pgmap);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern void remove_memory(int nid, u64 start, u64 size);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..319d01372efa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2140,7 +2140,7 @@ static inline void zero_resv_unavail(void) {}
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
-		enum memmap_context, struct vmem_altmap *);
+		enum memmap_context, struct dev_pagemap *);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index ecee37b44aa1..58327259420d 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -244,7 +244,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
 		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
 		if (!error)
 			move_pfn_range_to_zone(zone, align_start >> PAGE_SHIFT,
-					align_size >> PAGE_SHIFT, altmap);
+					align_size >> PAGE_SHIFT, pgmap);
 	}
 
 	mem_hotplug_done();
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7deb49f69e27..aae4e6cc65e9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -779,7 +779,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 }
 
 void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct dev_pagemap *pgmap)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nid = pgdat->node_id;
@@ -805,7 +805,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
 	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
-			MEMMAP_HOTPLUG, altmap);
+			MEMMAP_HOTPLUG, pgmap);
 
 	set_zone_contiguous(zone);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..545a5860cce7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5459,10 +5459,11 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn, enum memmap_context context,
-		struct vmem_altmap *altmap)
+		struct dev_pagemap *pgmap)
 {
 	unsigned long end_pfn = start_pfn + size;
 	pg_data_t *pgdat = NODE_DATA(nid);
+	struct vmem_altmap *altmap = NULL;
 	unsigned long pfn;
 	unsigned long nr_initialised = 0;
 	struct page *page;
@@ -5477,6 +5478,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	 * Honor reservation requested by the driver for this ZONE_DEVICE
 	 * memory
 	 */
+	if (pgmap && pgmap->altmap_valid)
+		altmap = &pgmap->altmap;
 	if (altmap && start_pfn == altmap->base_pfn)
 		start_pfn += altmap->reserve;
 

