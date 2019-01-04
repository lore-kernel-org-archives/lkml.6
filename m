Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B411C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E6208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfADMwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:52:06 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:45751 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfADMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:52:05 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 2C1D1B87AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:52:04 +0000 (GMT)
Received: (qmail 2494 invoked from network); 4 Jan 2019 12:52:04 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:52:04 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 10/25] mm, compaction: Ignore the fragmentation avoidance boost for isolation and compaction
Date:   Fri,  4 Jan 2019 12:49:56 +0000
Message-Id: <20190104125011.16071-11-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
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
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 57ba9d1da519..05c9a81d54ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2958,7 +2958,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * watermark, because we already know our high-order page
 		 * exists.
 		 */
-		watermark = min_wmark_pages(zone) + (1UL << order);
+		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
 
-- 
2.16.4

