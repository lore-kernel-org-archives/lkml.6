Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeCEMgM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:36:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933075AbeCEMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:36:08 -0500
Date: Mon, 5 Mar 2018 13:35:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Message-ID: <20180305123552.GY25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2048240.1dZKXsSxFh@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
>  	} else {
>  		unsigned int duration_us;
>  
> -		tick_nohz_idle_go_idle(true);
> -		rcu_idle_enter();
> -
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
>  		 */
>  		next_state = cpuidle_select(drv, dev, &duration_us);
> +
> +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC / HZ);

(FWIW we have TICK_USEC for this)

> +		rcu_idle_enter();
> +
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
>  		 * Give the governor an opportunity to reflect on the outcome

Also, I think that at this point you've introduced a problem; by not
disabling the tick unconditionally, we'll have extra wakeups due to the
(now still running) tick, which will bias the estimation, as per
reflect(), downwards.

We should effectively discard tick wakeups when we could have entered
nohz but didn't, accumulating the idle period in reflect and only commit
once we get a !tick wakeup.

Of course, for that to work we need to somehow divine what woke us,
which is going to be tricky.
