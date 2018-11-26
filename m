Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08366C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5B820817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5B820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeK0B3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:29:24 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:33833 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbeK0B3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:29:24 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id D749AB88C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:35:04 +0000 (GMT)
Received: (qmail 25380 invoked from network); 26 Nov 2018 14:35:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2018 14:35:04 -0000
Date:   Mon, 26 Nov 2018 14:35:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm: Use alloc_flags to record if kswapd can wake -fix
Message-ID: <20181126143503.GO23260@techsingularity.net>
References: <20181123114528.28802-1-mgorman@techsingularity.net>
 <20181123114528.28802-4-mgorman@techsingularity.net>
 <39711f99-1a2a-67d3-5cb0-a63ac739a917@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <39711f99-1a2a-67d3-5cb0-a63ac739a917@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka correctly pointed out that the ALLOC_KSWAPD flag needs to be
applied in the !CONFIG_ZONE_DMA32 case. This is a fix for the mmotm path
mm-use-alloc_flags-to-record-if-kswapd-can-wake.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e44eb68744ed..a48ebb821360 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3268,7 +3268,6 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 }
 #endif	/* CONFIG_NUMA */
 
-#ifdef CONFIG_ZONE_DMA32
 /*
  * The restriction on ZONE_DMA32 as being a suitable zone to use to avoid
  * fragmentation is subtle. If the preferred zone was HIGHMEM then
@@ -3285,6 +3284,7 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
 		alloc_flags |= ALLOC_KSWAPD;
 
+#ifdef CONFIG_ZONE_DMA32
 	if (zone_idx(zone) != ZONE_NORMAL)
 		goto out;
 
@@ -3298,15 +3298,9 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 		goto out;
 
 out:
+#endif /* CONFIG_ZONE_DMA32 */
 	return alloc_flags;
 }
-#else
-static inline unsigned int
-alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
-{
-	return 0;
-}
-#endif
 
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
