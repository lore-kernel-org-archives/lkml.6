Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeDIRz1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:55:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751742AbeDIRz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:55:26 -0400
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, catalin.marinas@arm.com
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <47e586d6-0cb5-0572-3f7b-d5eb5a6ced68@redhat.com>
Date: Mon, 9 Apr 2018 13:55:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180409105835.GC23134@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 06:58 AM, Will Deacon wrote:
> Hi Waiman,
>
> Thanks for taking this lot for a spin. Comments and questions below.
>
> On Fri, Apr 06, 2018 at 04:50:19PM -0400, Waiman Long wrote:
>> On 04/05/2018 12:58 PM, Will Deacon wrote:
>>> The qspinlock locking slowpath utilises a "pending" bit as a simple form
>>> of an embedded test-and-set lock that can avoid the overhead of explicit
>>> queuing in cases where the lock is held but uncontended. This bit is
>>> managed using a cmpxchg loop which tries to transition the uncontended
>>> lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
>>>
>>> Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
>>> indefinitely if the lock word is seen to oscillate between unlocked
>>> (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
>>> able to take the lock in the cmpxchg loop without queuing and pass it
>>> around amongst themselves.
>>>
>>> This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
>>> using atomic_fetch_or, and then inspecting the old value to see whether
>>> we need to spin on the current lock owner, or whether we now effectively
>>> hold the lock. The tricky scenario is when concurrent lockers end up
>>> queuing on the lock and the lock becomes available, causing us to see
>>> a lockword of (n,0,0). With pending now set, simply queuing could lead
>>> to deadlock as the head of the queue may not have observed the pending
>>> flag being cleared. Conversely, if the head of the queue did observe
>>> pending being cleared, then it could transition the lock from (n,0,0) ->
>>> (0,0,1) meaning that any attempt to "undo" our setting of the pending
>>> bit could race with a concurrent locker trying to set it.
>>>
>>> We handle this race by preserving the pending bit when taking the lock
>>> after reaching the head of the queue and leaving the tail entry intact
>>> if we saw pending set, because we know that the tail is going to be
>>> updated shortly.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>> ---
>> The pending bit was added to the qspinlock design to counter performance
>> degradation compared with ticket lock for workloads with light
>> spinlock contention. I run my spinlock stress test on a Intel Skylake
>> server running the vanilla 4.16 kernel vs a patched kernel with this
>> patchset. The locking rates with different number of locking threads
>> were as follows:
>>
>>   # of threads  4.16 kernel     patched 4.16 kernel
>>   ------------  -----------     -------------------
>>         1       7,417 kop/s         7,408 kop/s
>>         2       5,755 kop/s         4,486 kop/s
>>         3       4,214 kop/s         4,169 kop/s
>>         4       4,396 kop/s         4,383 kop/s
>>        
>> The 2 contending threads case is the one that exercise the pending bit
>> code path the most. So it is obvious that this is the one that is most
>> impacted by this patchset. The differences in the other cases are mostly
>> noise or maybe just a little bit on the 3 contending threads case.
> That is bizarre. A few questions:
>
>   1. Is this with my patches as posted, or also with your WRITE_ONCE change?

This is just the with your patches as posted.
 
>   2. Could you try to bisect my series to see which patch is responsible
>      for this degradation, please?

I have done further analysis with the help of CONFIG_QUEUED_LOCK_STAT
with another patch to enable counting the pending and the queuing code
paths.

Running the 2-thread test with the original qspinlock code on a Haswell
server, the performance data were

pending count = 3,265,220
queuing count = 22
locking rate = 11,648 kop/s

With your posted patches,

pending count = 330
queuing count = 9,965,127
locking rate = 4,178 kop/s

I believe that my test case has heavy dependency on _Q_PENDING_VAL
spinning loop. When I added back the loop, the performance data became:

pending count = 3,278,320
queuing count = 0
locking rate = 11,884 kop/s

Instead of an infinite loop, I also tried a limited spin with loop count
of 0x200 and I got similar performance data as the infinite loop case.

>   3. Could you point me at your stress test, so I can try to reproduce these
>      numbers on arm64 systems, please?

I will send you the test that I  used in a separate email.

>> I am not against this patch, but we certainly need to find out a way to
>> bring the performance number up closer to what it is before applying
>> the patch.
> We certainly need to *understand* where the drop is coming from, because
> the two-threaded case is still just a CAS on x86 with and without this
> patch series. Generally, there's a throughput cost when ensuring fairness
> and forward-progress otherwise we'd all be using test-and-set.

As stated above, the drop comes mainly from skipping the _Q_PENDING_VAL
spinning loop. I supposed that if we just do a limited spin, we can
still ensure forward progress while preserving the performance profile
of the original qspinlock code.

I don't think other codes in your patches cause any performance
regression as far as my testing is concerned.

Cheers,
Longman
