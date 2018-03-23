Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCWH5n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:57:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37797 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeCWH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:57:42 -0400
X-Google-Smtp-Source: AG47ELuPDb53aoLcO81hIXeKk2hAw9REd/m5//iwf+R20TEhPXIIKx/jmh3pRfj7XAoqmacI1cNpFw==
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To: zhaoyang.huang@spreadtrum.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        vel Tatashin <pasha.tatashin@oracle.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: [PATCH v1] mm: help the ALLOC_HARDER allocation pass the watermarki when CMA on
Date: Fri, 23 Mar 2018 15:57:32 +0800
Message-Id: <1521791852-7048-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the type of 'ALLOC_HARDER' page allocation, there is an express
highway for the whole process which lead the allocation reach __rmqueue_xxx
easier than other type.
However, when CMA is enabled, the free_page within zone_watermark_ok() will
be deducted for number the pages in CMA type, which may cause the watermark
check fail, but there are possible enough HighAtomic or Unmovable and
Reclaimable pages in the zone. So add 'alloc_harder' here to
count CMA pages in to clean the obstacles on the way to the final.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 635d7dd..cc18620 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3045,8 +3045,11 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 
 
 #ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
+	/*
+	 * If allocation can't use CMA areas and no alloc_harder set for none
+	 * order0 allocation, don't use free CMA pages.
+	 */
+	if (!(alloc_flags & ALLOC_CMA) && (!alloc_harder || !order))
 		free_pages -= zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
 
-- 
1.9.1
