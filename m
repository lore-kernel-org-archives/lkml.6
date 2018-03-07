Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeCGXSe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754706AbeCGXSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:18:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C331E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 8 Mar 2018 00:18:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 1/6] time: tick-sched: Reorganize idle tick
 management code
Message-ID: <20180307231827.GA9367@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
 <4136227.b9g9WnMbNJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4136227.b9g9WnMbNJ@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:02:01AM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/time/tick-sched.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> +
> +/**
> + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> + *
> + * Called when we start the idle loop.
> + */
> +void tick_nohz_idle_prepare(void)
> +{
> +	struct tick_sched *ts;
> +
> +	__tick_nohz_idle_prepare();
> +
> +	local_irq_disable();
> +
> +	ts = this_cpu_ptr(&tick_cpu_sched);
> +	ts->inidle = 1;
> +
> +	local_irq_enable();
> +}

Why not calling tick_nohz_start_idle() from there? This is going to
simplify the rest, you won't need to call tick_nohz_idle_go_idle()
from places that don't want to stop the tick and you can then remove
the stop_tick argument.

> +
> +/**
> + * tick_nohz_idle_go_idle - start idle period on the current CPU.
> + * @stop_tick: Whether or not to stop the idle tick.
> + *
> + * When @stop_tick is set and the next event is more than a tick into the
> + * future, stop the idle tick.
> + */
> +void tick_nohz_idle_go_idle(bool stop_tick)
> +{
> +	__tick_nohz_idle_enter(this_cpu_ptr(&tick_cpu_sched), stop_tick);
> +}
> +
> +void tick_nohz_idle_enter(void)
> +{
> +	struct tick_sched *ts;
> +
> +	__tick_nohz_idle_prepare();
>  
>  	local_irq_disable();
>  
>  	ts = this_cpu_ptr(&tick_cpu_sched);
>  	ts->inidle = 1;
> -	__tick_nohz_idle_enter(ts);
> +	__tick_nohz_idle_enter(ts, true);
>  
>  	local_irq_enable();
>  }

Ah I see you're keeping tick_nohz_idle_enter() around because of the callsite
in xen. It looks like a hack (from the xen part), I'll need to have a look at
it, just a note for myself...

Thanks.
