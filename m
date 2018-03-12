Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCLISE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:18:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41175 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:18:02 -0400
X-Google-Smtp-Source: AG47ELvoyctrtMZGWw4huZcgb1cjYdNvzR9w2iwVsdJwxASABUOcKtmokv5XDfhuuLkzuw+MperCOQQWQmXWShMZ4IU=
MIME-Version: 1.0
In-Reply-To: <20180312054412.yqyde34ly3kjoajj@tardis>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis>
From: =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date: Mon, 12 Mar 2018 16:18:00 +0800
Message-ID: <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Peter pointed out in this patch https://patchwork.kernel.org/patch/9771921/
>> that the spinning-lock used at __schedule() should be RCsc to ensure
>> visibility of writes prior to __schedule when the task is to be migrated to
>> another CPU.
>>
>> And this is emphasized at the comment of the newly introduced
>> smp_mb__after_spinlock(),
>>
>>  * This barrier must provide two things:
>>  *
>>  *   - it must guarantee a STORE before the spin_lock() is ordered against a
>>  *     LOAD after it, see the comments at its two usage sites.
>>  *
>>  *   - it must ensure the critical section is RCsc.
>>  *
>>  * The latter is important for cases where we observe values written by other
>>  * CPUs in spin-loops, without barriers, while being subject to scheduling.
>>  *
>>  * CPU0         CPU1            CPU2
>>  *
>>  *          for (;;) {
>>  *            if (READ_ONCE(X))
>>  *              break;
>>  *          }
>>  * X=1
>>  *          <sched-out>
>>  *                      <sched-in>
>>  *                      r = X;
>>  *
>>  * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
>>  * we get migrated and CPU2 sees X==0.
>>
>> which is used at,
>>
>> __schedule(bool preempt) {
>>     ...
>>     rq_lock(rq, &rf);
>>     smp_mb__after_spinlock();
>>     ...
>> }
>> .
>>
>> If I didn't miss something, I found this kind of visibility is __not__
>> necessarily
>> depends on the spinning-lock at __schedule being RCsc.
>>
>> In fact, as for runnable task A, the migration would be,
>>
>>  CPU0         CPU1            CPU2
>>
>> <ACCESS before schedule out A>
>>
>> lock(rq0)
>> schedule out A
>> unock(rq0)
>>
>>               lock(rq0)
>>               remove A from rq0
>>               unlock(rq0)
>>
>>               lock(rq2)
>>               add A into rq2
>>               unlock(rq2)
>>                                         lock(rq2)
>>                                         schedule in A
>>                                         unlock(rq2)
>>
>>                                         <ACCESS after schedule in A>
>>
>> <ACCESS before schedule out A> happens-before
>> unlock(rq0) happends-before
>> lock(rq0) happends-before
>> unlock(rq2) happens-before
>> lock(rq2) happens-before
>> <ACCESS after schedule in A>
>>
>
> But without RCsc lock, you cannot guarantee that a write propagates to
> CPU 0 and CPU 2 at the same time, so the same write may propagate to
> CPU0 before <ACCESS before schedule out A> but propagate to CPU 2 after
> <ACCESS after scheduler in A>. So..
>
> Regards,
> Boqun

Thank you for pointing out this case, Boqun.
But this is just one special case that acquire-release chains promise us.

A=B=0 as initial

  CPU0                CPU1                CPU2                CPU3
 write A=1
                           read A=1
                           write B=1
                           release X
                                                 acquire X
                                                 read A=?
                                                 release Y

    acquire Y

    read B=?

assurance 1: CPU3 will surely see B=1 writing by CPU1, and
assurance 2: CPU2 will also see A=1 writing by CPU0 as a special case

The second assurance is both in theory and implemented by real hardware.

As for theory, the C++11 memory model, which is a potential formal model
for kernel memory model as
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0124r4.html
descripes, states that:

If a value computation A of an atomic object M happens before a value
computation B of M, and A takes its value from a side effect X on M, then
the value computed by B shall either be the value stored by X or the value
stored by a side effect Y on M, where Y follows X in the modification
order of M.

at
$1.10 rule 18, on page 14
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf

As for real hardware, Luc provided detailed test and explanation on
ARM and POWER in 5.1 Cumulative Barriers for WRC  on page 19
in this paper:

A Tutorial Introduction to the ARM and POWER Relaxed Memory Models
https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test7.pdf

So, I think we may remove RCsc from smp_mb__after_spinlock which is
really confusing.

Best Regards,
Trol

>
>> And for stopped tasks,
>>
>>  CPU0         CPU1            CPU2
>>
>> <ACCESS before schedule out A>
>>
>> lock(rq0)
>> schedule out A
>> remove A from rq0
>> store-release(A->on_cpu)
>> unock(rq0)
>>
>>               load_acquire(A->on_cpu)
>>               set_task_cpu(A, 2)
>>
>>               lock(rq2)
>>               add A into rq2
>>               unlock(rq2)
>>
>>                                         lock(rq2)
>>                                         schedule in A
>>                                         unlock(rq2)
>>
>>                                         <ACCESS after schedule in A>
>>
>> <ACCESS before schedule out A> happens-before
>> store-release(A->on_cpu)  happens-before
>> load_acquire(A->on_cpu)  happens-before
>> unlock(rq2) happens-before
>> lock(rq2) happens-before
>> <ACCESS after schedule in A>
>>
>> So, I think the only requirement to smp_mb__after_spinlock is
>> to guarantee a STORE before the spin_lock() is ordered
>> against a LOAD after it. So we could remove the RCsc requirement
>> to allow more efficient implementation.
>>
>> Did I miss something or this RCsc requirement does not really matter?
