Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeDZJO6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:14:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754116AbeDZJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:14:53 -0400
Date: Thu, 26 Apr 2018 11:14:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180426091449.GA4082@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <f18c42e4-ead7-fbcd-b7da-6677e8485be9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f18c42e4-ead7-fbcd-b7da-6677e8485be9@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:34:36AM +0530, Kohli, Gaurav wrote:
> On 4/26/2018 1:39 AM, Peter Zijlstra wrote:
> 
> > On Wed, Apr 25, 2018 at 02:03:19PM +0530, Gaurav Kohli wrote:
> > > diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> > > index 5043e74..c5c5184 100644
> > > --- a/kernel/smpboot.c
> > > +++ b/kernel/smpboot.c
> > > @@ -122,7 +122,45 @@ static int smpboot_thread_fn(void *data)
> > >   		}
> > >   		if (kthread_should_park()) {
> > > +			/*
> > > +			 * Serialize against wakeup.
> > 			 *
> > 			 * Prior wakeups must complete and later wakeups
> > 			 * will observe TASK_RUNNING.
> > 			 *
> > 			 * This avoids the case where the TASK_RUNNING
> > 			 * store from ttwu() competes with the
> > 			 * TASK_PARKED store from kthread_parkme().
> > 			 *
> > 			 * If the TASK_PARKED store looses that
> > 			 * competition, kthread_unpark() will go wobbly.
> > > +			 */
> > > +			raw_spin_lock(&current->pi_lock);
> > >   			__set_current_state(TASK_RUNNING);
> > > +			raw_spin_unlock(&current->pi_lock);
> > >   			preempt_enable();
> > >   			if (ht->park && td->status == HP_THREAD_ACTIVE) {
> > >   				BUG_ON(td->cpu != smp_processor_id());
> > Does that work for you?
> 
> We have given patch for testing, usually it takes around 2-3 days for
> reproduction(we will update for the same).

I only changed the comment; surely your compiler doesn't generate
different code for that?

I was asking if the proposed comment was good with you; but see my more
recent email, that actually proposes a different fix.

> > 			/*
> > 			 * A similar race is possible here, but loosing
> > 			 * the TASK_INTERRUPTIBLE store is harmless and
> > 			 * will make us go around the loop once more.
> > 			 */
> 
> Actually instead of race, i am seeing wakeup miss problem which is
> very rare, if we take case of hotplug thread

Yes, triggering these issues is tricky, no doubt about that.

> > And of course, I suspect we actually want to use TASK_IDLE, smpboot
> > threads don't want signals do they? But that probably ought to be a
> > separate patch.
> 
> Yes I agree, we can control race from here as well,  Please suggest
> would below change be any help here:

That is not what I suggested. I said the thing should use TASK_IDLE
instead of TASK_INTERRUPTIBLE. Not change the location of it.
