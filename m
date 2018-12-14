Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B022C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCD420675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeLNXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:34 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:42127 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730023AbeLNXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:14 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 8CA061C2081
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:12 +0000 (GMT)
Received: (qmail 31280 invoked from network); 14 Dec 2018 23:03:12 -0000
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
Subject: [PATCH 07/14] mm, compaction: Always finish scanning of a full pageblock
Date:   Fri, 14 Dec 2018 23:03:03 +0000
Message-Id: <20181214230310.572-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compaction is finishing, it uses a flag to ensure the pageblock is
complete.  However, in general it makes sense to always complete migration
of a pageblock. Minimally, skip information is based on a pageblock and
partially scanned pageblocks may incur more scanning in the future. The
pageblock skip handling also becomes more strict later in the series and
the hint is more useful if a complete pageblock was always scanned.

The impact here is potentially on latencies as more scanning is done
but it's not a consistent win or loss as the scanning is not always a
high percentage of the pageblock and sometimes it is offset by future
reductions in scanning. Hence, the results are not presented this time as
it's a mix of gains/losses without any clear pattern. However, completing
scanning of the pageblock is important for later patches.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 19 ++++++++-----------
 mm/internal.h   |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8134dba47584..4f51435c645a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1338,16 +1338,14 @@ static enum compact_result __compact_finished(struct compact_control *cc)
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
@@ -1389,7 +1387,6 @@ static enum compact_result __compact_finished(struct compact_control *cc)
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

