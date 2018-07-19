Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB32FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A33D2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A33D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeGSOLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:11:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbeGSOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:10:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so6252971wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9kGTuFtM1X19n3S4sGAGaBCTvUCGMgulE2XHKU/6q7c=;
        b=LbT0se1H9VG120hFdrpq976JRTcpls4+QOLCZjQG531pLAXA+jNAqznn/TIJv5rfS6
         DotWHn906y4r9nmwn44G2mpafTzb2dfKljS01OLlvaFfbaOzzc2rpDhsykBLQmATpwGr
         hBmAG66lMTckm4O9WPRBtxaKsglBvUFX0iYgSJDOKgpSxUqF4eUSMWNZqjD8cEEjhvVO
         t0AOMNyw2O4TTwRcx+x0vHfjINRY8I70rn1dM9fe7EN+2QtGw9j502aSUlXaQMp5/b7Y
         hlRpe4t+gL68+wtJapwh07lRF47jHZRx2BjYa6SF0Mw11q9cQqEor6pJwvsiYcZNysaP
         vv1Q==
X-Gm-Message-State: AOUpUlHx2RfAulZ59P0R+5SW4BLpElPzeQP3G6hqvgemnnago6V9bYvv
        CA+mwvB0A7Y9RoUPmmV6zY8=
X-Google-Smtp-Source: AAOMgpc7ZXs6UFZ2/S4nyQsO9knxurZ94Yr7I07UsL4tjXrgWQPdaIzpWGEwK0TULJaR+Y8bPxdP3w==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr4324508wmb.133.1532006867605;
        Thu, 19 Jul 2018 06:27:47 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o4-v6sm11094930wra.3.2018.07.19.06.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:27:45 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 250BB124174;
        Thu, 19 Jul 2018 15:27:45 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Date:   Thu, 19 Jul 2018 15:27:38 +0200
Message-Id: <20180719132740.32743-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180719132740.32743-1-osalvador@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

In free_area_init_core we calculate the amount of managed pages
we are left with, by substracting the memmap pages and the pages
reserved for dma.
With the values left, we also account the total of kernel pages and
the total of pages.

Since memmap pages are calculated from zone->spanned_pages,
let us only do these calculcations whenever zone->spanned_pages is greather
than 0.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 73 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 10b754fba5fa..f7a6f4e13f41 100644
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
@@ -6267,43 +6301,12 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
+		unsigned long size = zone->spanned_pages;
+		unsigned long freesize = zone->present_pages;
 		unsigned long zone_start_pfn = zone->zone_start_pfn;
 
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
+		if (size)
+			freesize = calc_remaining_pages(j, freesize, size);
 
 		/*
 		 * Set an approximate value for lowmem here, it will be adjusted
-- 
2.13.6

