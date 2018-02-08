Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBHVVo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:21:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:21394 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbeBHVVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:21:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,480,1511856000";
   d="scan'208";a="29299067"
From: Alexey Skidanov <alexey.skidanov@intel.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH] mm: Free CMA pages to the buddy allocator instead of per-cpu-pagelists
Date: Thu,  8 Feb 2018 23:21:53 +0200
Message-Id: <1518124913-31290-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code frees pages to the per-cpu-pagelists (pcp) according to
their migrate type. The exception is isolated pages that are freed
directly to the buddy allocator.

The pages are marked as isolate to indicate the buddy allocator that
they are not supposed to be allocated as opposite to the pages located
in the pcp lists that are immediate candidates for the upcoming
allocation requests.

This was likely an oversight when the CMA migrate type was added. As a
result of this, freed CMA pages go to the MIGRATE_MOVABLE per-cpu-list.
This sometime leads to CMA page allocation instead of Movable one,
increasing the probability of CMA page pining, which may cause to CMA
allocation failure. In addition, there is no gain to free CMA page to
the pcp because the CMA pages mainly allocated for DMA purpose.

To fix this, we free CMA page directly to the buddy allocator. This
avoids the CMA page allocation instead of MOVABLE one. Actually, the CMA
pages are very similar to the isolated ones - both of them should not be
supposed as immediate candidates for upcoming allocation requests and
thus shouldn't be freed to pcp. I've audited all the other checks for
isolated pageblocks to ensure that this mistake was not repeated elsewhere.

Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 59d5921..9a76b68 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2644,7 +2644,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	 * excessively into the page allocator
 	 */
 	if (migratetype >= MIGRATE_PCPTYPES) {
-		if (unlikely(is_migrate_isolate(migratetype))) {
+		if (unlikely(is_migrate_isolate(migratetype) ||
+				is_migrate_cma(migratetype))) {
 			free_one_page(zone, page, pfn, 0, migratetype);
 			return;
 		}
-- 
2.7.4
