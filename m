Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB6C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF789208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfADMxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:53:49 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:49560 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbfADMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:53:49 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 1D93F1C1CE3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:53:46 +0000 (GMT)
Received: (qmail 9216 invoked from network); 4 Jan 2019 12:53:46 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:53:45 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 20/25] mm, compaction: Reduce unnecessary skipping of migration target scanner
Date:   Fri,  4 Jan 2019 12:50:06 +0000
Message-Id: <20190104125011.16071-21-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast isolation of pages can move the scanner faster than is necessary
depending on the contents of the free list. This patch will only allow
the fast isolation to initialise the scanner and advance it slowly. The
primary means of moving the scanner forward is via the linear scanner
to reduce the likelihood the migration source/target scanners meet
prematurely triggering a rescan.

                                        4.20.0                 4.20.0
                               noresched-v2r15         slowfree-v2r15
Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
Amean     fault-both-3      2736.50 (   0.00%)     2512.53 (   8.18%)
Amean     fault-both-5      4133.70 (   0.00%)     4159.43 (  -0.62%)
Amean     fault-both-7      5738.61 (   0.00%)     5950.15 (  -3.69%)
Amean     fault-both-12     9392.82 (   0.00%)     8674.38 (   7.65%)
Amean     fault-both-18    13257.15 (   0.00%)    12850.79 (   3.07%)
Amean     fault-both-24    16859.44 (   0.00%)    17242.86 (  -2.27%)
Amean     fault-both-30    16249.30 (   0.00%)    19404.18 * -19.42%*
Amean     fault-both-32    14904.71 (   0.00%)    16200.79 (  -8.70%)

The impact to latency, success rates and scan rates is marginal but
avoiding unnecessary restarts is important. It helps later patches that
are more careful about how pageblocks are treated as earlier iterations
of those patches hit corner cases where the restarts were punishing and
very visible.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 75eb0d40d4d7..6c5552c6d8f9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -324,10 +324,9 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
  * future. The information is later cleared by __reset_isolation_suitable().
  */
 static void update_pageblock_skip(struct compact_control *cc,
-			struct page *page, unsigned long nr_isolated)
+			struct page *page, unsigned long pfn)
 {
 	struct zone *zone = cc->zone;
-	unsigned long pfn;
 
 	if (cc->no_set_skip_hint)
 		return;
@@ -335,13 +334,8 @@ static void update_pageblock_skip(struct compact_control *cc,
 	if (!page)
 		return;
 
-	if (nr_isolated)
-		return;
-
 	set_pageblock_skip(page);
 
-	pfn = page_to_pfn(page);
-
 	/* Update where async and sync compaction should restart */
 	if (pfn < zone->compact_cached_free_pfn)
 		zone->compact_cached_free_pfn = pfn;
@@ -359,7 +353,7 @@ static inline bool pageblock_skip_persistent(struct page *page)
 }
 
 static inline void update_pageblock_skip(struct compact_control *cc,
-			struct page *page, unsigned long nr_isolated)
+			struct page *page, unsigned long pfn)
 {
 }
 
@@ -450,7 +444,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				bool strict)
 {
 	int nr_scanned = 0, total_isolated = 0;
-	struct page *cursor, *valid_page = NULL;
+	struct page *cursor;
 	unsigned long flags = 0;
 	bool locked = false;
 	unsigned long blockpfn = *start_pfn;
@@ -477,9 +471,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		if (!pfn_valid_within(blockpfn))
 			goto isolate_fail;
 
-		if (!valid_page)
-			valid_page = page;
-
 		/*
 		 * For compound pages such as THP and hugetlbfs, we can save
 		 * potentially a lot of iterations if we skip them at once.
@@ -576,10 +567,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (strict && blockpfn < end_pfn)
 		total_isolated = 0;
 
-	/* Update the pageblock-skip if the whole pageblock was scanned */
-	if (blockpfn == end_pfn)
-		update_pageblock_skip(cc, valid_page, total_isolated);
-
 	cc->total_free_scanned += nr_scanned;
 	if (total_isolated)
 		count_compact_events(COMPACTISOLATED, total_isolated);
@@ -1295,8 +1282,10 @@ fast_isolate_freepages(struct compact_control *cc)
 		}
 	}
 
-	if (highest && highest > cc->zone->compact_cached_free_pfn)
+	if (highest && highest >= cc->zone->compact_cached_free_pfn) {
+		highest -= pageblock_nr_pages;
 		cc->zone->compact_cached_free_pfn = highest;
+	}
 
 	cc->total_free_scanned += nr_scanned;
 	if (!page)
@@ -1376,6 +1365,10 @@ static void isolate_freepages(struct compact_control *cc)
 		isolate_freepages_block(cc, &isolate_start_pfn, block_end_pfn,
 					freelist, false);
 
+		/* Update the skip hint if the full pageblock was scanned */
+		if (isolate_start_pfn == block_end_pfn)
+			update_pageblock_skip(cc, page, block_start_pfn);
+
 		/* Are enough freepages isolated? */
 		if (cc->nr_freepages >= cc->nr_migratepages) {
 			if (isolate_start_pfn >= block_end_pfn) {
-- 
2.16.4

