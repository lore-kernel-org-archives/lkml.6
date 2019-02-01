Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20105C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43F521872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549015124;
	bh=1AaDbODAYpqj8/zZQAJ3i2yCxMSdRFow9lv7iZ/9g0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pb8CcHraoSZf1p5S/39bA7I1QKgXFuOUETC2xaAt7YQAVBMbdKIXuHA3hAfN42aov
	 usZ6cJnc60Apzx+5qKaEp1qG1tASSAlfktNvqvXDuKEXgTG1OJu3r/iEVNaL2AuHBG
	 mWJTr9La+IIzBkwO5NPNTBCPxM0QcYwxKtZ4QZTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfBAJ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:58:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:55276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfBAJ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:58:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2E9FAD43;
        Fri,  1 Feb 2019 09:58:39 +0000 (UTC)
Date:   Fri, 1 Feb 2019 10:58:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com
Subject: Re: [PATCH v10 3/3] mm: Maintain randomization of page free lists
Message-ID: <20190201095838.GJ11599@dhcp22.suse.cz>
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899812788.3165233.9066631950746578517.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154899812788.3165233.9066631950746578517.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 21:15:27, Dan Williams wrote:
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
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mmzone.h |   12 ++++++++++++
>  mm/page_alloc.c        |   11 +++++++++--
>  mm/shuffle.c           |   23 +++++++++++++++++++++++
>  mm/shuffle.h           |   12 ++++++++++++
>  4 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 2274e43933ae..a3cb9a21196d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -116,6 +116,18 @@ static inline void add_to_free_area_tail(struct page *page, struct free_area *ar
>  	area->nr_free++;
>  }
>  
> +#ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
> +/* Used to preserve page allocation order entropy */
> +void add_to_free_area_random(struct page *page, struct free_area *area,
> +		int migratetype);
> +#else
> +static inline void add_to_free_area_random(struct page *page,
> +		struct free_area *area, int migratetype)
> +{
> +	add_to_free_area(page, area, migratetype);
> +}
> +#endif
> +
>  /* Used for pages which are on another list */
>  static inline void move_to_free_area(struct page *page, struct free_area *area,
>  			     int migratetype)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3fd0df403766..2a0969e3b0eb 100644
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
> index 8badf4f0a852..19bbf3e37fb6 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -168,3 +168,26 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
>  	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
>  		shuffle_zone(z);
>  }
> +
> +void add_to_free_area_random(struct page *page, struct free_area *area,
> +		int migratetype)
> +{
> +	static u64 rand;
> +	static u8 rand_bits;
> +
> +	/*
> +	 * The lack of locking is deliberate. If 2 threads race to
> +	 * update the rand state it just adds to the entropy.
> +	 */
> +	if (rand_bits == 0) {
> +		rand_bits = 64;
> +		rand = get_random_u64();
> +	}
> +
> +	if (rand & 1)
> +		add_to_free_area(page, area, migratetype);
> +	else
> +		add_to_free_area_tail(page, area, migratetype);
> +	rand_bits--;
> +	rand >>= 1;
> +}
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 644c8ee97b9e..fc1e327ae22d 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -36,6 +36,13 @@ static inline void shuffle_zone(struct zone *z)
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
> @@ -48,5 +55,10 @@ static inline void shuffle_zone(struct zone *z)
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
> 

-- 
Michal Hocko
SUSE Labs
