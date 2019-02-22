Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE19A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBVR6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:58:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:60204 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVR6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:58:24 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gxF5W-000152-An; Fri, 22 Feb 2019 20:58:18 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH RFC] mm/vmscan: try to protect active working set of cgroup from reclaim.
Date:   Fri, 22 Feb 2019 20:58:25 +0300
Message-Id: <20190222175825.18657-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a presence of more than 1 memory cgroup in the system our reclaim
logic is just suck. When we hit memory limit (global or a limit on
cgroup with subgroups) we reclaim some memory from all cgroups.
This is sucks because, the cgroup that allocates more often always wins.
E.g. job that allocates a lot of clean rarely used page cache will push
out of memory other jobs with active relatively small all in memory
working set.

To prevent such situations we have memcg controls like low/max, etc which
are supposed to protect jobs or limit them so they to not hurt others.
But memory cgroups are very hard to configure right because it requires
precise knowledge of the workload which may vary during the execution.
E.g. setting memory limit means that job won't be able to use all memory
in the system for page cache even if the rest the system is idle.
Basically our current scheme requires to configure every single cgroup
in the system.

I think we can do better. The idea proposed by this patch is to reclaim
only inactive pages and only from cgroups that have big
(!inactive_is_low()) inactive list. And go back to shrinking active lists
only if all inactive lists are low.

Now, the simple test case to demonstrate the effect of the patch.
The job in one memcg repeatedly compresses one file:

 perf stat -n --repeat 20 gzip -ck sample > /dev/null

and just 'dd' running in parallel reading the disk in another cgroup.

Before:
Performance counter stats for 'gzip -ck sample' (20 runs):
      17.673572290 seconds time elapsed                                          ( +-  5.60% )
After:
Performance counter stats for 'gzip -ck sample' (20 runs):
      11.426193980 seconds time elapsed                                          ( +-  0.20% )

The more often dd cgroup allocates memory, the more gzip suffer.
With 4 parallel dd instead of one:

Before:
Performance counter stats for 'gzip -ck sample' (20 runs):
      499.976782013 seconds time elapsed                                          ( +- 23.13% )
After:
Performance counter stats for 'gzip -ck sample' (20 runs):
      11.307450516 seconds time elapsed                                          ( +-  0.27% )

It would be possible to achieve the similar effect by
setting the memory.low on gzip cgroup, but the best value for memory.low
depends on the size of the 'sample' file. It also possible
to limit the 'dd' job, but just imagine something more sophisticated
than just 'dd', the job that would benefit from occupying all available
memory. The best limit for such job would be something like
'total_memory' - 'sample size' which is again unknown.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index efd10d6b9510..2f562c3358ab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -104,6 +104,8 @@ struct scan_control {
 	/* One of the zones is ready for compaction */
 	unsigned int compaction_ready:1;
 
+	unsigned int may_shrink_active:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -2489,6 +2491,10 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 
 		scan >>= sc->priority;
 
+		if (!sc->may_shrink_active && inactive_list_is_low(lruvec,
+						file, memcg, sc, false))
+			scan = 0;
+
 		/*
 		 * If the cgroup's already been deleted, make sure to
 		 * scrape out the remaining cache.
@@ -2733,6 +2739,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	unsigned long nr_reclaimed, nr_scanned;
 	bool reclaimable = false;
+	bool retry;
 
 	do {
 		struct mem_cgroup *root = sc->target_mem_cgroup;
@@ -2742,6 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		};
 		struct mem_cgroup *memcg;
 
+		retry = false;
+
 		memset(&sc->nr, 0, sizeof(sc->nr));
 
 		nr_reclaimed = sc->nr_reclaimed;
@@ -2813,6 +2822,13 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
+		if ((sc->nr_scanned - nr_scanned) == 0 &&
+		     !sc->may_shrink_active) {
+			sc->may_shrink_active = 1;
+			retry = true;
+			continue;
+		}
+
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
@@ -2887,7 +2903,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
 			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
-	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
+	} while (retry || should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
 
 	/*
-- 
2.19.2

