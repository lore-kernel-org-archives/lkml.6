Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6880C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24657208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbeLNXD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:29 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:34219 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730694AbeLNXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:14 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 137711C20B0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:13 +0000 (GMT)
Received: (qmail 31313 invoked from network); 14 Dec 2018 23:03:12 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPA; 14 Dec 2018 23:03:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 09/14] mm, compaction: Ignore the fragmentation avoidance boost for isolation and compaction
Date:   Fri, 14 Dec 2018 23:03:05 +0000
Message-Id: <20181214230310.572-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pageblocks get fragmented, watermarks are artifically boosted to pages
are reclaimed to avoid further fragmentation events. However, compaction
is often either fragmentation-neutral or moving movable pages away from
unmovable/reclaimable pages. As the actual watermarks are preserved,
allow compaction to ignore the boost factor.

1-socket thpscale
                                    4.20.0-rc6             4.20.0-rc6
                               finishscan-v1r4           noboost-v1r4
Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
Amean     fault-both-3      3849.90 (   0.00%)     3753.53 (   2.50%)
Amean     fault-both-5      5054.13 (   0.00%)     5396.32 (  -6.77%)
Amean     fault-both-7      7061.77 (   0.00%)     7393.46 (  -4.70%)
Amean     fault-both-12    11560.59 (   0.00%)    12155.50 (  -5.15%)
Amean     fault-both-18    16120.15 (   0.00%)    16445.96 (  -2.02%)
Amean     fault-both-24    19804.31 (   0.00%)    20465.03 (  -3.34%)
Amean     fault-both-30    25018.73 (   0.00%)    20813.54 *  16.81%*
Amean     fault-both-32    24380.19 (   0.00%)    22384.02 (   8.19%)

The impact on the scan rates is a mixed bag because this patch is very
sensitive to timing and whether the boost was active or not. However,
detailed tracing indicated that failure of migration due to a premature
ENOMEM triggered by watermark checks were eliminated.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 80535cd55a92..c7b80e62bfd9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3043,7 +3043,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * watermark, because we already know our high-order page
 		 * exists.
 		 */
-		watermark = min_wmark_pages(zone) + (1UL << order);
+		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
 
-- 
2.16.4

