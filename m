Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73753ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BEF2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BEF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGRNZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeGRNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so4547480wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VYAg0Cr8uIBSNKsKO/TPs6ZQoAohB/dqzV9rC516WJY=;
        b=Cx5z7FOnnpCj8GrKe1qI/NdsXNAFgN+bj5+y/OR62lj2QpOrDNhUGa+0B6CAm2Cjaj
         ouzG7tZz+IwX6AFIMZqrwNPB/n/DBqBBgIVS9aCoKNTtCZVDyrG6UhoXzGhWx8WfdhFo
         smyhzu2CRhDVbhGZqGLDSGel9UYPvbY5M0EyCT6PYkQghG22IIt58YHpp2P7cWRbhyh+
         RGxSkDjFcBsXiVcqZnIEksIeoVE/ZmjGlaYWzBTpw9KVG3laImxIo+oHnhl/lTuBVBga
         SGdJ77At6lFLG/1jdsAxmanBfyDKbh2Zc6pZfmKiUtVzHDdgdvqrLqkSwvQmufAAZH1A
         WTaA==
X-Gm-Message-State: AOUpUlFNjrv/EbMxeIU4YAzNilGDckHXimi/HXeqWK/y/2N2gdjg54Wm
        o79BhMK0SnazY+lN+ZB7d0DymiO0
X-Google-Smtp-Source: AAOMgpcMVCngsqXUh5CuTtsu0ynwMg/o7AU0YCKxdCRtzFrSUkbFBHQ6ClKHQiI+1Z0vezK62yALBw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr4529521wrs.137.1531918058276;
        Wed, 18 Jul 2018 05:47:38 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id c5-v6sm4598730wrh.36.2018.07.18.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 05:47:37 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 3643D1240C5;
        Wed, 18 Jul 2018 14:47:36 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/3] mm/page_alloc: Move ifdefery out of free_area_init_core
Date:   Wed, 18 Jul 2018 14:47:20 +0200
Message-Id: <20180718124722.9872-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180718124722.9872-1-osalvador@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Moving the #ifdefs out of the function makes it easier to follow.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e357189cd24a..8a73305f7c55 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6206,6 +6206,37 @@ static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
 	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static void pgdat_init_numabalancing(struct pglist_data *pgdat)
+{
+	spin_lock_init(&pgdat->numabalancing_migrate_lock);
+	pgdat->numabalancing_migrate_nr_pages = 0;
+	pgdat->numabalancing_migrate_next_window = jiffies;
+}
+#else
+static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
+#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pgdat_init_split_queue(struct pglist_data *pgdat)
+{
+	spin_lock_init(&pgdat->split_queue_lock);
+	INIT_LIST_HEAD(&pgdat->split_queue);
+	pgdat->split_queue_len = 0;
+}
+#else
+static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
+#endif
+
+#ifdef CONFIG_COMPACTION
+static void pgdat_init_kcompactd(struct pglist_data *pgdat)
+{
+	init_waitqueue_head(&pgdat->kcompactd_wait);
+}
+#else
+static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
+#endif
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -6220,21 +6251,14 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	int nid = pgdat->node_id;
 
 	pgdat_resize_init(pgdat);
-#ifdef CONFIG_NUMA_BALANCING
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
-	pgdat->numabalancing_migrate_nr_pages = 0;
-	pgdat->numabalancing_migrate_next_window = jiffies;
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	spin_lock_init(&pgdat->split_queue_lock);
-	INIT_LIST_HEAD(&pgdat->split_queue);
-	pgdat->split_queue_len = 0;
-#endif
+
+	pgdat_init_numabalancing(pgdat);
+	pgdat_init_split_queue(pgdat);
+	pgdat_init_kcompactd(pgdat);
+
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
-#ifdef CONFIG_COMPACTION
-	init_waitqueue_head(&pgdat->kcompactd_wait);
-#endif
+
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(node_lruvec(pgdat));
-- 
2.13.6

