Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14249C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548875486;
	bh=dx4r0Pm/KnjoL+RmzY9fQqrqDfZMclnehif95i7E0f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jwDzoGvPAlug2Sl8D01eGKsOHgUOv4Hj7J/m8dHvN8wi1/a4lSL8ir0GkTscgooK0
	 EZtuzf+lwBx24moH2Ts1Fq6JjE9UwuDdKe5Xq3BUOjFhlEMxJpyyEWsfXZ//09eJg/
	 tTpqQyRk7NdXIacN1aPAFlDLjcKWRpjBgO8U1y1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfA3TLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:11:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbfA3TLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:11:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E8A5AD7A;
        Wed, 30 Jan 2019 19:11:23 +0000 (UTC)
Date:   Wed, 30 Jan 2019 20:11:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm: Maintain randomization of page free lists
Message-ID: <20190130191117.GH18811@dhcp22.suse.cz>
References: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154882454628.1338686.46582179767934746.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154882454628.1338686.46582179767934746.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 21:02:26, Dan Williams wrote:
> When freeing a page with an order >= shuffle_page_order randomly select
> the front or back of the list for insertion.
> 
> While the mm tries to defragment physical pages into huge pages this can
> tend to make the page allocator more predictable over time. Inject the
> front-back randomness to preserve the initial randomness established by
> shuffle_free_memory() when the kernel was booted.
> 
> The overhead of this manipulation is constrained by only being applied
> for MAX_ORDER sized pages by default.

I have asked in v7 but didn't get any response. Do we really ned per
free_area random pool? Why a global one is not sufficient?

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h  |   12 ++++++++++++
>  include/linux/shuffle.h |   12 ++++++++++++
>  mm/page_alloc.c         |   11 +++++++++--
>  mm/shuffle.c            |   16 ++++++++++++++++
>  4 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6ab8b58c6481..d42aafe23045 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -98,6 +98,10 @@ extern int page_group_by_mobility_disabled;
>  struct free_area {
>  	struct list_head	free_list[MIGRATE_TYPES];
>  	unsigned long		nr_free;
> +#ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
> +	u64			rand;
> +	u8			rand_bits;
> +#endif
>  };
>  
>  /* Used for pages not on another list */
> @@ -116,6 +120,14 @@ static inline void add_to_free_area_tail(struct page *page, struct free_area *ar
>  	area->nr_free++;
>  }
>  
> +#ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
> +/* Used to preserve page allocation order entropy */
> +void add_to_free_area_random(struct page *page, struct free_area *area,
> +		int migratetype);
> +#else
> +#define add_to_free_area_random add_to_free_area
> +#endif
> +
>  /* Used for pages which are on another list */
>  static inline void move_to_free_area(struct page *page, struct free_area *area,
>  			     int migratetype)
> diff --git a/include/linux/shuffle.h b/include/linux/shuffle.h
> index bed2d2901d13..649498442aa0 100644
> --- a/include/linux/shuffle.h
> +++ b/include/linux/shuffle.h
> @@ -29,6 +29,13 @@ static inline void shuffle_zone(struct zone *z)
>  		return;
>  	__shuffle_zone(z);
>  }
> +
> +static inline bool is_shuffle_order(int order)
> +{
> +	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> +                return false;
> +	return order >= SHUFFLE_ORDER;
> +}
>  #else
>  static inline void shuffle_free_memory(pg_data_t *pgdat)
>  {
> @@ -41,5 +48,10 @@ static inline void shuffle_zone(struct zone *z)
>  static inline void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
>  {
>  }
> +
> +static inline bool is_shuffle_order(int order)
> +{
> +	return false;
> +}
>  #endif
>  #endif /* _MM_SHUFFLE_H */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1cb9a467e451..7895f8bd1a32 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -43,6 +43,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/memremap.h>
>  #include <linux/stop_machine.h>
> +#include <linux/random.h>
>  #include <linux/sort.h>
>  #include <linux/pfn.h>
>  #include <linux/backing-dev.h>
> @@ -889,7 +890,8 @@ static inline void __free_one_page(struct page *page,
>  	 * so it's less likely to be used soon and more likely to be merged
>  	 * as a higher order page
>  	 */
> -	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)) {
> +	if ((order < MAX_ORDER-2) && pfn_valid_within(buddy_pfn)
> +			&& !is_shuffle_order(order)) {
>  		struct page *higher_page, *higher_buddy;
>  		combined_pfn = buddy_pfn & pfn;
>  		higher_page = page + (combined_pfn - pfn);
> @@ -903,7 +905,12 @@ static inline void __free_one_page(struct page *page,
>  		}
>  	}
>  
> -	add_to_free_area(page, &zone->free_area[order], migratetype);
> +	if (is_shuffle_order(order))
> +		add_to_free_area_random(page, &zone->free_area[order],
> +				migratetype);
> +	else
> +		add_to_free_area(page, &zone->free_area[order], migratetype);
> +
>  }
>  
>  /*
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index db517cdbaebe..0da7d1826c6a 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -186,3 +186,19 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
>  	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
>  		shuffle_zone(z);
>  }
> +
> +void add_to_free_area_random(struct page *page, struct free_area *area,
> +		int migratetype)
> +{
> +	if (area->rand_bits == 0) {
> +		area->rand_bits = 64;
> +		area->rand = get_random_u64();
> +	}
> +
> +	if (area->rand & 1)
> +		add_to_free_area(page, area, migratetype);
> +	else
> +		add_to_free_area_tail(page, area, migratetype);
> +	area->rand_bits--;
> +	area->rand >>= 1;
> +}
> 

-- 
Michal Hocko
SUSE Labs
