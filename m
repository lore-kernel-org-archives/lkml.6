Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033719AbeBOOz1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:55:27 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:60764 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033438AbeBOOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:55:25 -0500
Date: Thu, 15 Feb 2018 14:55:23 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/2] free_pcppages_bulk: do not hold lock when picking
 pages to free
Message-ID: <20180215145523.btoutbrskdvizkqk@techsingularity.net>
References: <20180124023050.20097-1-aaron.lu@intel.com>
 <20180124163926.c7ptagn655aeiut3@techsingularity.net>
 <20180125072144.GA27678@intel.com>
 <20180215124644.GA12360@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180215124644.GA12360@bombadil.infradead.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:46:44AM -0800, Matthew Wilcox wrote:
> On Thu, Jan 25, 2018 at 03:21:44PM +0800, Aaron Lu wrote:
> > When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
> > the zone->lock is held and then pages are chosen from PCP's migratetype
> > list. While there is actually no need to do this 'choose part' under
> > lock since it's PCP pages, the only CPU that can touch them is us and
> > irq is also disabled.
> 
> I have no objection to this patch.  If you're looking for ideas for
> future improvement though, I wonder whether using a LIST_HEAD is the
> best way to store these pages temporarily.  If you batch them into a
> pagevec and then free the entire pagevec, the CPU should be a little
> faster scanning a short array than walking a linked list.
> 
> It would also puts a hard boundary on how long zone->lock is held, as
> you'd drop it and go back for another batch after 15 pages.  That might
> be bad, of course.
> 

It's not a guaranteed win. You're trading a list traversal for increased
stack usage of 128 bytes (unless you stick a static one in the pgdat and
incur a cache miss penalty instead or a per-cpu pagevec and increase memory
consumption) and 2 spin lock acquire/releases in the common case which may
or may not be contended. It might make more sense if the PCP's themselves
where statically sized but that would limit tuning options and increase
the per-cpu footprint of the pcp structures.

Maybe I'm missing something obvious and it really would be a universal
win but right now I find it hard to imagine that it's a win.

> Another minor change I'd like to see is free_pcpages_bulk updating

> pcp->count itself; all of the callers do it currently.
> 

That should be reasonable, it's not even particularly difficult.

-- 
Mel Gorman
SUSE Labs
