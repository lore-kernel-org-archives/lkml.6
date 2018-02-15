Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161902AbeBOUrn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:47:43 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34316 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161064AbeBOUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:47:40 -0500
X-Google-Smtp-Source: AH8x226xh9vWeskfpPn0QH2yxmUjvIvfTsRffqcC37pe8jOR6ibhYRYVHzADKZLm/63UP13sofmnAA==
Date: Thu, 15 Feb 2018 12:47:37 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180215144525.GG7275@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.10.1802151239470.217103@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Michal Hocko wrote:

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
> 

It's a hard balance to achieve between a fast page allocator with per-cpu 
pagesets, reducing fragmentation of unmovable memory, and the performance 
impact of any fix to reduce that fragmentation for users currently 
unaffected.  Our patches to kick kcompactd for MIGRATE_UNMOVABLE 
pageblocks on fallback would be a waste unless you have a ton of anonymous 
memory you want backed by thp.

If hugepages is the main motivation for reducing the fragmentation, 
hugetlbfs could be suggested because it would give us more runtime control 
and we could leave surplus pages sitting in the free pool unless reclaimed 
under memory pressure.  That works fine in dedicated environments where we 
know how much hugetlb to reserve; if we give it back under memory pressure 
it becomes hard to reallocate the high number of hugepages we want (>95% 
of system memory).  It's much more sloppy in shared environments where the 
amount of hugepages are unknown.

And of course this doesn't address when a pin prevents memory from being 
migrated during memory compaction that is __GFP_MOVABLE at allocation but 
later pinned in place, which can still be a problem with ZONE_MOVABLE.  It 
would nice to have a solution where this memory can be annotated to want 
to come from a non-MIGRATE_MOVABLE pageblock, if possible.
