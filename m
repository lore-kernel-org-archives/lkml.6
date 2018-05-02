Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeEBNe0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:34:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeEBNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:34:23 -0400
Date: Wed, 2 May 2018 15:34:18 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] clocksource: rework Atmel TCB timer driver
Message-ID: <20180502133418.xa26c5ta2ytxxjcn@linutronix.de>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
 <20180426164623.tlv6kz5yopk6voxx@breakpoint.cc>
 <20180426185233.GU4813@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180426185233.GU4813@piout.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-26 20:52:33 [+0200], Alexandre Belloni wrote:
> 
> I don't remember you posted anything for the TCB. Wasn't it focused on
> getting rid of the PIT irq?

the PIT irq which was shared with the UART one some devices, yes this
was part of it. The other essential piece was using a higher frequency
for the device:
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/clocksource-tclib-allow-higher-clockrates.patch?h=linux-4.14.y-rt-patches

> As said below, this is solving multiple issues, including the one for
> SoCs that don't have the PIT.
will the PIT be removed? Where it needs the PIT?

> Ok, if I understand correctly tc_clkevt2_set_oneshot is called from
> atomic context so it shouldn't call tc_clkevt2_shutdown.
> 
> Back in 2016, tglx said:
> "There was an earlier discussion about the clk stuff. Actually the lock
> protecting disable/enable should be made raw, but there was some crap going on
> in some of the clk callbacks which made that impossible. We realy should
> revisit this."
> 
> Anyway, I'll try to avoid disabling the clock just to reenable it
> afterwards.
> 
> (Actually, I've just checked before sending and I've found your patch,
> I'll do something similar)
thanks.

> > >  - the current solution is wasting some TCB channels
> > > 
> > > The plan is to get this driver upstream, then convert the TCB PWM driver to be
> > > able to get rid of the tcb_clksrc driver along with atmel_tclib.
> > 
> > The config options are now less than optimal (for me at least). On
> > oldconfig it asks you for PIT and I say selected no because I wanted the
> > new one. So I end up with nothing.
> > Not sure you want do something about it…
> > 
> 
> I don't think you ending up with nothing but probably you removed the
> PIT and kept ATMEL_TCLIB which is the combination that is really
> difficult to protect from. I don't think it is worth the added Kconfig
> complexity.

TCLIB was still enabled yes. It is 'oldconfig'.

> > Is the resolution more or the same compared what we have in -RT? On an
> > idle system this clocks goes up to 180us/ 190us while the old clock
> > started at 160us and moved to around 180us after one hackbench
> > invocation. This could be nothing, it could be a lower frequency of the
> > clockevents device.
> > 
> 
> The driver shouldn't change anything on that side.
> 
> > If you intend to stick with this driver then I would replace the current
> > hack in -RT with this series.
> > 
> 
> That is one of the goal, yes.
> 
> The remaining one would be "clocksource: TCLIB: Allow higher clock rates
> for clock events"

I see. So I would need to keep that patch in queue after it was
dismissed from duty…

Sebastian
