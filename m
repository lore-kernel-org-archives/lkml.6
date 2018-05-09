Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbeEIIxv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:53:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:31335 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934141AbeEIIxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="227055183"
From: Aaron Lu <aaron.lu@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [RFC v3 PATCH 5/5] mm/can_skip_merge(): make it more aggressive to attempt cluster alloc/free
Date: Wed,  9 May 2018 16:54:50 +0800
Message-Id: <20180509085450.3524-6-aaron.lu@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509085450.3524-1-aaron.lu@intel.com>
References: <20180509085450.3524-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After system runs a long time, it's easy for a zone to have no
suitable high order page available and that will stop cluster alloc
and free in current implementation due to compact_considered > 0.

To make it favour order0 alloc/free, relax the condition to only
disallow cluster alloc/free when problem would occur, e.g. when
compaction is in progress.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 mm/internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e3f209f8fb39..521aa4d8f3c1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -552,10 +552,6 @@ void try_to_merge_page(struct page *page);
 #ifdef CONFIG_COMPACTION
 static inline bool can_skip_merge(struct zone *zone, int order)
 {
-	/* Compaction has failed in this zone, we shouldn't skip merging */
-	if (zone->compact_considered)
-		return false;
-
 	/* Only consider no_merge for order 0 pages */
 	if (order)
 		return false;
-- 
2.14.3
