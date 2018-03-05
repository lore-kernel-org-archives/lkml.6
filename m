Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeCELW2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:22:28 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40251 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933540AbeCELWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:22:24 -0500
X-Google-Smtp-Source: AG47ELuX/x9pgj+a+Rgoe2HR0ErZuytkCUJGDea6ZIDw2FbZ+U3ZF3aYHSphIeI/ARaTxTiwqeaeBw==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot
 available
To: "Liu, Monk" <Monk.Liu@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519800242-2442-1-git-send-email-Monk.Liu@amd.com>
 <fa9f8ade-000f-a9b5-0bc9-0dd3f10d9722@gmail.com>
 <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
Date: Mon, 5 Mar 2018 12:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB04494D7F15FC7D557D58488484DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.03.2018 um 08:55 schrieb Liu, Monk:
> Hi Christian
>
> You are right on that part of obj-staged is set to NULL in add_fence,
> So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?

Good question, I haven't wrote code that so I can't fully answer.

Maybe Chris or Maarten know more about that.

Christian.

>
> Thanks
> /Monk
>
> -----Original Message-----
> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
> Sent: 2018年2月28日 16:27
> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available
>
> Am 28.02.2018 um 07:44 schrieb Monk Liu:
>> under below scenario the obj->fence would refer to a wild pointer:
>>
>> 1,call reservation_object_reserved_shared
>> 2,call reservation_object_add_shared_fence
>> 3,call reservation_object_reserved_shared
>> 4,call reservation_object_add_shared_fence
>>
>> in step 1, staged is allocated,
>>
>> in step 2, code path will go reservation_object_add_shared_replace()
>> and obj->fence would be assigned as staged (through RCU_INIT_POINTER)
>>
>> in step 3, obj->staged will be freed(by simple kfree), which make
>> obj->fence point to a wild pointer...
>
> Well that explanation is still nonsense. See
> reservation_object_add_shared_fence:
>>          obj->staged = NULL;
> Among the first things reservation_object_add_shared_fence() does is it
> sets obj->staged to NULL.
>
> So step 3 will not free anything and we never have a wild pointer.
>
> Regards,
> Christian.
>
>> in step 4, code path will go reservation_object_add_shared_inplace()
>> and inside it the @fobj (which equals to @obj->staged, set by above steps)
>> is already a wild pointer
>>
>> should remov the kfree on staged in reservation_object_reserve_shared()
>>
>> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>    drivers/dma-buf/reservation.c | 7 ++-----
>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
>> index 375de41..b473ccc 100644
>> --- a/drivers/dma-buf/reservation.c
>> +++ b/drivers/dma-buf/reservation.c
>> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>>    	old = reservation_object_get_list(obj);
>>    
>>    	if (old && old->shared_max) {
>> -		if (old->shared_count < old->shared_max) {
>> -			/* perform an in-place update */
>> -			kfree(obj->staged);
>> -			obj->staged = NULL;
>> +		if (old->shared_count < old->shared_max)
>>    			return 0;
>> -		} else
>> +		else
>>    			max = old->shared_max * 2;
>>    	} else
>>    		max = 4;
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
