Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EBEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4C520685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4C520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409687AbeKWW31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:29:27 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:33970 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409672AbeKWW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:29:26 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id C9DF71C2CF2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:45:29 +0000 (GMT)
Received: (qmail 12335 invoked from network); 23 Nov 2018 11:45:29 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPA; 23 Nov 2018 11:45:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/5] mm: Use alloc_flags to record if kswapd can wake
Date:   Fri, 23 Nov 2018 11:45:26 +0000
Message-Id: <20181123114528.28802-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181123114528.28802-1-mgorman@techsingularity.net>
References: <20181123114528.28802-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch that copies the GFP flag __GFP_KSWAPD_RECLAIM
into alloc_flags. This is a preparation patch only that avoids having to
pass gfp_mask through a long callchain in a future patch.

Note that the setting in the fast path happens in alloc_flags_nofragment()
and it may be claimed that this has nothing to do with ALLOC_NO_FRAGMENT.
That's true in this patch but is not true later so it's done now for
easier review to show where the flag needs to be recorded.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 544355156c92..be826ee9dc7f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -489,6 +489,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
+#define ALLOC_KSWAPD		0x200 /* allow waking of kswapd */
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4ba84cd2977a..e44eb68744ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3278,10 +3278,15 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
  * fragmentation between the Normal and DMA32 zones.
  */
 static inline unsigned int
-alloc_flags_nofragment(struct zone *zone)
+alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 {
+	unsigned int alloc_flags = 0;
+
+	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
+		alloc_flags |= ALLOC_KSWAPD;
+
 	if (zone_idx(zone) != ZONE_NORMAL)
-		return 0;
+		goto out;
 
 	/*
 	 * If ZONE_DMA32 exists, assume it is the one after ZONE_NORMAL and
@@ -3290,13 +3295,14 @@ alloc_flags_nofragment(struct zone *zone)
 	 */
 	BUILD_BUG_ON(ZONE_NORMAL - ZONE_DMA32 != 1);
 	if (nr_online_nodes > 1 && !populated_zone(--zone))
-		return 0;
+		goto out;
 
-	return ALLOC_NOFRAGMENT;
+out:
+	return alloc_flags;
 }
 #else
 static inline unsigned int
-alloc_flags_nofragment(struct zone *zone)
+alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -3939,6 +3945,9 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	} else if (unlikely(rt_task(current)) && !in_interrupt())
 		alloc_flags |= ALLOC_HARDER;
 
+	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
+		alloc_flags |= ALLOC_KSWAPD;
+
 #ifdef CONFIG_CMA
 	if (gfpflags_to_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
@@ -4170,7 +4179,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
-	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
+	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
 
 	/*
@@ -4228,7 +4237,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 retry:
 	/* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
-	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
+	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
@@ -4451,7 +4460,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
 	 */
-	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone);
+	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
-- 
2.16.4

