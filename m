Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A972086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A972086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIKKeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:34:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:62541 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeIKKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:34:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="262426337"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2018 22:36:34 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yosef Lev <levyossi@icloud.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [RFC PATCH 6/9] use atomic for free_area[order].nr_free
Date:   Tue, 11 Sep 2018 13:36:13 +0800
Message-Id: <20180911053616.6894-7-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911053616.6894-1-aaron.lu@intel.com>
References: <20180911053616.6894-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will make free path run concurrently, free_area[].nr_free has
to be atomic.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        | 12 ++++++------
 mm/vmstat.c            |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 84cfa56e2d19..e66b8c63d5d1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -95,7 +95,7 @@ extern int page_group_by_mobility_disabled;
 
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
-	unsigned long		nr_free;
+	atomic_long_t		nr_free;
 };
 
 struct pglist_data;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d0b954783f1d..dff3edc60d71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -701,7 +701,7 @@ static inline void add_to_buddy_common(struct page *page, struct zone *zone,
 					unsigned int order)
 {
 	set_page_order(page, order);
-	zone->free_area[order].nr_free++;
+	atomic_long_inc(&zone->free_area[order].nr_free);
 }
 
 static inline void add_to_buddy_head(struct page *page, struct zone *zone,
@@ -728,7 +728,7 @@ static inline void remove_from_buddy(struct page *page, struct zone *zone,
 					unsigned int order)
 {
 	list_del(&page->lru);
-	zone->free_area[order].nr_free--;
+	atomic_long_dec(&zone->free_area[order].nr_free);
 	rmv_page_order(page);
 }
 
@@ -2225,7 +2225,7 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	int i;
 	int fallback_mt;
 
-	if (area->nr_free == 0)
+	if (atomic_long_read(&area->nr_free) == 0)
 		return -1;
 
 	*can_steal = false;
@@ -3178,7 +3178,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		struct free_area *area = &z->free_area[o];
 		int mt;
 
-		if (!area->nr_free)
+		if (atomic_long_read(&area->nr_free) == 0)
 			continue;
 
 		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
@@ -5029,7 +5029,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			struct free_area *area = &zone->free_area[order];
 			int type;
 
-			nr[order] = area->nr_free;
+			nr[order] = atomic_long_read(&area->nr_free);
 			total += nr[order] << order;
 
 			types[order] = 0;
@@ -5562,7 +5562,7 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	unsigned int order, t;
 	for_each_migratetype_order(order, t) {
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
-		zone->free_area[order].nr_free = 0;
+		atomic_long_set(&zone->free_area[order].nr_free, 0);
 	}
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 06d79271a8ae..c1985550bb9f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1030,7 +1030,7 @@ static void fill_contig_page_info(struct zone *zone,
 		unsigned long blocks;
 
 		/* Count number of free blocks */
-		blocks = zone->free_area[order].nr_free;
+		blocks = atomic_long_read(&zone->free_area[order].nr_free);
 		info->free_blocks_total += blocks;
 
 		/* Count free base pages */
@@ -1353,7 +1353,7 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
 	for (order = 0; order < MAX_ORDER; ++order)
-		seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		seq_printf(m, "%6lu ", atomic_long_read(&zone->free_area[order].nr_free));
 	seq_putc(m, '\n');
 }
 
-- 
2.17.1

