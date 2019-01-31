Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E5C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983442085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbfAaNzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:55:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbfAaNzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:55:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53362ABC3;
        Thu, 31 Jan 2019 13:55:02 +0000 (UTC)
Subject: Re: [PATCH 09/22] mm, compaction: Use free lists to quickly locate a
 migration source
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-10-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
Date:   Thu, 31 Jan 2019 14:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-10-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
...

> +	for (order = cc->order - 1;
> +	     order >= PAGE_ALLOC_COSTLY_ORDER && pfn == cc->migrate_pfn && nr_scanned < limit;
> +	     order--) {
> +		struct free_area *area = &cc->zone->free_area[order];
> +		struct list_head *freelist;
> +		unsigned long flags;
> +		struct page *freepage;
> +
> +		if (!area->nr_free)
> +			continue;
> +
> +		spin_lock_irqsave(&cc->zone->lock, flags);
> +		freelist = &area->free_list[MIGRATE_MOVABLE];
> +		list_for_each_entry(freepage, freelist, lru) {
> +			unsigned long free_pfn;
> +
> +			nr_scanned++;
> +			free_pfn = page_to_pfn(freepage);
> +			if (free_pfn < high_pfn) {
> +				update_fast_start_pfn(cc, free_pfn);

Shouldn't this update go below checking pageblock skip bit? We might be
caching pageblocks that will be skipped, and also potentially going
backwards from the original cc->migrate_pfn, which could perhaps explain
the reported kcompactd loops?

> +
> +				/*
> +				 * Avoid if skipped recently. Ideally it would
> +				 * move to the tail but even safe iteration of
> +				 * the list assumes an entry is deleted, not
> +				 * reordered.
> +				 */
> +				if (get_pageblock_skip(freepage)) {
> +					if (list_is_last(freelist, &freepage->lru))
> +						break;
> +
> +					continue;
> +				}
> +
> +				/* Reorder to so a future search skips recent pages */
> +				move_freelist_tail(freelist, freepage);
> +
> +				pfn = pageblock_start_pfn(free_pfn);
> +				cc->fast_search_fail = 0;
> +				set_pageblock_skip(freepage);
> +				break;
> +			}
> +
> +			if (nr_scanned >= limit) {
> +				cc->fast_search_fail++;
> +				move_freelist_tail(freelist, freepage);
> +				break;
> +			}
> +		}
> +		spin_unlock_irqrestore(&cc->zone->lock, flags);
> +	}
> +
> +	cc->total_migrate_scanned += nr_scanned;
> +
> +	/*
> +	 * If fast scanning failed then use a cached entry for a page block
> +	 * that had free pages as the basis for starting a linear scan.
> +	 */
> +	if (pfn == cc->migrate_pfn)
> +		reinit_migrate_pfn(cc);

This will set cc->migrate_pfn to the lowest pfn encountered, yet return
pfn initialized by original cc->migrate_pfn.
AFAICS isolate_migratepages() will use the returned pfn for the linear
scan and then overwrite cc->migrate_pfn with wherever it advanced from
there. So whatever we stored here into cc->migrate_pfn will never get
actually used, except when isolate_migratepages() returns with
ISOLATED_ABORT.
So maybe the infinite kcompactd loop is linked to ISOLATED_ABORT?

> +
> +	return pfn;
> +}
> +
>  /*
>   * Isolate all pages that can be migrated from the first suitable block,
>   * starting at the block pointed to by the migrate scanner pfn within
> @@ -1222,16 +1381,25 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  	const isolate_mode_t isolate_mode =
>  		(sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
>  		(cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
> +	bool fast_find_block;
>  
>  	/*
>  	 * Start at where we last stopped, or beginning of the zone as
> -	 * initialized by compact_zone()
> +	 * initialized by compact_zone(). The first failure will use
> +	 * the lowest PFN as the starting point for linear scanning.
>  	 */
> -	low_pfn = cc->migrate_pfn;
> +	low_pfn = fast_find_migrateblock(cc);
>  	block_start_pfn = pageblock_start_pfn(low_pfn);
>  	if (block_start_pfn < zone->zone_start_pfn)
>  		block_start_pfn = zone->zone_start_pfn;
>  
> +	/*
> +	 * fast_find_migrateblock marks a pageblock skipped so to avoid
> +	 * the isolation_suitable check below, check whether the fast
> +	 * search was successful.
> +	 */
> +	fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
> +
>  	/* Only scan within a pageblock boundary */
>  	block_end_pfn = pageblock_end_pfn(low_pfn);
>  
> @@ -1240,6 +1408,7 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  	 * Do not cross the free scanner.
>  	 */
>  	for (; block_end_pfn <= cc->free_pfn;
> +			fast_find_block = false,
>  			low_pfn = block_end_pfn,
>  			block_start_pfn = block_end_pfn,
>  			block_end_pfn += pageblock_nr_pages) {
> @@ -1259,7 +1428,7 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  			continue;
>  
>  		/* If isolation recently failed, do not retry */
> -		if (!isolation_suitable(cc, page))
> +		if (!isolation_suitable(cc, page) && !fast_find_block)
>  			continue;
>  
>  		/*
> @@ -1550,6 +1719,7 @@ static enum compact_result compact_zone(struct compact_control *cc)
>  	 * want to compact the whole zone), but check that it is initialised
>  	 * by ensuring the values are within zone boundaries.
>  	 */
> +	cc->fast_start_pfn = 0;
>  	if (cc->whole_zone) {
>  		cc->migrate_pfn = start_pfn;
>  		cc->free_pfn = pageblock_start_pfn(end_pfn - 1);
> diff --git a/mm/internal.h b/mm/internal.h
> index 9b32f4cab0ae..983cb975545f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -188,9 +188,11 @@ struct compact_control {
>  	unsigned int nr_migratepages;	/* Number of pages to migrate */
>  	unsigned long free_pfn;		/* isolate_freepages search base */
>  	unsigned long migrate_pfn;	/* isolate_migratepages search base */
> +	unsigned long fast_start_pfn;	/* a pfn to start linear scan from */
>  	struct zone *zone;
>  	unsigned long total_migrate_scanned;
>  	unsigned long total_free_scanned;
> +	unsigned int fast_search_fail;	/* failures to use free list searches */
>  	const gfp_t gfp_mask;		/* gfp mask of a direct compactor */
>  	int order;			/* order a direct compactor needs */
>  	int migratetype;		/* migratetype of direct compactor */
> 

