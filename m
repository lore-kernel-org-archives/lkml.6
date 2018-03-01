Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030979AbeCANpP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:45:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:59538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030801AbeCANpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:45:14 -0500
Date: Thu, 1 Mar 2018 14:45:12 +0100
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
Subject: Re: [PATCH v4 1/3] mm/free_pcppages_bulk: update pcp->count inside
Message-ID: <20180301134512.GI15057@dhcp22.suse.cz>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301062845.26038-2-aaron.lu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-03-18 14:28:43, Aaron Lu wrote:
> Matthew Wilcox found that all callers of free_pcppages_bulk() currently
> update pcp->count immediately after so it's natural to do it inside
> free_pcppages_bulk().
> 
> No functionality or performance change is expected from this patch.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Makes a lot of sense to me.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cb416723538f..faa33eac1635 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1148,6 +1148,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			page = list_last_entry(list, struct page, lru);
>  			/* must delete as __free_one_page list manipulates */
>  			list_del(&page->lru);
> +			pcp->count--;
>  
>  			mt = get_pcppage_migratetype(page);
>  			/* MIGRATE_ISOLATE page should not go to pcplists */
> @@ -2416,10 +2417,8 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  	local_irq_save(flags);
>  	batch = READ_ONCE(pcp->batch);
>  	to_drain = min(pcp->count, batch);
> -	if (to_drain > 0) {
> +	if (to_drain > 0)
>  		free_pcppages_bulk(zone, to_drain, pcp);
> -		pcp->count -= to_drain;
> -	}
>  	local_irq_restore(flags);
>  }
>  #endif
> @@ -2441,10 +2440,8 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  	pset = per_cpu_ptr(zone->pageset, cpu);
>  
>  	pcp = &pset->pcp;
> -	if (pcp->count) {
> +	if (pcp->count)
>  		free_pcppages_bulk(zone, pcp->count, pcp);
> -		pcp->count = 0;
> -	}
>  	local_irq_restore(flags);
>  }
>  
> @@ -2668,7 +2665,6 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	if (pcp->count >= pcp->high) {
>  		unsigned long batch = READ_ONCE(pcp->batch);
>  		free_pcppages_bulk(zone, batch, pcp);
> -		pcp->count -= batch;
>  	}
>  }
>  
> -- 
> 2.14.3
> 

-- 
Michal Hocko
SUSE Labs
