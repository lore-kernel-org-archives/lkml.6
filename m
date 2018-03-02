Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427728AbeCBR2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:28:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424524AbeCBR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:28:12 -0500
Date: Fri, 2 Mar 2018 09:28:07 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, compaction: drain pcps for zone when kcompactd fails
Message-ID: <20180302172807.GD31400@bombadil.infradead.org>
References: <alpine.DEB.2.20.1803010340100.88270@chino.kir.corp.google.com>
 <672ebefc-483d-2932-37b5-4ffe58156f0f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672ebefc-483d-2932-37b5-4ffe58156f0f@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 01:23:34PM +0100, Vlastimil Babka wrote:
> On 03/01/2018 12:42 PM, David Rientjes wrote:
> > It's possible for buddy pages to become stranded on pcps that, if drained,
> > could be merged with other buddy pages on the zone's free area to form
> > large order pages, including up to MAX_ORDER.
> 
> BTW I wonder if we could be smarter and quicker about the drains. Let a
> pcp struct page be easily recognized as such, and store the cpu number
> in there. Migration scanner could then maintain a cpumask, and recognize
> if the only missing pages for coalescing a cc->order block are on the
> pcplists, and then do a targeted drain.
> But that only makes sense to implement if it can make a noticeable
> difference to offset the additional overhead, of course.

Perhaps we should turn this around ... rather than waiting for the
coalescer to come along, when we're about to put a page on the pcp list,
check whether its buddy is PageBuddy().  If so, send it to the buddy
allocator so it can get merged instead of putting it on the pcp list.

I can see the negatives of that; if you're in a situation where you've
got a 2^12 block free and allocate one page, that's 12 splits.  Then you
free the page and it does 12 joins.  Then you allocate again and do 12
splits ...

That seems like a relatively rare scenario; we're generally going to
have a lot of pages in motion on any workload we care about, and there's
always going to be pages on the pcp list.

It's not an alternative to David's patch; having page A and page A+1 on
the pcp list will prevent the pages from getting merged.  But it should
delay the time until his bigger hammer kicks in.
