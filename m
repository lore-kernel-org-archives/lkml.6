Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9961DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6U5Uz2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABF82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeLLPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:08:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34956 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLLPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:07:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so6304393wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xCe3r7NYHbaE/Affh1D8jIUyvB7+n/RoYwt71OdfGRg=;
        b=j6U5Uz2HK7cli+A2EEdZh+TgoVHaGIt/vdqS0BUzm5o69dnvwHBryi8Df4nj5Y541U
         HhhnTR3InBwiiGQ9DPd3zPR10O3ArxPYx6HahqRM6/s1KGCs3epODeaBmzr+CRC3buKk
         ywKQCG/07I6zWyZcpAKEVpAmkcSiKRk1jVLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCe3r7NYHbaE/Affh1D8jIUyvB7+n/RoYwt71OdfGRg=;
        b=IQNwsJKdq1NsvCq8GAW05oYp5gRfCR/kR3ufs5jXdnltiRVYGxVz++OCM5Rci9XWxa
         RWh9a2EchGdieaysvLFLdxvFN1n7ghJgtdpvmKymKzkOn4lB/sAp6BBHSETfIssuukx6
         fjvYiV72yvet0plWxSQrKbLQIBPVMM6v1NQDw31HJTh7Nen9pLmoDX03PvyRViSwCjzK
         pmeNNZv7RL7WHf6O+aYaHPt/do+nuceFbX3cONYHZh5ZTq1PWGLVLXPMx3UTASufw/QA
         nhaHFkaJ2dBHYWCZZizTJEA9u3aow395Wzi5nD3F2qWKOGoLrg9Gnf7qMGtdQRms3dNy
         ky2Q==
X-Gm-Message-State: AA+aEWZ8pqxscfF/twoRnDTn9TEHoferk9VqNNApKMGoCSpIpdhS8If+
        DRCsyE2fGPhjYsu0Hzbgc7Sdjg==
X-Google-Smtp-Source: AFSGD/W1emCBqvHFjDT1zEPtEKrCPHR5lKyELWEKzyTma1UJkykg0BwdovLckJyLPgB+tndCcYxIcA==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr6300407wme.94.1544627275579;
        Wed, 12 Dec 2018 07:07:55 -0800 (PST)
Received: from [192.168.0.40] (73.150.94.92.rev.sfr.net. [92.94.150.73])
        by smtp.googlemail.com with ESMTPSA id 133sm2964415wme.9.2018.12.12.07.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 07:07:54 -0800 (PST)
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
Date:   Wed, 12 Dec 2018 16:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 18:35, Manivannan Sadhasivam wrote:
> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> and HWTIMER.
> 
> RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER
> (64 bit). Each timer provides optional interrupt support. In this
> driver, OSTIMER is used for clockevents and HWTIMER is used for
> clocksource.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The driver looks good to me. Do you want me to pick it up via my tree?

> ---
>  drivers/clocksource/Kconfig     |   8 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/timer-rda.c | 195 ++++++++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/clocksource/timer-rda.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 55c77e44bb2d..598b592e03d7 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -105,6 +105,14 @@ config OWL_TIMER
>  	help
>  	  Enables the support for the Actions Semi Owl timer driver.
>  
> +config RDA_TIMER
> +	bool "RDA timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
> +	select CLKSRC_MMIO
> +	select TIMER_OF
> +	help
> +	  Enables the support for the RDA Micro timer driver.
> +
>  config SUN4I_TIMER
>  	bool "Sun4i timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd9138104568..150020a90707 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
>  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
>  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
>  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
> +obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
>  
>  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
> new file mode 100644
> index 000000000000..fd1199c189bf
> --- /dev/null
> +++ b/drivers/clocksource/timer-rda.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RDA8810PL SoC timer driver
> + *
> + * Copyright RDA Microelectronics Company Limited
> + * Copyright (c) 2017 Andreas Färber
> + * Copyright (c) 2018 Manivannan Sadhasivam
> + *
> + * RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER (64 bit).
> + * Each timer provides optional interrupt support. In this driver, OSTIMER is
> + * used for clockevents and HWTIMER is used for clocksource.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +
> +#include "timer-of.h"
> +
> +#define RDA_OSTIMER_LOADVAL_L	0x000
> +#define RDA_OSTIMER_CTRL	0x004
> +#define RDA_HWTIMER_LOCKVAL_L	0x024
> +#define RDA_HWTIMER_LOCKVAL_H	0x028
> +#define RDA_TIMER_IRQ_MASK_SET	0x02c
> +#define RDA_TIMER_IRQ_MASK_CLR	0x030
> +#define RDA_TIMER_IRQ_CLR	0x034
> +
> +#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
> +#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
> +#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
> +
> +#define RDA_TIMER_IRQ_MASK_OSTIMER	BIT(0)
> +
> +#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
> +
> +static int rda_ostimer_start(void __iomem *base, bool periodic, u64 cycles)
> +{
> +	u32 ctrl, load_l;
> +
> +	load_l = (u32)cycles;
> +	ctrl = ((cycles >> 32) & 0xffffff);
> +	ctrl |= RDA_OSTIMER_CTRL_LOAD | RDA_OSTIMER_CTRL_ENABLE;
> +	if (periodic)
> +		ctrl |= RDA_OSTIMER_CTRL_REPEAT;
> +	/* Enable ostimer interrupt first */
> +	writel_relaxed(RDA_TIMER_IRQ_MASK_OSTIMER,
> +		       base + RDA_TIMER_IRQ_MASK_SET);
> +
> +	/* Write low 32 bits first, high 24 bits are with ctrl */
> +	writel_relaxed(load_l, base + RDA_OSTIMER_LOADVAL_L);
> +	writel_relaxed(ctrl, base + RDA_OSTIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_stop(void __iomem *base)
> +{
> +	/* Disable ostimer interrupt first */
> +	writel_relaxed(RDA_TIMER_IRQ_MASK_OSTIMER,
> +		       base + RDA_TIMER_IRQ_MASK_CLR);
> +
> +	writel_relaxed(0, base + RDA_OSTIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	struct timer_of *to = to_timer_of(evt);
> +
> +	rda_ostimer_stop(timer_of_base(to));
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	struct timer_of *to = to_timer_of(evt);
> +
> +	rda_ostimer_stop(timer_of_base(to));
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_periodic(struct clock_event_device *evt)
> +{
> +	struct timer_of *to = to_timer_of(evt);
> +	unsigned long cycles_per_jiffy;
> +
> +	rda_ostimer_stop(timer_of_base(to));
> +
> +	cycles_per_jiffy = ((unsigned long long)NSEC_PER_SEC / HZ *
> +			     evt->mult) >> evt->shift;
> +	rda_ostimer_start(timer_of_base(to), true, cycles_per_jiffy);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_tick_resume(struct clock_event_device *evt)
> +{
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_next_event(unsigned long evt,
> +				      struct clock_event_device *ev)
> +{
> +	struct timer_of *to = to_timer_of(ev);
> +
> +	rda_ostimer_start(timer_of_base(to), false, evt);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rda_ostimer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +	struct timer_of *to = to_timer_of(evt);
> +
> +	/* clear timer int */
> +	writel_relaxed(RDA_TIMER_IRQ_CLR_OSTIMER,
> +		       timer_of_base(to) + RDA_TIMER_IRQ_CLR);
> +
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct timer_of rda_ostimer_of = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE,
> +
> +	.clkevt = {
> +		.name = "rda-ostimer",
> +		.rating = 250,
> +		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> +			    CLOCK_EVT_FEAT_DYNIRQ,
> +		.set_state_shutdown = rda_ostimer_set_state_shutdown,
> +		.set_state_oneshot = rda_ostimer_set_state_oneshot,
> +		.set_state_periodic = rda_ostimer_set_state_periodic,
> +		.tick_resume = rda_ostimer_tick_resume,
> +		.set_next_event	= rda_ostimer_set_next_event,
> +	},
> +
> +	.of_base = {
> +		.name = "rda-timer",
> +		.index = 0,
> +	},
> +
> +	.of_irq = {
> +		.name = "ostimer",
> +		.handler = rda_ostimer_interrupt,
> +		.flags = IRQF_TIMER,
> +	},
> +};
> +
> +static u64 rda_hwtimer_read(struct clocksource *cs)
> +{
> +	void __iomem *base = timer_of_base(&rda_ostimer_of);
> +	u32 lo, hi;
> +
> +	/* Always read low 32 bits first */
> +	do {
> +		lo = readl_relaxed(base + RDA_HWTIMER_LOCKVAL_L);
> +		hi = readl_relaxed(base + RDA_HWTIMER_LOCKVAL_H);
> +	} while (hi != readl_relaxed(base + RDA_HWTIMER_LOCKVAL_H));
> +
> +	return ((u64)hi << 32) | lo;
> +}
> +
> +static struct clocksource rda_hwtimer_clocksource = {
> +	.name           = "rda-timer",
> +	.rating         = 400,
> +	.read           = rda_hwtimer_read,
> +	.mask           = CLOCKSOURCE_MASK(64),
> +	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int __init rda_timer_init(struct device_node *np)
> +{
> +	unsigned long rate = 2000000;
> +	int ret;
> +
> +	ret = timer_of_init(np, &rda_ostimer_of);
> +	if (ret)
> +		return ret;
> +
> +	clocksource_register_hz(&rda_hwtimer_clocksource, rate);
> +
> +	clockevents_config_and_register(&rda_ostimer_of.clkevt, rate,
> +					0x2, UINT_MAX);
> +
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

