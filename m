Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeD2HFA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 03:05:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbeD2HE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 03:04:59 -0400
X-Google-Smtp-Source: AB8JxZqDrgr4QXNE2WnAfpl0RVf+iB5nCaxZzKNZ6VBATJwfvw94LB3rHPLs0wre4FE7E2XNFSQvSw==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/2] drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge
 pages
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180426150618.13470-2-michel@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9ae5f860-e893-40ed-febd-986bda5ba3ef@gmail.com>
Date: Sun, 29 Apr 2018 09:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426150618.13470-2-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.2018 um 17:06 schrieb Michel Dänzer:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> GFP_TRANSHUGE tries very hard to allocate huge pages, which can result
> in long delays with high memory pressure. I have observed firefox
> freezing for up to around a minute due to this while restic was taking
> a full system backup.
>
> Since we don't really need huge pages, use GFP_TRANSHUGE_LIGHT |
> __GFP_NORETRY instead, in order to fail quickly when there are no huge
> pages available.

Yeah, that goes into the direction Felix already suggested as well.

> Set __GFP_KSWAPD_RECLAIM as well, in order for huge pages to be freed
> up in the background if necessary.

And that is even better, thanks.

>
> With these changes, I'm no longer seeing freezes during a restic backup.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_page_alloc.c     | 11 ++++++++---
>   drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  3 ++-
>   2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index 2ce91272b111..6794f15461d9 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -914,7 +914,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
>   			while (npages >= HPAGE_PMD_NR) {
>   				gfp_t huge_flags = gfp_flags;
>   
> -				huge_flags |= GFP_TRANSHUGE;
> +				huge_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
> +					__GFP_KSWAPD_RECLAIM;
>   				huge_flags &= ~__GFP_MOVABLE;
>   				huge_flags &= ~__GFP_COMP;
>   				p = alloc_pages(huge_flags, HPAGE_PMD_ORDER);
> @@ -1033,11 +1034,15 @@ int ttm_page_alloc_init(struct ttm_mem_global *glob, unsigned max_pages)
>   				  GFP_USER | GFP_DMA32, "uc dma", 0);
>   
>   	ttm_page_pool_init_locked(&_manager->wc_pool_huge,
> -				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP),
> +				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
> +				   __GFP_KSWAPD_RECLAIM) &
> +				  ~(__GFP_MOVABLE | __GFP_COMP),
>   				  "wc huge", order);
>   
>   	ttm_page_pool_init_locked(&_manager->uc_pool_huge,
> -				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP)
> +				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
> +				   __GFP_KSWAPD_RECLAIM) &
> +				  ~(__GFP_MOVABLE | __GFP_COMP)
>   				  , "uc huge", order);
>   
>   	_manager->options.max_size = max_pages;
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> index 291b04213ec5..5a551158c289 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -910,7 +910,8 @@ static gfp_t ttm_dma_pool_gfp_flags(struct ttm_dma_tt *ttm_dma, bool huge)
>   		gfp_flags |= __GFP_ZERO;
>   
>   	if (huge) {
> -		gfp_flags |= GFP_TRANSHUGE;
> +		gfp_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
> +			__GFP_KSWAPD_RECLAIM;
>   		gfp_flags &= ~__GFP_MOVABLE;
>   		gfp_flags &= ~__GFP_COMP;
>   	}
