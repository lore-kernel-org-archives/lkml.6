Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF00C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9162D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9162D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405811AbeKWCSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:18:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:48852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731999AbeKWCSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:18:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26E27B06C;
        Thu, 22 Nov 2018 15:38:51 +0000 (UTC)
Subject: Re: [PATCH 3/4] mm: Reclaim small amounts of memory when an external
 fragmentation event occurs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181121101414.21301-1-mgorman@techsingularity.net>
 <20181121101414.21301-4-mgorman@techsingularity.net>
 <cc8ec820-1526-d753-4619-dedaa227a179@suse.cz>
 <20181122150446.GK23260@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <c65bf59a-1134-0fc8-5718-dbd6752fa851@suse.cz>
Date:   Thu, 22 Nov 2018 16:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122150446.GK23260@techsingularity.net>
Content-Type:   text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 4:04 PM, Mel Gorman wrote:
> On Thu, Nov 22, 2018 at 02:53:08PM +0100, Vlastimil Babka wrote:
>>
>> So the reason I was wondering about movable vs unmovable fallbacks here
>> is that movable fallbacks are ok as they can be migrated later, but the
>> unmovable/reclaimable not, which is bad if they fallback to movable
>> pageblock. Movable fallbacks can however fill the unmovable pageblocks
>> and increase change of the unmovable fallback, but that would depend on
>> the workload. So hypothetically if the test workload was such that
>> movable fallbacks did not cause unmovable fallbacks, and a patch would
>> thus only decrease the movable fallbacks (at the cost of e.g. higher
>> reclaim, as this patch) with unmovable fallbacks unchanged, then it
>> would be useful to know that for better evaluation of the pros vs cons,
>> imho.
>>
> 
> I can give the breakdown in the next changelog as it'll be similar for
> each instance of the workload.
> 
> Movable fallbacks are ok in that they can fallback but not ok in that
> they can fill an unmovable/reclaimable pageblock causing them to
> fallback later. I think you understand this already.

Yes.

> If there is a
> movable pageblock, it is pretty much guaranteed to affect an
> unmovable/reclaimable pageblock and while it might not be enough to
> actually cause a unmovable/reclaimable fallback in the future, we cannot
> know that in advance so the patch takes the only option available to it.
> 
> In terms of reclaim, what I've observed for a few workloads is that
> reclaim is different but not necessarily worse. With the patch, reclaim
> is roughly similar overall but at a smoother rate. The vanilla kernel
> tends to spike with large amounts of reclaim at semi-regular intervals
> where as this path has a small amount of reclaim done steadily over
> time.
> 
> Now I did encounter a bug whereby fio reduced throughput because the
> boosted reclaim also reclaimed slab which caused secondary issues that
> were unrelated to the fragmentation pattern. This will be fixed in the
> next version.
> 
> While it does leave open the possibilty that a slab-intensive workload
> occupying lots of memory will still cause fragmentation, that is a
> different class of problem and would be approached differently. That
> particular problem is not covered by this approach but it does not exclude
> it either as the full solution would have to encompass both.

OK, thanks for explaining.

>>> +	max_boost = max(pageblock_nr_pages, max_boost);
>>> +
>>> +	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
>>> +		max_boost);
>>> +}
>>> +
>>>  /*
>>>   * This function implements actual steal behaviour. If order is large enough,
>>>   * we can steal whole pageblock. If not, we first move freepages in this
>>> @@ -2160,6 +2176,14 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>>>  		goto single_page;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Boost watermarks to increase reclaim pressure to reduce the
>>> +	 * likelihood of future fallbacks. Wake kswapd now as the node
>>> +	 * may be balanced overall and kswapd will not wake naturally.
>>> +	 */
>>> +	boost_watermark(zone);
>>> +	wakeup_kswapd(zone, 0, 0, zone_idx(zone));
>>> +
>>>  	/* We are not allowed to try stealing from the whole block */
>>>  	if (!whole_block)
>>>  		goto single_page;
>>> @@ -3277,11 +3301,19 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>>>   * probably too small. It only makes sense to spread allocations to avoid
>>>   * fragmentation between the Normal and DMA32 zones.
>>>   */
>>> -static inline unsigned int alloc_flags_nofragment(struct zone *zone)
>>> +static inline unsigned int
>>> +alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>>>  {
>>>  	if (zone_idx(zone) != ZONE_NORMAL)
>>>  		return 0;
>>>  
>>> +	/*
>>> +	 * A fragmenting fallback will try waking kswapd. ALLOC_NOFRAGMENT
>>> +	 * may break that so such callers can introduce fragmentation.
>>> +	 */
>>
>> I think I don't understand this comment :( Do you want to avoid waking
>> up kswapd from steal_suitable_fallback() (introduced above) for
>> allocations without __GFP_KSWAPD_RECLAIM? But returning 0 here means
>> actually allowing the allocation go through steal_suitable_fallback()?
>> So should it return ALLOC_NOFRAGMENT below, or was the intent different?
>>
> 
> I want to avoid waking kswapd in steal_suitable_fallback if waking
> kswapd is not allowed.

OK, but then this 'if' should return ALLOC_NOFRAGMENT, not 0?
But that will still not prevent waking kswapd for nodes where there's no
ZONE_DMA32, or any node when get_page_from_freelist() retries without
fallback.

> If the calling context does not allow it, it does
> mean that fragmentation will be allowed to occur. I'm banking on it
> being a relatively rare case but potentially it'll be problematic. The
> main source of allocation requests that I expect to hit this are THP and
> as they are already at pageblock_order, it has limited impact from a
> fragmentation perspective -- particularly as pageblock_order stealing is
> allowed even with ALLOC_NOFRAGMENT.

Yep, THP will skip the wakeup in steal_suitable_fallback() via 'goto
single_page' above it. For other users of ~__GFP_KSWAPD_RECLAIM (are
there any?) we could maybe just ignore and wakeup kswapd anyway, since
avoiding fragmentation is more important? Or if we wanted to avoid
wakeup reliably, then steal_suitable_fallback() would have to know and
check gfp_flags I'm afraid, and that doesn't seem worth the trouble.
