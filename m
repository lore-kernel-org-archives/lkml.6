Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756120AbeEIFSX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:18:23 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:37315 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeEIFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:18:21 -0400
X-Google-Smtp-Source: AB8JxZph9t9BBLNcWprZBp50hJpRwGvITKa6GUAn9OKXdRvKiQWejjPtUf7g3XHzcxDCTYbbkiJD8puaVfBkyrlJMNU=
MIME-Version: 1.0
In-Reply-To: <5AF25B2E.8080901@rock-chips.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com> <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
 <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com> <5AF25B2E.8080901@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 8 May 2018 22:18:18 -0700
X-Google-Sender-Auth: rmNS31WeKWbvKc7fbvP9geqd86k
Message-ID: <CAD=FV=WZ+2MNbe341M7OQD11+RxaJuzdM6zMnXYB4dka74K1hQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 8, 2018 at 7:21 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Doug,
>
> On 05/09/2018 03:46 AM, Doug Anderson wrote:
>>
>> One note is that in the case Brian points at (where we need to
>> simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
>> we needed to do that to avoid losing interrupts.  For details, see
>> commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
>> supporting both edges").  We did this because:
>>
>> 1. We believed that the IP block in Rockchip SoCs has nearly the same
>> logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.
>>
>
> hmm, but i saw the gpio-dwapb.c actually toggle trigger after handle irq,
> which might avoid the race Brian mentioned:
> +               generic_handle_irq(gpio_irq);
> +               irq_status &= ~BIT(hwirq);
> +
> +               if ((irq_get_trigger_type(gpio_irq) & IRQ_TYPE_SENSE_MASK)
> +                       == IRQ_TYPE_EDGE_BOTH)
> +                       dwapb_toggle_trigger(gpio, hwirq);

The code you point at in dwapb_toggle_trigger() specifically is an
example of toggling the polarity _without_ disabling the interrupt in
between.  We took this as "working" code and as proof that it was OK
to change polarity without disabling the interrupt in-between.


> and i also saw ./qcom/pinctrl-msm.c do the
> toggle(msm_gpio_update_dual_edge_pos) at the end of msm_gpio_irq_set_type
> and msm_gpio_irq_ack, that seems can avoid the polarity races too.
>
>> 2. We were actually losing real interrupts and this was the only way
>> we could figure out how to fix it.
>>
>> When I tested that back in the day I was fairly convinced that we
>> weren't losing any interrupts in the EDGE_BOTH case after my fix, but
>> I certainly could have messed up.
>>
>>
>> For the EDGE_BOTH case it was important not to lose an interrupt
>> because, as you guys are talking about, we could end up configured the
>> wrong way.  I think in your case where you're just picking one
>> polarity losing an interrupt shouldn't matter since it's undefined
>> exactly if an edge happens while you're in the middle of executing
>> rockchip_irq_set_type().  Is that right?
>
>
> right, so we now have 2 cases: rockchip_irq_demux/ rockchip_irq_set_type
>
> if i'm right about the spurious irq(only happen when set rising for a high
> gpio, or set falling for a low gpio), then:
>
> 1/ rockchip_irq_demux
> it's important to not losing irqs in this case, maybe we can
>
> a) ack irq
> b) update polarity for edge both irq
>
> we don't need to disable irq in b), since we would not hit the spurious irq
> cases here(always check gpio level to toggle it)

Unless you have some sort of proof that rockchip_irq_demux(), I would
take it as an example of something that works.  I remember stress
testing the heck out of it.  Do you have some evidence that it's not
working?  I think Brian was simply speculating that there might be a
race here, but I don't think anyone has shown it have they?  Looking
back at my notes, the thing I really made sure to stress was that we
never got into a situation where we were losing an edge (AKA we were
never configured to look for a falling edge when the line was already
low).  I'm not sure I confirmed that we never got an extra interrupt.

I'm at home right now and I can't add prints and poke at things, but
as I understand it for edge interrupts the usual flow to make sure
interrupts aren't ever lost is:

1. See that the interrupt went off
2. Ack it (clear it)
3. Call the interrupt handler

...presumably in this case rockchip_irq_demux() is called after step
#2 (but I don't know if it's called before or after step #3).  If the
line is toggling like crazy while the 3 steps are going on, it's OK if
the interrupt handler is called more than once.  In general this could
be considered expected.  That's why you Ack before handling--any extra
edges that come in any time after the interrupt handler starts (even
after the very first instruction) need to cause the interrupt handler
to get called again.

This is different than Brian's understanding since he seemed to think
the Ack was happening later.  If you're in front of something where
you can add printouts, maybe you can tell us.  I tried to look through
the code and it was too twisted for me to be sure.


> 2/ rockchip_irq_set_type
> it's important to not having spurious irqs
>
> so we can disable irq during changing polarity only in these case:
> ((rising && gpio is heigh) || (falling && gpio is low))
>
> i'm still confirming the spurious irq with IC guys.

Hmmm, thinking about all this more, I'm curious how callers expect
this to work.  Certainly things are undefined if you have the
following situation:

Start: rising edge trigger, line is actually high
Request: change to falling edge trigger
Line falls during the request

In that case it's OK to throw the interrupt away because it can be
argued that the line could have fallen before the request actually
took place.  ...but it seems like there could be situations where the
user wouldn't expect interrupts to be thrown away by a call to
irq_set_type().  In other words:

Start: rising edge trigger, line is actually high
Request: change to falling edge trigger
Line falls, rises, and falls during the request

...in that case you'd expect that some sort of interrupt would have
gone off and not be thrown away.  No matter what instant in time the
request actually took place it should have caught an edge, right?


Said another way: As a client of irq_set_type() I'd expect it to not
throw away interrupts, but I'd expect that the change in type would be
atomic.  That is: if the interrupt came in before the type change in
type applied then it should trigger with the old rules.  If the
interrupt came in after the type change then it should trigger with
the new rules.


I would be tempted to confirm your testing and just clear the spurious
interrupts that you're aware of.  AKA: if there's no interrupt pending
and you change the type to "IRQ_TYPE_EDGE_RISING" or
"IRQ_TYPE_EDGE_FALLING" then you should clear the interrupt.  It's
still racy, but I guess it's the best you can do unless IC guys come
up with something better.



Anyway, it's past my bedtime.  Hopefully some of the above made sense.
I'm sure you'll tell me if it didn't or if I said something
stupid/wrong.  :-P

-Doug
