Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166350AbeBOUsW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:48:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161064AbeBOUsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:48:20 -0500
Date: Thu, 15 Feb 2018 12:48:17 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-ID: <20180215204817.GB22948@bombadil.infradead.org>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <20180214095911.GB28460@dhcp22.suse.cz>
 <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
 <20180215144525.GG7275@dhcp22.suse.cz>
 <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 09:49:00AM -0600, Christopher Lameter wrote:
> On Thu, 15 Feb 2018, Matthew Wilcox wrote:
> > What if ... on startup, slab allocated a MAX_ORDER page for itself.
> > It would then satisfy its own page allocation requests from this giant
> > page.  If we start to run low on memory in the rest of the system, slab
> > can be induced to return some of it via its shrinker.  If slab runs low
> > on memory, it tries to allocate another MAX_ORDER page for itself.
> 
> The inducing of releasing memory back is not there but you can run SLUB
> with MAX_ORDER allocations by passing "slab_min_order=9" or so on bootup.

This is subtly different from the idea that I had.  If you set
slub_min_order to 9, then slub will allocate 2MB pages for each slab,
so allocating one object from kmalloc-32 and one object from dentry will
cause 4MB to be taken from the system.

What I was proposing was an intermediate page allocator where slab would
request 2MB for its own uses all at once, then allocate pages from that to
individual slabs, so allocating a kmalloc-32 object and a dentry object
would result in 510 pages of memory still being available for any slab
that needed it.
