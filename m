Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758400AbeD0NJY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:09:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758119AbeD0NJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:09:22 -0400
Subject: Re: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <1adce90b-7627-ed71-fd34-bb33388790d5@redhat.com>
 <20180427101619.GB21705@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d9b1cc76-7878-43d2-bda9-b3bf074b5c9e@redhat.com>
Date: Fri, 27 Apr 2018 09:09:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180427101619.GB21705@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 06:16 AM, Will Deacon wrote:
> Hi Waiman,
>
> On Thu, Apr 26, 2018 at 04:16:30PM -0400, Waiman Long wrote:
>> On 04/26/2018 06:34 AM, Will Deacon wrote:
>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
>>> index 2711940429f5..2dbad2f25480 100644
>>> --- a/kernel/locking/qspinlock_paravirt.h
>>> +++ b/kernel/locking/qspinlock_paravirt.h
>>> @@ -118,11 +118,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
>>>  	WRITE_ONCE(lock->pending, 1);
>>>  }
>>>  
>>> -static __always_inline void clear_pending(struct qspinlock *lock)
>>> -{
>>> -	WRITE_ONCE(lock->pending, 0);
>>> -}
>>> -
>>>  /*
>>>   * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
>>>   * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
>> There is another clear_pending() function after the "#else /*
>> _Q_PENDING_BITS == 8 */" line that need to be removed as well.
> Bugger, sorry I missed that one. Is the >= 16K CPUs case supported elsewhere
> in Linux? The x86 Kconfig appears to clamp NR_CPUS to 8192 iiuc.
>
> Anyway, additional patch below. Ingo -- please can you apply this on top?
>
I don't think we support >= 16k in any of the distros. However, this
will be a limit that we will reach eventually. That is why I said we can
wait.

Cheers,
Longman
