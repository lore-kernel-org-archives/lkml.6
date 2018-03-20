Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeCTOLI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:11:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:44189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeCTOLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:11:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="26050991"
Date: Tue, 20 Mar 2018 22:11:01 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH v2 2/4] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20180320141101.GB2033@intel.com>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-3-aaron.lu@intel.com>
 <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 12:45:50PM +0100, Vlastimil Babka wrote:
> On 03/20/2018 09:54 AM, Aaron Lu wrote:
> > Running will-it-scale/page_fault1 process mode workload on a 2 sockets
> > Intel Skylake server showed severe lock contention of zone->lock, as
> > high as about 80%(42% on allocation path and 35% on free path) CPU
> > cycles are burnt spinning. With perf, the most time consuming part inside
> > that lock on free path is cache missing on page structures, mostly on
> > the to-be-freed page's buddy due to merging.
> 
> But why, with all the prefetching in place?

The prefetch is just for its order 0 buddy, if merge happens, then its
order 1 buddy will also be checked and on and on, so the cache misses
are much more in merge mode.

> 
> > One way to avoid this overhead is not do any merging at all for order-0
> > pages. With this approach, the lock contention for zone->lock on free
> > path dropped to 1.1% but allocation side still has as high as 42% lock
> > contention. In the meantime, the dropped lock contention on free side
> > doesn't translate to performance increase, instead, it's consumed by
> > increased lock contention of the per node lru_lock(rose from 5% to 37%)
> > and the final performance slightly dropped about 1%.
> > 
> > Though performance dropped a little, it almost eliminated zone lock
> > contention on free path and it is the foundation for the next patch
> > that eliminates zone lock contention for allocation path.
> 
> Not thrilled about such disruptive change in the name of a
> microbenchmark :/ Shouldn't normally the pcplists hide the overhead?

Sadly, with the default pcp count, it didn't avoid the lock contention.
We can of course increase pcp->count to a large enough value to avoid
entering buddy and thus avoid zone->lock contention, but that would
require admin to manually change the value on a per-machine per-workload
basis I believe.

> If not, wouldn't it make more sense to turn zone->lock into a range lock?

Not familiar with range lock, will need to take a look at it, thanks for
the pointer.

> 
> > A new document file called "struct_page_filed" is added to explain
> > the newly reused field in "struct page".
> 
> Sounds rather ad-hoc for a single field, I'd rather document it via
> comments.

Dave would like to have a document to explain all those "struct page"
fields that are repurposed under different scenarios and this is the
very start of the document :-)

I probably should have explained the intent of the document more.

Thanks for taking a look at this.

> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> >  Documentation/vm/struct_page_field |  5 +++
> >  include/linux/mm_types.h           |  1 +
> >  mm/compaction.c                    | 13 +++++-
> >  mm/internal.h                      | 27 ++++++++++++
> >  mm/page_alloc.c                    | 89 +++++++++++++++++++++++++++++++++-----
> >  5 files changed, 122 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/vm/struct_page_field
> > 
