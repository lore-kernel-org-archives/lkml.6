Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DDBC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC620850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfARRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:54:22 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:44223 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728949AbfARRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:54:21 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 9BA53B879A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:54:19 +0000 (GMT)
Received: (qmail 5918 invoked from network); 18 Jan 2019 17:54:19 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:54:19 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 15/22] mm, compaction: Keep cached migration PFNs synced for unusable pageblocks
Date:   Fri, 18 Jan 2019 17:51:29 +0000
Message-Id: <20190118175136.31341-16-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate has separate cached PFNs for ASYNC and SYNC* migration on the
basis that some migrations will fail in ASYNC mode. However, if the cached
PFNs match at the start of scanning and pageblocks are skipped due to
having no isolation candidates, then the sync state does not matter.
This patch keeps matching cached PFNs in sync until a pageblock with
isolation candidates is found.

The actual benefit is marginal given that the sync scanner following the
async scanner will often skip a number of pageblocks but it's useless
work. Any benefit depends heavily on whether the scanners restarted
recently.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 14bb66d48392..829540f6f3da 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1969,6 +1969,7 @@ static enum compact_result compact_zone(struct compact_control *cc)
 	unsigned long end_pfn = zone_end_pfn(cc->zone);
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
+	bool update_cached;
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
@@ -2016,6 +2017,17 @@ static enum compact_result compact_zone(struct compact_control *cc)
 
 	last_migrated_pfn = 0;
 
+	/*
+	 * Migrate has separate cached PFNs for ASYNC and SYNC* migration on
+	 * the basis that some migrations will fail in ASYNC mode. However,
+	 * if the cached PFNs match and pageblocks are skipped due to having
+	 * no isolation candidates, then the sync state does not matter.
+	 * Until a pageblock with isolation candidates is found, keep the
+	 * cached PFNs in sync to avoid revisiting the same blocks.
+	 */
+	update_cached = !sync &&
+		cc->zone->compact_cached_migrate_pfn[0] == cc->zone->compact_cached_migrate_pfn[1];
+
 	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
 				cc->free_pfn, end_pfn, sync);
 
@@ -2047,6 +2059,11 @@ static enum compact_result compact_zone(struct compact_control *cc)
 			last_migrated_pfn = 0;
 			goto out;
 		case ISOLATE_NONE:
+			if (update_cached) {
+				cc->zone->compact_cached_migrate_pfn[1] =
+					cc->zone->compact_cached_migrate_pfn[0];
+			}
+
 			/*
 			 * We haven't isolated and migrated anything, but
 			 * there might still be unflushed migrations from
@@ -2054,6 +2071,7 @@ static enum compact_result compact_zone(struct compact_control *cc)
 			 */
 			goto check_drain;
 		case ISOLATE_SUCCESS:
+			update_cached = false;
 			last_migrated_pfn = start_pfn;
 			;
 		}
-- 
2.16.4

