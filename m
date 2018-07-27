Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFEDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0182089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0182089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeG0PZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:25:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39478 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbeG0PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:25:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so5562423wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLjX86dg8uQeCW6TtBr2m2PymECIejY8mSgyHYdYlu0=;
        b=f4/fKjk3x8w/3m1xjpjMRVuxLB1+uwfu7jvo7BG9OPSUhuEC3jtdFNj+O8mIhShbCd
         pK2XAnDiiaNmR5Rn6/F0QcoTPO06xWdFJ0DpDhzUFArEbiLV10ZIJC+ro9msVxE++cp6
         PtbWac1t8lUErJsgavJOfVEuRQfvIk3Gye5CZeK/YoXJQ0uBo4jVk3RTVCGzOj4kdXdq
         RGgGnA0d8FHo/KBRqax0pcfBUJZqvVpZJZeX4Dv36B+5wkcqcoWOlbpz6feuHC/AsEsR
         fmGemtJ+wzVEZkYOMh3SFjlfADvgqtX1n0MNzzPTmtjxBGASlB49GzOevE/kZVKNEUN/
         NELg==
X-Gm-Message-State: AOUpUlGOo45sAXY8463hWqxH5GUtC8AoZ+2crfKG6okB3V2siTdI89Zm
        tsi/9Ch+WggP+ZIAcKXPU3A=
X-Google-Smtp-Source: AAOMgpcBIboTEUwcb6wP210AtcdEurM/V+DENPIG4N3H4v88x1FelOMS2isMJCNkG6IK4LG0fEgTkg==
X-Received: by 2002:a1c:7d58:: with SMTP id y85-v6mr4283926wmc.91.1532700214603;
        Fri, 27 Jul 2018 07:03:34 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id d14-v6sm5587085wrr.12.2018.07.27.07.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:03:33 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id E4F06124407;
        Fri, 27 Jul 2018 16:03:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 3/4] mm/page_alloc: Inline function to handle CONFIG_DEFERRED_STRUCT_PAGE_INIT
Date:   Fri, 27 Jul 2018 16:03:24 +0200
Message-Id: <20180727140325.11881-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180727140325.11881-1-osalvador@techadventures.net>
References: <20180727140325.11881-1-osalvador@techadventures.net>
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

