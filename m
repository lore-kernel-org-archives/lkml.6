Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeCFWv6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:51:58 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36959 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753978AbeCFWv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:51:56 -0500
X-Google-Smtp-Source: AG47ELv5c9G0o/fVb8XLvhPASeFVq6/IiPXgVboqOqzzzrlGTsjKHNZB7k+FQ9NqByJ9JC7/EyXZLg==
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kent Overstreet <koverstreet@google.com>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <6b839441-cee1-aefc-e432-7a0473f7da61@mvista.com>
Date: Tue, 6 Mar 2018 16:51:53 -0600
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

I'm adding the author (Kent) to this email, I should have done that 
originally.

You are right, it looks like all the percpu_ref_switch.. and 
percpu_ref_kill...
functions are broken here.

I also don't understand the need for a global lock for non-global variables.
It looks like this could become a bottleneck in a big SMP system.

I'm going to spend some time with this and try to figure out what is going
on.  Hopefully Kent or Tejun can offer some insight.

-corey

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
>> I'm also wondering why we don't have a warning like this in the
>> *_spin_lock_irq() macros, perhaps turned on with a debug
>> option.  That would catch things like this sooner.
> Ideally you would add lockdep_assert_irqs_enabled() to
> local_irq_disable() so you would have it hidden behind lockdep with an
> recursion check and everything. But this needs a lot of headers like
> task_struct so…
> I had once WARN_ON_ONCE(irqs_disabled()) added to testdrive it and had a
> few false-positive in the early boot or constructs like in
> __run_hrtimer(). I didn't look at it further…
>
>> Thanks,
>>
>> -corey
> Sebastian
