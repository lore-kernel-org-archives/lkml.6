Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756827AbeBPApH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:45:07 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:40791 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeBPApF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:45:05 -0500
X-Google-Smtp-Source: AH8x2264x12wH9UwAwRHF4idCMeNPPKTXnmW6/rcSdo+viQIQEexytcvJbvOgzb6sSlnAc+Mpkbrog==
Date: Thu, 15 Feb 2018 16:45:02 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Matthew Wilcox <willy@infradead.org>
cc: Christopher Lameter <cl@linux.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180215204817.GB22948@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.10.1802151638510.50948@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz> <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake> <20180215204817.GB22948@bombadil.infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Matthew Wilcox wrote:

> What I was proposing was an intermediate page allocator where slab would
> request 2MB for its own uses all at once, then allocate pages from that to
> individual slabs, so allocating a kmalloc-32 object and a dentry object
> would result in 510 pages of memory still being available for any slab
> that needed it.
> 

A type of memory arena built between the page allocator and slab 
allocator.

The issue that I see with this is eventually there's going to be low on 
memory situations where memory needs to be reclaimed from these arena 
pages.  We can free individual pages back to the buddy allocator, but have 
no control over whether an entire pageblock can be freed back.  So now we 
have MIGRATE_MOVABLE or MIGRATE_UNMOVABLE pageblocks with some user pages 
and some slab pages, and we've reached the same fragmentation issue in a 
different way.  After that, it will become more difficult for the slab 
allocator to request a page of pageblock_order.

Other than the stranding issue of MIGRATE_UNMOVABLE pages on pcps, the 
page allocator currently does well in falling back to other migratetypes 
but there isn't any type of slab reclaim or defragmentation done in the 
background to try to free up as much memory from that 
now-MIGRATE_UNMOVABLE pageblock as possible.  We have patches that do 
that, but as I mentioned before it can affect the performance of the page 
allocator because it drains pcps on fallback and it does kcompactd 
compaction in the background even if you don't need order-9 memory later 
(or you've defragmented needlessly when more slab is just going to be 
allocated anyway).
