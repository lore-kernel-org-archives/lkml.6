Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C48C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C692087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfAaWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:14:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAaWOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:14:54 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75F3EE48;
        Thu, 31 Jan 2019 22:14:52 +0000 (UTC)
Date:   Thu, 31 Jan 2019 14:14:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm: Maintain randomization of page free lists
Message-Id: <20190131141451.f60cdc434f97a31e3136ade4@linux-foundation.org>
In-Reply-To: <154882454628.1338686.46582179767934746.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154882454628.1338686.46582179767934746.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 21:02:26 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

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
> 
> ...
>
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

A static inline would be nicer.

> +#endif
> +
>  /* Used for pages which are on another list */
>  static inline void move_to_free_area(struct page *page, struct free_area *area,
>  			     int migratetype)
> 
> ...
>
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

Well that's nice and simple.
