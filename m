Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755637AbeEHTqb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:46:31 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:43086 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755446AbeEHTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:46:28 -0400
X-Google-Smtp-Source: AB8JxZq67bf5EkZ3W1U3UBZuKuS9a9pJS6tv1QoxBuv2rHhi6D6jBlOzlRdhAR/pOJUUaCIsOUeXw2DxYchQC1nK2Pw=
MIME-Version: 1.0
In-Reply-To: <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com> <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 8 May 2018 12:46:25 -0700
X-Google-Sender-Auth: dXY3dKqDkn_n4f_cpvNQzaXGhS4
Message-ID: <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
To: Brian Norris <briannorris@chromium.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
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

On Mon, May 7, 2018 at 6:56 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Tue, May 08, 2018 at 09:36:24AM +0800, Jeffy Chen wrote:
>> On 05/08/2018 06:15 AM, Brian Norris wrote:
>> > On the other hand...this also implies there may be a race condition
>> > there, where we might lose an interrupt if there is an edge between the
>> > re-configuration of the polarity in rockchip_irq_demux() and the
>> > clearing/handling of the interrupt (handle_edge_irq() ->
>> > chip->irq_ack()). If we have an edge between there, then we might ack
>> > it, but leave the polarity such that we aren't ready for the next
>> > (inverted) edge.
>>
>> if let me guess, the unexpected irq we saw is the hardware trying to avoid
>> losing irq? for example, we set a EDGE_RISING, and the hardware saw the gpio
>> is already high, then though it might lost an irq, so fake one for safe?
>
> I won't pretend to know what the IC designers were doing, but I don't
> think that would resolve the problem I'm talking about. The sequence is
> something like:
> 1. EDGE_BOTH IRQ occurs (e.g., low to high)
> 2. reconfigure polarity in rockchip_irq_demux() (polarity=low)
> 3. continue to handle_edge_irq()
> 4. another HW edge occurs (e.g., high to low)
> 5. handle_edge_irq() (from 3) acks (clears) IRQ (before a subsequent
>    rockchip_irq_demux() gets a chance to run and flip the polarity)
> ...
>
> Now the polarity is still low, but the next trigger should be a
> low-to-high edge.
>
>> i'll try to confirm it with IC guys.

One note is that in the case Brian points at (where we need to
simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
we needed to do that to avoid losing interrupts.  For details, see
commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
supporting both edges").  We did this because:

1. We believed that the IP block in Rockchip SoCs has nearly the same
logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.

2. We were actually losing real interrupts and this was the only way
we could figure out how to fix it.

When I tested that back in the day I was fairly convinced that we
weren't losing any interrupts in the EDGE_BOTH case after my fix, but
I certainly could have messed up.


For the EDGE_BOTH case it was important not to lose an interrupt
because, as you guys are talking about, we could end up configured the
wrong way.  I think in your case where you're just picking one
polarity losing an interrupt shouldn't matter since it's undefined
exactly if an edge happens while you're in the middle of executing
rockchip_irq_set_type().  Is that right?


-Doug
