Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0F20858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeGSO3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:29:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSO3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:29:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 974ADACB7;
        Thu, 19 Jul 2018 13:45:47 +0000 (UTC)
Date:   Thu, 19 Jul 2018 15:45:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 4/5] mm/page_alloc: Inline function to handle
 CONFIG_DEFERRED_STRUCT_PAGE_INIT
Message-ID: <20180719134546.GD7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-5-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719132740.32743-5-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 15:27:39, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Let us move the code between CONFIG_DEFERRED_STRUCT_PAGE_INIT
> to an inline function.

... to remove an ugly ifdef in the code.

Please always mention _why_ in the changelog. I can clearly see what
you've done in the diff.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f7a6f4e13f41..d77bc2a7ec2c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6379,6 +6379,21 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
>  static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
>  #endif /* CONFIG_FLAT_NODE_MEM_MAP */
>  
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
> +{
> +	/*
> +	 * We start only with one section of pages, more pages are added as
> +	 * needed until the rest of deferred pages are initialized.
> +	 */
> +	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
> +						pgdat->node_spanned_pages);
> +	pgdat->first_deferred_pfn = ULONG_MAX;
> +}
> +#else
> +static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
> +#endif
> +
>  void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
>  		unsigned long node_start_pfn, unsigned long *zholes_size)
>  {
> @@ -6404,16 +6419,8 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
>  				  zones_size, zholes_size);
>  
>  	alloc_node_mem_map(pgdat);
> +	pgdat_set_deferred_range(pgdat);
>  
> -#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> -	/*
> -	 * We start only with one section of pages, more pages are added as
> -	 * needed until the rest of deferred pages are initialized.
> -	 */
> -	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
> -					 pgdat->node_spanned_pages);
> -	pgdat->first_deferred_pfn = ULONG_MAX;
> -#endif
>  	free_area_init_core(pgdat);
>  }
>  
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
