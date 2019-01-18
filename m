Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91FDC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884EB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfARRyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:54:33 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:52809 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbfARRyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:54:32 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id BFCDD98C6A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:54:29 +0000 (UTC)
Received: (qmail 6551 invoked from network); 18 Jan 2019 17:54:29 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:54:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 16/22] mm, compaction: Rework compact_should_abort as compact_check_resched
Date:   Fri, 18 Jan 2019 17:51:30 +0000
Message-Id: <20190118175136.31341-17-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With incremental changes, compact_should_abort no longer makes
any documented sense. Rename to compact_check_resched and update the
associated comments.  There is no benefit other than reducing redundant
code and making the intent slightly clearer. It could potentially be
merged with earlier patches but it just makes the review slightly
harder.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c | 61 ++++++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 829540f6f3da..9aa71945255d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -404,6 +404,21 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+/*
+ * Aside from avoiding lock contention, compaction also periodically checks
+ * need_resched() and records async compaction as contended if necessary.
+ */
+static inline void compact_check_resched(struct compact_control *cc)
+{
+	/* async compaction aborts if contended */
+	if (need_resched()) {
+		if (cc->mode == MIGRATE_ASYNC)
+			cc->contended = true;
+
+		cond_resched();
+	}
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -432,33 +447,7 @@ static bool compact_unlock_should_abort(spinlock_t *lock,
 		return true;
 	}
 
-	if (need_resched()) {
-		if (cc->mode == MIGRATE_ASYNC)
-			cc->contended = true;
-		cond_resched();
-	}
-
-	return false;
-}
-
-/*
- * Aside from avoiding lock contention, compaction also periodically checks
- * need_resched() and either schedules in sync compaction or aborts async
- * compaction. This is similar to what compact_unlock_should_abort() does, but
- * is used where no lock is concerned.
- *
- * Returns false when no scheduling was needed, or sync compaction scheduled.
- * Returns true when async compaction should abort.
- */
-static inline bool compact_should_abort(struct compact_control *cc)
-{
-	/* async compaction aborts if contended */
-	if (need_resched()) {
-		if (cc->mode == MIGRATE_ASYNC)
-			cc->contended = true;
-
-		cond_resched();
-	}
+	compact_check_resched(cc);
 
 	return false;
 }
@@ -747,8 +736,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			return 0;
 	}
 
-	if (compact_should_abort(cc))
-		return 0;
+	compact_check_resched(cc);
 
 	if (cc->direct_compaction && (cc->mode == MIGRATE_ASYNC)) {
 		skip_on_failure = true;
@@ -1379,12 +1367,10 @@ static void isolate_freepages(struct compact_control *cc)
 				isolate_start_pfn = block_start_pfn) {
 		/*
 		 * This can iterate a massively long zone without finding any
-		 * suitable migration targets, so periodically check if we need
-		 * to schedule, or even abort async compaction.
+		 * suitable migration targets, so periodically check resched.
 		 */
-		if (!(block_start_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages))
-						&& compact_should_abort(cc))
-			break;
+		if (!(block_start_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
+			compact_check_resched(cc);
 
 		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
 									zone);
@@ -1675,11 +1661,10 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
 		/*
 		 * This can potentially iterate a massively long zone with
 		 * many pageblocks unsuitable, so periodically check if we
-		 * need to schedule, or even abort async compaction.
+		 * need to schedule.
 		 */
-		if (!(low_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages))
-						&& compact_should_abort(cc))
-			break;
+		if (!(low_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
+			compact_check_resched(cc);
 
 		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
 									zone);
-- 
2.16.4

