Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeBSQ3u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:29:50 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44339 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeBSQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:29:49 -0500
X-Google-Smtp-Source: AH8x226sWkWOkFospRrVGbBBFV9NLe6J2euIboYNmrpNTbOukJMRrXEeiITSva60TgcLU3pfCUFOig==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180219152421.GQ22199@phenom.ffwll.local>
 <cbfec1ed-d01f-1d4f-c3c0-cc04b93bc58c@gmail.com>
 <20180219161544.GY22199@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2e696981-6b4a-e292-c16a-0f3477dbf8ce@gmail.com>
Date: Mon, 19 Feb 2018 17:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219161544.GY22199@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.02.2018 um 17:15 schrieb Daniel Vetter:
> On Mon, Feb 19, 2018 at 04:41:55PM +0100, Christian König wrote:
>> Am 19.02.2018 um 16:24 schrieb Daniel Vetter:
>>> On Thu, Feb 15, 2018 at 03:19:42PM +0100, Christian König wrote:
>>>> amdgpu needs to verify if userspace sends us valid addresses and the simplest
>>>> way of doing this is to check if the buffer object is locked with the ticket
>>>> of the current submission.
>>>>
>>>> Clean up the access to the ww_mutex internals by providing a function
>>>> for this and extend the check to the thread owning the underlying mutex.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 ++-
>>>>    include/linux/ww_mutex.h               | 17 +++++++++++++++++
>>>>    2 files changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index eaa3cb0c3ad1..4c04b560e358 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -1594,7 +1594,8 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>>>>    	*map = mapping;
>>>>    	/* Double check that the BO is reserved by this CS */
>>>> -	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
>>>> +	if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, current,
>>>> +				  &parser->ticket))
>>>>    		return -EINVAL;
>>>>    	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
>>>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>>>> index 39fda195bf78..dd580db289e8 100644
>>>> --- a/include/linux/ww_mutex.h
>>>> +++ b/include/linux/ww_mutex.h
>>>> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>>>>    	return mutex_is_locked(&lock->base);
>>>>    }
>>>> +/**
>>>> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
>>>> + * @lock: the mutex to be queried
>>>> + * @task: the task structure to check
>>>> + * @ctx: the w/w acquire context to test
>>>> + *
>>>> + * Returns true if the mutex is locked in the context by the given task, false
>>>> + * otherwise.
>>>> + */
>>>> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
>>>> +					struct task_struct *task,
>>>> +					struct ww_acquire_ctx *ctx)
>>>> +{
>>>> +	return likely(__mutex_owner(&lock->base) == task) &&
>>>> +		READ_ONCE(lock->ctx) == ctx;
>>> Just comparing the context should be good enough. If you ever pass a
>>> ww_acquire_ctx which does not belong to your own thread your seriously
>>> wreaking things much worse already (and if we do catch that, should
>>> probably lock the ctx to a given task when ww-mutex debugging is enabled).
>>>
>>> That also simplifies the function signature.
>>>
>>> Of course that means if you don't have a ctx, you can't test ownership of
>>> a ww_mute, but I think that's not a really valid use-case.
>> Well exactly that is the use case in TTM, see patch #3 in this series.
>>
>> In TTM the evicted BOs are trylocked and so we need a way of testing for
>> ownership without a context.
> I don't think your final patch to keep ww_mutex locked until the end
> works. You can't really nest ww_mutex_trylock with ww_mutex at will (since
> trylock bypasses the entire deadlock avoidance).

Well that is not a problem at all. See we don't nest trylock with normal 
lock acquiring, cause that would indeed bypass the whole deadlock detection.

Instead we first use ww_mutex_acquire to lock all BOs which are needed 
for a command submission, including the deadlock detection.

Then all additional BOs which needed to be evicted to fulfill the 
current request are trylocked.

> If this is really what you want to do, then we need a
> ww_mutex_trylock_ctx, which also fills out the ctx value (so that other
> threads can correctly resolve deadlocks when you hold that lock while
> trying to grab additional locks). In which case you really don't need the
> task pointer.

Actually considered that as well, but it turned out that this is exactly 
what I don't want.

Cause then we wouldn't be able to distinct ww_mutex locked with a 
context (because they are part of the submission) and without (because 
TTM trylocked them).

> Yes it's a disappointment that lockdep doesn't correctly track trylocks,
> it just does basic sanity checks, but then drops them on the floor wrt
> depency tracking. Just in case you wonder why you're not getting a
> lockdeps splat for this. Unfortunately I don't understand lockdep enough
> to be able to fix this gap.

Sorry to disappoint you, but lockdep is indeed capable to correctly 
track those trylocked BOs.

Got quite a bunch of warning before I was able to resolve to this solution.

Christian.

> -Daniel
>
>> Christian.
>>
>>>    And not needed
>>> for cmd submission, where you need the ctx anyway.
>>>
>>> Besides this interface nit looks all good. With the task check&parameter
>>> removed:
>>>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>
>>> -Daniel
>>>
>>>> +}
>>>> +
>>>>    #endif
>>>> -- 
>>>> 2.14.1
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
