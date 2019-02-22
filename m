Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CD320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfBVRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:43:48 -0500
Received: from relay.sw.ru ([185.231.240.75]:59684 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfBVRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:43:28 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gxEr3-00010r-J9; Fri, 22 Feb 2019 20:43:21 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/5] mm/vmscan: don't forcely shrink active anon lru list
Date:   Fri, 22 Feb 2019 20:43:37 +0300
Message-Id: <20190222174337.26390-5-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222174337.26390-1-aryabinin@virtuozzo.com>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_node_memcg() always forcely shrink active anon list.
This doesn't seem like correct behavior. If system/memcg has no swap, it's
absolutely pointless to rebalance anon lru lists.
And in case we did scan the active anon list above, it's unclear why would
we need this additional force scan. If there are cases when we want more
aggressive scan of the anon lru we should just change the scan target
in get_scan_count() (and better explain such cases in the comments).

Remove this force shrink and let get_scan_count() to decide how
much of active anon we want to shrink.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 07f74e9507b6..efd10d6b9510 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2563,8 +2563,8 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 			 sc->priority == DEF_PRIORITY);
 
 	blk_start_plug(&plug);
-	while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
-					nr[LRU_INACTIVE_FILE]) {
+	while (nr[LRU_ACTIVE_ANON] || nr[LRU_INACTIVE_ANON] ||
+		nr[LRU_ACTIVE_FILE] || nr[LRU_INACTIVE_FILE]) {
 		unsigned long nr_anon, nr_file, percentage;
 		unsigned long nr_scanned;
 
@@ -2636,14 +2636,6 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	}
 	blk_finish_plug(&plug);
 	sc->nr_reclaimed += nr_reclaimed;
-
-	/*
-	 * Even if we did not try to evict anon pages at all, we want to
-	 * rebalance the anon lru active/inactive ratio.
-	 */
-	if (inactive_list_is_low(lruvec, false, memcg, sc, true))
-		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
-				   sc, LRU_ACTIVE_ANON);
 }
 
 /* Use reclaim/compaction for costly allocs or under memory pressure */
-- 
2.19.2

