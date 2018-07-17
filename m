Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A54ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBF020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbeGQL3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:29:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42097 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeGQL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:28:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so787521wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/G133LW3AMb98SZ7TOHjyYBpeXlNPwTPfphZKp2QLFc=;
        b=k1vY/UkPWV2ZJfSSelbaNks5okVce3jYkaxP/GwAUVVrZKSUzAjo+VEe2+8FfVhAgz
         iILYezbEIpJ9NiIE1LQMbahXi0DIp0Eh0XL5m4G1f/lmdBPFJGsgCi3IvOCsXkwgkOM8
         VEAfyfnlxkzjiWwqRpnB3lIuiKeKsugl7MI179PvEWKWOdXGcsV9U2tk7/BVMA3TjSBJ
         RUUljm5YWc8hxI9K8m6UOPh+4F4hJCqESzK4LBIi1KcF6pBgfWurdhp0qYabWWfFAo2D
         LeDaPLzxewEJ0YAhsk63jnFaH13m8pHA2rf7UKQDn/9z7qCycsnjE3Dqhqd5GBxP/Sm8
         dvlg==
X-Gm-Message-State: AOUpUlFqt67Fgjn0dt8kInQw+aKdBrAXaENYGLfW/xDZRoxxZZZrM1H6
        mMzVgopDp4ceXlzgm2wjOFw=
X-Google-Smtp-Source: AAOMgpciRVmRDprOtbFXQ0IAcf/V/10SbWc66QyE9lYKB7h/zKqX99NInHQ/BU2E3I3Yf6aGn/+Iiw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13-v6mr958518wru.80.1531825015258;
        Tue, 17 Jul 2018 03:56:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q140-v6sm1491771wmb.35.2018.07.17.03.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 3F9F7123FFC;
        Tue, 17 Jul 2018 12:56:53 +0200 (CEST)
From:   osalvador@techadventures.net
To:     linux-mm@kvack.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        akpm@linux-foundation.org, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 3/3] mm: Make free_area_init_node call certain functions only when booting
Date:   Tue, 17 Jul 2018 12:56:22 +0200
Message-Id: <20180717105622.12410-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180717105622.12410-1-osalvador@techadventures.net>
References: <20180717105622.12410-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

If free_area_init_node got called from memhotplug code, we do not need
to call calculate_node_totalpages(), as the node has no pages.

We do not need to set the range for the deferred initialization either,
as memmap_init_zone skips that when the context is MEMMAP_HOTPLUG.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3bf939393ca1..d2562751dbfd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6299,8 +6299,6 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(node_lruvec(pgdat));
 
-	pgdat->per_cpu_nodestats = &boot_nodestats;
-
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 
@@ -6386,6 +6384,21 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
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
@@ -6407,20 +6420,14 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 #else
 	start_pfn = node_start_pfn;
 #endif
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size);
-
-	alloc_node_mem_map(pgdat);
+	if (system_state == SYSTEM_BOOTING) {
+		calculate_node_totalpages(pgdat, start_pfn, end_pfn,
+					  zones_size, zholes_size);
+		alloc_node_mem_map(pgdat);
+		pgdat_set_deferred_range(pgdat);
+		pgdat->per_cpu_nodestats = &boot_nodestats;
+	}
 
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

