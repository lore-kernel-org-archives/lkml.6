Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C237208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfADMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:53:38 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:43297 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbfADMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:53:38 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id DD630988B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:53:35 +0000 (UTC)
Received: (qmail 8538 invoked from network); 4 Jan 2019 12:53:35 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:53:35 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 19/25] mm, compaction: Do not consider a need to reschedule as contention
Date:   Fri,  4 Jan 2019 12:50:05 +0000
Message-Id: <20190104125011.16071-20-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning on large machines can take a considerable length of time and
eventually need to be rescheduled. This is treated as an abort event but
that's not appropriate as the attempt is likely to be retried after making
numerous checks and taking another cycle through the page allocator.
This patch will check the need to reschedule if necessary but continue
the scanning.

The main benefit is reduced scanning when compaction is taking a long time
or the machine is over-saturated. It also avoids an unnecessary exit of
compaction that ends up being retried by the page allocator in the outer
loop.

                                        4.20.0                 4.20.0
                              synccached-v2r15        noresched-v2r15
Amean     fault-both-3      2655.55 (   0.00%)     2736.50 (  -3.05%)
Amean     fault-both-5      4580.67 (   0.00%)     4133.70 (   9.76%)
Amean     fault-both-7      5740.50 (   0.00%)     5738.61 (   0.03%)
Amean     fault-both-12     9237.55 (   0.00%)     9392.82 (  -1.68%)
Amean     fault-both-18    12899.51 (   0.00%)    13257.15 (  -2.77%)
Amean     fault-both-24    16342.47 (   0.00%)    16859.44 (  -3.16%)
Amean     fault-both-30    20394.26 (   0.00%)    16249.30 *  20.32%*
Amean     fault-both-32    17450.76 (   0.00%)    14904.71 *  14.59%*

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1a41a2dbff24..75eb0d40d4d7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -398,19 +398,11 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
-/*
- * Aside from avoiding lock contention, compaction also periodically checks
- * need_resched() and records async compaction as contended if necessary.
- */
+/* Avoid soft-lockups due to long scan times */
 static inline void compact_check_resched(struct compact_control *cc)
 {
-	/* async compaction aborts if contended */
-	if (need_resched()) {
-		if (cc->mode == MIGRATE_ASYNC)
-			cc->contended = true;
-
+	if (need_resched())
 		cond_resched();
-	}
 }
 
 /*
-- 
2.16.4

