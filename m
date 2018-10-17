Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25BC5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0E92087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJQO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:27:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:61980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeJQO1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:27:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="273090138"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 23:33:45 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [RFC v4 PATCH 5/5] mm/can_skip_merge(): make it more aggressive to attempt cluster alloc/free
Date:   Wed, 17 Oct 2018 14:33:30 +0800
Message-Id: <20181017063330.15384-6-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017063330.15384-1-aaron.lu@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index fb4e8f7976e5..309a3f43e613 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -538,10 +538,6 @@ void try_to_merge_page(struct page *page);
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
2.17.2

