Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEJWQc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:16:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46032 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeEJWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:16:30 -0400
X-Google-Smtp-Source: AB8JxZryAfM9k8zGf7p2POrZSkIhYKULRf5E6QciyouFfzthPmGbzKsG9MhjPx7mIBX72vlXaLAUeA==
Date: Thu, 10 May 2018 15:16:27 -0700
From: Brian Norris <briannorris@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when
 changing it's capability
Message-ID: <20180510221626.GA258670@rodete-desktop-imager.corp.google.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com>
 <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
 <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
 <5AF25B2E.8080901@rock-chips.com>
 <CAD=FV=WZ+2MNbe341M7OQD11+RxaJuzdM6zMnXYB4dka74K1hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WZ+2MNbe341M7OQD11+RxaJuzdM6zMnXYB4dka74K1hQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ irqchip maintainers

[ irqchip is weird -- it's all over drivers/{pinctrl,gpio,irqchip}/ :D ]

Hi Doug,

On Tue, May 08, 2018 at 10:18:18PM -0700, Doug Anderson wrote:
> On Tue, May 8, 2018 at 7:21 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> > On 05/09/2018 03:46 AM, Doug Anderson wrote:
> >> One note is that in the case Brian points at (where we need to
> >> simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
> >> we needed to do that to avoid losing interrupts.  For details, see
> >> commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
> >> supporting both edges").  We did this because:
> >>
> >> 1. We believed that the IP block in Rockchip SoCs has nearly the same
> >> logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.
> >>
> >
> > hmm, but i saw the gpio-dwapb.c actually toggle trigger after handle irq,
> > which might avoid the race Brian mentioned:
> > +               generic_handle_irq(gpio_irq);
> > +               irq_status &= ~BIT(hwirq);
> > +
> > +               if ((irq_get_trigger_type(gpio_irq) & IRQ_TYPE_SENSE_MASK)
> > +                       == IRQ_TYPE_EDGE_BOTH)
> > +                       dwapb_toggle_trigger(gpio, hwirq);
> 
> The code you point at in dwapb_toggle_trigger() specifically is an
> example of toggling the polarity _without_ disabling the interrupt in
> between.  We took this as "working" code and as proof that it was OK
> to change polarity without disabling the interrupt in-between.

There's a crucial ordering difference though: gpio-dwapb performs its
polarity adjustments *after* calling generic_handle_irq(), which among
other things calls ->irq_ack(). This means that it's re-ensuring that
the polarity is correct *after* the point at which it last ack'ed the
interrupt. So there's no chance of it clearing a second interrupt
without appropriately reconfiguring the polarity.

> > and i also saw ./qcom/pinctrl-msm.c do the
> > toggle(msm_gpio_update_dual_edge_pos) at the end of msm_gpio_irq_set_type
> > and msm_gpio_irq_ack, that seems can avoid the polarity races too.
> >
> >> 2. We were actually losing real interrupts and this was the only way
> >> we could figure out how to fix it.
> >>
> >> When I tested that back in the day I was fairly convinced that we
> >> weren't losing any interrupts in the EDGE_BOTH case after my fix, but
> >> I certainly could have messed up.
> >>
> >>
> >> For the EDGE_BOTH case it was important not to lose an interrupt
> >> because, as you guys are talking about, we could end up configured the
> >> wrong way.  I think in your case where you're just picking one
> >> polarity losing an interrupt shouldn't matter since it's undefined
> >> exactly if an edge happens while you're in the middle of executing
> >> rockchip_irq_set_type().  Is that right?
> >
> >
> > right, so we now have 2 cases: rockchip_irq_demux/ rockchip_irq_set_type
> >
> > if i'm right about the spurious irq(only happen when set rising for a high
> > gpio, or set falling for a low gpio), then:
> >
> > 1/ rockchip_irq_demux
> > it's important to not losing irqs in this case, maybe we can
> >
> > a) ack irq
> > b) update polarity for edge both irq
> >
> > we don't need to disable irq in b), since we would not hit the spurious irq
> > cases here(always check gpio level to toggle it)
> 
> Unless you have some sort of proof that rockchip_irq_demux(), I would
> take it as an example of something that works.  I remember stress
> testing the heck out of it.  Do you have some evidence that it's not
> working?  I think Brian was simply speculating that there might be a
> race here, but I don't think anyone has shown it have they?  Looking
> back at my notes, the thing I really made sure to stress was that we
> never got into a situation where we were losing an edge (AKA we were
> never configured to look for a falling edge when the line was already
> low).  I'm not sure I confirmed that we never got an extra interrupt.

I'll agree wholeheartedly that I'm only at the speculation stage right
now :) I can try to poke at it sometime if I get some cycles. I'd
definitely want to get better test results to prove this before changing
this part.

This is really just a side tangent anyway, because apparently the
existing code is working well enough for rockchip_irq_demux(), and for
$subject, we're really only working on improving set_type().

> I'm at home right now and I can't add prints and poke at things, but
> as I understand it for edge interrupts the usual flow to make sure
> interrupts aren't ever lost is:
> 
> 1. See that the interrupt went off
> 2. Ack it (clear it)
> 3. Call the interrupt handler
> 
> ...presumably in this case rockchip_irq_demux() is called after step
> #2 (but I don't know if it's called before or after step #3).  If the

One thing to note here is that we're talking about a 2-level (chained)
interrupt system. We've got the GIC, which does all of 1, 2, 3 at its
level, and as part of #3 for the GIC, it runs the 2nd-level handler --
rockchip_irq_demux() -- which has to perform all of 1, 2, 3 at its level.

1 -> this is looping over GPIO_INT_STATUS in rockchip_irq_demux()
2 -> this happens when writing to GPIO_PORTS_EOI, which only is called
     by ->irq_ack() (irq_gc_ack_set_bit()) ... which happens from:
       rockchip_irq_demux()
         -> generic_handle_irq()
	   -> handle_edge_irq()
             -> desc->irq_data.chip->irq_ack() = irq_gc_ack_set_bit()
3 -> same callpath as 2, except it's
     -> handle_edge_irq()
       -> handle_irq_event()

Those all happen in the correct order.

But the problem is that you left out the part about "change polarity for
emulating EDGE_BOTH"; in your example (gpio-dwapb.c), polarity
adjustment happens *after* 2; in Rockchip's driver, we have it before.
I'm pretty sure dwapb is correct, and we are not.

> line is toggling like crazy while the 3 steps are going on, it's OK if
> the interrupt handler is called more than once.  In general this could
> be considered expected.  That's why you Ack before handling--any extra
> edges that come in any time after the interrupt handler starts (even
> after the very first instruction) need to cause the interrupt handler
> to get called again.
> 
> This is different than Brian's understanding since he seemed to think
> the Ack was happening later.  If you're in front of something where
> you can add printouts, maybe you can tell us.  I tried to look through
> the code and it was too twisted for me to be sure.

I'm not sure your understanding of my understanding is accurate :)
Hopefully the above clarifies what I'm thinking?

> > 2/ rockchip_irq_set_type
> > it's important to not having spurious irqs
> >
> > so we can disable irq during changing polarity only in these case:
> > ((rising && gpio is heigh) || (falling && gpio is low))
> >
> > i'm still confirming the spurious irq with IC guys.
> 
> Hmmm, thinking about all this more, I'm curious how callers expect
> this to work.  Certainly things are undefined if you have the
> following situation:
> 
> Start: rising edge trigger, line is actually high
> Request: change to falling edge trigger
> Line falls during the request
> 
> In that case it's OK to throw the interrupt away because it can be
> argued that the line could have fallen before the request actually
> took place.  ...but it seems like there could be situations where the
> user wouldn't expect interrupts to be thrown away by a call to
> irq_set_type().  In other words:
> 
> Start: rising edge trigger, line is actually high
> Request: change to falling edge trigger
> Line falls, rises, and falls during the request
> 
> ...in that case you'd expect that some sort of interrupt would have
> gone off and not be thrown away.  No matter what instant in time the
> request actually took place it should have caught an edge, right?
> 
> 
> Said another way: As a client of irq_set_type() I'd expect it to not
> throw away interrupts, but I'd expect that the change in type would be
> atomic.  That is: if the interrupt came in before the type change in
> type applied then it should trigger with the old rules.  If the
> interrupt came in after the type change then it should trigger with
> the new rules.

I'm not sure it's totally possible to differentiate these, but that
seems about right I think.

> I would be tempted to confirm your testing and just clear the spurious
> interrupts that you're aware of.  AKA: if there's no interrupt pending
> and you change the type to "IRQ_TYPE_EDGE_RISING" or
> "IRQ_TYPE_EDGE_FALLING" then you should clear the interrupt.  It's
> still racy, but I guess it's the best you can do unless IC guys come
> up with something better.

Thanks! Yeah, clearing (rather than temporarily disabling) seems to make
more sense.

> Anyway, it's past my bedtime.  Hopefully some of the above made sense.
> I'm sure you'll tell me if it didn't or if I said something
> stupid/wrong.  :-P

Brian
