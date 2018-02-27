Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeB0CAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:00:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:29726 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeB0CAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:00:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="178307447"
Date: Tue, 27 Feb 2018 10:00:58 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
Message-ID: <20180227020058.GB9141@intel.com>
References: <20180226135346.7208-1-aaron.lu@intel.com>
 <20180226135346.7208-3-aaron.lu@intel.com>
 <alpine.DEB.2.20.1802261352160.135844@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802261352160.135844@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:53:10PM -0800, David Rientjes wrote:
> On Mon, 26 Feb 2018, Aaron Lu wrote:
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3154859cccd6..35576da0a6c9 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1116,13 +1116,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  	int migratetype = 0;
> >  	int batch_free = 0;
> >  	bool isolated_pageblocks;
> > +	struct page *page, *tmp;
> > +	LIST_HEAD(head);
> >  
> >  	pcp->count -= count;
> > -	spin_lock(&zone->lock);
> > -	isolated_pageblocks = has_isolate_pageblock(zone);
> > -
> >  	while (count) {
> > -		struct page *page;
> >  		struct list_head *list;
> >  
> >  		/*
> > @@ -1144,26 +1142,31 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  			batch_free = count;
> >  
> >  		do {
> > -			int mt;	/* migratetype of the to-be-freed page */
> > -
> >  			page = list_last_entry(list, struct page, lru);
> >  			/* must delete as __free_one_page list manipulates */
> 
> Looks good in general, but I'm not sure how I reconcile this comment with 
> the new implementation that later links page->lru again.

Thanks for pointing this out.

I think the comment is useless now since there is a list_add_tail right
below so it's obvious we need to take the page off its original list.
I'll remove the comment in an update.

> 
> >  			list_del(&page->lru);
> >  
> > -			mt = get_pcppage_migratetype(page);
> > -			/* MIGRATE_ISOLATE page should not go to pcplists */
> > -			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> > -			/* Pageblock could have been isolated meanwhile */
> > -			if (unlikely(isolated_pageblocks))
> > -				mt = get_pageblock_migratetype(page);
> > -
> >  			if (bulkfree_pcp_prepare(page))
> >  				continue;
> >  
> > -			__free_one_page(page, page_to_pfn(page), zone, 0, mt);
> > -			trace_mm_page_pcpu_drain(page, 0, mt);
> > +			list_add_tail(&page->lru, &head);
> >  		} while (--count && --batch_free && !list_empty(list));
> >  	}
