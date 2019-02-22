Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB52C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBVRn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:43:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:59688 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfBVRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:43:28 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gxEr3-00010r-Bv; Fri, 22 Feb 2019 20:43:21 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/5] mm/compaction: pass pgdat to too_many_isolated() instead of zone
Date:   Fri, 22 Feb 2019 20:43:35 +0300
Message-Id: <20190222174337.26390-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222174337.26390-1-aryabinin@virtuozzo.com>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

too_many_isolated() in mm/compaction.c looks only at node state,
so it makes more sense to change argument to pgdat instead of zone.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a3305f13a138..b2d02aba41d8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -738,16 +738,16 @@ isolate_freepages_range(struct compact_control *cc,
 }
 
 /* Similar to reclaim, but different enough that they don't share logic */
-static bool too_many_isolated(struct zone *zone)
+static bool too_many_isolated(pg_data_t *pgdat)
 {
 	unsigned long active, inactive, isolated;
 
-	inactive = node_page_state(zone->zone_pgdat, NR_INACTIVE_FILE) +
-			node_page_state(zone->zone_pgdat, NR_INACTIVE_ANON);
-	active = node_page_state(zone->zone_pgdat, NR_ACTIVE_FILE) +
-			node_page_state(zone->zone_pgdat, NR_ACTIVE_ANON);
-	isolated = node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE) +
-			node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON);
+	inactive = node_page_state(pgdat, NR_INACTIVE_FILE) +
+			node_page_state(pgdat, NR_INACTIVE_ANON);
+	active = node_page_state(pgdat, NR_ACTIVE_FILE) +
+			node_page_state(pgdat, NR_ACTIVE_ANON);
+	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
+			node_page_state(pgdat, NR_ISOLATED_ANON);
 
 	return isolated > (inactive + active) / 2;
 }
@@ -774,8 +774,7 @@ static unsigned long
 isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			unsigned long end_pfn, isolate_mode_t isolate_mode)
 {
-	struct zone *zone = cc->zone;
-	pg_data_t *pgdat = zone->zone_pgdat;
+	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	unsigned long nr_scanned = 0, nr_isolated = 0;
 	struct lruvec *lruvec;
 	unsigned long flags = 0;
@@ -791,7 +790,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	 * list by either parallel reclaimers or compaction. If there are,
 	 * delay for some time until fewer pages are isolated
 	 */
-	while (unlikely(too_many_isolated(zone))) {
+	while (unlikely(too_many_isolated(pgdat))) {
 		/* async migration should just abort */
 		if (cc->mode == MIGRATE_ASYNC)
 			return 0;
-- 
2.19.2

