Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDEH56 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:57:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45745 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeDEH55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:57:57 -0400
Date: Thu, 5 Apr 2018 09:57:53 +0200
From: Michal Hocko <mhocko@kernel.org>
To: js1304@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm/thp: don't count ZONE_MOVABLE as the target for
 freepage reserving
Message-ID: <20180405075753.GZ6312@dhcp22.suse.cz>
References: <1522913236-15776-1-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522913236-15776-1-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 16:27:16, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> ZONE_MOVABLE only has movable pages so we don't need to keep enough
> freepages to avoid or deal with fragmentation. So, don't count it.
> 
> This changes min_free_kbytes and thus min_watermark greatly
> if ZONE_MOVABLE is used. It will make the user uses more memory.

OK, but why does it matter. Has anybody seen this as an issue?

> o System
> 22GB ram, fakenuma, 2 nodes. 5 zones are used.
> 
> o Before
> min_free_kbytes: 112640
> 
> zone_info (min_watermark):
> Node 0, zone      DMA
>         min      19
> Node 0, zone    DMA32
>         min      3778
> Node 0, zone   Normal
>         min      10191
> Node 0, zone  Movable
>         min      0
> Node 0, zone   Device
>         min      0
> Node 1, zone      DMA
>         min      0
> Node 1, zone    DMA32
>         min      0
> Node 1, zone   Normal
>         min      14043
> Node 1, zone  Movable
>         min      127
> Node 1, zone   Device
>         min      0
> 
> o After
> min_free_kbytes: 90112
> 
> zone_info (min_watermark):
> Node 0, zone      DMA
>         min      15
> Node 0, zone    DMA32
>         min      3022
> Node 0, zone   Normal
>         min      8152
> Node 0, zone  Movable
>         min      0
> Node 0, zone   Device
>         min      0
> Node 1, zone      DMA
>         min      0
> Node 1, zone    DMA32
>         min      0
> Node 1, zone   Normal
>         min      11234
> Node 1, zone  Movable
>         min      102
> Node 1, zone   Device
>         min      0
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/khugepaged.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5de1c6f..92dd4e6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1880,8 +1880,16 @@ static void set_recommended_min_free_kbytes(void)
>  	int nr_zones = 0;
>  	unsigned long recommended_min;
>  
> -	for_each_populated_zone(zone)
> +	for_each_populated_zone(zone) {
> +		/*
> +		 * We don't need to worry about fragmentation of
> +		 * ZONE_MOVABLE since it only has movable pages.
> +		 */
> +		if (zone_idx(zone) > gfp_zone(GFP_USER))
> +			continue;
> +
>  		nr_zones++;
> +	}
>  
>  	/* Ensure 2 pageblocks are free to assist fragmentation avoidance */
>  	recommended_min = pageblock_nr_pages * nr_zones * 2;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
