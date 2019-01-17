Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CDEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfAQQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:38:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbfAQQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:38:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC97AACD1;
        Thu, 17 Jan 2019 16:38:36 +0000 (UTC)
Subject: Re: [PATCH 15/25] mm, compaction: Finish pageblock scanning on
 contention
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-16-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ab29ee0b-6b01-c57e-7d7d-de540f06ce07@suse.cz>
Date:   Thu, 17 Jan 2019 17:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-16-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:50 PM, Mel Gorman wrote:
> Async migration aborts on spinlock contention but contention can be high
> when there are multiple compaction attempts and kswapd is active. The
> consequence is that the migration scanners move forward uselessly while
> still contending on locks for longer while leaving suitable migration
> sources behind.
> 
> This patch will acquire the lock but track when contention occurs. When
> it does, the current pageblock will finish as compaction may succeed for
> that block and then abort. This will have a variable impact on latency as
> in some cases useless scanning is avoided (reduces latency) but a lock
> will be contended (increase latency) or a single contended pageblock is
> scanned that would otherwise have been skipped (increase latency).
> 
>                                         4.20.0                 4.20.0
>                                 norescan-v2r15    finishcontend-v2r15
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2872.13 (   0.00%)     2973.08 (  -3.51%)
> Amean     fault-both-5      4330.56 (   0.00%)     3870.19 (  10.63%)
> Amean     fault-both-7      6496.63 (   0.00%)     6580.50 (  -1.29%)
> Amean     fault-both-12    10280.59 (   0.00%)     9527.40 (   7.33%)
> Amean     fault-both-18    11079.19 (   0.00%)    13395.86 * -20.91%*
> Amean     fault-both-24    17207.80 (   0.00%)    14936.94 *  13.20%*
> Amean     fault-both-30    17736.13 (   0.00%)    16748.46 (   5.57%)
> Amean     fault-both-32    18509.41 (   0.00%)    18521.30 (  -0.06%)
> 
>                                    4.20.0                 4.20.0
>                            norescan-v2r15    finishcontend-v2r15
> Percentage huge-1         0.00 (   0.00%)        0.00 (   0.00%)
> Percentage huge-3        96.87 (   0.00%)       97.57 (   0.72%)
> Percentage huge-5        94.63 (   0.00%)       96.88 (   2.39%)
> Percentage huge-7        93.83 (   0.00%)       95.47 (   1.74%)
> Percentage huge-12       92.65 (   0.00%)       98.64 (   6.47%)
> Percentage huge-18       93.66 (   0.00%)       98.33 (   4.98%)
> Percentage huge-24       93.15 (   0.00%)       98.88 (   6.15%)
> Percentage huge-30       93.16 (   0.00%)       97.09 (   4.21%)
> Percentage huge-32       92.58 (   0.00%)       96.20 (   3.92%)
> 
> As expected, a variable impact on latency while allocation success
> rates are slightly higher. System CPU usage is reduced by about 10%
> but scan rate impact is mixed
> 
> Compaction migrate scanned    31772603    19980216
> Compaction free scanned       63267928   120381828
> 
> Migration scan rates are reduced 37% which is expected as a pageblock
> is used by the async scanner instead of skipped but the free scanning is
> increased. This can be partially accounted for by the increased success
> rate but also by the fact that the scanners do not meet for longer when
> pageblocks are actually used. Overall this is justified and completing
> a pageblock scan is very important for later patches.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some comments below.

> @@ -538,18 +535,8 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  		 * recheck as well.
>  		 */
>  		if (!locked) {
> -			/*
> -			 * The zone lock must be held to isolate freepages.
> -			 * Unfortunately this is a very coarse lock and can be
> -			 * heavily contended if there are parallel allocations
> -			 * or parallel compactions. For async compaction do not
> -			 * spin on the lock and we acquire the lock as late as
> -			 * possible.
> -			 */
> -			locked = compact_trylock_irqsave(&cc->zone->lock,
> +			locked = compact_lock_irqsave(&cc->zone->lock,
>  								&flags, cc);
> -			if (!locked)
> -				break;

Seems a bit dangerous to continue compact_lock_irqsave() to return bool that
however now always returns true, and remove the safety checks that test the
result. Easy for somebody in the future to reintroduce some 'return false'
condition (even though the name now says lock and not trylock) and start
crashing. I would either change it to return void, or leave the checks in place.

>  
>  			/* Recheck this is a buddy page under lock */
>  			if (!PageBuddy(page))
> @@ -910,15 +897,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  		/* If we already hold the lock, we can skip some rechecking */
>  		if (!locked) {
> -			locked = compact_trylock_irqsave(zone_lru_lock(zone),
> +			locked = compact_lock_irqsave(zone_lru_lock(zone),
>  								&flags, cc);
>  
> -			/* Allow future scanning if the lock is contended */
> -			if (!locked) {
> -				clear_pageblock_skip(page);
> -				break;
> -			}

Ditto.

> -
>  			/* Try get exclusive access under lock */
>  			if (!skip_updated) {
>  				skip_updated = true;
> @@ -961,9 +942,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  		/*
>  		 * Avoid isolating too much unless this block is being
> -		 * rescanned (e.g. dirty/writeback pages, parallel allocation).
> +		 * rescanned (e.g. dirty/writeback pages, parallel allocation)
> +		 * or a lock is contended. For contention, isolate quickly to
> +		 * potentially remove one source of contention.
>  		 */
> -		if (cc->nr_migratepages == COMPACT_CLUSTER_MAX && !cc->rescan) {
> +		if (cc->nr_migratepages == COMPACT_CLUSTER_MAX &&
> +		    !cc->rescan && !cc->contended) {
>  			++low_pfn;
>  			break;
>  		}
> @@ -1411,12 +1395,8 @@ static void isolate_freepages(struct compact_control *cc)
>  		isolate_freepages_block(cc, &isolate_start_pfn, block_end_pfn,
>  					freelist, false);
>  
> -		/*
> -		 * If we isolated enough freepages, or aborted due to lock
> -		 * contention, terminate.
> -		 */
> -		if ((cc->nr_freepages >= cc->nr_migratepages)
> -							|| cc->contended) {

Does it really make sense to continue in the case of free scanner, when we know
we will just return back the extra pages in the end? release_freepages() will
update the cached pfns, but the pageblock skip bit will stay, so we just leave
those pages behind. Unless finishing the block is important for the later
patches (as changelog mentions) even in the case of free scanner, but then we
can just skip the rest of it, as truly scanning it can't really help anything?

> +		/* Are enough freepages isolated? */
> +		if (cc->nr_freepages >= cc->nr_migratepages) {
>  			if (isolate_start_pfn >= block_end_pfn) {
>  				/*
>  				 * Restart at previous pageblock if more
