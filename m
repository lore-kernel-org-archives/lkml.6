Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758450AbeBPQBV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:01:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758469AbeBPQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:01:19 -0500
Date: Fri, 16 Feb 2018 08:01:16 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-ID: <20180216160116.GA24395@bombadil.infradead.org>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <20180214095911.GB28460@dhcp22.suse.cz>
 <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
 <20180215144525.GG7275@dhcp22.suse.cz>
 <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
 <20180215204817.GB22948@bombadil.infradead.org>
 <alpine.DEB.2.20.1802160941500.9660@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802160941500.9660@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 09:44:25AM -0600, Christopher Lameter wrote:
> On Thu, 15 Feb 2018, Matthew Wilcox wrote:
> > What I was proposing was an intermediate page allocator where slab would
> > request 2MB for its own uses all at once, then allocate pages from that to
> > individual slabs, so allocating a kmalloc-32 object and a dentry object
> > would result in 510 pages of memory still being available for any slab
> > that needed it.
> 
> Well thats not really going to work since you would be mixing objects of
> different sizes which may present more fragmentation problems within the
> 2M later if they are freed and more objects are allocated.

I don't understand this response.  I'm not suggesting mixing objects
of different sizes within the same page.  The vast majority of slabs
use order-0 pages, a few use order-1 pages and larger sizes are almost
unheard of.  I'm suggesting the slab have it's own private arena of pages
that it uses for allocating pages to slabs; when an entire page comes
free in a slab, it is returned to the arena.  When the arena is empty,
slab requests another arena from the page allocator.

If you're concerned about order-0 allocations fragmenting the arena
for order-1 slabs, then we could have separate arenas for order-0 and
order-1.  But there should be no more fragmentation caused by sticking
within an arena for page allocations than there would be by spreading
slab allocations across all memory.
