Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeBNK2n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:28:43 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33361 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeBNK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:28:41 -0500
X-Google-Smtp-Source: AH8x227AhjOKN949VLdEIXpiDM8no3skOz+yEru1s9vxEWhDgXmRND4TxOvrb46thOu8vUpsiEZ8gQ==
Date: Wed, 14 Feb 2018 02:28:38 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180214095911.GB28460@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Michal Hocko wrote:

> I do not have any objections regarding the extension. What I am more
> interested in is _why_ people are still using this command line
> parameter at all these days. Why would anybody want to introduce lowmem
> issues from 32b days. I can see the CMA/Hotplug usecases for
> ZONE_MOVABLE but those have their own ways to define zone movable. I was
> tempted to simply remove the kernelcore already. Could you be more
> specific what is your usecase which triggered a need of an easier
> scaling of the size?

Fragmentation of non-__GFP_MOVABLE pages due to low on memory situations 
can pollute most pageblocks on the system, as much as 1GB of slab being 
fragmented over 128GB of memory, for example.  When the amount of kernel 
memory is well bounded for certain systems, it is better to aggressively 
reclaim from existing MIGRATE_UNMOVABLE pageblocks rather than eagerly 
fallback to others.

We have additional patches that help with this fragmentation if you're 
interested, specifically kcompactd compaction of MIGRATE_UNMOVABLE 
pageblocks triggered by fallback of non-__GFP_MOVABLE allocations and 
draining of pcp lists back to the zone free area to prevent stranding.
