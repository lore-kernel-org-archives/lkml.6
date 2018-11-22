Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F766C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406143AbeKWDpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:45:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732556AbeKWDpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:45:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D599AE4A;
        Thu, 22 Nov 2018 17:05:03 +0000 (UTC)
Subject: Re: [PATCH 4/4] mm: Stall movable allocations until kswapd progresses
 during serious external fragmentation event
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181121101414.21301-1-mgorman@techsingularity.net>
 <20181121101414.21301-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <35ea6691-e819-5581-7d32-39c1abfbe775@suse.cz>
Date:   Thu, 22 Nov 2018 18:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121101414.21301-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:14 AM, Mel Gorman wrote:
> An event that potentially causes external fragmentation problems has
> already been described but there are degrees of severity.  A "serious"
> event is defined as one that steals a contiguous range of pages of an order
> lower than fragment_stall_order (PAGE_ALLOC_COSTLY_ORDER by default). If a
> movable allocation request that is allowed to sleep needs to steal a small
> block then it schedules until kswapd makes progress or a timeout passes.
> The watermarks are also boosted slightly faster so that kswapd makes
> greater effort to reclaim enough pages to avoid the fragmentation event.
> 
> This stall is not guaranteed to avoid serious fragmentation events.
> If memory pressure is high enough, the pages freed by kswapd may be
> reallocated or the free pages may not be in pageblocks that contain
> only movable pages. Furthermore an allocation request that cannot stall
> (e.g. atomic allocations) or unmovable/reclaimable allocations will still
> proceed without stalling.

Not doing this for unmovable/reclaimable allocations is kinda disadvantage?

>  ==============================================================
>  
> +fragment_stall_order
> +
> +External fragmentation control is managed on a pageblock level where the
> +page allocator tries to avoid mixing pages of different mobility within page
> +blocks (e.g. order 9 on 64-bit x86). If external fragmentation is perfectly
> +controlled then a THP allocation will often succeed up to the number of
> +movable pageblocks in the system as reported by /proc/pagetypeinfo.
> +
> +When memory is low, the system may have to mix pageblocks and will wake
> +kswapd to try control future fragmentation. fragment_stall_order controls if
> +the allocating task will stall if possible until kswapd makes some progress
> +in preference to fragmenting the system. This incurs a small stall penalty
> +in exchange for future success at allocating huge pages. If the stalls
> +are undesirable and high-order allocations are irrelevant then this can
> +be disabled by writing 0 to the tunable. Writing the pageblock order will
> +strongly (but not perfectly) control external fragmentation.
> +
> +The default will stall for fragmenting allocations smaller than the
> +PAGE_ALLOC_COSTLY_ORDER (defined as order-3 at the time of writing).

Perhaps be more explicit that steals of orders strictly lower than given
value will stall? So for the default order-3, the sysctl value is 4,
which might confuse somebody.

> +
> @@ -2130,9 +2131,10 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
>  	return false;
>  }
>  
> +
> +static void stall_fragmentation(struct zone *pzone)
> +{
> +	DEFINE_WAIT(wait);
> +	long remaining = 0;
> +	long timeout = HZ/50;
> +	pg_data_t *pgdat = pzone->zone_pgdat;
> +
> +	if (current->flags & PF_MEMALLOC)
> +		return;
> +
> +	boost_watermark(pzone, true);

Should zone->lock be taken around this to make watermark_boost
adjustment safe? Similar to balance_pgdat().

> +	prepare_to_wait(&pgdat->pfmemalloc_wait, &wait, TASK_INTERRUPTIBLE);
> +	if (waitqueue_active(&pgdat->kswapd_wait))
> +		wake_up_interruptible(&pgdat->kswapd_wait);
> +	remaining = schedule_timeout(timeout);
> +	finish_wait(&pgdat->pfmemalloc_wait, &wait);
> +	if (remaining != timeout) {
> +		trace_mm_fragmentation_stall(pgdat->node_id,
> +			jiffies_to_usecs(timeout - remaining));
> +		count_vm_event(FRAGMENTSTALL);
> +	}
>  }
>  

> @@ -4186,6 +4234,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 */
>  	alloc_flags = gfp_to_alloc_flags(gfp_mask);
>  
> +	/*
> +	 * Consider stalling on heavy for movable allocations in preference to
> +	 * fragmenting unmovable/reclaimable pageblocks.
> +	 */
> +	if ((gfp_mask & (__GFP_MOVABLE|__GFP_DIRECT_RECLAIM)) ==
> +			(__GFP_MOVABLE|__GFP_DIRECT_RECLAIM))
> +		alloc_flags |= ALLOC_FRAGMENT_STALL;

Surprised that this only has effect in the slowpath, i.e. when
watermarks are below 'low'. If it's intended (to not stall that much I
suppose) maybe explain the rationale in the changelog?

Thanks for the series, Mel, hope the results are still optimistic after
some of the fixes that might unfortunately limit its impact :)

Vlastimil
