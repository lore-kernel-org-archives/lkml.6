Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeCMDeR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:34:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:22522 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbeCMDeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:34:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="24674194"
Date: Tue, 13 Mar 2018 11:35:19 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 3/3 update] mm/free_pcppages_bulk: prefetch buddy
 while not holding lock
Message-ID: <20180313033519.GC13782@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301160950.b561d6b8b561217bad511229@linux-foundation.org>
 <20180302082756.GC6356@intel.com>
 <20180309082431.GB30868@intel.com>
 <988ce376-bdc4-0989-5133-612bfa3f7c45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988ce376-bdc4-0989-5133-612bfa3f7c45@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:32:32AM -0700, Dave Hansen wrote:
> On 03/09/2018 12:24 AM, Aaron Lu wrote:
> > +			/*
> > +			 * We are going to put the page back to the global
> > +			 * pool, prefetch its buddy to speed up later access
> > +			 * under zone->lock. It is believed the overhead of
> > +			 * an additional test and calculating buddy_pfn here
> > +			 * can be offset by reduced memory latency later. To
> > +			 * avoid excessive prefetching due to large count, only
> > +			 * prefetch buddy for the last pcp->batch nr of pages.
> > +			 */
> > +			if (count > pcp->batch)
> > +				continue;
> > +			pfn = page_to_pfn(page);
> > +			buddy_pfn = __find_buddy_pfn(pfn, 0);
> > +			buddy = page + (buddy_pfn - pfn);
> > +			prefetch(buddy);
> 
> FWIW, I think this needs to go into a helper function.  Is that possible?

I'll give it a try.

> 
> There's too much logic happening here.  Also, 'count' going from
> batch_size->0 is totally non-obvious from the patch context.  It makes
> this hunk look totally wrong by itself.
