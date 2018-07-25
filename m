Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB19ECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDBB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDBB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbeGYXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:15:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbeGYXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:15:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so6855wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ad4OTLIPpMcbeOgRn7cNcAJiN8JJ4IImE90/3zrSenU=;
        b=lilh9nhqUHVy6BUmN2OP3GdSFCwPJf9UZpRlHX0sqWUq3gWueVCMddKWU5KTT1U0bu
         yyMqKQ7/uND7pzugwUI+HuieSn/zAxYGO9e4oJG4svbqbfeUHyFcSaAhM+/lVzgJiFdq
         ZrZSgQBTq7hoe5KxBjwxNo+HrZUR3ZnXcoWfT3s1O0I1uMhW3uKgJ93AXdyuIrqnNPtb
         599Or5rzMworQYI6hEVlw57ZIZNYPGvScelzQNGIXSF29a1SCDJBGSGHG0oJHIyo755Y
         RerMmegGsFr34mE1dbB9tCBw2PISnIch8Jr1Jd+a25Xb73zWqDf4c1hOSAIVogSzYBwH
         /8MQ==
X-Gm-Message-State: AOUpUlGxelHj/Yn5/qBXYH8OvskQUY6+I4jYHXHWsGITuOFLFclqdQN3
        Xx3Cl/IRFvPN9zmm4Qnrqdk=
X-Google-Smtp-Source: AAOMgpchnNwSDYXydPO96tsdnWQg2kVs8zmBXVoG3BPLNpkKwoonPv5Icvawctv1nC0wAIgER7wkZw==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr5401757wma.129.1532556113118;
        Wed, 25 Jul 2018 15:01:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v2-v6sm142494wrn.97.2018.07.25.15.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:01:51 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id C2EEB124366;
        Thu, 26 Jul 2018 00:01:50 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/5] mm/page_alloc: Inline function to handle CONFIG_DEFERRED_STRUCT_PAGE_INIT
Date:   Thu, 26 Jul 2018 00:01:42 +0200
Message-Id: <20180725220144.11531-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180725220144.11531-1-osalvador@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
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

