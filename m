Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeDYUJ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:09:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeDYUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:09:24 -0400
Date: Wed, 25 Apr 2018 22:09:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gaurav Kohli <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 02:03:19PM +0530, Gaurav Kohli wrote:
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 5043e74..c5c5184 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -122,7 +122,45 @@ static int smpboot_thread_fn(void *data)
>  		}
>  
>  		if (kthread_should_park()) {
> +			/*
> +			 * Serialize against wakeup.
			 *
			 * Prior wakeups must complete and later wakeups
			 * will observe TASK_RUNNING.
			 *
			 * This avoids the case where the TASK_RUNNING
			 * store from ttwu() competes with the
			 * TASK_PARKED store from kthread_parkme().
			 *
			 * If the TASK_PARKED store looses that
			 * competition, kthread_unpark() will go wobbly.
> +			 */
> +			raw_spin_lock(&current->pi_lock);
>  			__set_current_state(TASK_RUNNING);
> +			raw_spin_unlock(&current->pi_lock);
>  			preempt_enable();
>  			if (ht->park && td->status == HP_THREAD_ACTIVE) {
>  				BUG_ON(td->cpu != smp_processor_id());

Does that work for you?

But looking at this a bit more; don't we have the exact same problem
with the TASK_RUNNING store in the !ht->thread_should_run() case?
Suppose a ttwu() happens concurrently there, it can end up competing
against the TASK_INTERRUPTIBLE store, no?

Of course, that race is not fatal, we'll just end up going around the
loop once again I suppose. Maybe a comment there too?

			/*
			 * A similar race is possible here, but loosing
			 * the TASK_INTERRUPTIBLE store is harmless and
			 * will make us go around the loop once more.
			 */

And of course, I suspect we actually want to use TASK_IDLE, smpboot
threads don't want signals do they? But that probably ought to be a
separate patch.
