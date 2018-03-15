Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCOR0w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCOR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:26:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4B8204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 15 Mar 2018 18:26:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180315172643.GA14075@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <2019498.YXfJVQUTuX@aspire.rjw.lan>
 <20180314154934.GA3635@lerouge>
 <20180314172016.GO4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314172016.GO4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:20:16PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 04:49:39PM +0100, Frederic Weisbecker wrote:
> > On Mon, Mar 12, 2018 at 10:47:41AM +0100, Rafael J. Wysocki wrote:
> 
> > > @@ -136,6 +138,13 @@ static inline u64 get_cpu_idle_time_us(i
> > >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> > >  #endif /* !CONFIG_NO_HZ_COMMON */
> > >  
> > > +static inline void tick_nohz_idle_stop_tick_protected(void)
> > > +{
> > > +	local_irq_disable();
> > > +	tick_nohz_idle_stop_tick();
> > > +	local_irq_enable();
> > > +}
> > 
> > It seems that even if we have CONFIG_NO_HZ_COMMON=n,
> > tick_nohz_idle_stop_tick_protected() will have overhead, right?
> 
> IIRC the only callsite of the _protected thing that remains at the end
> is in the hotplug path. So who cares ;-)

Hey, I see you trying to sneak in overhead out of hatred against the hotplug
code ;-)
