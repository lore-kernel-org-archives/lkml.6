Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758473AbeBPQIc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:08:32 -0500
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:58370 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753022AbeBPQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:08:31 -0500
Date: Fri, 16 Feb 2018 10:08:28 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180216160116.GA24395@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802161002260.10336@nuc-kabylake>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz> <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake> <20180215204817.GB22948@bombadil.infradead.org> <alpine.DEB.2.20.1802160941500.9660@nuc-kabylake> <20180216160116.GA24395@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfA1HohpbdGwXDNuubu8knmIZcSTwByIihj4g2ceJeD50UtW0F+Cd9HpAC+ZYsJ8BZEkJxUYU9flHK6pR0GrOBlX/tAJA3JvJspfNDDFkG1bWLyn633lD
 lXdq8xHmXnPtoaNDZ1WCoJyHT9pPxKTw93fzP5j6R/AwNw4MkCvoL3Je8XggKHe+qd5l3q0pltzGAvjvkAqN2gXT28MQbDYd3bWxlWicmbbKLQxALVRTXq5+
 PnMSxNYOxtmZmgVkjZA9kMuYoLUHu/flwXG3Yc8sav7F/NATy8V+RhfFh4hXwZRIqG7k2DGk7NPPY7B/nrT24Wnixnz7mgq/QbnSKS2pRhqgEeB7lhQAtgIS
 Y6ELE9aat8xjIIAxJfHYMEGpmSSTyJbZ7JRIk7RAKcJK8VfpfWuURpXBdk4MxF/q24OI477GrKak1ahxxGKY6/Q0xRTUgw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Matthew Wilcox wrote:

> On Fri, Feb 16, 2018 at 09:44:25AM -0600, Christopher Lameter wrote:
> > On Thu, 15 Feb 2018, Matthew Wilcox wrote:
> > > What I was proposing was an intermediate page allocator where slab would
> > > request 2MB for its own uses all at once, then allocate pages from that to
> > > individual slabs, so allocating a kmalloc-32 object and a dentry object
> > > would result in 510 pages of memory still being available for any slab
> > > that needed it.
> >
> > Well thats not really going to work since you would be mixing objects of
> > different sizes which may present more fragmentation problems within the
> > 2M later if they are freed and more objects are allocated.
>
> I don't understand this response.  I'm not suggesting mixing objects
> of different sizes within the same page.  The vast majority of slabs
> use order-0 pages, a few use order-1 pages and larger sizes are almost
> unheard of.  I'm suggesting the slab have it's own private arena of pages
> that it uses for allocating pages to slabs; when an entire page comes
> free in a slab, it is returned to the arena.  When the arena is empty,
> slab requests another arena from the page allocator.

This just shifts the fragmentation problem because the 2M page cannot be
released until all 4k or 8k pages within that 2M page are freed. How is
that different from the page allocator which cannot coalesce an 2M page
until all fragments have been released?

The kernelcore already does something similar by limiting the
general unmovable allocs to a section of memory.

> If you're concerned about order-0 allocations fragmenting the arena
> for order-1 slabs, then we could have separate arenas for order-0 and
> order-1.  But there should be no more fragmentation caused by sticking
> within an arena for page allocations than there would be by spreading
> slab allocations across all memory.

We avoid large frames at this point but they are beneficial to pack
objects tighter and also increase performance.

Maybe what we should do is raise the lowest allocation size instead and
allocate 2^x groups of pages to certain purposes?

I.e. have a base allocation size of 16k and if the alloc was a page cache
page then use the remainder for the neigboring pages.

Similar things could be done for the page allocator.

Raising the minimum allocation size may allow us to reduce the sizes
necessary to be allocated at the price of loosing some memory. On large
systems this may not matter much.
