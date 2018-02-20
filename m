Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeBTN1A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:27:00 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45272 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBTN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:26:58 -0500
X-Google-Smtp-Source: AH8x226CcVRSr4851giCDT765s6vzi4TX0JEObosugWJc8KVYTGuzzNmxD+rK2mM04wVE5AGrx2qEA==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
To: Peter Zijlstra <peterz@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
Date: Tue, 20 Feb 2018 14:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220131253.GF25314@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.2018 um 14:12 schrieb Peter Zijlstra:
> On Tue, Feb 20, 2018 at 01:58:26PM +0100, Christian König wrote:
>> amdgpu needs to verify if userspace sends us valid addresses and the simplest
>> way of doing this is to check if the buffer object is locked with the ticket
>> of the current submission.
>>
>> Clean up the access to the ww_mutex internals by providing a function
>> for this and extend the check to the thread owning the underlying mutex.
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> Much thanks for Cc'ing the relevant maintainers :/

Sorry for that.

>> ---
>>   include/linux/ww_mutex.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>> index 39fda195bf78..14e4149d3d9d 100644
>> --- a/include/linux/ww_mutex.h
>> +++ b/include/linux/ww_mutex.h
>> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>>   	return mutex_is_locked(&lock->base);
>>   }
>>   
>> +/**
>> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
>> + * @lock: the mutex to be queried
>> + * @ctx: the w/w acquire context to test
>> + *
>> + * If @ctx is not NULL test if the mutex is owned by this context.
>> + * If @ctx is NULL test if the mutex is owned by the current thread.
>> + */
>> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
>> +					struct ww_acquire_ctx *ctx)
>> +{
>> +	if (ctx)
>> +		return likely(READ_ONCE(lock->ctx) == ctx);
>> +	else
>> +		return likely(__mutex_owner(&lock->base) == current);
>> +}
> Much better than the previous version. If you want to bike-shed, you can
> leave out the 'else' and unindent the last line.

Thanks for the suggestion, going to do this.

> I do worry about potential users of .ctx = NULL, though. It makes it far
> too easy to do recursive locking, which is something we should strongly
> discourage.

Well, one of the addressed use cases is indeed checking for recursive 
locking. But recursive locking is something rather normal for ww_mutex 
and we are just exercising an existing code path.

E.g. the most common use case for the ww_mutex is in the graphics 
drivers where usespace sends us a list of buffer objects to work with.

Now when userspace sends us duplicates in that buffer list the 
expectation is to get -EALREADY from ww_mutex_lock when we try to lock 
the same ww_mutex twice.

Depending on the driver this then results in returning an error code to 
userspace or just ignoring the duplicate (because of backward 
compatibility).


The intention behind this function is now to a) be able to extend those 
checks to make sure user space doesn't sends us potentially harmful 
nonsense and b) allow to check for recursion in TTM during buffer object 
eviction which uses ww_mutex_trylock instead of ww_mutex_lock.

Regards,
Christian.
