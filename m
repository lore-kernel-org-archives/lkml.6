Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788812075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788812075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbeGROPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:15:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:38550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731249AbeGROPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:15:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA26BAD86;
        Wed, 18 Jul 2018 13:37:17 +0000 (UTC)
Date:   Wed, 18 Jul 2018 15:37:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/3] mm/page_alloc: Move ifdefery out of
 free_area_init_core
Message-ID: <20180718133717.GE7193@dhcp22.suse.cz>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-2-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718124722.9872-2-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-07-18 14:47:20, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Moving the #ifdefs out of the function makes it easier to follow.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

OK, this makes some sense.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e357189cd24a..8a73305f7c55 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6206,6 +6206,37 @@ static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
>  	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
>  }
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +static void pgdat_init_numabalancing(struct pglist_data *pgdat)
> +{
> +	spin_lock_init(&pgdat->numabalancing_migrate_lock);
> +	pgdat->numabalancing_migrate_nr_pages = 0;
> +	pgdat->numabalancing_migrate_next_window = jiffies;
> +}
> +#else
> +static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
> +#endif
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void pgdat_init_split_queue(struct pglist_data *pgdat)
> +{
> +	spin_lock_init(&pgdat->split_queue_lock);
> +	INIT_LIST_HEAD(&pgdat->split_queue);
> +	pgdat->split_queue_len = 0;
> +}
> +#else
> +static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
> +#endif
> +
> +#ifdef CONFIG_COMPACTION
> +static void pgdat_init_kcompactd(struct pglist_data *pgdat)
> +{
> +	init_waitqueue_head(&pgdat->kcompactd_wait);
> +}
> +#else
> +static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
> +#endif
> +
>  /*
>   * Set up the zone data structures:
>   *   - mark all pages reserved
> @@ -6220,21 +6251,14 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
>  	int nid = pgdat->node_id;
>  
>  	pgdat_resize_init(pgdat);
> -#ifdef CONFIG_NUMA_BALANCING
> -	spin_lock_init(&pgdat->numabalancing_migrate_lock);
> -	pgdat->numabalancing_migrate_nr_pages = 0;
> -	pgdat->numabalancing_migrate_next_window = jiffies;
> -#endif
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	spin_lock_init(&pgdat->split_queue_lock);
> -	INIT_LIST_HEAD(&pgdat->split_queue);
> -	pgdat->split_queue_len = 0;
> -#endif
> +
> +	pgdat_init_numabalancing(pgdat);
> +	pgdat_init_split_queue(pgdat);
> +	pgdat_init_kcompactd(pgdat);
> +
>  	init_waitqueue_head(&pgdat->kswapd_wait);
>  	init_waitqueue_head(&pgdat->pfmemalloc_wait);
> -#ifdef CONFIG_COMPACTION
> -	init_waitqueue_head(&pgdat->kcompactd_wait);
> -#endif
> +
>  	pgdat_page_ext_init(pgdat);
>  	spin_lock_init(&pgdat->lru_lock);
>  	lruvec_init(node_lruvec(pgdat));
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
