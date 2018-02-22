Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeBVG7r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:59:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:49595 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeBVG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:59:46 -0500
Date: Thu, 22 Feb 2018 07:59:43 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Use higher-order pages in vmalloc
Message-ID: <20180222065943.GA30681@dhcp22.suse.cz>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz>
 <20180221154214.GA4167@bombadil.infradead.org>
 <fff58819-d39d-3a8a-f314-690bcb2f95d7@intel.com>
 <20180221170129.GB27687@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221170129.GB27687@bombadil.infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-02-18 09:01:29, Matthew Wilcox wrote:
> On Wed, Feb 21, 2018 at 08:16:22AM -0800, Dave Hansen wrote:
> > On 02/21/2018 07:42 AM, Matthew Wilcox wrote:
> > > This prompted me to write a patch I've been meaning to do for a while,
> > > allocating large pages if they're available to satisfy vmalloc.  I thought
> > > it would save on touching multiple struct pages, but it turns out that
> > > the checking code we currently have in the free_pages path requires you
> > > to have initialised all of the tail pages (maybe we can make that code
> > > conditional ...)
> > 
> > What the concept here?  If we can use high-order pages for vmalloc() at
> > the moment, we *should* use them?
> 
> Right.  It helps with fragmentation if we can keep higher-order
> allocations together.

Hmm, wouldn't it help if we made vmalloc pages migrateable instead? That
would help the compaction and get us to a lower fragmentation longterm
without playing tricks in the allocation path.

> > One of the coolest things about vmalloc() is that it can do large
> > allocations without consuming large (high-order) pages, so it has very
> > few side-effects compared to doing a bunch of order-0 allocations.  This
> > patch seems to propose removing that cool thing.  Even trying the
> > high-order allocation could kick off a bunch of reclaim and compaction
> > that was not there previously.
> 
> Yes, that's one of the debatable things.  It'd be nice to have a GFP
> flag that stopped after calling get_page_from_freelist() and didn't try
> to do compaction or reclaim.

GFP_NOWAIT, you mean?

> > If you could take this an only _opportunistically_ allocate large pages,
> > it could be a more universal win.  You could try to make sure that no
> > compaction or reclaim is done for the large allocation.  Or, maybe you
> > only try it if there are *only* high-order pages in the allocator that
> > would have been broken down into order-0 *anyway*.
> > 
> > I'm not sure it's worth it, though.  I don't see a lot of folks
> > complaining about vmalloc()'s speed or TLB impact.
> 
> No, I'm not sure it's worth it either, although Konstantin's mail
> suggesting improvements in fork speed were possible by avoiding vmalloc
> reminded me that I'd been meaning to give this a try.

Maybe we should consider kvmalloc for the kernel stack?
-- 
Michal Hocko
SUSE Labs
