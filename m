Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B88C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF84D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfARRxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:53:10 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:55130 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbfARRxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:53:10 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 7EC9B1C35AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:53:08 +0000 (GMT)
Received: (qmail 2023 invoked from network); 18 Jan 2019 17:53:08 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:53:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 08/22] mm, compaction: Ignore the fragmentation avoidance boost for isolation and compaction
Date:   Fri, 18 Jan 2019 17:51:22 +0000
Message-Id: <20190118175136.31341-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pageblocks get fragmented, watermarks are artifically boosted to
reclaim pages to avoid further fragmentation events. However, compaction
is often either fragmentation-neutral or moving movable pages away from
unmovable/reclaimable pages. As the true watermarks are preserved, allow
compaction to ignore the boost factor.

The expected impact is very slight as the main benefit is that compaction
is slightly more likely to succeed when the system has been fragmented
very recently. On both 1-socket and 2-socket machines for THP-intensive
allocation during fragmentation the success rate was increased by less
than 1% which is marginal. However, detailed tracing indicated that
failure of migration due to a premature ENOMEM triggered by watermark
checks were eliminated.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fc769ff4fb2c..6607cb7131b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,7 +3071,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * watermark, because we already know our high-order page
 		 * exists.
 		 */
-		watermark = min_wmark_pages(zone) + (1UL << order);
+		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
 
-- 
2.16.4

