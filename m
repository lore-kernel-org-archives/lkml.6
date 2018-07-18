Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112EBECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86EB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86EB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGRNZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51303 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbeGRNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id h3-v6so2259326wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/5O9NHC2sSQXY1D1Puqte8VarWZHIWWUCI1iuNEE64=;
        b=nhfRo4lgUxhqzgCv6KLtOcOCbyjPl3qu7fqxlXcoS7E7nee/JLp9JMKORC1onM4XSy
         scfmRJu4L1pijjKpN61A4D9Tle8bsES+Lok7v9lYTwLsxIP8cvn6GObuM0Fbw2927kAg
         2huVJ8xwdjON+HVDt1RLv/rPQ/dmiy+PfNm5M48Z9AxVqkjZbhJ9sUvRaSOVhP5hAjIw
         OZzkMT1wnLcwqXvex3Dkl9+8mmFC6LO62sOUsVWoesSUuTYblzTQqppMi+VH2Zj3+ifs
         Wyxm/K9cFpM/1wb/iDy21vYhROsRShtyQbfk+pfWif9oKjXZFkX1/m4BNkosEgFmZYOR
         NDuQ==
X-Gm-Message-State: AOUpUlEatCDS0lt2cCyq2z26fsdLpjmrg1VRM/QF2E0cXYxt9AmuYfvp
        qDZQZflkt9l7+H1jfdlT6Wk=
X-Google-Smtp-Source: AAOMgpfEKhJpaMt+4ScWPfF0nWep86UdOglR3jUw7t40Hj2jb/yfMBtJjnN6ug6FRfnuFfl0NVBJOQ==
X-Received: by 2002:a1c:69d2:: with SMTP id z79-v6mr1597964wmh.92.1531918058691;
        Wed, 18 Jul 2018 05:47:38 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g10-v6sm4754781wru.43.2018.07.18.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 05:47:37 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 676C21240C6;
        Wed, 18 Jul 2018 14:47:36 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/3] mm/page_alloc: Refactor free_area_init_core
Date:   Wed, 18 Jul 2018 14:47:21 +0200
Message-Id: <20180718124722.9872-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180718124722.9872-1-osalvador@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When free_area_init_core gets called from the memhotplug code,
we only need to perform some of the operations in
there.

Since memhotplug code is the only place where free_area_init_core
gets called while node being still offline, we can better separate
the context from where it is called.

This patch re-structures the code for that purpose.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 94 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a73305f7c55..d652a3ad720c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,6 +6237,40 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
+static unsigned long calc_remaining_pages(enum zone_type type, unsigned long freesize,
+								unsigned long size)
+{
+	unsigned long memmap_pages = calc_memmap_size(size, freesize);
+
+	if(!is_highmem_idx(type)) {
+		if (freesize >= memmap_pages) {
+			freesize -= memmap_pages;
+			if (memmap_pages)
+				printk(KERN_DEBUG
+					"  %s zone: %lu pages used for memmap\n",
+					zone_names[type], memmap_pages);
+		} else
+			pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				zone_names[type], memmap_pages, freesize);
+	}
+
+	/* Account for reserved pages */
+	if (type == 0 && freesize > dma_reserve) {
+		freesize -= dma_reserve;
+		printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
+		zone_names[0], dma_reserve);
+	}
+
+	if (!is_highmem_idx(type))
+		nr_kernel_pages += freesize;
+	/* Charge for highmem memmap if there are enough kernel pages */
+	else if (nr_kernel_pages > memmap_pages * 2)
+		nr_kernel_pages -= memmap_pages;
+	nr_all_pages += freesize;
+
+	return freesize;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -6249,6 +6283,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 {
 	enum zone_type j;
 	int nid = pgdat->node_id;
+	bool no_hotplug_context;
 
 	pgdat_resize_init(pgdat);
 
@@ -6265,45 +6300,18 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	pgdat->per_cpu_nodestats = &boot_nodestats;
 
+	/* Memhotplug is the only place where free_area_init_node gets called
+	 * with the node being still offline.
+	 */
+	no_hotplug_context = node_online(nid);
+
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
-		unsigned long zone_start_pfn = zone->zone_start_pfn;
+		unsigned long size = zone->spanned_pages;
+		unsigned long freesize = zone->present_pages;
 
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
-
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
+		if (no_hotplug_context)
+			freesize = calc_remaining_pages(j, freesize, size);
 
 		/*
 		 * Set an approximate value for lowmem here, it will be adjusted
@@ -6311,6 +6319,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		 * And all highmem pages will be managed by the buddy system.
 		 */
 		zone->managed_pages = freesize;
+
 #ifdef CONFIG_NUMA
 		zone->node = nid;
 #endif
@@ -6320,13 +6329,14 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		zone_seqlock_init(zone);
 		zone_pcp_init(zone);
 
-		if (!size)
-			continue;
+		if (size && no_hotplug_context) {
+			unsigned long zone_start_pfn = zone->zone_start_pfn;
 
-		set_pageblock_order();
-		setup_usemap(pgdat, zone, zone_start_pfn, size);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init(size, nid, j, zone_start_pfn);
+			set_pageblock_order();
+			setup_usemap(pgdat, zone, zone_start_pfn, size);
+			init_currently_empty_zone(zone, zone_start_pfn, size);
+			memmap_init(size, nid, j, zone_start_pfn);
+		}
 	}
 }
 
-- 
2.13.6

