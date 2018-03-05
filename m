Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeCELvL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:51:11 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44767 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeCELvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:51:10 -0500
X-Google-Smtp-Source: AG47ELtFxWI3ZAi/AGYrA/agnXKFXrtNOn+i8sPGDE2TMTDAmufa+4lAtKIGmyYbexi1gdAhRca5Mw==
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
 <f40975c4-c5df-c06c-9a6a-a96705232461@gmail.com>
 <BLUPR12MB04491D607CA17302B4E5524584DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <210b7a03-f309-8ab6-0f23-17377660e664@amd.com>
 <BLUPR12MB04495463743D454E9384C2B684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <3baa1046-79b1-7c6d-644f-9aa921733ad2@amd.com>
 <BLUPR12MB0449D174A98BC6740FDB0D4684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <67d0d2de-ae45-4e46-33fc-48d9c0a53ea1@gmail.com>
Date: Mon, 5 Mar 2018 12:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB0449D174A98BC6740FDB0D4684DA0@BLUPR12MB0449.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, not really.

It's just that reservation_object_reserve_shared() is called multiple 
times without actually adding fences.

That is a perfectly normal use case, so nothing special here.

Christian.

Am 05.03.2018 um 12:47 schrieb Liu, Monk:
> Can you give more details ? thanks
>
> /Monk
>
> -----Original Message-----
> From: Koenig, Christian
> Sent: 2018年3月5日 19:39
> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when slot available
>
> Am 05.03.2018 um 12:37 schrieb Liu, Monk:
>> But the thing confuse me is according to the design, if driver keep
>> calling reserve_shared() prior to add_fence(), and with lock held of cause, That BUG() shouldn't hit, so there are two things in face looks weired to me:
>> 1) by design in reserve_shared(), obj->staged should be already NULL,
>> so why we kfree on it
> No, that is not correct.
>
>> 2) in fact, amdgpu can hit the case that obj->staged is not NULL in
>> reserved_shared(), don't know how it lead here
> We reserved a fence slot without using it, so it is still there when
> reserve_shared() is called.
>
> Christian.
>
>>
>> Any thought ?
>>
>> /Monk
>>
>> -----Original Message-----
>> From: Koenig, Christian
>> Sent: 2018年3月5日 19:29
>> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when
>> slot available
>>
>> Am 05.03.2018 um 12:25 schrieb Liu, Monk:
>>> And by the way, I add "if (staged!=NULL) BUG();" prior to
>>> "kfree(obj->staged)" in reserve_shared() routine, and this BUG() is actually hit, The stack dump shows it is hit during the vm_bo_update() in gem_va_update()...
>> That is expected. The staged handling just makes sure that there is room available, it doesn't guarantee that it is actually used.
>>
>> E.g. we can end up reserving a fence slot, but then find that we actually don't need it.
>>
>> Christian.
>>
>>> Besides, the whole reservation logic still looks a little weired to me ... especially this staged part ...
>>>
>>> Thanks
>>>
>>> /Monk
>>>
>>> -----Original Message-----
>>> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
>>> Sent: 2018年3月5日 19:22
>>> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org;
>>> linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged when
>>> slot available
>>>
>>> Am 05.03.2018 um 08:55 schrieb Liu, Monk:
>>>> Hi Christian
>>>>
>>>> You are right on that part of obj-staged is set to NULL in
>>>> add_fence, So my following question will be why we kfree(obj->staged) in reserve_shared() if staged is always NULL in that point ?
>>> Good question, I haven't wrote code that so I can't fully answer.
>>>
>>> Maybe Chris or Maarten know more about that.
>>>
>>> Christian.
>>>
>>>> Thanks
>>>> /Monk
>>>>
>>>> -----Original Message-----
>>>> From: Christian König [mailto:ckoenig.leichtzumerken@gmail.com]
>>>> Sent: 2018年2月28日 16:27
>>>> To: Liu, Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org;
>>>> linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] dma-buf/reservation: shouldn't kfree staged
>>>> when slot available
>>>>
>>>> Am 28.02.2018 um 07:44 schrieb Monk Liu:
>>>>> under below scenario the obj->fence would refer to a wild pointer:
>>>>>
>>>>> 1,call reservation_object_reserved_shared
>>>>> 2,call reservation_object_add_shared_fence
>>>>> 3,call reservation_object_reserved_shared
>>>>> 4,call reservation_object_add_shared_fence
>>>>>
>>>>> in step 1, staged is allocated,
>>>>>
>>>>> in step 2, code path will go
>>>>> reservation_object_add_shared_replace()
>>>>> and obj->fence would be assigned as staged (through
>>>>> RCU_INIT_POINTER)
>>>>>
>>>>> in step 3, obj->staged will be freed(by simple kfree), which make
>>>>> obj->fence point to a wild pointer...
>>>> Well that explanation is still nonsense. See
>>>> reservation_object_add_shared_fence:
>>>>>             obj->staged = NULL;
>>>> Among the first things reservation_object_add_shared_fence() does is
>>>> it sets obj->staged to NULL.
>>>>
>>>> So step 3 will not free anything and we never have a wild pointer.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> in step 4, code path will go
>>>>> reservation_object_add_shared_inplace()
>>>>> and inside it the @fobj (which equals to @obj->staged, set by above
>>>>> steps) is already a wild pointer
>>>>>
>>>>> should remov the kfree on staged in
>>>>> reservation_object_reserve_shared()
>>>>>
>>>>> Change-Id: If7c01f1b4be3d3d8a81efa90216841f79ab1fc1c
>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>> ---
>>>>>       drivers/dma-buf/reservation.c | 7 ++-----
>>>>>       1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma-buf/reservation.c
>>>>> b/drivers/dma-buf/reservation.c index 375de41..b473ccc 100644
>>>>> --- a/drivers/dma-buf/reservation.c
>>>>> +++ b/drivers/dma-buf/reservation.c
>>>>> @@ -74,12 +74,9 @@ int reservation_object_reserve_shared(struct reservation_object *obj)
>>>>>       	old = reservation_object_get_list(obj);
>>>>>       
>>>>>       	if (old && old->shared_max) {
>>>>> -		if (old->shared_count < old->shared_max) {
>>>>> -			/* perform an in-place update */
>>>>> -			kfree(obj->staged);
>>>>> -			obj->staged = NULL;
>>>>> +		if (old->shared_count < old->shared_max)
>>>>>       			return 0;
>>>>> -		} else
>>>>> +		else
>>>>>       			max = old->shared_max * 2;
>>>>>       	} else
>>>>>       		max = 4;
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
