Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834C820870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYs0hcXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeKTPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:34:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39037 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbeKTPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:34:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so353678pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6s6ScYDGXlGp0Aq1BZsxe22gqUkUPAghZIeu2eN1Y1Y=;
        b=dYs0hcXNRVf3hdfxblhnehiYVV1Pv0IUf38n4eDqmwLpCNmda6dqKyEn3+2H/K/b3Y
         tIO3VODbvsaCeTsUsPnV1b3toG9KgwKPEqyBnz+G8/zdjih9w6G41cjdATTvpKP7nZPq
         eVTD3WcLe0nTatziWMvs2FYUF6XaNw789H0V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6s6ScYDGXlGp0Aq1BZsxe22gqUkUPAghZIeu2eN1Y1Y=;
        b=XCVXkj6Pc+NCWbL/m+0G2CD2ytN5GePrj8oH3qQkZKdS+r4wi3UoCxrRggXfgd31PD
         C9julTuxcpiH0iyP0oqYcQYVG5P30RJEduPtTSCjf7CdQ8hdTHmWIDbuk9GWIspA8cZw
         dwa96GYmklGqb+jYSKQx/r/0HUXVvuxvWREWRNfU7PtfbXkC6oAIAiTm2bccmEVrUYpV
         Bq/bObMSXTUzir0OQHryLLycssgFTCYjg8yc4WwBt7MqJ7lMRtN5C1ceKfe9mFoSQ8dK
         GLlgCwrB8iDkRI9E1aAlYJ9Dc2oUzosuGbngRJTr1+VE9iiePySfZspf9b83NJ9n+xPJ
         p1Mw==
X-Gm-Message-State: AA+aEWZBS2YCy6BiuSz2AlZmlxFNZ0LtJ7uRfJpnZE2SDk0zKaOyVXo1
        ki/XY1cx+zwp7jZrbBn7X5R3
X-Google-Smtp-Source: AFSGD/U8sZbVC+2n2ue09a4kqLrauzGpAxntiO2+aECM8zTkc/Sqth4lYIwTLN6lnOLl6gT9IIhiTA==
X-Received: by 2002:a63:9845:: with SMTP id l5mr623489pgo.142.1542690420608;
        Mon, 19 Nov 2018 21:07:00 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7280:70ee:bd9e:c1c9:b807:673a])
        by smtp.gmail.com with ESMTPSA id k129sm49163797pgk.29.2018.11.19.21.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 21:06:59 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:36:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, service@rdamicro.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
Message-ID: <20181120050650.GC5885@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Nov 19, 2018 at 05:57:12PM +0000, Marc Zyngier wrote:
> On 19/11/2018 17:09, Manivannan Sadhasivam wrote:
> > Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> > and HWTIMER.
> > 
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/mach-rda/Kconfig       |   1 +
> >  drivers/clocksource/Kconfig     |   7 ++
> >  drivers/clocksource/Makefile    |   1 +
> >  drivers/clocksource/timer-rda.c | 187 ++++++++++++++++++++++++++++++++
> >  4 files changed, 196 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-rda.c
> > 
> > diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> > index 29012bc68ca4..1ea753f57b2d 100644
> > --- a/arch/arm/mach-rda/Kconfig
> > +++ b/arch/arm/mach-rda/Kconfig
> > @@ -4,5 +4,6 @@ menuconfig ARCH_RDA
> >  	select COMMON_CLK
> >  	select GENERIC_IRQ_CHIP
> >  	select RDA_INTC
> > +	select RDA_TIMER
> >  	help
> >  	  This enables support for the RDA Micro 8810PL SoC family.
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 55c77e44bb2d..f51eee3a72ea 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -105,6 +105,13 @@ config OWL_TIMER
> >  	help
> >  	  Enables the support for the Actions Semi Owl timer driver.
> >  
> > +config RDA_TIMER
> > +	bool "RDA timer driver" if COMPILE_TEST
> > +	depends on GENERIC_CLOCKEVENTS
> > +	select CLKSRC_MMIO
> > +	help
> > +	  Enables the support for the RDA Micro timer driver.
> > +
> >  config SUN4I_TIMER
> >  	bool "Sun4i timer driver" if COMPILE_TEST
> >  	depends on HAS_IOMEM
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index dd9138104568..150020a90707 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
> >  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
> >  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
> >  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
> > +obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
> >  
> >  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
> >  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> > diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
> > new file mode 100644
> > index 000000000000..3aa684d92c5d
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-rda.c
> > @@ -0,0 +1,187 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * RDA8810PL SoC timer driver
> > + *
> > + * Copyright RDA Microelectronics Company Limited
> > + * Copyright (c) 2017 Andreas Färber
> > + * Copyright (c) 2018 Manivannan Sadhasivam
> > + */
> > +
> > +#include <linux/clockchips.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +#define RDA_OSTIMER_LOADVAL_L	0x000
> > +#define RDA_OSTIMER_CTRL	0x004
> > +#define RDA_HWTIMER_LOCKVAL_L	0x024
> > +#define RDA_HWTIMER_LOCKVAL_H	0x028
> > +#define RDA_TIMER_IRQ_MASK_SET	0x02c
> > +#define RDA_TIMER_IRQ_CLR	0x034
> > +
> > +#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
> > +#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
> > +#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
> > +
> > +#define RDA_TIMER_IRQ_MASK_SET_OSTIMER	BIT(0)
> > +
> > +#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
> > +
> > +static void __iomem *rda_timer_base;
> > +
> > +static u64 rda_hwtimer_read(struct clocksource *cs)
> > +{
> > +	u32 lo, hi;
> > +
> > +	/* Always read low 32 bits first */
> > +	lo = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_L);
> > +	hi = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_H);
> 
> Please use the relaxed accessors throughout this driver. There is zero
> reason to use the non-relaxed versions here.
> 

Okay.

> Now, I'm pretty sure this thing isn't correct.
> 
> 	<timer = 0x00000000ffffffff>
> 	lo = 0xffffffff;
> 	<tick, timer = 0x0000000100000000>
> 	hi = 0x00000001;
> 
> Bingo. You cannot read a 64bit counter with only two 32bit accesses.
> 

I think the lack of description makes confusion here. In this SoC, there
are two independent timers available: OSTIMER (56 bit) and HWTIMER (64 bit)
with optional interrupt support. I have used OSTIMER for clockevents and
HWTIMER for clocksource. Will add this information in driver.

Please let me know whether I have to model these two clocksources
differently!

> > +
> > +	return ((u64)hi << 32) | lo;
> > +}
> > +
> > +static struct clocksource rda_clocksource = {
> > +	.name           = "rda-timer",
> > +	.rating         = 400,
> > +	.read           = rda_hwtimer_read,
> > +	.mask           = CLOCKSOURCE_MASK(64),
> 
> This is a 64bit counter? See below.
> 

Yes, this is the HWTIMER and is 64 bit.

> > +	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +static int rda_ostimer_start(bool periodic, u64 cycles)
> > +{
> > +	u32 ctrl, load_l;
> > +
> > +	load_l = (u32)cycles;
> > +	ctrl = ((cycles >> 32) & 0xffffff);
> > +	ctrl |= RDA_OSTIMER_CTRL_LOAD | RDA_OSTIMER_CTRL_ENABLE;
> > +	if (periodic)
> > +		ctrl |= RDA_OSTIMER_CTRL_REPEAT;
> > +
> > +	/* Enable ostimer interrupt first */
> > +	writel(RDA_TIMER_IRQ_MASK_SET_OSTIMER,
> > +	       rda_timer_base + RDA_TIMER_IRQ_MASK_SET);
> 
> Is it masking or enabling the interrupt?
> 

On this platform, we need to set corresponding bit in the RDA_TIMER_IRQ_MASK_SET
register to enable an interrupt.

> > +
> > +	/* Write low 32 bits first, high 24 bits are with ctrl */
> 
> You're saying that you can only write 56 bits? This contradicts the 64bt
> counter thing above.
> 
> > +	writel(load_l, rda_timer_base + RDA_OSTIMER_LOADVAL_L);
> > +	writel(ctrl, rda_timer_base + RDA_OSTIMER_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_stop(void)
> > +{
> > +	/* Disable ostimer interrupt first */
> > +	writel(0, rda_timer_base + RDA_TIMER_IRQ_MASK_SET);
> > +

Here the register should be RDA_TIMER_IRQ_MASK_CLR.

> > +	writel(0, rda_timer_base + RDA_OSTIMER_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_set_state_shutdown(struct clock_event_device *evt)
> > +{
> > +	rda_ostimer_stop();
> > +
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_set_state_oneshot(struct clock_event_device *evt)
> > +{
> > +	rda_ostimer_stop();
> > +
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_set_state_periodic(struct clock_event_device *evt)
> > +{
> > +	unsigned long cycles_per_jiffy;
> > +
> > +	rda_ostimer_stop();
> > +
> > +	cycles_per_jiffy = ((unsigned long long)NSEC_PER_SEC / HZ *
> > +			     evt->mult) >> evt->shift;
> > +	rda_ostimer_start(true, cycles_per_jiffy);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_tick_resume(struct clock_event_device *evt)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int rda_ostimer_set_next_event(unsigned long evt,
> > +				      struct clock_event_device *ev)
> > +{
> > +	rda_ostimer_start(false, evt);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct clock_event_device rda_clockevent = {
> > +	.name			= "rda-ostimer",
> > +	.rating			= 250,
> > +	.features		= CLOCK_EVT_FEAT_PERIODIC |
> > +				  CLOCK_EVT_FEAT_ONESHOT |
> > +				  CLOCK_EVT_FEAT_DYNIRQ,
> > +	.set_state_shutdown	= rda_ostimer_set_state_shutdown,
> > +	.set_state_oneshot	= rda_ostimer_set_state_oneshot,
> > +	.set_state_periodic	= rda_ostimer_set_state_periodic,
> > +	.tick_resume		= rda_ostimer_tick_resume,
> > +	.set_next_event		= rda_ostimer_set_next_event,
> > +};
> > +
> > +static irqreturn_t rda_ostimer_interrupt(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = dev_id;
> > +
> > +	/* clear timer int */
> > +	writel(RDA_TIMER_IRQ_CLR_OSTIMER, rda_timer_base + RDA_TIMER_IRQ_CLR);
> > +
> > +	if (evt->event_handler)
> > +		evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int __init rda_timer_init(struct device_node *node)
> > +{
> > +	unsigned long rate = 2000000;
> > +	int ostimer_irq, ret;
> > +
> > +	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
> > +	if (IS_ERR(rda_timer_base)) {
> > +		pr_err("Can't map timer registers");
> > +		return PTR_ERR(rda_timer_base);
> > +	}
> > +
> > +	ostimer_irq = of_irq_get_byname(node, "ostimer");
> > +	if (ostimer_irq <= 0) {
> > +		pr_err("Can't parse ostimer IRQ");
> > +		return -EINVAL;
> 
> Leaking IO space.
> 

Ack.

> > +	}
> > +
> > +	clocksource_register_hz(&rda_clocksource, rate);
> > +
> > +	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
> > +			  "rda-ostimer", &rda_clockevent);
> > +	if (ret) {
> > +		pr_err("failed to request irq %d\n", ostimer_irq);
> > +		return ret;
> 
> Same here.
> 

Ack.

> > +	}
> > +
> > +	irq_force_affinity(ostimer_irq, cpumask_of(0));
> 
> Why?
> 

Not needed, will remove it.

Thanks,
Mani

> > +
> > +	rda_clockevent.cpumask = cpumask_of(0);
> > +	rda_clockevent.irq = ostimer_irq;
> > +	clockevents_config_and_register(&rda_clockevent, rate,
> > +					0x2, 0xffffffff);
> > +
> > +	return 0;
> > +}
> > +
> > +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
> > 
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
