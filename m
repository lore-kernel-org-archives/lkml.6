Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439DCECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0178F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGRNZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35521 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbeGRNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so4569928wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+9JS2c7Tw5KibY5zESrEVlALGGos2Uk1nhW3AGPdvw=;
        b=CDZ4ujbml0iLul49iU/Dcb4iuNaOYXKUpCeqYlUKWC1pBRuQE+Hf7mvrhxif48K+28
         9XstWduXi3+PBBlOqo2pWwnQ2aA7pDf8PknKFBGwoIvA4DrAvfAGNAFr1kDTIVeIRzyG
         q0EXnmdjhczUUHtKtXRYP3uJMdnYSXvsnjpxpxDJxZ04B1d63Hsg5RHqBBiLOcAYyCQa
         vXClX4acu4aJXOa5/ujrQmOgxOtIgb9jQ44Vi38RwNRV+fWPHgE7TpjR14lRy07QuDlr
         5LmbaZgctRBoPe2UG8uor/20pbP2ieTM8/3n/mKBOFxlhGir9rrTsEWJBuh/JneP7yQf
         4kCQ==
X-Gm-Message-State: AOUpUlH7ezzfPHp9dydTE+xVQMVZ+iZKzGrwCEI3vKyx/bG6woos/SNm
        W0LCcgK2uexq02wYrm98Wt8=
X-Google-Smtp-Source: AAOMgpdugi4SDF7W40LdMnNfnedowq5QETLG4kycovUDXnpRGPy1ArQOhfClGMv3I1+Rfe7bOsq3Sg==
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr4433873wrs.164.1531918059245;
        Wed, 18 Jul 2018 05:47:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h12-v6sm19597395wmb.3.2018.07.18.05.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 05:47:38 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 9988E1240C7;
        Wed, 18 Jul 2018 14:47:36 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/3] mm/page_alloc: Split context in free_area_init_node
Date:   Wed, 18 Jul 2018 14:47:22 +0200
Message-Id: <20180718124722.9872-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180718124722.9872-1-osalvador@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

If free_area_init_node gets called from memhotplug code,
we do not need to call calculate_node_totalpages(),
as the node has no pages.

The same goes for the deferred initialization, as
memmap_init_zone skips that when the context is MEMMAP_HOTPLUG.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d652a3ad720c..99c342eeb5db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6388,12 +6388,28 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static void pgdat_set_deferred_range(pg_data_t *pgdat)
+{
+	/*
+	 * We start only with one section of pages, more pages are added as
+	 * needed until the rest of deferred pages are initialized.
+	 */
+	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
+						pgdat->node_spanned_pages);
+	pgdat->first_deferred_pfn = ULONG_MAX;
+}
+#else
+static void pgdat_set_deferred_range(pg_data_t *pgdat) {}
+#endif
+
 void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 		unsigned long node_start_pfn, unsigned long *zholes_size)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long start_pfn = 0;
 	unsigned long end_pfn = 0;
+	bool no_hotplug_context = node_online(nid);
 
 	/* pg_data_t should be reset to zero when it's allocated */
 	WARN_ON(pgdat->nr_zones || pgdat->kswapd_classzone_idx);
@@ -6409,20 +6425,17 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 #else
 	start_pfn = node_start_pfn;
 #endif
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size);
 
-	alloc_node_mem_map(pgdat);
-
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	/*
-	 * We start only with one section of pages, more pages are added as
-	 * needed until the rest of deferred pages are initialized.
+	/* Memhotplug is the only place where free_area_init_node gets called
+	 * with the node being still offline.
 	 */
-	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
-					 pgdat->node_spanned_pages);
-	pgdat->first_deferred_pfn = ULONG_MAX;
-#endif
+	if (no_hotplug_context) {
+		calculate_node_totalpages(pgdat, start_pfn, end_pfn,
+					  zones_size, zholes_size);
+		alloc_node_mem_map(pgdat);
+		pgdat_set_deferred_range(pgdat);
+	}
+
 	free_area_init_core(pgdat);
 }
 
-- 
2.13.6

