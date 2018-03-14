Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCNRUj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:20:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCNRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:20:37 -0400
Date: Wed, 14 Mar 2018 18:20:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v4 1/7] time: tick-sched: Reorganize idle tick
 management code
Message-ID: <20180314172016.GO4064@hirez.programming.kicks-ass.net>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <2019498.YXfJVQUTuX@aspire.rjw.lan>
 <20180314154934.GA3635@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314154934.GA3635@lerouge>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:49:39PM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 12, 2018 at 10:47:41AM +0100, Rafael J. Wysocki wrote:

> > @@ -136,6 +138,13 @@ static inline u64 get_cpu_idle_time_us(i
> >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> >  #endif /* !CONFIG_NO_HZ_COMMON */
> >  
> > +static inline void tick_nohz_idle_stop_tick_protected(void)
> > +{
> > +	local_irq_disable();
> > +	tick_nohz_idle_stop_tick();
> > +	local_irq_enable();
> > +}
> 
> It seems that even if we have CONFIG_NO_HZ_COMMON=n,
> tick_nohz_idle_stop_tick_protected() will have overhead, right?

IIRC the only callsite of the _protected thing that remains at the end
is in the hotplug path. So who cares ;-)
