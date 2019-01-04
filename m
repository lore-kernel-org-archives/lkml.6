Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A021872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfADMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:54:10 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:48332 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbfADMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:54:09 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 793071C2123
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:54:06 +0000 (GMT)
Received: (qmail 10824 invoked from network); 4 Jan 2019 12:54:06 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:54:06 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 22/25] mm, compaction: Sample pageblocks for free pages
Date:   Fri,  4 Jan 2019 12:50:08 +0000
Message-Id: <20190104125011.16071-23-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once fast searching finishes, there is a possibility that the linear
scanner is scanning full blocks found by the fast scanner earlier. This
patch uses an adaptive stride to sample pageblocks for free pages. The
more consecutive full pageblocks encountered, the larger the stride until
a pageblock with free pages is found. The scanners might meet slightly
sooner but it is an acceptable risk given that the search of the free
lists may still encounter the pages and adjust the cached PFN of the free
scanner accordingly.

In terms of latency and success rates, the impact is not obvious but the
free scan rate is reduced by 87% on a 1-socket machine and 92% on a
2-socket machine. It's also the first time in the series where the number
of pages scanned by the migration scanner is greater than the free scanner
due to the increased search efficiency.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 652e249168b1..cc532e81a7b7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -441,6 +441,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				unsigned long *start_pfn,
 				unsigned long end_pfn,
 				struct list_head *freelist,
+				unsigned int stride,
 				bool strict)
 {
 	int nr_scanned = 0, total_isolated = 0;
@@ -450,10 +451,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	unsigned long blockpfn = *start_pfn;
 	unsigned int order;
 
+	/* Strict mode is for isolation, speed is secondary */
+	if (strict)
+		stride = 1;
+
 	cursor = pfn_to_page(blockpfn);
 
 	/* Isolate free pages. */
-	for (; blockpfn < end_pfn; blockpfn++, cursor++) {
+	for (; blockpfn < end_pfn; blockpfn += stride, cursor += stride) {
 		int isolated;
 		struct page *page = cursor;
 
@@ -624,7 +629,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-						block_end_pfn, &freelist, true);
+					block_end_pfn, &freelist, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -1139,7 +1144,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
 
 	/* Scan before */
 	if (start_pfn != pfn) {
-		isolate_freepages_block(cc, &start_pfn, pfn, &cc->freepages, false);
+		isolate_freepages_block(cc, &start_pfn, pfn, &cc->freepages, 1, false);
 		if (cc->nr_freepages >= cc->nr_migratepages)
 			return;
 	}
@@ -1147,7 +1152,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
 	/* Scan after */
 	start_pfn = pfn + nr_isolated;
 	if (start_pfn != end_pfn)
-		isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, false);
+		isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
 	if (cc->nr_freepages < cc->nr_migratepages)
@@ -1333,7 +1338,9 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
 	unsigned long block_end_pfn;	/* end of current pageblock */
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
+	unsigned long nr_isolated;
 	struct list_head *freelist = &cc->freepages;
+	unsigned int stride;
 
 	/* Try a small search of the free lists for a candidate */
 	isolate_start_pfn = fast_isolate_freepages(cc);
@@ -1356,6 +1363,7 @@ static void isolate_freepages(struct compact_control *cc)
 	block_end_pfn = min(block_start_pfn + pageblock_nr_pages,
 						zone_end_pfn(zone));
 	low_pfn = pageblock_end_pfn(cc->migrate_pfn);
+	stride = cc->mode == MIGRATE_ASYNC ? COMPACT_CLUSTER_MAX : 1;
 
 	/*
 	 * Isolate free pages until enough are available to migrate the
@@ -1387,8 +1395,8 @@ static void isolate_freepages(struct compact_control *cc)
 			continue;
 
 		/* Found a block suitable for isolating free pages from. */
-		isolate_freepages_block(cc, &isolate_start_pfn, block_end_pfn,
-					freelist, false);
+		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
+					block_end_pfn, freelist, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn == block_end_pfn)
@@ -1412,6 +1420,13 @@ static void isolate_freepages(struct compact_control *cc)
 			 */
 			break;
 		}
+
+		/* Adjust stride depending on isolation */
+		if (nr_isolated) {
+			stride = 1;
+			continue;
+		}
+		stride = min_t(unsigned int, COMPACT_CLUSTER_MAX, stride << 1);
 	}
 
 	/*
-- 
2.16.4

