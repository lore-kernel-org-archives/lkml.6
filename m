Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21241C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E741821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfBSPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:24:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBSPYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:24:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B46DAEB7;
        Tue, 19 Feb 2019 15:24:10 +0000 (UTC)
Subject: Re: [PATCH v10 2/3] mm: Move buddy list manipulations into helpers
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899812264.3165233.5219320056406926223.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <4672701b-6775-6efd-0797-b6242591419e@suse.cz>
Date:   Tue, 19 Feb 2019 16:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154899812264.3165233.5219320056406926223.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 6:15 AM, Dan Williams wrote:
> In preparation for runtime randomization of the zone lists, take all
> (well, most of) the list_*() functions in the buddy allocator and put
> them in helper functions. Provide a common control point for injecting
> additional behavior when freeing pages.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Here's another fixlet to fold into mm-move-buddy-list-manipulations-into-helpers.patch
This time not critical.

----8<----
From 05aaff61f62f86e646c4a2581fe2ff63ff66a199 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 19 Feb 2019 16:20:33 +0100
Subject: [PATCH] mm: Move buddy list manipulations into helpers-fix2

del_page_from_free_area() migratetype parameter is unused, remove it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        | 14 ++++----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index da5321c747f8..2fd4247262e9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -143,7 +143,7 @@ static inline struct page *get_page_from_free_area(struct free_area *area,
 }
 
 static inline void del_page_from_free_area(struct page *page,
-		struct free_area *area, int migratetype)
+		struct free_area *area)
 {
 	list_del(&page->lru);
 	__ClearPageBuddy(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 37ed14ad0b59..d2b6d5245568 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -901,8 +901,7 @@ static inline void __free_one_page(struct page *page,
 		if (page_is_guard(buddy))
 			clear_page_guard(zone, buddy, order, migratetype);
 		else
-			del_page_from_free_area(buddy, &zone->free_area[order],
-					migratetype);
+			del_page_from_free_area(buddy, &zone->free_area[order]);
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -2173,7 +2172,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
-		del_page_from_free_area(page, area, migratetype);
+		del_page_from_free_area(page, area);
 		expand(zone, page, order, current_order, area, migratetype);
 		set_pcppage_migratetype(page, migratetype);
 		return page;
@@ -3144,7 +3143,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 
 	/* Remove page from free list */
 
-	del_page_from_free_area(page, area, mt);
+	del_page_from_free_area(page, area);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -8507,9 +8506,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	spin_lock_irqsave(&zone->lock, flags);
 	pfn = start_pfn;
 	while (pfn < end_pfn) {
-		struct free_area *area;
-		int mt;
-
 		if (!pfn_valid(pfn)) {
 			pfn++;
 			continue;
@@ -8528,13 +8524,11 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
 		order = page_order(page);
-		area = &zone->free_area[order];
 #ifdef CONFIG_DEBUG_VM
 		pr_info("remove from free list %lx %d %lx\n",
 			pfn, 1 << order, end_pfn);
 #endif
-		mt = get_pageblock_migratetype(page);
-		del_page_from_free_area(page, area, mt);
+		del_page_from_free_area(page, &zone->free_area[order]);
 		for (i = 0; i < (1 << order); i++)
 			SetPageReserved((page+i));
 		pfn += (1 << order);
-- 
2.20.1

