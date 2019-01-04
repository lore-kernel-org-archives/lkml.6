Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E194AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A3B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfADMxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:53:09 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:50378 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbfADMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:53:07 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 555D51C219E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:53:05 +0000 (GMT)
Received: (qmail 6206 invoked from network); 4 Jan 2019 12:53:05 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:53:05 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 16/25] mm, compaction: Check early for huge pages encountered by the migration scanner
Date:   Fri,  4 Jan 2019 12:50:02 +0000
Message-Id: <20190104125011.16071-17-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scanning for sources or targets, PageCompound is checked for huge
pages as they can be skipped quickly but it happens relatively late after
a lot of setup and checking. This patch short-cuts the check to make it
earlier. It might still change when the lock is acquired but this has
less overhead overall. The free scanner advances but the migration scanner
does not. Typically the free scanner encounters more movable blocks that
change state over the lifetime of the system and also tends to scan more
aggressively as it's actively filling its portion of the physical address
space with data. This could change in the future but for the moment,
this worked better in practice and incurred fewer scan restarts.

The impact on latency and allocation success rates is marginal but the
free scan rates are reduced by 32% and system CPU usage is reduced by
2.6%. The 2-socket results are not materially different.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 608d274f9880..921720f7a416 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1071,6 +1071,9 @@ static bool suitable_migration_source(struct compact_control *cc,
 {
 	int block_mt;
 
+	if (pageblock_skip_persistent(page))
+		return false;
+
 	if ((cc->mode != MIGRATE_ASYNC) || !cc->direct_compaction)
 		return true;
 
@@ -1693,12 +1696,17 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
 			continue;
 
 		/*
-		 * For async compaction, also only scan in MOVABLE blocks.
-		 * Async compaction is optimistic to see if the minimum amount
-		 * of work satisfies the allocation.
+		 * For async compaction, also only scan in MOVABLE blocks
+		 * without huge pages. Async compaction is optimistic to see
+		 * if the minimum amount of work satisfies the allocation.
+		 * The cached PFN is updated as it's possible that all
+		 * remaining blocks between source and target are suitable
+		 * and the compaction scanners fail to meet.
 		 */
-		if (!suitable_migration_source(cc, page))
+		if (!suitable_migration_source(cc, page)) {
+			update_cached_migrate(cc, block_end_pfn);
 			continue;
+		}
 
 		/* Perform the isolation */
 		low_pfn = isolate_migratepages_block(cc, low_pfn,
-- 
2.16.4

