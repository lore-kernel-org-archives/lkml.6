Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBZVxQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:53:16 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36336 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBZVxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:53:13 -0500
X-Google-Smtp-Source: AG47ELtEt/v3EyuhbIEKzn/c6A1ORgdfrYuAAH39Rm1YdlTjDdQ8ngIxwh6V9f+bdbJjUSJ+xKNLwg==
Date: Mon, 26 Feb 2018 13:53:10 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Aaron Lu <aaron.lu@intel.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
In-Reply-To: <20180226135346.7208-3-aaron.lu@intel.com>
Message-ID: <alpine.DEB.2.20.1802261352160.135844@chino.kir.corp.google.com>
References: <20180226135346.7208-1-aaron.lu@intel.com> <20180226135346.7208-3-aaron.lu@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Aaron Lu wrote:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3154859cccd6..35576da0a6c9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1116,13 +1116,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int migratetype = 0;
>  	int batch_free = 0;
>  	bool isolated_pageblocks;
> +	struct page *page, *tmp;
> +	LIST_HEAD(head);
>  
>  	pcp->count -= count;
> -	spin_lock(&zone->lock);
> -	isolated_pageblocks = has_isolate_pageblock(zone);
> -
>  	while (count) {
> -		struct page *page;
>  		struct list_head *list;
>  
>  		/*
> @@ -1144,26 +1142,31 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			batch_free = count;
>  
>  		do {
> -			int mt;	/* migratetype of the to-be-freed page */
> -
>  			page = list_last_entry(list, struct page, lru);
>  			/* must delete as __free_one_page list manipulates */

Looks good in general, but I'm not sure how I reconcile this comment with 
the new implementation that later links page->lru again.

>  			list_del(&page->lru);
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
