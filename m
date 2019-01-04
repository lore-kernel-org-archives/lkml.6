Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B135C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452DA208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfADMyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:54:40 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:58519 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfADMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:54:39 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 06EB8988BA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:54:37 +0000 (UTC)
Received: (qmail 12608 invoked from network); 4 Jan 2019 12:54:36 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:54:36 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 25/25] mm, compaction: Do not direct compact remote memory
Date:   Fri,  4 Jan 2019 12:50:11 +0000
Message-Id: <20190104125011.16071-26-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote compaction is expensive and possibly counter-productive. Locality
is expected to often have better performance characteristics than remote
high-order pages. For small allocations, it's expected that locality is
generally required or fallbacks are possible. For larger allocations such
as THP, they are forbidden at the time of writing but if __GFP_THISNODE
is ever removed, then it would still be preferable to fallback to small
local base pages over remote THP in the general case. kcompactd is still
woken via kswapd so compaction happens eventually.

While this patch potentially has both positive and negative effects,
it is best to avoid the possibility of remote compaction given the cost
relative to any potential benefit.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index ae70be023b21..cc17f0c01811 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2348,6 +2348,16 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			continue;
 		}
 
+		/*
+		 * Do not compact remote memory. It's expensive and high-order
+		 * small allocations are expected to prefer or require local
+		 * memory. Similarly, larger requests such as THP can fallback
+		 * to base pages in preference to remote huge pages if
+		 * __GFP_THISNODE is not specified
+		 */
+		if (zone_to_nid(zone) != zone_to_nid(ac->preferred_zoneref->zone))
+			continue;
+
 		status = compact_zone_order(zone, order, gfp_mask, prio,
 				alloc_flags, ac_classzone_idx(ac), capture);
 		rc = max(status, rc);
-- 
2.16.4

