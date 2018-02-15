Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033752AbeBOPLe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:11:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033510AbeBOPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:11:33 -0500
Date: Thu, 15 Feb 2018 07:11:29 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-ID: <20180215151129.GB12360@bombadil.infradead.org>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <20180214095911.GB28460@dhcp22.suse.cz>
 <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
 <20180215144525.GG7275@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215144525.GG7275@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:45:25PM +0100, Michal Hocko wrote:
> > When the amount of kernel 
> > memory is well bounded for certain systems, it is better to aggressively 
> > reclaim from existing MIGRATE_UNMOVABLE pageblocks rather than eagerly 
> > fallback to others.
> > 
> > We have additional patches that help with this fragmentation if you're 
> > interested, specifically kcompactd compaction of MIGRATE_UNMOVABLE 
> > pageblocks triggered by fallback of non-__GFP_MOVABLE allocations and 
> > draining of pcp lists back to the zone free area to prevent stranding.
> 
> Yes, I think we need a proper fix. (Ab)using zone_movable for this
> usecase is just sad.

What if ... on startup, slab allocated a MAX_ORDER page for itself.
It would then satisfy its own page allocation requests from this giant
page.  If we start to run low on memory in the rest of the system, slab
can be induced to return some of it via its shrinker.  If slab runs low
on memory, it tries to allocate another MAX_ORDER page for itself.

I think even this should reduce fragmentation.  We could enhance the
fragmentation reduction by noticing when somebody else releases a page
that was previously part of a slab MAX_ORDER page and handing that page
back to slab.  When slab notices that it has an entire MAX_ORDER page free
(and sufficient other memory on hand that it's unlikely to need it soon),
it can hand that MAX_ORDER page back to the page allocator.
