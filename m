Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57864FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0690A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0690A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeG3Lwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:52:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36657 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeG3LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:52:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so12255293wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLjX86dg8uQeCW6TtBr2m2PymECIejY8mSgyHYdYlu0=;
        b=hp/sYbJaXAsSsCLlC5R2kXOYytflVr+/U5EFlhKWB6QrBrAJc8d/a6Jbhcz90RaMsU
         V+49hoUGHzEjR2vu/D/sCTHQEj2Rzw9rNYlJS4WAvlNBcdKlw5wrEtmbUTRkHAA7XI7T
         zmVxkw8jWZwx4XrhPjMBLe+Ew2NFAXNX35ltiDLB1E9rtZiImXda0Vz4gBxo+0AFHg5o
         jSDRwIizN4i6+UE3nBk1nkTFRCkMZfTlwG6nNQsLQXcGaMbhA09Rbuoa+JPJZatVdhxe
         7m4mbZK4C59XG4ZSdgi5ITRleVVyGYBymR056hIHq+Qw9f8E1c1i+ZCZJEqKsFmgLKT7
         ZXKw==
X-Gm-Message-State: AOUpUlHg+u/+0sMED5N0X/7dKWzuX+XE6k8IafkaVZ4v7uM5subkWRvX
        MOCOVK0ZDgErUhg9yu8XAWo=
X-Google-Smtp-Source: AAOMgpfDkD8HTOD8T5QX45QcnuBXi6q6ZGk/UOmhrH3XoSmv8wsXmzIw2HQuh7a78XB+JJjI1PklUQ==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr17387965wrc.93.1532945885293;
        Mon, 30 Jul 2018 03:18:05 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 188-v6sm16724942wmv.11.2018.07.30.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 03:18:03 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 3D248124448;
        Mon, 30 Jul 2018 12:18:03 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 3/4] mm/page_alloc: Inline function to handle CONFIG_DEFERRED_STRUCT_PAGE_INIT
Date:   Mon, 30 Jul 2018 12:17:56 +0200
Message-Id: <20180730101757.28058-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180730101757.28058-1-osalvador@techadventures.net>
References: <20180730101757.28058-1-osalvador@techadventures.net>
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
 mm/page_alloc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 10b754fba5fa..4e84a17a5030 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6376,6 +6376,21 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
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
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
+#endif
+
 void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 		unsigned long node_start_pfn, unsigned long *zholes_size)
 {
@@ -6401,16 +6416,8 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
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

