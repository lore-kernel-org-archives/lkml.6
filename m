Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B2CC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241762087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfARRxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:53:00 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:60052 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbfARRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:53:00 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 534FBB87ED
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:52:58 +0000 (GMT)
Received: (qmail 1326 invoked from network); 18 Jan 2019 17:52:58 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:52:58 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 07/22] mm, compaction: Always finish scanning of a full pageblock
Date:   Fri, 18 Jan 2019 17:51:21 +0000
Message-Id: <20190118175136.31341-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compaction is finishing, it uses a flag to ensure the pageblock
is complete but it makes sense to always complete migration of a
pageblock. Minimally, skip information is based on a pageblock and
partially scanned pageblocks may incur more scanning in the future. The
pageblock skip handling also becomes more strict later in the series and
the hint is more useful if a complete pageblock was always scanned.

The potentially impacts latency as more scanning is done but it's not a
consistent win or loss as the scanning is not always a high percentage
of the pageblock and sometimes it is offset by future reductions
in scanning. Hence, the results are not presented this time due to a
misleading mix of gains/losses without any clear pattern. However, full
scanning of the pageblock is important for later patches.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c | 19 ++++++++-----------
 mm/internal.h   |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 32a88b49f973..3d11c209614a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1331,16 +1331,14 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	if (is_via_compact_memory(cc->order))
 		return COMPACT_CONTINUE;
 
-	if (cc->finishing_block) {
-		/*
-		 * We have finished the pageblock, but better check again that
-		 * we really succeeded.
-		 */
-		if (IS_ALIGNED(cc->migrate_pfn, pageblock_nr_pages))
-			cc->finishing_block = false;
-		else
-			return COMPACT_CONTINUE;
-	}
+	/*
+	 * Always finish scanning a pageblock to reduce the possibility of
+	 * fallbacks in the future. This is particularly important when
+	 * migration source is unmovable/reclaimable but it's not worth
+	 * special casing.
+	 */
+	if (!IS_ALIGNED(cc->migrate_pfn, pageblock_nr_pages))
+		return COMPACT_CONTINUE;
 
 	/* Direct compactor: Is a suitable page free? */
 	for (order = cc->order; order < MAX_ORDER; order++) {
@@ -1382,7 +1380,6 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 				return COMPACT_SUCCESS;
 			}
 
-			cc->finishing_block = true;
 			return COMPACT_CONTINUE;
 		}
 	}
diff --git a/mm/internal.h b/mm/internal.h
index f40d06d70683..9b32f4cab0ae 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -203,7 +203,6 @@ struct compact_control {
 	bool direct_compaction;		/* False from kcompactd or /proc/... */
 	bool whole_zone;		/* Whole zone should/has been scanned */
 	bool contended;			/* Signal lock or sched contention */
-	bool finishing_block;		/* Finishing current pageblock */
 };
 
 unsigned long
-- 
2.16.4

