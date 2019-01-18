Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D940CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18492087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfARNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:40:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:40234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfARNkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:40:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88C70AD04;
        Fri, 18 Jan 2019 13:40:01 +0000 (UTC)
Subject: Re: [PATCH 24/25] mm, compaction: Capture a page under direct
 compaction
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-25-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d8a3dfc9-e4f6-ceb6-f29d-832bef14a14a@suse.cz>
Date:   Fri, 18 Jan 2019 14:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-25-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:50 PM, Mel Gorman wrote:
> Compaction is inherently race-prone as a suitable page freed during
> compaction can be allocated by any parallel task. This patch uses a
> capture_control structure to isolate a page immediately when it is freed
> by a direct compactor in the slow path of the page allocator. The intent
> is to avoid redundant scanning.
> 
>                                         4.20.0                 4.20.0
>                                selective-v2r15          capture-v2r15
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2624.85 (   0.00%)     2594.49 (   1.16%)
> Amean     fault-both-5      3842.66 (   0.00%)     4088.32 (  -6.39%)
> Amean     fault-both-7      5459.47 (   0.00%)     5936.54 (  -8.74%)
> Amean     fault-both-12     9276.60 (   0.00%)    10160.85 (  -9.53%)
> Amean     fault-both-18    14030.73 (   0.00%)    13908.92 (   0.87%)
> Amean     fault-both-24    13298.10 (   0.00%)    16819.86 * -26.48%*
> Amean     fault-both-30    17648.62 (   0.00%)    17901.74 (  -1.43%)
> Amean     fault-both-32    19161.67 (   0.00%)    18621.32 (   2.82%)
> 
> Latency is only moderately affected but the devil is in the details.
> A closer examination indicates that base page fault latency is much
> reduced but latency of huge pages is increased as it takes creater care
> to succeed. Part of the "problem" is that allocation success rates
> are close to 100% even when under pressure and compaction gets harder
> 
>                                    4.20.0                 4.20.0
>                           selective-v2r15          capture-v2r15
> Percentage huge-1         0.00 (   0.00%)        0.00 (   0.00%)
> Percentage huge-3        99.95 (   0.00%)       99.98 (   0.03%)
> Percentage huge-5        98.83 (   0.00%)       98.01 (  -0.84%)
> Percentage huge-7        96.78 (   0.00%)       98.30 (   1.58%)
> Percentage huge-12       98.85 (   0.00%)       97.76 (  -1.10%)
> Percentage huge-18       97.52 (   0.00%)       99.05 (   1.57%)
> Percentage huge-24       97.07 (   0.00%)       99.34 (   2.35%)
> Percentage huge-30       96.59 (   0.00%)       99.08 (   2.58%)
> Percentage huge-32       95.94 (   0.00%)       99.03 (   3.22%)
> 
> And scan rates are reduced as expected by 10% for the migration
> scanner and 37% for the free scanner indicating that there is
> less redundant work.
> 
> Compaction migrate scanned    20338945.00    18133661.00
> Compaction free scanned       12590377.00     7986174.00
> 
> The impact on 2-socket is much larger albeit not presented. Under
> a different workload that fragments heavily, the allocation latency
> is reduced by 26% while the success rate goes from 63% to 80%
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Great, you crossed off this old TODO item, and didn't need pageblock isolation
to do that :D

I have just one worry...

> @@ -837,6 +873,12 @@ static inline void __free_one_page(struct page *page,
>  
>  continue_merging:
>  	while (order < max_order - 1) {
> +		if (compaction_capture(capc, page, order)) {
> +			if (likely(!is_migrate_isolate(migratetype)))
> +				__mod_zone_freepage_state(zone, -(1 << order),
> +								migratetype);
> +			return;

What about MIGRATE_CMA pageblocks and compaction for non-movable allocation,
won't that violate CMA expecteations?
And less critically, this will avoid the migratetype stealing decisions and
actions, potentially resulting in worse fragmentation avoidance?

> +		}
>  		buddy_pfn = __find_buddy_pfn(pfn, order);
>  		buddy = page + (buddy_pfn - pfn);
>  
