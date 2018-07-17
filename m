Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A91820C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A91820C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeGQL3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:29:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeGQL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:28:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so801229wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRN6BVIjhi4Szt9i0nsQJEBXG+lbTWrcyANSNDxqxJY=;
        b=TSwxCFCvYiksyxwxOuQl6kMC2Pho/cKolC79IMLp+RTOWAPL2zPVmY/ZkannE2IBLv
         zlxD3s+J38oQRQYzalBMjQQHHDAO+ogaX0ZpEXN+vBMAB5ZVKTTKGxqZS9nwV/pjyWVh
         QMq7eM9mVOhaaT8XLxs/OO1MPf++8HxSVJIchvCbeXnt1dYbe5HAoYioswH8Sxsw9o8N
         7RABDhGeV9ohOs0xT4SWTi9ijRKDU/2qf/KCTgPRP2+pBPXq/FVHeuQerJFYvPjNx2lE
         VkOLU4SWv/3SuOPQpOM/IEcovfsC8xu0aBSiBY/cazoa6EH3od2+rVCauTWZzKVXGLo7
         5M2w==
X-Gm-Message-State: AOUpUlHrbn/6vcQBOjC+xbJtz/WcMlUIgyNLuce6vLYmLv81aa8A7fGw
        8rEc2313uQuYPaKJ1foGI3M=
X-Google-Smtp-Source: AAOMgpfPvxzQhqIe9tUCH8KFopSdCeYkO4zUFi3ME0K5mjlQW7+HjBIVXX4D6pfcC8O5dvAbE3X4rQ==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr1013222wrg.243.1531825014840;
        Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q140-v6sm1491748wmb.35.2018.07.17.03.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id C757F123FFB;
        Tue, 17 Jul 2018 12:56:52 +0200 (CEST)
From:   osalvador@techadventures.net
To:     linux-mm@kvack.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        akpm@linux-foundation.org, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 2/3] mm: Refactor free_area_init_core
Date:   Tue, 17 Jul 2018 12:56:21 +0200
Message-Id: <20180717105622.12410-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180717105622.12410-1-osalvador@techadventures.net>
References: <20180717105622.12410-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When free_area_init_core gets called from the memhotplug code,
we do not really need to go through all memmap calculations.

This structures the code a bit better.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 106 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a73305f7c55..3bf939393ca1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,6 +6237,42 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
+static void calculate_pages(enum zone_type type, unsigned long *freesize,
+							unsigned long size)
+{
+	/*
+	 * Adjust freesize so that it accounts for how much memory
+	 * is used by this zone for memmap. This affects the watermark
+	 * and per-cpu initialisations
+	 */
+	unsigned long memmap_pages = calc_memmap_size(size, *freesize);
+
+	if (!is_highmem_idx(type)) {
+		if (*freesize >= memmap_pages) {
+			freesize -= memmap_pages;
+			if (memmap_pages)
+				printk(KERN_DEBUG
+					"  %s zone: %lu pages used for memmap\n",
+					zone_names[type], memmap_pages);
+		} else
+			pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				zone_names[type], memmap_pages, *freesize);
+	}
+
+	if (type == 0 && *freesize > dma_reserve) {
+		*freesize -= dma_reserve;
+		printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
+					zone_names[0], dma_reserve);
+	}
+
+	if (!is_highmem_idx(type))
+		nr_kernel_pages += *freesize;
+	/* Charge for highmem memmap if there are enough kernel pages */
+	else if (nr_kernel_pages > memmap_pages * 2)
+		nr_kernel_pages -= memmap_pages;
+	nr_all_pages += *freesize;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -6267,50 +6303,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
-		unsigned long zone_start_pfn = zone->zone_start_pfn;
-
-		size = zone->spanned_pages;
-		freesize = zone->present_pages;
-
-		/*
-		 * Adjust freesize so that it accounts for how much memory
-		 * is used by this zone for memmap. This affects the watermark
-		 * and per-cpu initialisations
-		 */
-		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
-			if (freesize >= memmap_pages) {
-				freesize -= memmap_pages;
-				if (memmap_pages)
-					printk(KERN_DEBUG
-					       "  %s zone: %lu pages used for memmap\n",
-					       zone_names[j], memmap_pages);
-			} else
-				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
-					zone_names[j], memmap_pages, freesize);
-		}
 
-		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
-					zone_names[0], dma_reserve);
-		}
-
-		if (!is_highmem_idx(j))
-			nr_kernel_pages += freesize;
-		/* Charge for highmem memmap if there are enough kernel pages */
-		else if (nr_kernel_pages > memmap_pages * 2)
-			nr_kernel_pages -= memmap_pages;
-		nr_all_pages += freesize;
-
-		/*
-		 * Set an approximate value for lowmem here, it will be adjusted
-		 * when the bootmem allocator frees pages into the buddy system.
-		 * And all highmem pages will be managed by the buddy system.
-		 */
-		zone->managed_pages = freesize;
 #ifdef CONFIG_NUMA
 		zone->node = nid;
 #endif
@@ -6320,13 +6313,28 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		zone_seqlock_init(zone);
 		zone_pcp_init(zone);
 
-		if (!size)
-			continue;
+		if(system_state == SYSTEM_BOOTING) {
+			unsigned long size, freesize;
+			unsigned long zone_start_pfn = zone->zone_start_pfn;
 
-		set_pageblock_order();
-		setup_usemap(pgdat, zone, zone_start_pfn, size);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init(size, nid, j, zone_start_pfn);
+			size = zone->spanned_pages;
+			freesize = zone->present_pages;
+			calculate_pages(j, &freesize, size);
+
+			/*
+			 * Set an approximate value for lowmem here, it will be adjusted
+			 * when the bootmem allocator frees pages into the buddy system.
+			 * And all highmem pages will be managed by the buddy system.
+			 */
+			zone->managed_pages = freesize;
+			if (!size)
+				continue;
+
+			set_pageblock_order();
+			setup_usemap(pgdat, zone, zone_start_pfn, size);
+			init_currently_empty_zone(zone, zone_start_pfn, size);
+			memmap_init(size, nid, j, zone_start_pfn);
+		}
 	}
 }
 
-- 
2.13.6

