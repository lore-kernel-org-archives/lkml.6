Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758208AbeDXOHs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:07:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:21428 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbeDXOHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:07:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="40082454"
Date: Tue, 24 Apr 2018 17:07:41 +0300
From: Imre Deak <imre.deak@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: Early timeouts due to inaccurate jiffies during system
 suspend/resume
Message-ID: <20180424140741.yxn5u6rdviblhtzx@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20180419013200.wxkzqfdacfsijci5@ideak-desk.fi.intel.com>
 <alpine.DEB.2.21.1804191256200.1563@nanos.tec.linutronix.de>
 <20180423170128.mf7g26rniimm7asf@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423170128.mf7g26rniimm7asf@ideak-desk.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 08:01:28PM +0300, Imre Deak wrote:
> On Thu, Apr 19, 2018 at 01:05:39PM +0200, Thomas Gleixner wrote:
> > On Thu, 19 Apr 2018, Imre Deak wrote:
> > > Hi,
> > > 
> > > while checking bug [1], I noticed that jiffies based timing loops like
> > > 
> > > 	expire = jiffies + timeout + 1;
> > > 	while (!time_after(jiffies, expire))
> > > 		do_something;
> > > 
> > > can last shorter than expected (that is less than timeout).
> > 
> > Yes, that can happen when the timer interrupt is delayed long enough for
> > whatever reason. If you need accurate timing then you need to use
> > ktime_get().
> 
> Thanks. I always regarded jiffies as non-accurate, but something that
> gives a minimum time delay guarantee (when adjusted by +1 as above). I
> wonder if there are other callers in kernel that don't expect an early
> timeout.

msleep and any other schedule_timeout based waits are also affected. At the
same time for example msleep's documentation says:
"msleep - sleep safely even with waitqueue interruptions".

To me that suggests a wait with a minimum guaranteed delay.

Ville had an idea to make the behavior more deterministic by clamping
the jiffies increment to 1 for each timer interrupt. Would that work?

> 
> We switched now to using ktime_get_raw() in the i915 driver.
> 
> > 
> > > After some ftracing it seems like jiffies gets stale due to a missed
> > > LAPIC timer interrupt after the interrupt is armed in
> > > lapic_next_deadline() and before jiffies is sampled at 2. above.
> > > Eventually the interrupt does get delivered, at which point jiffies gets
> > > updated via tick_do_update_jiffies64() with a >1 ticks increment.
> > > Between lapic_next_deadline() and the - late - delivery of the interrupt
> > > the CPU on which the interrupt is armed doesn't go idle.
> > 
> > That's odd. I have no real explanation for that.
> 
> Looks like the reason is IRQ latency. For reference here are the
> longest ones I found with irqsoff ftracing, all running with IRQs disabled
> during system resume:
> 
> hpet_rtc_interrupt()->hpet_rtc_timer_reinit():
> do { ... } while(!hpet_cnt_ahead(...));
> takes sometimes up to ~40msec for me.
> 
> hpet_rtc_interrupt()->mc146818_get_time():
> if (mc146818_is_updating()) mdelay(20);
> 
> driver_probe_device->atkbd_connect()->i8042_port_close()->__i8042_command()->i8042_wait_write():
> takes sometimes up to ~10msec for me.
> 
> All the above paired with asynchronous calling of the drivers' resume
> hooks may result in the jumps in jiffies I saw.
> 
> --Imre
