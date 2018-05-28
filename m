Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeE1Itp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:49:45 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:59167 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754022AbeE1Itn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:49:43 -0400
Date: Mon, 28 May 2018 09:49:40 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: do not break __GFP_THISNODE by zonelist
 reset
Message-ID: <20180528084940.avqh7unxdghvx7ow@techsingularity.net>
References: <20180525130853.13915-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180525130853.13915-1-vbabka@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:08:53PM +0200, Vlastimil Babka wrote:
> In __alloc_pages_slowpath() we reset zonelist and preferred_zoneref for
> allocations that can ignore memory policies. The zonelist is obtained from
> current CPU's node. This is a problem for __GFP_THISNODE allocations that want
> to allocate on a different node, e.g. because the allocating thread has been
> migrated to a different CPU.
> 
> This has been observed to break SLAB in our 4.4-based kernel, because there it
> relies on __GFP_THISNODE working as intended. If a slab page is put on wrong
> node's list, then further list manipulations may corrupt the list because
> page_to_nid() is used to determine which node's list_lock should be locked and
> thus we may take a wrong lock and race.
> 
> Current SLAB implementation seems to be immune by luck thanks to commit
> 511e3a058812 ("mm/slab: make cache_grow() handle the page allocated on
> arbitrary node") but there may be others assuming that __GFP_THISNODE works as
> promised.
> 
> We can fix it by simply removing the zonelist reset completely. There is
> actually no reason to reset it, because memory policies and cpusets don't
> affect the zonelist choice in the first place. This was different when commit
> 183f6371aac2 ("mm: ignore mempolicies when using ALLOC_NO_WATERMARK")
> introduced the code, as mempolicies provided their own restricted zonelists.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: 183f6371aac2 ("mm: ignore mempolicies when using ALLOC_NO_WATERMARK")

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks.

-- 
Mel Gorman
SUSE Labs
