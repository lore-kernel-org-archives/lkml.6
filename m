Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B82064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2B82064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeG0PZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:25:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39476 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730737AbeG0PZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:25:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so5562391wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=09jE8HQnR78gKgCVm3YT0g0xgTev+DzLs5mljNQWB3Y=;
        b=ihcYnS1suULwWfgCKkinKiCgoJiMBZo6c+ksG+8TYfjHGDZm65WtCzY+pDTbTQUrAq
         z5RLOwhHDk/m8LoSkWZr/aeTyT0BxBOhrqe/XMP/7J751CijKstGFsxY9D8l1FScBvBZ
         vH8B7Tr5EqlXazKuCJy6C/BRQOOOjvf4+NNV8bT/ML3iK5ut269gLquz+eST6cswvsxw
         ljz6QmhtmGcyfwI+XxzDOPpwXKODXT2llRGuRvV9GyXAV5lJIYT4y2FoeMnzW5hdBpjK
         crTvYpnEWQwcqt1jDdlIDkAI6d9Av8wUuNlKHKP2q7+8SmSydzJ2cnb90txhLfntrJEn
         6b+g==
X-Gm-Message-State: AOUpUlFfmFKA6MVY94J5TpitVZBLkn/wnnnbFrd5NgDoEQhzwHbZpJOm
        ygvZ3fTL/LFFo+xGHi4Iois=
X-Google-Smtp-Source: AAOMgpfnYfgeyb1lK5pdIFr1c+xnkt449YTC2ibUtk9nV1wQnfxsctvKIEdyZI/Vfl6LGJmQDXsxCQ==
X-Received: by 2002:a1c:9215:: with SMTP id u21-v6mr4315769wmd.106.1532700213727;
        Fri, 27 Jul 2018 07:03:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3453450wmc.13.2018.07.27.07.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:03:32 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 71EC5124405;
        Fri, 27 Jul 2018 16:03:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 1/4] mm/page_alloc: Move ifdefery out of free_area_init_core
Date:   Fri, 27 Jul 2018 16:03:22 +0200
Message-Id: <20180727140325.11881-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180727140325.11881-1-osalvador@techadventures.net>
References: <20180727140325.11881-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Moving the #ifdefs out of the function makes it easier to follow.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
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

