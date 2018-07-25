Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC248C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8464920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGYXPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:15:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37614 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbeGYXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:15:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so2112wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Id+mrqjnu26knFarWg2kIgattDnTOoEqy5e1QbH6y3s=;
        b=ckWXXGZopD7OSudK7Z0eHFaLzZxEBORxozyipgSAI0ec5m9gL151O5cMtTx/v8yZV4
         RvlGKTjkSUBmxwC6uZrD+iLHEaFx3pCvisQe6tQQCgUecdW5ouz1rxkXkkU8Hnidhnto
         HJYDdFCWfIYVT4F3L6+zs7tyG1YUG9WLk/9OwZvdm4kYEShPzy9m+XeZ/l3FYkV2tSXq
         ahv2SgkggclJ4Ma1rMw1ZZw+QPGMSydGHXPGy13F883keSmTs9hE5iVIZkOTrL3Snjct
         t9wuB6jRefyumAop/NAO/vD4IbIVkAu215OVCkjYTMpwHiFrl/gS6Prr2umSXfCDKTEf
         G8Ow==
X-Gm-Message-State: AOUpUlGDcI/rukXV+YzhVbU2swr6xYCiLHmifFxOowCtCxv9Ylby4Q3b
        cHikazL/NOhFIf4ruEYRcgY=
X-Google-Smtp-Source: AAOMgpdXr7ZpURGDvQ4QrP7r+GbCiIHafp2RLqyBFS+hqwXk2LaB+lf1hP14ke09aY+/SPFKpK4Tfg==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr5450015wme.13.1532556113866;
        Wed, 25 Jul 2018 15:01:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e204-v6sm5183748wma.8.2018.07.25.15.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:01:53 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 1E390124367;
        Thu, 26 Jul 2018 00:01:51 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 4/5] mm/page_alloc: Move initialization of node and zones to an own function
Date:   Thu, 26 Jul 2018 00:01:43 +0200
Message-Id: <20180725220144.11531-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180725220144.11531-1-osalvador@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, whenever a new node is created/re-used from the memhotplug path,
we call free_area_init_node()->free_area_init_core().
But there is some code that we do not really need to run when we are coming
from such path.

free_area_init_core() performs the following actions:

1) Initializes pgdat internals, such as spinlock, waitqueues and more.
2) Account # nr_all_pages and nr_kernel_pages. These values are used later on
   when creating hash tables.
3) Account number of managed_pages per zone, substracting dma_reserved and memmap pages.
4) Initializes some fields of the zone structure data
5) Calls init_currently_empty_zone to initialize all the freelists
6) Calls memmap_init to initialize all pages belonging to certain zone

When called from memhotplug path, free_area_init_core() only performs actions #1 and #4.

Action #2 is pointless as the zones do not have any pages since either the node was freed,
or we are re-using it, eitherway all zones belonging to this node should have 0 pages.
For the same reason, action #3 results always in manages_pages being 0.

Action #5 and #6 are performed later on when onlining the pages:
 online_pages()->move_pfn_range_to_zone()->init_currently_empty_zone()
 online_pages()->move_pfn_range_to_zone()->memmap_init_zone()

This patch moves the node/zone initializtion to their own function, so it allows us
to create a small version of free_area_init_core(next patch), where we only perform:

1) Initialization of pgdat internals, such as spinlock, waitqueues and more
4) Initialization of some fields of the zone structure data

This patch only introduces these two functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e84a17a5030..a455dc85da19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,21 +6237,9 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
-/*
- * Set up the zone data structures:
- *   - mark all pages reserved
- *   - mark all memory queues empty
- *   - clear the memory bitmaps
- *
- * NOTE: pgdat should get zeroed by caller.
- */
-static void __paginginit free_area_init_core(struct pglist_data *pgdat)
+static void __paginginit pgdat_init_internals(struct pglist_data *pgdat)
 {
-	enum zone_type j;
-	int nid = pgdat->node_id;
-
 	pgdat_resize_init(pgdat);
-
 	pgdat_init_numabalancing(pgdat);
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
@@ -6262,7 +6250,35 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(node_lruvec(pgdat));
+}
+
+static void zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
+							unsigned long remaining_pages)
+{
+	zone->managed_pages = remaining_pages;
+	zone_set_nid(zone, nid);
+	zone->name = zone_names[idx];
+	zone->zone_pgdat = NODE_DATA(nid);
+	spin_lock_init(&zone->lock);
+	zone_seqlock_init(zone);
+	zone_pcp_init(zone);
+}
+
+/*
+ * Set up the zone data structures:
+ *   - mark all pages reserved
+ *   - mark all memory queues empty
+ *   - clear the memory bitmaps
+ *
+ * NOTE: pgdat should get zeroed by caller.
+ * NOTE: this function is only called during early init.
+ */
+static void __paginginit free_area_init_core(struct pglist_data *pgdat)
+{
+	enum zone_type j;
+	int nid = pgdat->node_id;
 
+	pgdat_init_internals(pgdat);
 	pgdat->per_cpu_nodestats = &boot_nodestats;
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
@@ -6310,13 +6326,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
-		zone->managed_pages = freesize;
-		zone_set_nid(zone, nid);
-		zone->name = zone_names[j];
-		zone->zone_pgdat = pgdat;
-		spin_lock_init(&zone->lock);
-		zone_seqlock_init(zone);
-		zone_pcp_init(zone);
+		zone_init_internals(zone, j, nid, freesize);
 
 		if (!size)
 			continue;
-- 
2.13.6

