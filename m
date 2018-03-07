Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeCGPpd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:45:33 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32791 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933870AbeCGPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:45:31 -0500
X-Google-Smtp-Source: AG47ELtwWZ8O70DdaL1WEvqz1Z1vbCzUW8e+vQGs4Kfg9Nuy/xqdGfrzbAvYWg2qP0ke6dRSARDTOg==
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
Date: Wed, 7 Mar 2018 09:45:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 11:46 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-05 09:08:11 [-0600], Corey Minyard wrote:
>> Starting with the change
>>
>> 8a64547a07980f9d25e962a78c2e10ee82bdb742 fs/dcache: use swait_queue instead
>> of
>> waitqueue
> …
>> The following change is the obvious reason:
>>
>> --- a/kernel/sched/swait.c
>> +++ b/kernel/sched/swait.c
>> @@ -69,6 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
>>          struct swait_queue *curr;
>>          LIST_HEAD(tmp);
>>
>> +       WARN_ON(irqs_disabled());
>>          raw_spin_lock_irq(&q->lock);
>>          list_splice_init(&q->task_list, &tmp);
>>          while (!list_empty(&tmp)) {
>>
>> I've done a little bit of analysis here, percpu_ref_kill_and_confirm()
>> does spin_lock_irqsave() and then does a percpu_ref_put().  If the
>> refcount reaches zero, the release function of the refcount is
>> called.  In this case, the block code has set this to
>> blk_queue_usage_counter_release(), which calls swake_up_all().
>>
>> It seems like a bad idea to call percpu_ref_put() with interrupts
>> disabled.  This problem actually doesn't appear to be RT-related,
>> there's just no warning call if the RT tree isn't used.
> yeah but vanilla uses wake_up() which does spin_lock_irqsafe() so it is
> not an issue there.
>
> The odd part here is that percpu_ref_kill_and_confirm() does _irqsave()
> which suggests that it might be called from any context and then it does
> wait_event_lock_irq() which enables interrupts again while it waits. So
> it can't be used from any context.
>
>> I'm not sure if it's best to just do the put outside the lock, or
>> have modified put function that returns a bool to know if a release
>> is required, then the release function can be called outside the
>> lock.  I can do patches and test, but I'm hoping for a little
>> guidance here.
> swake_up_all() does raw_spin_lock_irq() because it should be called from
> non-IRQ context. And it drops the lock (+IRQ enable) between wake-ups in
> case we "need_resched()" because we woke a high-priority waiter. There
> is the list_splice because we wanted to drop the locks (and have IRQs
> open) during the entire wake up process but finish_swait() may happen
> during the wake up and so we must hold the lock while the list-item is
> removed for the queue head.
> I have no idea what is the wisest thing to do here. The obvious fix
> would be to use the irqsafe() variant here and not drop the lock between
> wake ups. That is essentially what swake_up_all_locked() does which I
> need for the completions (and based on some testing most users have one
> waiter except during PM and some crypto code).
> It is probably no comparison to wake_up_q() (which does multiple wake
> ups without a context switch) but then we did this before like that.
>
> Preferably we would have a proper list_splice() and some magic in the
> "early" dequeue part that works.
>

Maybe just modify the block code to run the swake_up_all() call in a 
workqueue
or tasklet?  If you think that works, I'll create a patch, test it, and 
submit it if
all goes well.

Thanks,

-corey
