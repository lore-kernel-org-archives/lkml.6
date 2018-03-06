Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeCFRqJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:46:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbeCFRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:46:07 -0500
Date: Tue, 6 Mar 2018 18:46:04 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 09:08:11 [-0600], Corey Minyard wrote:
> Starting with the change
> 
> 8a64547a07980f9d25e962a78c2e10ee82bdb742 fs/dcache: use swait_queue instead
> of
> waitqueue
…
> The following change is the obvious reason:
> 
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -69,6 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
>         struct swait_queue *curr;
>         LIST_HEAD(tmp);
> 
> +       WARN_ON(irqs_disabled());
>         raw_spin_lock_irq(&q->lock);
>         list_splice_init(&q->task_list, &tmp);
>         while (!list_empty(&tmp)) {
> 
> I've done a little bit of analysis here, percpu_ref_kill_and_confirm()
> does spin_lock_irqsave() and then does a percpu_ref_put().  If the
> refcount reaches zero, the release function of the refcount is
> called.  In this case, the block code has set this to
> blk_queue_usage_counter_release(), which calls swake_up_all().
> 
> It seems like a bad idea to call percpu_ref_put() with interrupts
> disabled.  This problem actually doesn't appear to be RT-related,
> there's just no warning call if the RT tree isn't used.

yeah but vanilla uses wake_up() which does spin_lock_irqsafe() so it is
not an issue there.

The odd part here is that percpu_ref_kill_and_confirm() does _irqsave()
which suggests that it might be called from any context and then it does
wait_event_lock_irq() which enables interrupts again while it waits. So
it can't be used from any context.

> I'm not sure if it's best to just do the put outside the lock, or
> have modified put function that returns a bool to know if a release
> is required, then the release function can be called outside the
> lock.  I can do patches and test, but I'm hoping for a little
> guidance here.

swake_up_all() does raw_spin_lock_irq() because it should be called from
non-IRQ context. And it drops the lock (+IRQ enable) between wake-ups in
case we "need_resched()" because we woke a high-priority waiter. There
is the list_splice because we wanted to drop the locks (and have IRQs
open) during the entire wake up process but finish_swait() may happen
during the wake up and so we must hold the lock while the list-item is
removed for the queue head.
I have no idea what is the wisest thing to do here. The obvious fix
would be to use the irqsafe() variant here and not drop the lock between
wake ups. That is essentially what swake_up_all_locked() does which I
need for the completions (and based on some testing most users have one
waiter except during PM and some crypto code).
It is probably no comparison to wake_up_q() (which does multiple wake
ups without a context switch) but then we did this before like that.

Preferably we would have a proper list_splice() and some magic in the
"early" dequeue part that works.

> I'm also wondering why we don't have a warning like this in the
> *_spin_lock_irq() macros, perhaps turned on with a debug
> option.  That would catch things like this sooner.

Ideally you would add lockdep_assert_irqs_enabled() to
local_irq_disable() so you would have it hidden behind lockdep with an
recursion check and everything. But this needs a lot of headers like
task_struct so…
I had once WARN_ON_ONCE(irqs_disabled()) added to testdrive it and had a
few false-positive in the early boot or constructs like in
__run_hrtimer(). I didn't look at it further…

> Thanks,
> 
> -corey

Sebastian
