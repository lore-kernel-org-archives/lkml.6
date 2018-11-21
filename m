Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11CA214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11CA214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbeKVAxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:53:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbeKVAxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:53:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3CDCAE3E;
        Wed, 21 Nov 2018 14:18:29 +0000 (UTC)
Subject: Re: [PATCH 1/4] mm, page_alloc: Spread allocations across zones
 before introducing fragmentation
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181121101414.21301-1-mgorman@techsingularity.net>
 <20181121101414.21301-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <7c053d34-fd3f-ca10-6ad7-a9d85652626f@suse.cz>
Date:   Wed, 21 Nov 2018 15:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181121101414.21301-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:14 AM, Mel Gorman wrote:
> The page allocator zone lists are iterated based on the watermarks
> of each zone which does not take anti-fragmentation into account. On
> x86, node 0 may have multiple zones while other nodes have one zone. A
> consequence is that tasks running on node 0 may fragment ZONE_NORMAL even
> though ZONE_DMA32 has plenty of free memory. This patch special cases
> the allocator fast path such that it'll try an allocation from a lower
> local zone before fragmenting a higher zone. In this case, stealing of
> pageblocks or orders larger than a pageblock are still allowed in the
> fast path as they are uninteresting from a fragmentation point of view.
> 
> This was evaluated using a benchmark designed to fragment memory
> before attempting THPs.  It's implemented in mmtests as the following
> configurations
> 
> configs/config-global-dhp__workload_thpfioscale
> configs/config-global-dhp__workload_thpfioscale-defrag
> configs/config-global-dhp__workload_thpfioscale-madvhugepage
> 
> e.g. from mmtests
> ./run-mmtests.sh --run-monitor --config configs/config-global-dhp__workload_thpfioscale test-run-1
> 
> The broad details of the workload are as follows;
> 
> 1. Create an XFS filesystem (not specified in the configuration but done
>    as part of the testing for this patch)
> 2. Start 4 fio threads that write a number of 64K files inefficiently.
>    Inefficiently means that files are created on first access and not
>    created in advance (fio parameterr create_on_open=1) and fallocate
>    is not used (fallocate=none). With multiple IO issuers this creates
>    a mix of slab and page cache allocations over time. The total size
>    of the files is 150% physical memory so that the slabs and page cache
>    pages get mixed
> 3. Warm up a number of fio read-only threads accessing the same files
>    created in step 2. This part runs for the same length of time it
>    took to create the files. It'll fault back in old data and further
>    interleave slab and page cache allocations. As it's now low on
>    memory due to step 2, fragmentation occurs as pageblocks get
>    stolen.
> 4. While step 3 is still running, start a process that tries to allocate
>    75% of memory as huge pages with a number of threads. The number of
>    threads is based on a (NR_CPUS_SOCKET - NR_FIO_THREADS)/4 to avoid THP
>    threads contending with fio, any other threads or forcing cross-NUMA
>    scheduling. Note that the test has not been used on a machine with less
>    than 8 cores. The benchmark records whether huge pages were allocated
>    and what the fault latency was in microseconds
> 5. Measure the number of events potentially causing external fragmentation,
>    the fault latency and the huge page allocation success rate.
> 6. Cleanup
> 
> Note that due to the use of IO and page cache that this benchmark is not
> suitable for running on large machines where the time to fragment memory
> may be excessive. Also note that while this is one mix that generates
> fragmentation that it's not the only mix that generates fragmentation.
> Differences in workload that are more slab-intensive or whether SLUB is
> used with high-order pages may yield different results.
> 
> When the page allocator fragments memory, it records the event using the
> mm_page_alloc_extfrag event. If the fallback_order is smaller than a
> pageblock order (order-9 on 64-bit x86) then it's considered an event
> that may cause external fragmentation issues in the future. Hence, the
> primary metric here is the number of external fragmentation events that
> occur with order < 9. The secondary metric is allocation latency and huge
> page allocation success rates but note that differences in latencies and
> what the success rate also can affect the number of external fragmentation
> event which is why it's a secondary metric.
> 
> 1-socket Skylake machine
> config-global-dhp__workload_thpfioscale XFS (no special madvise)
> 4 fio threads, 1 THP allocating thread
> --------------------------------------
> 
> 4.20-rc1 extfrag events < order 9:  1023463
> 4.20-rc1+patch:                      358574 (65% reduction)

It would be nice to have also breakdown of what kind of extfrag events,
mainly distinguish number of unmovable/reclaimable allocations
fragmenting movable pageblocks, as those are the most critical ones.

...

> @@ -3253,6 +3268,36 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  }
>  #endif	/* CONFIG_NUMA */
>  
> +#ifdef CONFIG_ZONE_DMA32
> +/*
> + * The restriction on ZONE_DMA32 as being a suitable zone to use to avoid
> + * fragmentation is subtle. If the preferred zone was HIGHMEM then
> + * premature use of a lower zone may cause lowmem pressure problems that
> + * are wose than fragmentation. If the next zone is ZONE_DMA then it is
> + * probably too small. It only makes sense to spread allocations to avoid
> + * fragmentation between the Normal and DMA32 zones.
> + */
> +static inline unsigned int alloc_flags_nofragment(struct zone *zone)
> +{
> +	if (zone_idx(zone) != ZONE_NORMAL)
> +		return 0;
> +
> +	/*
> +	 * If ZONE_DMA32 exists, assume it is the one after ZONE_NORMAL and
> +	 * the pointer is within zone->zone_pgdat->node_zones[].
> +	 */
> +	if (!populated_zone(--zone))
> +		return 0;

How about something along:
BUILD_BUG_ON(ZONE_NORMAL - ZONE_DMA32 != 1);

Also is this perhaps going against your earlier efforts of speeding up
the fast path, and maybe it would be faster to just stick a bool into
struct zone, which would be set true once during zonelist build, only
for a ZONE_NORMAL with ZONE_DMA32 in the same node?

> +
> +	return ALLOC_NOFRAGMENT;
> +}
> +#else
> +static inline unsigned int alloc_flags_nofragment(struct zone *zone)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * get_page_from_freelist goes through the zonelist trying to allocate
>   * a page.
> @@ -3264,11 +3309,14 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  	struct zoneref *z = ac->preferred_zoneref;
>  	struct zone *zone;
>  	struct pglist_data *last_pgdat_dirty_limit = NULL;
> +	bool no_fallback;
>  
> +retry:

Ugh, I think 'z = ac->preferred_zoneref' should be moved here under
retry. AFAICS without that, the preference of local node to
fragmentation avoidance doesn't work?

>  	/*
>  	 * Scan zonelist, looking for a zone with enough free.
>  	 * See also __cpuset_node_allowed() comment in kernel/cpuset.c.
>  	 */
> +	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
>  	for_next_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
>  								ac->nodemask) {
>  		struct page *page;
> @@ -3307,6 +3355,21 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			}
>  		}
>  
> +		if (no_fallback) {
> +			int local_nid;
> +
> +			/*
> +			 * If moving to a remote node, retry but allow
> +			 * fragmenting fallbacks. Locality is more important
> +			 * than fragmentation avoidance.
> +			 */
> +			local_nid = zone_to_nid(ac->preferred_zoneref->zone);
> +			if (zone_to_nid(zone) != local_nid) {
> +				alloc_flags &= ~ALLOC_NOFRAGMENT;
> +				goto retry;
> +			}
> +		}
> +
>  		mark = zone->watermark[alloc_flags & ALLOC_WMARK_MASK];
>  		if (!zone_watermark_fast(zone, order, mark,
>  				       ac_classzone_idx(ac), alloc_flags)) {
> @@ -3374,6 +3437,15 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		}
>  	}
>  
> +	/*
> +	 * It's possible on a UMA machine to get through all zones that are
> +	 * fragmented. If avoiding fragmentation, reset and try again
> +	 */
> +	if (no_fallback) {
> +		alloc_flags &= ~ALLOC_NOFRAGMENT;
> +		goto retry;
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -4369,6 +4441,12 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  
>  	finalise_ac(gfp_mask, &ac);
>  
> +	/*
> +	 * Forbid the first pass from falling back to types that fragment
> +	 * memory until all local zones are considered.
> +	 */
> +	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone);
> +
>  	/* First allocation attempt */
>  	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
>  	if (likely(page))
> 

