Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7A6208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQjwHXAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7A6208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbeGJQUR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:20:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55374 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934422AbeGJQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:20:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id v128-v6so7652469wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7uU9MMUzkKZhqF3UjOFvASNrGD77xJElxezfbVru80=;
        b=aQjwHXAbl/GnBybm7oNxRKvS+Y2PFdy/rCMFSwFhQcP8a6TPQb53cvz4S7Q8l6w1Wc
         LB+jOovtoGeuN5C1tw+QygSZh7D/KPAsUTRdl8btYnS6N/GB+RjvwaZgUrzO8RMxxir8
         K6hn2nBROEvBWwp3Fwb1miuEmAq8cQdi2NHjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7uU9MMUzkKZhqF3UjOFvASNrGD77xJElxezfbVru80=;
        b=fi7e3r3ShaSIAF64gbPmE3UztHTpdLOxb8+p68oDQ7p1XYHdl58Z+1W30vKJvuJIKL
         sBB4WhFxG0iKjBni3mFiz99hHVegd/sVfFluH3v4AxgQnduUJ0T7KYJnBQ8bSlq0vLUH
         krZ+d5ktnUpQnaa76fOui0gzdz9A2VzPWNnv7rtpcUtYEkys6FiU2a8ZbbZpidKM7HGC
         ishoMFWyqkCQDxl3EmCPdo9cWpdWFDu/q8uEKyJ/N5CCwOf832VnCwClD0/fJ457d5o+
         8nBJxOUcdUi+IsJMbwvr7vUymsAEVUITl/QYzS5iwt81mdz4f8Ox1B2b4Sq3hZFnTsuf
         CNKQ==
X-Gm-Message-State: AOUpUlGMIectEM6Aa0+guVGULAcgr9sKM9jpF1CNjidBzSbJcWwd6IGd
        hnrZN6+UX/nklC+JDsv3Dm46aQ==
X-Google-Smtp-Source: AAOMgpdvhdK24dOqayilhxCA4vuRWU9Lq7+Ut0/Hy+7ckGy4ONxerNlvMF21zkNqm2bNeJhi2wXIew==
X-Received: by 2002:a1c:9b43:: with SMTP id d64-v6mr4300190wme.109.1531239613227;
        Tue, 10 Jul 2018 09:20:13 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.242.72])
        by smtp.googlemail.com with ESMTPSA id o4-v6sm33315262wra.3.2018.07.10.09.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:20:12 -0700 (PDT)
Subject: Re: [PATCH v7 4/5] clocksource: add driver for i.MX EPIT timer
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <20180611155001.3506-5-peron.clem@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <27e8d6f0-b415-f31e-ae89-0b35397d0cf2@linaro.org>
Date:   Tue, 10 Jul 2018 18:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611155001.3506-5-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 17:50, Clément Péron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add driver for NXP's EPIT timer used in i.MX SoC.

Give a description on how works this timer.


> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Tested-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/clocksource/Kconfig          |  11 ++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-imx-epit.c | 265 +++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/clocksource/timer-imx-epit.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 8e8a09755d10..790478afd02c 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -576,6 +576,17 @@ config H8300_TPU
>  	  This enables the clocksource for the H8300 platform with the
>  	  H8S2678 cpu.
>  
> +config CLKSRC_IMX_EPIT
> +	bool "Clocksource using i.MX EPIT"
> +	depends on CLKDEV_LOOKUP && (ARCH_MXC || COMPILE_TEST)
> +	select CLKSRC_MMIO
> +	help
> +	  This enables EPIT support available on some i.MX platforms.
> +	  Normally you don't have a reason to do so as the EPIT has
> +	  the same features and uses the same clocks as the GPT.
> +	  Anyway, on some systems the GPT may be in use for other
> +	  purposes.
> +
>  config CLKSRC_IMX_GPT
>  	bool "Clocksource using i.MX GPT" if COMPILE_TEST
>  	depends on ARM && CLKDEV_LOOKUP
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 00caf37e52f9..d9426f69ec69 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
>  obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
>  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
>  obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
> +obj-$(CONFIG_CLKSRC_IMX_EPIT)		+= timer-imx-epit.o
>  obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
>  obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
>  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
> diff --git a/drivers/clocksource/timer-imx-epit.c b/drivers/clocksource/timer-imx-epit.c
> new file mode 100644
> index 000000000000..7f1c8e2e00aa
> --- /dev/null
> +++ b/drivers/clocksource/timer-imx-epit.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX EPIT Timer
> + *
> + * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
> + * Copyright (C) 2018 Clément Péron <clement.peron@devialet.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +
> +#define EPITCR				0x00
> +#define EPITSR				0x04
> +#define EPITLR				0x08
> +#define EPITCMPR			0x0c
> +#define EPITCNR				0x10
> +
> +#define EPITCR_EN			BIT(0)
> +#define EPITCR_ENMOD			BIT(1)
> +#define EPITCR_OCIEN			BIT(2)
> +#define EPITCR_RLD			BIT(3)
> +#define EPITCR_PRESC(x)			(((x) & 0xfff) << 4)
> +#define EPITCR_SWR			BIT(16)
> +#define EPITCR_IOVW			BIT(17)
> +#define EPITCR_DBGEN			BIT(18)
> +#define EPITCR_WAITEN			BIT(19)
> +#define EPITCR_RES			BIT(20)
> +#define EPITCR_STOPEN			BIT(21)
> +#define EPITCR_OM_DISCON		(0 << 22)
> +#define EPITCR_OM_TOGGLE		(1 << 22)
> +#define EPITCR_OM_CLEAR			(2 << 22)
> +#define EPITCR_OM_SET			(3 << 22)
> +#define EPITCR_CLKSRC_OFF		(0 << 24)
> +#define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
> +#define EPITCR_CLKSRC_REF_HIGH		(2 << 24)
> +#define EPITCR_CLKSRC_REF_LOW		(3 << 24)
> +
> +#define EPITSR_OCIF			BIT(0)
> +
> +struct epit_timer {
> +	void __iomem *base;
> +	int irq;
> +	struct clk *clk;
> +	struct clock_event_device ced;
> +	struct irqaction act;
> +};
> +
> +static void __iomem *sched_clock_reg;
> +
> +static inline struct epit_timer *to_epit_timer(struct clock_event_device *ced)
> +{
> +	return container_of(ced, struct epit_timer, ced);
> +}
> +
> +static inline void epit_irq_disable(struct epit_timer *epittm)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(epittm->base + EPITCR);
> +	writel_relaxed(val & ~EPITCR_OCIEN, epittm->base + EPITCR);
> +}
> +
> +static inline void epit_irq_enable(struct epit_timer *epittm)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(epittm->base + EPITCR);
> +	writel_relaxed(val | EPITCR_OCIEN, epittm->base + EPITCR);
> +}
> +
> +static void epit_irq_acknowledge(struct epit_timer *epittm)
> +{
> +	writel_relaxed(EPITSR_OCIF, epittm->base + EPITSR);
> +}
> +
> +static u64 notrace epit_read_sched_clock(void)
> +{
> +	return ~readl_relaxed(sched_clock_reg);
> +}
> +
> +static int epit_set_next_event(unsigned long cycles,
> +			       struct clock_event_device *ced)
> +{
> +	struct epit_timer *epittm = to_epit_timer(ced);
> +	unsigned long tcmp;
> +
> +	tcmp = readl_relaxed(epittm->base + EPITCNR) - cycles;
> +	writel_relaxed(tcmp, epittm->base + EPITCMPR);
> +
> +	return 0;
> +}
> +
> +/* Left event sources disabled, no more interrupts appear */
> +static int epit_shutdown(struct clock_event_device *ced)
> +{
> +	struct epit_timer *epittm = to_epit_timer(ced);
> +	unsigned long flags;
> +
> +	/*
> +	 * The timer interrupt generation is disabled at least
> +	 * for enough time to call epit_set_next_event()
> +	 */
> +	local_irq_save(flags);

This is not necessary. This function is called with interrupt disabled.

> +	/* Disable interrupt in EPIT module */
> +	epit_irq_disable(epittm);
> +
> +	/* Clear pending interrupt */
> +	epit_irq_acknowledge(epittm);

No irq ack is needed here. Neither disabling the interrupt.

Why not just stop the counter ?

> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static int epit_set_oneshot(struct clock_event_device *ced)
> +{
> +	struct epit_timer *epittm = to_epit_timer(ced);
> +	unsigned long flags;
> +
> +	/*
> +	 * The timer interrupt generation is disabled at least
> +	 * for enough time to call epit_set_next_event()
> +	 */
> +	local_irq_save(flags);

This is not necessary. This function is called with interrupt disabled.

> +	/* Disable interrupt in EPIT module */
> +	epit_irq_disable(epittm);
> +
> +	/* Clear pending interrupt, only while switching mode */
> +	if (!clockevent_state_oneshot(ced))
> +		epit_irq_acknowledge(epittm);

Why do you need to ack the interrupt here ?

> +	/*
> +	 * Do not put overhead of interrupt enable/disable into
> +	 * epit_set_next_event(), the core has about 4 minutes
> +	 * to call epit_set_next_event() or shutdown clock after
> +	 * mode switching
> +	 */
> +	epit_irq_enable(epittm);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *ced = dev_id;
> +	struct epit_timer *epittm = to_epit_timer(ced);
> +
> +	epit_irq_acknowledge(epittm);
> +
> +	ced->event_handler(ced);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init epit_clocksource_init(struct epit_timer *epittm)
> +{
> +	unsigned int c = clk_get_rate(epittm->clk);
> +
> +	sched_clock_reg = epittm->base + EPITCNR;
> +	sched_clock_register(epit_read_sched_clock, 32, c);
> +
> +	return clocksource_mmio_init(epittm->base + EPITCNR, "epit", c, 200, 32,
> +				     clocksource_mmio_readl_down);
> +}
> +
> +static int __init epit_clockevent_init(struct epit_timer *epittm)
> +{
> +	struct clock_event_device *ced = &epittm->ced;
> +	struct irqaction *act = &epittm->act;
> +
> +	ced->name = "epit";
> +	ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
> +	ced->set_state_shutdown = epit_shutdown;
> +	ced->tick_resume = epit_shutdown;
> +	ced->set_state_oneshot = epit_set_oneshot;
> +	ced->set_next_event = epit_set_next_event;
> +	ced->rating = 200;
> +	ced->cpumask = cpumask_of(0);
> +	ced->irq = epittm->irq;
> +	clockevents_config_and_register(ced, clk_get_rate(epittm->clk),
> +					0xff, 0xfffffffe);
> +
> +	act->name = "i.MX EPIT Timer Tick",
> +	act->flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	act->handler = epit_timer_interrupt;
> +	act->dev_id = ced;
> +
> +	/* Make irqs happen */
> +	return setup_irq(epittm->irq, act);
> +}
> +
> +static int __init epit_timer_init(struct device_node *np)
> +{
> +	struct epit_timer *epittm;
> +	int ret;
> +
> +	epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
> +	if (!epittm)
> +		return -ENOMEM;
> +
> +	epittm->base = of_iomap(np, 0);
> +	if (!epittm->base) {
> +		ret = -ENXIO;
> +		goto out_kfree;
> +	}
> +
> +	epittm->irq = irq_of_parse_and_map(np, 0);
> +	if (!epittm->irq) {
> +		ret = -EINVAL;
> +		goto out_iounmap;
> +	}
> +
> +	/* Get EPIT clock */
> +	epittm->clk = of_clk_get(np, 0);
> +	if (IS_ERR(epittm->clk)) {
> +		pr_err("i.MX EPIT: unable to get clk\n");
> +		ret = PTR_ERR(epittm->clk);
> +		goto out_iounmap;
> +	}
> +
> +	ret = clk_prepare_enable(epittm->clk);
> +	if (ret) {
> +		pr_err("i.MX EPIT: unable to prepare+enable clk\n");
> +		goto out_iounmap;
> +	}

Please replace all the above with the timer-of API as:

https://patchwork.kernel.org/patch/10510443/


> +	/* Initialise to a known state (all timers off, and timing reset) */
> +	writel_relaxed(0x0, epittm->base + EPITCR);
> +	writel_relaxed(0xffffffff, epittm->base + EPITLR);
> +	writel_relaxed(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
> +		       epittm->base + EPITCR);
> +
> +	ret = epit_clocksource_init(epittm);
> +	if (ret) {
> +		pr_err("i.MX EPIT: failed to init clocksource\n");
> +		goto out_clk_disable;
> +	}
> +
> +	ret = epit_clockevent_init(epittm);
> +	if (ret) {
> +		pr_err("i.MX EPIT: failed to init clockevent\n");
> +		goto out_clk_disable;
> +	}
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable_unprepare(epittm->clk);
> +out_iounmap:
> +	iounmap(epittm->base);
> +out_kfree:
> +	kfree(epittm);
> +
> +	return ret;
> +}
> +TIMER_OF_DECLARE(epit_timer, "fsl,imx31-epit", epit_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

