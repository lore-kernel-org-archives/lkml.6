Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF534C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716DF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716DF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJDFRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:17:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50556 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeJDFRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:17:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F6FD20802; Thu,  4 Oct 2018 00:26:48 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2E872071E;
        Thu,  4 Oct 2018 00:26:47 +0200 (CEST)
Date:   Thu, 4 Oct 2018 00:26:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
Message-ID: <20181003222648.GM4088@piout.net>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <20180913113024.3571-3-alexandre.belloni@bootlin.com>
 <3ff4d71d-6a63-58ca-bdfd-79b9867fa477@linaro.org>
 <20180925211629.GE3112@piout.net>
 <7988ce42-fba9-db31-c1df-b78900192598@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7988ce42-fba9-db31-c1df-b78900192598@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2018 23:24:11+0200, Daniel Lezcano wrote:
> On 25/09/2018 23:16, Alexandre Belloni wrote:
> > On 24/09/2018 03:59:55+0200, Daniel Lezcano wrote:
> >> On 13/09/2018 13:30, Alexandre Belloni wrote:
> >>> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> >>> clocksource and two clockevent devices.
> >>>
> >>> One of the clockevent device is linked to the clocksource counter and so it
> >>> will run at the same frequency. This will be used when there is only on TCB
> >>> channel available for timers.
> >>>
> >>> The other clockevent device runs on a separate TCB channel when available.
> >>>
> >>> This driver uses regmap and syscon to be able to probe early in the boot
> >>> and avoid having to switch on the TCB clocksource later. 
> >>
> >> Sorry, I don't get it. Can you elaborate?
> >>
> > 
> > The current existing way of sharing TCB channels is getting probed to
> > late in the boot process to be used as the clocksource so currently, the
> > PIT is necessary to act as the clocksource until the TCB clocksource can
> > be probed.
> > 
> > This is a big issue for SoCs without a PIT, they simply can't boot.
> 
> I'm still missing the point. The timer (clocksource + clocksource) is
> probed very early with TIMER_OF_DECLARE.
> 

No, tcb_clksrc is probed very latebecause it needs tclib to be probed
first and this happens at arch_initcall.
> 
> > This also solves:
> > 33d8c15559df Revert "clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock"
> > 7b9f1d16e6d1 clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock
> > 
> > 
> >>> Using regmap also
> >>> means that unused TCB channels may be used by other drivers (PWM for
> >>> example). read/writel are still used to access channel specific registers
> >>> to avoid the performance impact of regmap (mainly locking).
> >>
> >> I don't get the regmap reasoning here.
> > 
> > Because there are 3 channels per TCB, some TCB can have channels handled
> > by different drivers (say channel 0 for clocksource, channel 1 for
> > clockevent and channel 2 for PWM). There are configuration registers that
> > are shared for all the channels and so the access needs to be handled
> > properly. But as we discussed on a previous version of the patch, we
> > don't want to lock/unlock each time we read the clocksource so for the
> > channel specific registers, readl/writel is used directly.
> 
> Can you point me to the code where we have racy access to the
> ATMEL_TC_BMR register ?
> 

There is non currently.

> 
> >> My main concern with this driver is the 16bits chained support. See
> >> below in the comments.
> >>
> >>
> >>> +struct atmel_tcb_clksrc {
> >>> +	struct clocksource clksrc;
> >>> +	struct clock_event_device clkevt;
> >>> +	struct regmap *regmap;
> >>> +	void __iomem *base;
> >>> +	struct clk *clk[2];
> >>> +	char name[20];
> >>
> >> You can reasonably remove this field and use directly the ones in the
> >> clocksrc/evt.
> >>
> > 
> > name in struct clocksource is a pointer to a string, we still need a
> > place to store that string.
> 
> Come on!
> 
> char *name = kasprintf(...);
> 
> tc.clkevt.name = name;
> tc.clksrc.name = name;
> 
> no need to add a specific field for this.
> 

And how is unconditionally dynamically allocating memory better than
having a field in the struct?

> >> Can you explain why returning "t0_clk" is better than returning an error?
> >>
> > 
> > This is the current tclib behavior and doing otherwise would break the
> > DT ABI.
> > The reason for this behavior is that some TCB may have a clock
> > per channel while others have one clock for the whole block.
> 
> What are the DT ABI? Can you point the snippets ?
> 

It is documented in Documentation/devicetree/bindings/mfd/atmel-tcb.txt

> >> Using two channels to emulate a 32bits timer has a significant cost,
> >> especially in the sched_clock function which is part of the hot kernel
> >> path. In addition it makes the code less maintainable and readable.
> >>
> >> Why don't you just stick to a specific rate with the prescalar value and
> >> reduce the rating of the timer ? (example in the stm32 timer,
> >> stm32_timer_set_prescaler and init function).
> >>
> >> It will be less precise (thus the lower rating) but will make the system
> >> faster by preventing multiple register reads in the sched_clock.
> >>
> >> Is it an acceptable trade-off ?
> >>
> > 
> > Not at this point, the goal is to not change the current behaviour.
> > Some customer rely on the fast timer (they are bitbanging some RF
> > protocols) and counting at more that 5MHz using a 16 bit timer is
> > definitively too fast.
> 
> Not if you use the prescalar.
> 

I'm not sure what you mean. 16bits at 5MHz (and it is actually faster than that)
wraps up every 13ms.

> > This is something that could be changed once we implement timer rate
> > selection (but I doubt it will make the code more readable).
> > 
> > I'm not saying we shouldn't question what was done 10 years ago but I'd
> > rather not change it is this series.
> > 
> > Also, the goal is to get rid of the tcb_clksrc driver now that avr32 is
> > gone. This will be done once the pwm driver is converted (I did that in
> > v1).
> 
> You want to get rid of the tcb_clksrc by adding a new driver which is
> very similar without taking into consideration to do a move to something
> cleaner and putting in question what was already done.
> 
> 
> 
> >>> +	tcb_base = of_iomap(node->parent, 0);
> >>> +	if (!tcb_base) {
> >>> +		pr_err("%s +%d %s\n", __FILE__, __LINE__, __func__);
> >>
> >> Remove those debug information and replace them by a proper error message.
> >>
> > 
> > My mistake, this will be simply removed.
> > 
> >>> +		return -ENXIO;
> >>> +	}
> >>> +
> >>> +	match = of_match_node(atmel_tcb_dt_ids, node->parent);
> >>> +	bits = (uintptr_t)match->data;
> >>> +
> >>> +	err = of_property_read_u32_index(node, "reg", 0, &channel);
> >>> +	if (err)
> >>> +		return err;
> >>> +
> >>> +	irq = of_irq_get(node->parent, channel);
> >>> +	if (irq < 0) {
> >>
> >> if (irq <= 0) {
> >>
> >>> +		irq = of_irq_get(node->parent, 0);
> >>
> >> Why ?
> >>
> > 
> > See the binding, 
> 
> Ok, can you point me to the code ?
> 
> > the timer is a child of the TCB and the TCB node has
> > the irq info. So, the TCB is defined in the dtsi and the child nodes are
> > in the board dts.
> > 
> >>> +		if (irq < 0)
> >>
> >> if (irq <= 0) {
> >>
> >>> +			return irq;
> >>> +	}
> >>> +
> >>> +	if (bits == 16) {
> >>> +		of_property_read_u32_index(node, "reg", 1, &chan1);
> >>> +		if (chan1 == -1) {
> >>> +			pr_err("%s: clocksource needs two channels\n",
> >>> +			       node->parent->full_name);
> >>
> >> Think about it. The code is giving up at this point in the boot process.
> >> So of two things, you consider there is an alternate clocksource /
> >> clockevent or the system hangs:
> >>
> >>  - If there is an alternate clocksource why support 32bits by chaining
> >> the channels with the cost it introduces instead of using the alternate
> >> one ?
> >>
> > 
> > The PIT is almost always the worse clocksource as it is very slow.
> 
> What is slow here ?
> 

Well, my wording was very poor. The main issue with the pit is the
resolution of the clockevent (95 to 160 ms). Also, it wrap every 10
seconds or so.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
