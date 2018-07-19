Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829EEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A34020858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A34020858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGSO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:27:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731105AbeGSO1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:27:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88C46AD5E;
        Thu, 19 Jul 2018 13:44:17 +0000 (UTC)
Date:   Thu, 19 Jul 2018 15:44:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180719134417.GC7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719132740.32743-4-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 15:27:38, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> In free_area_init_core we calculate the amount of managed pages
> we are left with, by substracting the memmap pages and the pages
> reserved for dma.
> With the values left, we also account the total of kernel pages and
> the total of pages.
> 
> Since memmap pages are calculated from zone->spanned_pages,
> let us only do these calculcations whenever zone->spanned_pages is greather
> than 0.

But why do we care? How do we test this? In other words, why is this
worth merging?

> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 73 ++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 10b754fba5fa..f7a6f4e13f41 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6237,6 +6237,40 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
>  static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
>  #endif
>  
> +static unsigned long calc_remaining_pages(enum zone_type type, unsigned long freesize,
> +								unsigned long size)
> +{
> +	unsigned long memmap_pages = calc_memmap_size(size, freesize);
> +
> +	if(!is_highmem_idx(type)) {
> +		if (freesize >= memmap_pages) {
> +			freesize -= memmap_pages;
> +			if (memmap_pages)
> +				printk(KERN_DEBUG
> +					"  %s zone: %lu pages used for memmap\n",
> +					zone_names[type], memmap_pages);
> +		} else
> +			pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
> +				zone_names[type], memmap_pages, freesize);
> +	}
> +
> +	/* Account for reserved pages */
> +	if (type == 0 && freesize > dma_reserve) {
> +		freesize -= dma_reserve;
> +		printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
> +		zone_names[0], dma_reserve);
> +	}
> +
> +	if (!is_highmem_idx(type))
> +		nr_kernel_pages += freesize;
> +	/* Charge for highmem memmap if there are enough kernel pages */
> +	else if (nr_kernel_pages > memmap_pages * 2)
> +		nr_kernel_pages -= memmap_pages;
> +	nr_all_pages += freesize;
> +
> +	return freesize;
> +}
> +
>  /*
>   * Set up the zone data structures:
>   *   - mark all pages reserved
> @@ -6267,43 +6301,12 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
>  
>  	for (j = 0; j < MAX_NR_ZONES; j++) {
>  		struct zone *zone = pgdat->node_zones + j;
> -		unsigned long size, freesize, memmap_pages;
> +		unsigned long size = zone->spanned_pages;
> +		unsigned long freesize = zone->present_pages;
>  		unsigned long zone_start_pfn = zone->zone_start_pfn;
>  
> -		size = zone->spanned_pages;
> -		freesize = zone->present_pages;
> -
> -		/*
> -		 * Adjust freesize so that it accounts for how much memory
> -		 * is used by this zone for memmap. This affects the watermark
> -		 * and per-cpu initialisations
> -		 */
> -		memmap_pages = calc_memmap_size(size, freesize);
> -		if (!is_highmem_idx(j)) {
> -			if (freesize >= memmap_pages) {
> -				freesize -= memmap_pages;
> -				if (memmap_pages)
> -					printk(KERN_DEBUG
> -					       "  %s zone: %lu pages used for memmap\n",
> -					       zone_names[j], memmap_pages);
> -			} else
> -				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
> -					zone_names[j], memmap_pages, freesize);
> -		}
> -
> -		/* Account for reserved pages */
> -		if (j == 0 && freesize > dma_reserve) {
> -			freesize -= dma_reserve;
> -			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
> -					zone_names[0], dma_reserve);
> -		}
> -
> -		if (!is_highmem_idx(j))
> -			nr_kernel_pages += freesize;
> -		/* Charge for highmem memmap if there are enough kernel pages */
> -		else if (nr_kernel_pages > memmap_pages * 2)
> -			nr_kernel_pages -= memmap_pages;
> -		nr_all_pages += freesize;
> +		if (size)
> +			freesize = calc_remaining_pages(j, freesize, size);
>  
>  		/*
>  		 * Set an approximate value for lowmem here, it will be adjusted
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
