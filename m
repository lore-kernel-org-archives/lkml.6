Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754920AbeDZVkS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:40:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbeDZVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:40:17 -0400
Date: Thu, 26 Apr 2018 23:40:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Imre Deak <imre.deak@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: Early timeouts due to inaccurate jiffies during system
 suspend/resume
In-Reply-To: <20180424140741.yxn5u6rdviblhtzx@ideak-desk.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1804262331280.1596@nanos.tec.linutronix.de>
References: <20180419013200.wxkzqfdacfsijci5@ideak-desk.fi.intel.com> <alpine.DEB.2.21.1804191256200.1563@nanos.tec.linutronix.de> <20180423170128.mf7g26rniimm7asf@ideak-desk.fi.intel.com> <20180424140741.yxn5u6rdviblhtzx@ideak-desk.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Imre Deak wrote:
> On Mon, Apr 23, 2018 at 08:01:28PM +0300, Imre Deak wrote:
> > On Thu, Apr 19, 2018 at 01:05:39PM +0200, Thomas Gleixner wrote:
> > > On Thu, 19 Apr 2018, Imre Deak wrote:
> > > > Hi,
> > > > 
> > > > while checking bug [1], I noticed that jiffies based timing loops like
> > > > 
> > > > 	expire = jiffies + timeout + 1;
> > > > 	while (!time_after(jiffies, expire))
> > > > 		do_something;
> > > > 
> > > > can last shorter than expected (that is less than timeout).
> > > 
> > > Yes, that can happen when the timer interrupt is delayed long enough for
> > > whatever reason. If you need accurate timing then you need to use
> > > ktime_get().
> > 
> > Thanks. I always regarded jiffies as non-accurate, but something that
> > gives a minimum time delay guarantee (when adjusted by +1 as above). I
> > wonder if there are other callers in kernel that don't expect an early
> > timeout.
> 
> msleep and any other schedule_timeout based waits are also affected. At the
> same time for example msleep's documentation says:
> "msleep - sleep safely even with waitqueue interruptions".
> 
> To me that suggests a wait with a minimum guaranteed delay.

Kinda :) The problem with jiffies is that it's a software maintained
counter which depends on interrupt delivery. Contrary to hardware based
counters which just work (most of the time at least).

> Ville had an idea to make the behavior more deterministic by clamping
> the jiffies increment to 1 for each timer interrupt. Would that work?

In theory, but there is the problem with NOHZ. NOHZ idle allows the CPU to
sleep for more than 1 jiffie in order to safe power by not waking up just
to increment jiffies and go back to sleep. So we need to push jiffies
forward when the system was completely idle for some time. We already make
sure that jiffies are updated on interrupt entry from idle before any code
relying on them is run.

Now for the weird case where interrupts get delayed awfully long, the right
answer is to break these long interrupt disabled sections. Anything which
holds interrupts disabled longer than a couple of microseconds is broken.

Thanks,

	tglx
