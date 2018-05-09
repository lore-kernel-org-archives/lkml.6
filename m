Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755770AbeEIGnM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:43:12 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:56793 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeEIGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:43:10 -0400
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: dianders@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <4b4898535c909a6839f3e8707e269212>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AF29818.2010705@rock-chips.com>
Date: Wed, 09 May 2018 14:41:28 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>
CC: Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com> <20180507221511.GA6448@rodete-desktop-imager.corp.google.com> <5AF0FF18.1050905@rock-chips.com> <20180508015623.GA61455@rodete-desktop-imager.corp.google.com> <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com> <5AF25B2E.8080901@rock-chips.com> <CAD=FV=WZ+2MNbe341M7OQD11+RxaJuzdM6zMnXYB4dka74K1hQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WZ+2MNbe341M7OQD11+RxaJuzdM6zMnXYB4dka74K1hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for your reply :)

On 05/09/2018 01:18 PM, Doug Anderson wrote:
>> >
>> >
>> >right, so we now have 2 cases: rockchip_irq_demux/ rockchip_irq_set_type
>> >
>> >if i'm right about the spurious irq(only happen when set rising for a high
>> >gpio, or set falling for a low gpio), then:
>> >
>> >1/ rockchip_irq_demux
>> >it's important to not losing irqs in this case, maybe we can
>> >
>> >a) ack irq
>> >b) update polarity for edge both irq
>> >
>> >we don't need to disable irq in b), since we would not hit the spurious irq
>> >cases here(always check gpio level to toggle it)
> Unless you have some sort of proof that rockchip_irq_demux(), I would
> take it as an example of something that works.  I remember stress
> testing the heck out of it.  Do you have some evidence that it's not
> working?  I think Brian was simply speculating that there might be a
> race here, but I don't think anyone has shown it have they?  Looking
> back at my notes, the thing I really made sure to stress was that we
> never got into a situation where we were losing an edge (AKA we were
> never configured to look for a falling edge when the line was already
> low).  I'm not sure I confirmed that we never got an extra interrupt.
>
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

i think the current edge both irq flow for rk3399 would be:
gic_handle_irq //irq-gic-v3.c
   handle_domain_irq
     rockchip_irq_demux //pinctrl-rockchip.c
       toggle polarity
       generic_handle_irq
         handle_edge_irq //kernel/irq
           irq_ack
           handle_irq_event
             action->handler

so i think the race might actually exist (maybe we can add some delay 
after toggle polarity to confirm)


BTW, checking other drivers, there're quite a few using this kind of 
toggle edge for edge both, and they go different ways:

1/ toggle it in ack():
mediatek/pinctrl-mtk-common.c
gpio-ingenic.c
gpio-ep93xx.c

2/ toggle it before handle_irq:
pinctrl-rockchip.c
pinctrl-armada-37xx.c
gpio-ath79.c
gpio-mxs.c
gpio-omap.c
gpio-mvebu.c

3/ toggle it after handle_irq:
gpio-dwapb.c
gpio-pmic-eic-sprd.c


would it make sense to support this kind of emulate edge both irq in 
some core codes?

>
>
>> >2/ rockchip_irq_set_type
>> >it's important to not having spurious irqs
>> >
>> >so we can disable irq during changing polarity only in these case:
>> >((rising && gpio is heigh) || (falling && gpio is low))
>> >
>> >i'm still confirming the spurious irq with IC guys.
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
>
>
> I would be tempted to confirm your testing and just clear the spurious
> interrupts that you're aware of.  AKA: if there's no interrupt pending
> and you change the type to "IRQ_TYPE_EDGE_RISING" or
> "IRQ_TYPE_EDGE_FALLING" then you should clear the interrupt.  It's
> still racy, but I guess it's the best you can do unless IC guys come
> up with something better.
>

hmmm, right, clear the spurious irq seems to be a better way, will try 
to do it in the next version.
>
>
> Anyway, it's past my bedtime.  Hopefully some of the above made sense.
> I'm sure you'll tell me if it didn't or if I said something
> stupid/wrong.:-P
>
> -Doug
>
>
>
