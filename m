Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWMFn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:05:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35236 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:05:42 -0500
X-Google-Smtp-Source: AG47ELuM7gzgl56lBw4BNvud4LN1lqGuvm9rZRKUYfiKLLwwlKEb4iEgJAilJsPieyCh1UzQCVyGmA==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction
 and swapout.
To: "He, Roger" <Hongbo.He@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220125829.27060-3-christian.koenig@amd.com>
 <MWHPR1201MB0127CE75F5FD6DE84A0B93C6FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6eadbbea-8eca-a1ab-93bb-d37ae6e5f29d@gmail.com>
Date: Fri, 23 Feb 2018 13:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1201MB0127CE75F5FD6DE84A0B93C6FDCC0@MWHPR1201MB0127.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.02.2018 um 10:46 schrieb He, Roger:
>
> -----Original Message-----
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Christian K?nig
> Sent: Tuesday, February 20, 2018 8:58 PM
> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction and swapout.
>
> This solves the problem that when we swapout a BO from a domain we sometimes couldn't make room for it because holding the lock blocks all other BOs with this reservation object.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c index d90b1cf10b27..3a44c2ee4155 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -713,31 +713,30 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,  EXPORT_SYMBOL(ttm_bo_eviction_valuable);
>   
>   /**
> - * Check the target bo is allowable to be evicted or swapout, including cases:
> - *
> - * a. if share same reservation object with ctx->resv, have assumption
> - * reservation objects should already be locked, so not lock again and
> - * return true directly when either the opreation allow_reserved_eviction
> - * or the target bo already is in delayed free list;
> - *
> - * b. Otherwise, trylock it.
> + * Check if the target bo is allowed to be evicted or swapedout.
>    */
>   static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
> -			struct ttm_operation_ctx *ctx, bool *locked)
> +					   struct ttm_operation_ctx *ctx,
> +					   bool *locked)
>   {
> -	bool ret = false;
> +	/* First check if we can lock it */
> +	*locked = reservation_object_trylock(bo->resv);
> +	if (*locked)
> +		return true;
>   
> -	*locked = false;
> +	/* Check if it's locked because it is part of the current operation */
>   	if (bo->resv == ctx->resv) {
>   		reservation_object_assert_held(bo->resv);
> -		if (ctx->allow_reserved_eviction || !list_empty(&bo->ddestroy))
> -			ret = true;
> -	} else {
> -		*locked = reservation_object_trylock(bo->resv);
> -		ret = *locked;
> +		return ctx->allow_reserved_eviction ||
> +			!list_empty(&bo->ddestroy);
>   	}
>   
> -	return ret;
> +	/* Check if it's locked because it was already evicted */
> +	if (ww_mutex_is_owned_by(&bo->resv->lock, NULL))
> +		return true;
>
> For the special case: when command submission with Per-VM-BO enabled,
> All BOs  a/b/c are always valid BO. After the validation of BOs a and b,
> when validation of BO c, is it possible to return true and then evict BO a and b by mistake ?
> Because a/b/c share same task_struct.

No, that's why I check the context as well. BOs explicitly reserved have 
a non NULL context while BOs trylocked for swapout have a NULL context.

Christian.

>
> Thanks
> Roger(Hongbo.He)
>
> +	/* Some other thread is using it, don't touch it */
> +	return false;
>   }
>   
>   static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
