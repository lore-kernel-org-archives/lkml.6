Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425116AbeBOPtE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:49:04 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:46602 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424663AbeBOPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:49:02 -0500
Date: Thu, 15 Feb 2018 09:49:00 -0600 (CST)
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
In-Reply-To: <20180215151129.GB12360@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz>
 <20180215151129.GB12360@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfN5zxHWeIZ3rt2BEhgKJYILLFPJrDJ5/PssKICgWc1bjkd/DTDalksV7uoK9oo7vmblZaLejzMwL34BWQ3nPaDgSxBL51K7sFJjb7cyf1vqqzbholJuD
 0IXMfkoFaiNWzkrycHVFiQAODTIxzsiKqEanbn4XCu7BIbmBEgEEjxvjxcdIrGmHR0zWPGI7+/GC1KwvNNZCnBH7Ej/Ao+TMw7yfGlZU51PD4ewutYpEpDQl
 ZuGf5LGyzTGLcMLw+9+thJpB/REdsLHD8ma1yD4yVb0wis0RfohhUdlsRBvj8GELVBz2xzus/OyrO1qj9IEsuwKUsBnaSkXkq0qMcjyoQsjFFfxJHyJMCi9m
 aFEw8c9xXU0IYO0M2uWufXnL1zk2I7MhpGps+sEHRXLriqWCQZAOlrJoFS24yVCRIcmersxs8zpGdC8iW2/hoXrPtODR4g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Matthew Wilcox wrote:

> What if ... on startup, slab allocated a MAX_ORDER page for itself.
> It would then satisfy its own page allocation requests from this giant
> page.  If we start to run low on memory in the rest of the system, slab
> can be induced to return some of it via its shrinker.  If slab runs low
> on memory, it tries to allocate another MAX_ORDER page for itself.

The inducing of releasing memory back is not there but you can run SLUB
with MAX_ORDER allocations by passing "slab_min_order=9" or so on bootup.

> I think even this should reduce fragmentation.  We could enhance the
> fragmentation reduction by noticing when somebody else releases a page
> that was previously part of a slab MAX_ORDER page and handing that page
> back to slab.  When slab notices that it has an entire MAX_ORDER page free
> (and sufficient other memory on hand that it's unlikely to need it soon),
> it can hand that MAX_ORDER page back to the page allocator.

SLUB will release MAX_ORDER pages if they are completely free with the
above configuration.
