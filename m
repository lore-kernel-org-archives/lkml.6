Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031016AbeCANzX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030826AbeCANzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:55:20 -0500
Date: Thu, 1 Mar 2018 14:55:18 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
Message-ID: <20180301135518.GJ15057@dhcp22.suse.cz>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-3-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301062845.26038-3-aaron.lu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-03-18 14:28:44, Aaron Lu wrote:
> When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
> the zone->lock is held and then pages are chosen from PCP's migratetype
> list. While there is actually no need to do this 'choose part' under
> lock since it's PCP pages, the only CPU that can touch them is us and
> irq is also disabled.
> 
> Moving this part outside could reduce lock held time and improve
> performance. Test with will-it-scale/page_fault1 full load:
> 
> kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
> v4.16-rc2+  9034215        7971818       13667135       15677465
> this patch  9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
> 
> What the test does is: starts $nr_cpu processes and each will repeatedly
> do the following for 5 minutes:
> 1 mmap 128M anonymouse space;
> 2 write access to that space;
> 3 munmap.
> The score is the aggregated iteration.

Iteration count I assume. I am still quite surprised that this would
have such a large impact.

> https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault1.c
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

The patch makes sense to me
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index faa33eac1635..dafdcdec9c1f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1116,12 +1116,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int migratetype = 0;
>  	int batch_free = 0;
>  	bool isolated_pageblocks;
> -
> -	spin_lock(&zone->lock);
> -	isolated_pageblocks = has_isolate_pageblock(zone);
> +	struct page *page, *tmp;
> +	LIST_HEAD(head);
>  
>  	while (count) {
> -		struct page *page;
>  		struct list_head *list;
>  
>  		/*
> @@ -1143,27 +1141,36 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			batch_free = count;
>  
>  		do {
> -			int mt;	/* migratetype of the to-be-freed page */
> -
>  			page = list_last_entry(list, struct page, lru);
> -			/* must delete as __free_one_page list manipulates */
> +			/* must delete to avoid corrupting pcp list */
>  			list_del(&page->lru);
>  			pcp->count--;
>  
> -			mt = get_pcppage_migratetype(page);
> -			/* MIGRATE_ISOLATE page should not go to pcplists */
> -			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> -			/* Pageblock could have been isolated meanwhile */
> -			if (unlikely(isolated_pageblocks))
> -				mt = get_pageblock_migratetype(page);
> -
>  			if (bulkfree_pcp_prepare(page))
>  				continue;
>  
> -			__free_one_page(page, page_to_pfn(page), zone, 0, mt);
> -			trace_mm_page_pcpu_drain(page, 0, mt);
> +			list_add_tail(&page->lru, &head);
>  		} while (--count && --batch_free && !list_empty(list));
>  	}
> +
> +	spin_lock(&zone->lock);
> +	isolated_pageblocks = has_isolate_pageblock(zone);
> +
> +	/*
> +	 * Use safe version since after __free_one_page(),
> +	 * page->lru.next will not point to original list.
> +	 */
> +	list_for_each_entry_safe(page, tmp, &head, lru) {
> +		int mt = get_pcppage_migratetype(page);
> +		/* MIGRATE_ISOLATE page should not go to pcplists */
> +		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> +		/* Pageblock could have been isolated meanwhile */
> +		if (unlikely(isolated_pageblocks))
> +			mt = get_pageblock_migratetype(page);
> +
> +		__free_one_page(page, page_to_pfn(page), zone, 0, mt);
> +		trace_mm_page_pcpu_drain(page, 0, mt);
> +	}
>  	spin_unlock(&zone->lock);
>  }
>  
> -- 
> 2.14.3
> 

-- 
Michal Hocko
SUSE Labs
