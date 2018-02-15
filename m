Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033180AbeBOOWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:22:34 -0500
Received: from foss.arm.com ([217.140.101.70]:54850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033031AbeBOOWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:22:33 -0500
Date: Thu, 15 Feb 2018 14:22:39 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180215142239.GF16623@arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 06:53:44PM +0000, Mathieu Desnoyers wrote:
> ----- On Feb 14, 2018, at 11:51 AM, Mark Rutland mark.rutland@arm.com wrote:
> > On Wed, Feb 14, 2018 at 03:07:41PM +0000, Will Deacon wrote:
> >> If the exit()ing task had recently migrated from another CPU, then that
> >> CPU could concurrently run context_switch() and take this path:
> >> 
> >> 	if (!prev->mm) {
> >> 		prev->active_mm = NULL;
> >> 		rq->prev_mm = oldmm;
> >> 	}
> > 
> > IIUC, on the prior context_switch, next->mm == NULL, so we set
> > next->active_mm to prev->mm.
> > 
> > Then, in this context_switch we set oldmm = prev->active_mm (where prev
> > is next from the prior context switch).
> > 
> > ... right?
> > 
> >> which then means finish_task_switch will call mmdrop():
> >> 
> >> 	struct mm_struct *mm = rq->prev_mm;
> >> 	[...]
> >> 	if (mm) {
> >> 		membarrier_mm_sync_core_before_usermode(mm);
> >> 		mmdrop(mm);
> >> 	}
> > 
> > ... then here we use what was prev->active_mm in the most recent context
> > switch.
> > 
> > So AFAICT, we're never concurrently accessing a task_struct::mm field
> > here, only prev::{mm,active_mm} while prev is current...
> > 
> > [...]
> > 
> >> diff --git a/kernel/exit.c b/kernel/exit.c
> >> index 995453d9fb55..f91e8d56b03f 100644
> >> --- a/kernel/exit.c
> >> +++ b/kernel/exit.c
> >> @@ -534,8 +534,9 @@ static void exit_mm(void)
> >>         }
> >>         mmgrab(mm);
> >>         BUG_ON(mm != current->active_mm);
> >> -       /* more a memory barrier than a real lock */
> >>         task_lock(current);
> >> +       /* Ensure we've grabbed the mm before setting current->mm to NULL */
> >> +       smp_mb__after_spin_lock();
> >>         current->mm = NULL;
> > 
> > ... and thus I don't follow why we would need to order these with
> > anything more than a compiler barrier (if we're preemptible here).
> > 
> > What have I completely misunderstood? ;)
> 
> The compiler barrier would not change anything, because task_lock()
> already implies a compiler barrier (provided by the arch spin lock
> inline asm memory clobber). So compiler-wise, it cannot move the
> mmgrab(mm) after the store "current->mm = NULL".
> 
> However, given the scenario involves multiples CPUs (one doing exit_mm(),
> the other doing context switch), the actual order of perceived load/store
> can be shuffled. And AFAIU nothing prevents the CPU from ordering the
> atomic_inc() done by mmgrab(mm) _after_ the store to current->mm.

Mark and I have spent most of the morning looking at this and realised I
made a mistake in my original guesswork: prev can't migrate until half way
down finish_task_switch when on_cpu = 0, so the access of prev->mm in
context_switch can't race with exit_mm() for that task.

Furthermore, although the mmgrab() could in theory be reordered with
current->mm = NULL (and the ARMv8 architecture allows this too), it's
pretty unlikely with LL/SC atomics and the backwards branch, where the
CPU would have to pull off quite a few tricks for this to happen.

Instead, we've come up with a more plausible sequence that can in theory
happen on a single CPU:

<task foo calls exit()>

do_exit
	exit_mm
		mmgrab(mm);			// foo's mm has count +1
		BUG_ON(mm != current->active_mm);
		task_lock(current);
		current->mm = NULL;
		task_unlock(current);

<irq and ctxsw to kthread>

context_switch(prev=foo, next=kthread)
	mm = next->mm;
	oldmm = prev->active_mm;

	if (!mm) {				// True for kthread
		next->active_mm = oldmm;
		mmgrab(oldmm);			// foo's mm has count +2
	}

	if (!prev->mm) {			// True for foo
		rq->prev_mm = oldmm;
	}

	finish_task_switch
		mm = rq->prev_mm;
		if (mm) {			// True (foo's mm)
			mmdrop(mm);		// foo's mm has count +1
		}

	[...]

<ctxsw to task bar>

context_switch(prev=kthread, next=bar)
	mm = next->mm;
	oldmm = prev->active_mm;		// foo's mm!

	if (!prev->mm) {			// True for kthread
		rq->prev_mm = oldmm;
	}

	finish_task_switch
		mm = rq->prev_mm;
		if (mm) {			// True (foo's mm)
			mmdrop(mm);		// foo's mm has count +0
		}

	[...]

<ctxsw back to task foo>

context_switch(prev=bar, next=foo)
	mm = next->mm;
	oldmm = prev->active_mm;

	if (!mm) {				// True for foo
		next->active_mm = oldmm;	// This is bar's mm
		mmgrab(oldmm);			// bar's mm has count +1
	}


	[return back to exit_mm]

mmdrop(mm);					// foo's mm has count -1

At this point, we've got an imbalanced count on the mm and could free it
prematurely as seen in the KASAN log. A subsequent context-switch away
from foo would therefore result in a use-after-free.

Assuming others agree with this diagnosis, I'm not sure how to fix it.
It's basically not safe to set current->mm = NULL with preemption enabled.

Will
