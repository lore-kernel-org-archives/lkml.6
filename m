Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B3620838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B3620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbeKABzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:55:46 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:50712 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbeKABzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:55:46 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id BAF4A1C22A6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:56:53 +0000 (GMT)
Received: (qmail 3210 invoked from network); 31 Oct 2018 16:56:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Oct 2018 16:56:53 -0000
Date:   Wed, 31 Oct 2018 16:56:52 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm: Reclaim small amounts of memory when an external
 fragmentation event occurs
Message-ID: <20181031165651.GE23537@techsingularity.net>
References: <20181031160645.7633-1-mgorman@techsingularity.net>
 <20181031160645.7633-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181031160645.7633-4-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 04:06:43PM +0000, Mel Gorman wrote:
> An external fragmentation event was previously described as
> 
>     When the page allocator fragments memory, it records the event using
>     the mm_page_alloc_extfrag event. If the fallback_order is smaller
>     than a pageblock order (order-9 on 64-bit x86) then it's considered
>     an event that will cause external fragmentation issues in the future.
> 

This had a build error reported by the 0-day bot. It's trivially fixed
with

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77bcc35903e0..e36c279dfade 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3317,8 +3317,8 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
  * probably too small. It only makes sense to spread allocations to avoid
  * fragmentation between the Normal and DMA32 zones.
  */
-static inline unsigned int alloc_flags_nofragment(struct zone *zone,
-							gfp_t gfp_mask)
+static inline unsigned int
+alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 {
 	if (zone_idx(zone) != ZONE_NORMAL)
 		return 0;
@@ -3340,7 +3340,8 @@ static inline unsigned int alloc_flags_nofragment(struct zone *zone,
 	return ALLOC_NOFRAGMENT;
 }
 #else
-static inline unsigned int alloc_flags_nofragment(struct zone *zone)
+static inline unsigned int
+alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 {
 	return 0;
 }

-- 
Mel Gorman
SUSE Labs
