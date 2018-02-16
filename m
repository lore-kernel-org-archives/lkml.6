Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756659AbeBPPoa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:44:30 -0500
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:46454 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756467AbeBPPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:44:28 -0500
Date: Fri, 16 Feb 2018 09:44:25 -0600 (CST)
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
In-Reply-To: <20180215204817.GB22948@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802160941500.9660@nuc-kabylake>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz> <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake> <20180215204817.GB22948@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMClK1qe20MO0855Dd54Hu4F0TGxZcw71Jb05oECT9RPVW4iOlGFOOmhezR1WCr9eKe4f2CO0nux6Ni7nGBAKU9OEg09yBSf6sdLI119rouJqjCndXsp
 GqdbZkV9WRxpWSFc6wzN9zDi4r8rUkiiqXlajGbKJutL5Kodq2xjFk2Z7aE+CPYgoNJKmcNsbbNOpSvjKaZ5efo9OM6Jh3teA+ROA4gOoUW7pTqwzvURiwM5
 A1hpBKYiiKOrWo+26u18uVLcWMybHecPusrbSDiNUvWeMfr0ngpwxsZ4ZkVgCBzaSKVx2DwfKlElSmNySkPwfp30UHoKnotqLmXT+wcGUwqqi2NQj7eGIZcs
 togQtEtKkZp14MH74+/UvEUvj9mVuA3UazkMsUoY7uQAcMsmhRu10d9kLMh29vPk7ZaGszP9q3veoVYQAM/7cO2b/Hxf+A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Matthew Wilcox wrote:

> > The inducing of releasing memory back is not there but you can run SLUB
> > with MAX_ORDER allocations by passing "slab_min_order=9" or so on bootup.
>
> This is subtly different from the idea that I had.  If you set
> slub_min_order to 9, then slub will allocate 2MB pages for each slab,
> so allocating one object from kmalloc-32 and one object from dentry will
> cause 4MB to be taken from the system.

Right.

> What I was proposing was an intermediate page allocator where slab would
> request 2MB for its own uses all at once, then allocate pages from that to
> individual slabs, so allocating a kmalloc-32 object and a dentry object
> would result in 510 pages of memory still being available for any slab
> that needed it.

Well thats not really going to work since you would be mixing objects of
different sizes which may present more fragmentation problems within the
2M later if they are freed and more objects are allocated.

What we could do is add a readonly allocation mode for those objects for
which we know that are never freed. Those could be combined into 2M
blocks.

Or an allocation mode where we would free a whole bunch of objects in one
go. If we can mark those allocs then they could be satisfied from the same
block.
