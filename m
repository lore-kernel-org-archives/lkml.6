Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeEFNs3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 09:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEFNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 09:48:28 -0400
Date: Sun, 6 May 2018 06:48:14 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20180506134814.GB7362@bombadil.infradead.org>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
 <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 09:32:15AM +0000, Huaisheng HS1 Ye wrote:
> This idea is great, we can replace GFP_ZONE_TABLE and GFP_ZONE_BAD with it.
> I have realized it preliminarily based on your code and tested it on a 2 sockets platform. Fortunately, we got a positive test result.

Great!

> I made some adjustments for __GFP_HIGHMEM, this flag is special than others, because the return result of gfp_zone has two possibilities, which depend on ___GFP_MOVABLE has been enabled or disabled.
> When ___GFP_MOVABLE has been enabled, ZONE_MOVABLE shall be returned. When disabled, OPT_ZONE_HIGHMEM shall be used.
> 
> #define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> #define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)

I'm not sure this is right ... Let me think about this a little.

> #define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
> #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
> #define GFP_ZONEMASK	((__force gfp_t)___GFP_ZONE_MASK | ___GFP_MOVABLE)
> 
> The present situation is that, based on this change, the bits of flags, __GFP_DMA and __GFP_HIGHMEM and __GFP_DMA32, have been encoded.
> That is totally different from existing code, you know in kernel scope, there are many drivers or subsystems use these flags directly to realize bit manipulations like this below,
> swiotlb-xen.c (drivers\xen):	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
> extent_io.c (fs\btrfs):			mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
> 
> Because of these flags have been encoded, the above operations can cause problem.
> I am trying to get a solution to resolve it. Any progress will be reported.

These users probably want:

flags &= GFP_RECLAIM_MASK;
