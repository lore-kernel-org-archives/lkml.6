Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDLORB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:17:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752759AbeDLOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:16:56 -0400
Subject: Re: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
 <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
 <20180412140605.GB21296@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e48ed216-f524-5b81-9790-33ccb78f7c06@redhat.com>
Date: Thu, 12 Apr 2018 10:16:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180412140605.GB21296@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 10:06 AM, Will Deacon wrote:
> On Wed, Apr 11, 2018 at 03:53:16PM -0400, Waiman Long wrote:
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index 396701e8c62d..a8fc402b3f3a 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -162,6 +162,17 @@ struct __qspinlock {
>>>  
>>>  #if _Q_PENDING_BITS == 8
>>>  /**
>>> + * clear_pending - clear the pending bit.
>>> + * @lock: Pointer to queued spinlock structure
>>> + *
>>> + * *,1,* -> *,0,*
>>> + */
>>> +static __always_inline void clear_pending(struct qspinlock *lock)
>>> +{
>>> +	WRITE_ONCE(lock->pending, 0);
>>> +}
>>> +
>>> +/**
>>>   * clear_pending_set_locked - take ownership and clear the pending bit.
>>>   * @lock: Pointer to queued spinlock structure
>>>   *
>>> @@ -201,6 +212,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>>>  #else /* _Q_PENDING_BITS == 8 */
>>>  
>>>  /**
>>> + * clear_pending - clear the pending bit.
>>> + * @lock: Pointer to queued spinlock structure
>>> + *
>>> + * *,1,* -> *,0,*
>>> + */
>>> +static __always_inline void clear_pending(struct qspinlock *lock)
>>> +{
>>> +	atomic_andnot(_Q_PENDING_VAL, &lock->val);
>>> +}
>>> +
>>> +/**
>>>   * clear_pending_set_locked - take ownership and clear the pending bit.
>>>   * @lock: Pointer to queued spinlock structure
>>>   *
>> BTW, there is a similar clear_pending() function in
>> qspinlock_paravirt.c. I think you need to remove that with this patch.
> Thanks, I'll do that. I did build and bisect this series... for arm64, which
> is completely useless as it doesn't get compiled until the final patch which
> I haven't posted here.
>
> Will

You certainly need to get a x86 system and compiles with the patches
applied one-by-one with CONFIG_PARAVIRT_SPINLOCKS enabled.

Cheers,
Longman
