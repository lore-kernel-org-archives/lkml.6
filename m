Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033495AbeBOOp3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:45:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:48042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033423AbeBOOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:45:27 -0500
Date: Thu, 15 Feb 2018 15:45:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-ID: <20180215144525.GG7275@dhcp22.suse.cz>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <20180214095911.GB28460@dhcp22.suse.cz>
 <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-02-18 02:28:38, David Rientjes wrote:
> On Wed, 14 Feb 2018, Michal Hocko wrote:
> 
> > I do not have any objections regarding the extension. What I am more
> > interested in is _why_ people are still using this command line
> > parameter at all these days. Why would anybody want to introduce lowmem
> > issues from 32b days. I can see the CMA/Hotplug usecases for
> > ZONE_MOVABLE but those have their own ways to define zone movable. I was
> > tempted to simply remove the kernelcore already. Could you be more
> > specific what is your usecase which triggered a need of an easier
> > scaling of the size?
> 
> Fragmentation of non-__GFP_MOVABLE pages due to low on memory situations 
> can pollute most pageblocks on the system, as much as 1GB of slab being 
> fragmented over 128GB of memory, for example.

OK, I was assuming something like that.

> When the amount of kernel 
> memory is well bounded for certain systems, it is better to aggressively 
> reclaim from existing MIGRATE_UNMOVABLE pageblocks rather than eagerly 
> fallback to others.
> 
> We have additional patches that help with this fragmentation if you're 
> interested, specifically kcompactd compaction of MIGRATE_UNMOVABLE 
> pageblocks triggered by fallback of non-__GFP_MOVABLE allocations and 
> draining of pcp lists back to the zone free area to prevent stranding.

Yes, I think we need a proper fix. (Ab)using zone_movable for this
usecase is just sad.

-- 
Michal Hocko
SUSE Labs
