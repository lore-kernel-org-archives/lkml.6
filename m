Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeEHA0B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:26:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeEHA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:26:00 -0400
Date: Mon, 7 May 2018 17:25:47 -0700
From: Matthew Wilcox <willy@infradead.org>
To: dsterba@suse.cz, Huaisheng HS1 Ye <yehs1@lenovo.com>,
        Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned
 int in gfp_zone
Message-ID: <20180508002547.GA16338@bombadil.infradead.org>
References: <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
 <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506134814.GB7362@bombadil.infradead.org>
 <HK2PR03MB168447008C658172FFDA402992840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506185532.GA13604@bombadil.infradead.org>
 <HK2PR03MB1684BF10B3B515BFABD35F8B929B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180507184410.GA12361@bombadil.infradead.org>
 <20180507212500.bdphwfhk55w6vlbb@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507212500.bdphwfhk55w6vlbb@twin.jikos.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 11:25:01PM +0200, David Sterba wrote:
> On Mon, May 07, 2018 at 11:44:10AM -0700, Matthew Wilcox wrote:
> > But something like btrfs should almost certainly be using ~GFP_ZONEMASK.
> 
> Agreed, the direct use of __GFP_DMA32 was added in 3ba7ab220e8918176c6f
> to substitute GFP_NOFS, so the allocation flags are less restrictive but
> still acceptable for allocation from slab.
> 
> The requirement from btrfs is to avoid highmem, the 'must be acceptable
> for slab' requirement is more MM internal and should have been hidden
> under some opaque flag mask. There was no strong need for that at the
> time.

The GFP flags encode a multiple of different requirements.  There's
"What can the allocator do to free memory" and "what area of memory
can the allocation come from".  btrfs doesn't actually want to
allocate memory from ZONE_MOVABLE or ZONE_DMA either.  It's probably never
been called with those particular flags set, but in the spirit of
future-proofing btrfs, perhaps a patch like this is in order?

---- >8 ----

Subject: btrfs: Allocate extents from ZONE_NORMAL
From: Matthew Wilcox <mawilcox@microsoft.com>

If anyone ever passes a GFP_DMA or GFP_MOVABLE allocation flag to
allocate_extent_state, it will try to allocate memory from the wrong zone.
We just want to allocate memory from ZONE_NORMAL, so use GFP_RECLAIM_MASK
to get what we want.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e99b329002cf..4e4a67b7b29d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -216,12 +216,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 {
 	struct extent_state *state;
 
-	/*
-	 * The given mask might be not appropriate for the slab allocator,
-	 * drop the unsupported bits
-	 */
-	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
-	state = kmem_cache_alloc(extent_state_cache, mask);
+	state = kmem_cache_alloc(extent_state_cache, mask & GFP_RECLAIM_MASK);
 	if (!state)
 		return state;
 	state->state = 0;
