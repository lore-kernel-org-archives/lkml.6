Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeCFIRW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:17:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51174 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCFIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:17:21 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before stopping the tick
Date: Tue, 06 Mar 2018 09:18:04 +0100
Message-ID: <2173697.qZXBTo6fPi@aspire.rjw.lan>
In-Reply-To: <1520292421.6857.22.camel@surriel.com>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2048240.1dZKXsSxFh@aspire.rjw.lan> <1520292421.6857.22.camel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 6, 2018 12:27:01 AM CET Rik van Riel wrote:
> On Sun, 2018-03-04 at 23:28 +0100, Rafael J. Wysocki wrote:
> > 
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
> >  	} else {
> >  		unsigned int duration_us;
> >  
> > -		tick_nohz_idle_go_idle(true);
> > -		rcu_idle_enter();
> > -
> >  		/*
> >  		 * Ask the cpuidle framework to choose a convenient
> > idle state.
> >  		 */
> >  		next_state = cpuidle_select(drv, dev, &duration_us);
> > +
> > +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC /
> > HZ);
> > +		rcu_idle_enter();
> > +
> >  		entered_state = call_cpuidle(drv, dev, next_state);
> 
> When the expected idle period is short enough
> that the timer is not stopped, does it make
> sense to still call rcu_idle_enter?
> 
> Should rcu_idle_enter also be conditional on
> the expected idle period?

Well, that would be the next step. :-)
