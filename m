Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422914AbeCBI06 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:26:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:19901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422857AbeCBI05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:26:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="30902997"
Date: Fri, 2 Mar 2018 16:27:56 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
Message-ID: <20180302082756.GC6356@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301160950.b561d6b8b561217bad511229@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301160950.b561d6b8b561217bad511229@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:09:50PM -0800, Andrew Morton wrote:
> On Thu,  1 Mar 2018 14:28:45 +0800 Aaron Lu <aaron.lu@intel.com> wrote:
> 
> > When a page is freed back to the global pool, its buddy will be checked
> > to see if it's possible to do a merge. This requires accessing buddy's
> > page structure and that access could take a long time if it's cache cold.
> > 
> > This patch adds a prefetch to the to-be-freed page's buddy outside of
> > zone->lock in hope of accessing buddy's page structure later under
> > zone->lock will be faster. Since we *always* do buddy merging and check
> > an order-0 page's buddy to try to merge it when it goes into the main
> > allocator, the cacheline will always come in, i.e. the prefetched data
> > will never be unused.
> > 
> > In the meantime, there are two concerns:
> > 1 the prefetch could potentially evict existing cachelines, especially
> >   for L1D cache since it is not huge;
> > 2 there is some additional instruction overhead, namely calculating
> >   buddy pfn twice.
> > 
> > For 1, it's hard to say, this microbenchmark though shows good result but
> > the actual benefit of this patch will be workload/CPU dependant;
> > For 2, since the calculation is a XOR on two local variables, it's expected
> > in many cases that cycles spent will be offset by reduced memory latency
> > later. This is especially true for NUMA machines where multiple CPUs are
> > contending on zone->lock and the most time consuming part under zone->lock
> > is the wait of 'struct page' cacheline of the to-be-freed pages and their
> > buddies.
> > 
> > Test with will-it-scale/page_fault1 full load:
> > 
> > kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
> > v4.16-rc2+  9034215        7971818       13667135       15677465
> > patch2/3    9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
> > this patch 10338868 +8.4%  8544477 +2.8% 14839808 +5.5% 17155464 +2.9%
> > Note: this patch's performance improvement percent is against patch2/3.
> > 
> > ...
> >
> > @@ -1150,6 +1153,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  				continue;
> >  
> >  			list_add_tail(&page->lru, &head);
> > +
> > +			/*
> > +			 * We are going to put the page back to the global
> > +			 * pool, prefetch its buddy to speed up later access
> > +			 * under zone->lock. It is believed the overhead of
> > +			 * calculating buddy_pfn here can be offset by reduced
> > +			 * memory latency later.
> > +			 */
> > +			pfn = page_to_pfn(page);
> > +			buddy_pfn = __find_buddy_pfn(pfn, 0);
> > +			buddy = page + (buddy_pfn - pfn);
> > +			prefetch(buddy);
> 
> What is the typical list length here?  Maybe it's approximately the pcp
> batch size which is typically 128 pages?

Most of time it is pcp->batch, unless when pcp's pages need to be
all drained like in drain_local_pages(zone).

The pcp->batch has a default value of 31 and its upper limit is 96 for
x86_64. For this test, it is 31 here, I didn't manipulate
/proc/sys/vm/percpu_pagelist_fraction to change it.

With this said, the count here could be pcp->count when pcp's pages
need to be all drained and though pcp->count's default value is
(6*pcp->batch)=186, user can increase that value through the above
mentioned procfs interface and the resulting pcp->count could be too
big for prefetch. Ying also mentioned this today and suggested adding
an upper limit here to avoid prefetching too much. Perhaps just prefetch
the last pcp->batch pages if count here > pcp->batch? Since pcp->batch
has an upper limit, we won't need to worry prefetching too much.

> 
> If so, I'm a bit surprised that it is effective to prefetch 128 page
> frames before using any them for real.  I guess they'll fit in the L2
> cache.   Thoughts?
