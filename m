Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCOMy3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:54:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56341 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeCOMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:54:27 -0400
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
Subject: Re: [RFT][PATCH v4 4/7] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 15 Mar 2018 13:54:59 +0100
Message-ID: <1998970.adS4ugIWGe@aspire.rjw.lan>
In-Reply-To: <20180314125929.GU4043@hirez.programming.kicks-ass.net>
References: <2352117.3UUoYAu18A@aspire.rjw.lan> <15847301.VVmNzm1RNz@aspire.rjw.lan> <20180314125929.GU4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 1:59:29 PM CET Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 10:54:18AM +0100, Rafael J. Wysocki wrote:
> > @@ -378,6 +384,26 @@ static int menu_select(struct cpuidle_dr
> >  	if (idx == -1)
> >  		idx = 0; /* No states enabled. Must use 0. */
> >  
> > +	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
> > +		*nohz_ret = false;
> > +	} else if (drv->states[idx].target_residency < TICK_USEC_HZ) {
> > +		first_idx = idx;
> > +		for (i = idx + 1; i < drv->state_count; i++) {
> > +			if (!drv->states[i].disabled &&
> > +			    !dev->states_usage[i].disable) {
> > +				first_idx = i;
> > +				break;
> > +			}
> 		}
> > +
> > +		/*
> > +		 * Do not stop the tick if there is at least one more state
> > +		 * within the tick period range that could be used if longer
> > +		 * idle duration was predicted.
> > +		 */
> > +		*nohz_ret = !(first_idx > idx &&
> > +			      drv->states[first_idx].target_residency < TICK_USEC_HZ);
> 
> 
> Why though? That comment only states what it does, but gives no clue as
> to why we're doing this. What was wrong with disabling NOHZ if the
> selected state (@idx) has shorter target residency.
> 
> 
> > +	}
> > +
> >  	data->last_state_idx = idx;
> >  
> >  	return data->last_state_idx;
> > 
> 

I invented this complicated logic because of the concern that using
predicted_us alone may skew the prediction algotithm too much towards
the lower values, so the idea was (roughly) to allow CPUs to be idle
for longer times more aggressively.  That is, to stop the tick even
in some cases in which predicted_us was below the tick period length,
but then again not too often.

It appears to work, but you are right that it is confusing and on
a second thought simpler code is always better as long as it gets the
job done.

I'll rework this and resend the series later today.

Thanks!
