Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935686AbeCHJVs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:21:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44793 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935629AbeCHJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:21:46 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
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
Subject: Re: [RFC/RFT][PATCH v2 1/6] time: tick-sched: Reorganize idle tick management code
Date: Thu, 08 Mar 2018 10:22:26 +0100
Message-ID: <1938066.lrFpnYERYl@aspire.rjw.lan>
In-Reply-To: <20180307231827.GA9367@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <4136227.b9g9WnMbNJ@aspire.rjw.lan> <20180307231827.GA9367@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 8, 2018 12:18:29 AM CET Frederic Weisbecker wrote:
> On Tue, Mar 06, 2018 at 10:02:01AM +0100, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-pm.orig/kernel/time/tick-sched.c
> > +++ linux-pm/kernel/time/tick-sched.c
> > +
> > +/**
> > + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> > + *
> > + * Called when we start the idle loop.
> > + */
> > +void tick_nohz_idle_prepare(void)
> > +{
> > +	struct tick_sched *ts;
> > +
> > +	__tick_nohz_idle_prepare();
> > +
> > +	local_irq_disable();
> > +
> > +	ts = this_cpu_ptr(&tick_cpu_sched);
> > +	ts->inidle = 1;
> > +
> > +	local_irq_enable();
> > +}
> 
> Why not calling tick_nohz_start_idle() from there? This is going to
> simplify the rest, you won't need to call tick_nohz_idle_go_idle()
> from places that don't want to stop the tick and you can then remove
> the stop_tick argument.

So I guess I would then use ts->idle_entrytime as "now" in the
tick_nohz_get_sleep_length() computation, right?
