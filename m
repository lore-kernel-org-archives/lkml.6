Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCDFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D8208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860D8208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbeHAOJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:09:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389033AbeHAOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:09:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so6721563wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEl6v+KhyseIxz3P6IpGKnaa00NRWn3MiUa39SO2/ao=;
        b=Yp4II5cdEQGxWf5L7N73ENe793CAeJDi4ZB13T6GklCFlAqU3IS8KkZ4Vs8afz+0gP
         XS43TFqpVZXv9KwHIFOmKKJnWOTTX3Of8BCe0j0r10FGrTKgFT1i1iL+nQfvHqT47/dW
         b1IAIgCsx1b7kxXbvantGknEPMnNCjy+3nCo/NYLnyWTBxcnLQpIWeOglnnprlzmJdPt
         CA0KVdMtgI8NCfyih+Oiea4gA52+A9kfOGcDoHs78l+SuSksUj9VhMkGWpeMq363z9DD
         YgJQ+h3/if7uMR7TQsYs+w1rzyG/8vPBHpaI5UeWJ90qff505j5hPkXfxAuKxL6Nc5IU
         tLwA==
X-Gm-Message-State: AOUpUlGEKzhglcOjLgM1Tucb/Bta0lCdC6BqeAqIv3hzYfA03bmqC6TG
        X7UjP3j3OpcUg89EAUUKHPU=
X-Google-Smtp-Source: AAOMgpeStQvSCKJlejEJI91o5Pl/98PLDSxrNtJvKLEtlgvJXumWAN9tFkf8nNvnJvPGM/1zxMm7nA==
X-Received: by 2002:a1c:b609:: with SMTP id g9-v6mr2451453wmf.73.1533126237152;
        Wed, 01 Aug 2018 05:23:57 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j3-v6sm24749220wrt.70.2018.08.01.05.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:23:56 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 39549124541;
        Wed,  1 Aug 2018 14:23:55 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: [PATCH v6 3/5] mm: remove __paginginit
Date:   Wed,  1 Aug 2018 14:23:46 +0200
Message-Id: <20180801122348.21588-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180801122348.21588-1-osalvador@techadventures.net>
References: <20180801122348.21588-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>

__paginginit is the same thing as __meminit except for platforms without
sparsemem, there it is defined as __init.

Remove __paginginit and use __meminit. Use __ref in one single function
that merges __meminit and __init sections: setup_usemap().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/internal.h   | 12 ------------
 mm/page_alloc.c | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 33c22754d282..87256ae1bef8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -389,18 +389,6 @@ static inline struct page *mem_map_next(struct page *iter,
 	return iter + 1;
 }
 
-/*
- * FLATMEM and DISCONTIGMEM configurations use alloc_bootmem_node,
- * so all functions starting at paging_init should be marked __init
- * in those cases. SPARSEMEM, however, allows for memory hotplug,
- * and alloc_bootmem_node is not used.
- */
-#ifdef CONFIG_SPARSEMEM
-#define __paginginit __meminit
-#else
-#define __paginginit __init
-#endif
-
 /* Memory initialisation debug and verification */
 enum mminit_level {
 	MMINIT_WARNING,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 295977c6acae..607f98f8816d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6122,7 +6122,7 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
 	return usemapsize / 8;
 }
 
-static void __init setup_usemap(struct pglist_data *pgdat,
+static void __ref setup_usemap(struct pglist_data *pgdat,
 				struct zone *zone,
 				unsigned long zone_start_pfn,
 				unsigned long zonesize)
@@ -6142,7 +6142,7 @@ static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __paginginit set_pageblock_order(void)
+void __meminit set_pageblock_order(void)
 {
 	unsigned int order;
 
@@ -6170,14 +6170,14 @@ void __paginginit set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __paginginit set_pageblock_order(void)
+void __meminit set_pageblock_order(void)
 {
 }
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
-						   unsigned long present_pages)
+static unsigned long __meminit calc_memmap_size(unsigned long spanned_pages,
+						unsigned long present_pages)
 {
 	unsigned long pages = spanned_pages;
 
@@ -6235,7 +6235,7 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
  *
  * NOTE: pgdat should get zeroed by caller.
  */
-static void __paginginit free_area_init_core(struct pglist_data *pgdat)
+static void __meminit free_area_init_core(struct pglist_data *pgdat)
 {
 	enum zone_type j;
 	int nid = pgdat->node_id;
@@ -6366,8 +6366,9 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
-void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
-		unsigned long node_start_pfn, unsigned long *zholes_size)
+void __meminit free_area_init_node(int nid, unsigned long *zones_size,
+				   unsigned long node_start_pfn,
+				   unsigned long *zholes_size)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long start_pfn = 0;
@@ -6412,7 +6413,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
  * may be accessed (for example page_to_pfn() on some configuration accesses
  * flags). We must explicitly zero those struct pages.
  */
-void __paginginit zero_resv_unavail(void)
+void __meminit zero_resv_unavail(void)
 {
 	phys_addr_t start, end;
 	unsigned long pfn;
-- 
2.13.6

