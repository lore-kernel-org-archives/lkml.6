Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNMIP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:08:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51864 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:08:13 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Wed, 14 Mar 2018 13:08:47 +0100
Message-ID: <1612418.9UMGjv7DaP@aspire.rjw.lan>
In-Reply-To: <20180314120450.GT4043@hirez.programming.kicks-ass.net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <20180314120450.GT4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 1:04:50 PM CET Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 10:36:27AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If poll_idle() is allowed to spin until need_resched() returns 'true',
> > it may actually spin for a much longer time than expected by the idle
> > governor, since set_tsk_need_resched() is not always called by the
> > timer interrupt handler.  If that happens, the CPU may spend much
> > more time than anticipated in the "polling" state.
> > 
> > To prevent that from happening, limit the time of the spinning loop
> > in poll_idle().
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > -> v2: After additional testing reduce POLL_IDLE_TIME_CHECK_COUNT to 1000.
> > 
> > ---
> >  drivers/cpuidle/poll_state.c |   17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/cpuidle/poll_state.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/poll_state.c
> > +++ linux-pm/drivers/cpuidle/poll_state.c
> > @@ -5,16 +5,31 @@
> >   */
> >  
> >  #include <linux/cpuidle.h>
> > +#include <linux/ktime.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/idle.h>
> >  
> > +#define POLL_IDLE_TIME_CHECK_COUNT	1000
> > +#define POLL_IDLE_TIME_LIMIT		(TICK_NSEC / 16)
> > +
> >  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> >  			       struct cpuidle_driver *drv, int index)
> >  {
> > +	ktime_t start = ktime_get();
> 
> I would recoomend not using ktime_get(), imagine the 'joy' if that
> happens to be the HPET.
> 
> >  	local_irq_enable();
> >  	if (!current_set_polling_and_test()) {
> > +		unsigned int time_check_counter = 0;
> > +
> > +		while (!need_resched()) {
> >  			cpu_relax();
> > +			if (time_check_counter++ < POLL_IDLE_TIME_CHECK_COUNT)
> > +				continue;
> > +
> > +			time_check_counter = 0;
> > +			if (ktime_sub(ktime_get(), start) > POLL_IDLE_TIME_LIMIT)
> > +				break;
> > +		}
> >  	}
> >  	current_clr_polling();
> 
> Since the idle loop is strictly per-cpu, you can use regular
> sched_clock() here. Something like:
> 
> 	u64 start = sched_clock();
> 
> 	local_irq_enable();
> 	if (!current_set_polling_and_test()) {
> 		while (!need_resched()) {
> 			cpu_relax();
> 
> 			if (sched_clock() - start > POLL_IDLE_TIME_LIMIT)
> 				break;
> 		}
> 	}
> 	current_clr_polling();

Good idea!

> On x86 we don't have to use that time_check_counter thing, sched_clock()
> is really cheap, not sure if it makes sense on other platforms.

Let's do it the way you suggested, if there are issues with it, we
can still add the counter later.

Thanks!
