Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0A320675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbeLNXGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:06:04 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:36914 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728415AbeLNXGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:06:04 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id DADE21C2072
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:06:02 +0000 (GMT)
Received: (qmail 3420 invoked from network); 14 Dec 2018 23:06:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Dec 2018 23:06:02 -0000
Date:   Fri, 14 Dec 2018 23:06:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/14] mm, compaction: Do not direct compact remote memory
Message-ID: <20181214230601.GE29005@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 39d33b6d1172..05fecd7227e4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2208,6 +2208,16 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
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


-- 
Mel Gorman
SUSE Labs
