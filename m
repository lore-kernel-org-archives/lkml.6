Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C70ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E8A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGQL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:28:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGQL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:28:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so811856wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aoQ3hjjwbDevILRQhdQeeoqo7f175v8Mth2S6+yE7wU=;
        b=G35yuruZ2terY83wfyXQoCKNHgGBuOxmkmyyQUAqgvnvmq3JrqSTD1xZPiPkGdrwdr
         wn5Nu+Uk49zqZXnxjBRaehCYpw7jANG87ec2RaPF1zHVxusZ4kYC2NjvqeDGUw5OoUsB
         UmuEM2RVeDs+x2bWhy2gd7YSLnOA2VqVJydJiAuAzc6CTPXJdMoKLSftKHFUdQgYj3wx
         +wFwnUXClvGn0+LUUOuK+iylD/GfvNofvXzNfZwyhWKI2NS3Fj8/hHVQhbNDL1ovp6EJ
         jc0Mw5sxISP7aGeMyNdD5PDb813R+LVZFOdMm72I6Ppwsocd1i2Ie/TBqYQ1iCcx4K9t
         /gbw==
X-Gm-Message-State: AOUpUlEngtAJrDQah4T0PI6No0NXLfgY5ZBrCDOKe87Do32LdHGZV7g/
        jVWg5iLPk4Vtj2vrevgR26Q=
X-Google-Smtp-Source: AAOMgpeZujtKV5UphfYTvkXHrI6pq+9uhlqLxQmJ9u7AiqIytaotn8iG9EZiMBTQ3JTeRWkvO52gRA==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr940914wrg.62.1531825014118;
        Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id z3-v6sm1198901wru.27.2018.07.17.03.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:56:53 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 94E69123FFA;
        Tue, 17 Jul 2018 12:56:52 +0200 (CEST)
From:   osalvador@techadventures.net
To:     linux-mm@kvack.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        akpm@linux-foundation.org, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 1/3] mm: Make free_area_init_core more readable by moving the ifdefs
Date:   Tue, 17 Jul 2018 12:56:20 +0200
Message-Id: <20180717105622.12410-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180717105622.12410-1-osalvador@techadventures.net>
References: <20180717105622.12410-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Moving the #ifdefery out of the function makes it easier to follow.

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

