Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeB1I0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:26:50 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44724 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeB1I0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:26:49 -0500
X-Google-Smtp-Source: AH8x227mnYt18nFoTEjriqKEwoLMESXV9aayBuFSmY5ht0wNqDa7X+RMzV/KefChl58rTCcS5vUinA==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
To: Monk Liu <Monk.Liu@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
Date: Wed, 28 Feb 2018 09:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.02.2018 um 07:44 schrieb Monk Liu:
> under below scenario the obj->fence would refer to a wild pointer:
>
> 1,call reservation_object_reserved_shared
> 2,call reservation_object_add_shared_fence
> 3,call reservation_object_reserved_shared
> 4,call reservation_object_add_shared_fence
>
> in step 1, staged is allocated,
>
> in step 2, code path will go reservation_object_add_shared_replace()
> and obj->fence would be assigned as staged (through RCU_INIT_POINTER)
>
> in step 3, obj->staged will be freed(by simple kfree),
> which make obj->fence point to a wild pointer...


Well that explanation is still nonsense. See 
reservation_object_add_shared_fence:
>         obj->staged = NULL;

Among the first things reservation_object_add_shared_fence() does is it 
sets obj->staged to NULL.

So step 3 will not free anything and we never have a wild pointer.

Regards,
Christian.

>
> in step 4, code path will go reservation_object_add_shared_inplace()
> and inside it the @fobj (which equals to @obj->staged, set by above steps)
> is already a wild pointer
>
> should remov the kfree on staged in reservation_object_reserve_shared()
>
> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/dma-buf/reservation.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
> index 375de41..b473ccc 100644
> --- a/drivers/dma-buf/reservation.c
> +++ b/drivers/dma-buf/reservation.c
> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>   	old = reservation_object_get_list(obj);
>   
>   	if (old && old->shared_max) {
> -		if (old->shared_count < old->shared_max) {
> -			/* perform an in-place update */
> -			kfree(obj->staged);
> -			obj->staged = NULL;
> +		if (old->shared_count < old->shared_max)
>   			return 0;
> -		} else
> +		else
>   			max = old->shared_max * 2;
>   	} else
>   		max = 4;
