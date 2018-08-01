Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B124520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B124520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbeHAOJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:09:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50853 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389033AbeHAOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:09:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6781456wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oO/r0b2f7XB/e6iVHlV69GT6OlFJSDIymKWsErYI290=;
        b=U87aRD5PRMU3eg49CM1SL1jR8NuW1XXYGQ2lLCmgJ7LfIgfJdRG4uQRBgoHZC4gSc8
         3uy9AHAZOc0p/YSAkhyaSYncc8emZVFYiV8elnCWKOBfNmEjVvLQ4tX8/mCxexchlI27
         WOsTfu6VtenwfYo4sn9nAgk0KysOJHAbyoglZm0C54O/5G1Vdqu+QbMvutfrOrCCNihD
         GciOrHc8Aug2XVYIn6KFMYzJ6ndVtqAfvpIDUDK3yJbGFuvggQjub0t4CCD/Et6CyR8l
         yAZINMUmf5ALWLu8xEFAUyJAKbCxG/rFG8WturxBiroQSIT7kclr5G5Rq2i0rNBlPIDO
         b/Kg==
X-Gm-Message-State: AOUpUlG3PAHIGdM7GQZ22N4BtFBXq59JTZYCWhJC7KZen9TJt81AGNPR
        qiWMV4HQUMOqpQZ3uqCxLr8=
X-Google-Smtp-Source: AAOMgpdwKtW4RSPjIIzre19SBdCLL2SBkcN3WtX94xVqaMazVDQ3gARceeTHShFhQBhk8mRG+CMKUg==
X-Received: by 2002:a1c:4d16:: with SMTP id o22-v6mr2506449wmh.49.1533126238433;
        Wed, 01 Aug 2018 05:23:58 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1090486wmc.38.2018.08.01.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:23:56 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 73865124542;
        Wed,  1 Aug 2018 14:23:55 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 4/5] mm/page_alloc: Inline function to handle CONFIG_DEFERRED_STRUCT_PAGE_INIT
Date:   Wed,  1 Aug 2018 14:23:47 +0200
Message-Id: <20180801122348.21588-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180801122348.21588-1-osalvador@techadventures.net>
References: <20180801122348.21588-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Let us move the code between CONFIG_DEFERRED_STRUCT_PAGE_INIT
to an inline function.
Not having an ifdef in the function makes the code more readable.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 607f98f8816d..56ee8c029759 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6366,6 +6366,22 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
+{
+	/*
+	 * We start only with one section of pages, more pages are added as
+	 * needed until the rest of deferred pages are initialized.
+	 */
+
+	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
+						pgdat->node_spanned_pages);
+	pgdat->first_deferred_pfn = ULONG_MAX;
+}
+#else
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
+#endif
+
 void __meminit free_area_init_node(int nid, unsigned long *zones_size,
 				   unsigned long node_start_pfn,
 				   unsigned long *zholes_size)
@@ -6392,16 +6408,8 @@ void __meminit free_area_init_node(int nid, unsigned long *zones_size,
 				  zones_size, zholes_size);
 
 	alloc_node_mem_map(pgdat);
+	pgdat_set_deferred_range(pgdat);
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	/*
-	 * We start only with one section of pages, more pages are added as
-	 * needed until the rest of deferred pages are initialized.
-	 */
-	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
-					 pgdat->node_spanned_pages);
-	pgdat->first_deferred_pfn = ULONG_MAX;
-#endif
 	free_area_init_core(pgdat);
 }
 
-- 
2.13.6

