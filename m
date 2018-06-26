Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0801226844
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801226844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbeFZJwh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:52:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19110 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933294AbeFZJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:52:34 -0400
X-UUID: 2a7dafb517654147ae899a62eb796b07-20180626
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1356940267; Tue, 26 Jun 2018 17:52:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 26 Jun 2018 17:52:28 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 26 Jun 2018 17:52:28 +0800
Message-ID: <1530006748.17448.33.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] clocksource/drivers/mtk_systimer: Add support for
 Mediatek SoCs
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 26 Jun 2018 17:52:28 +0800
In-Reply-To: <47b8aaab-98f3-8429-961c-fdcdc2c11a41@linaro.org>
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
         <1529910601-15005-3-git-send-email-stanley.chu@mediatek.com>
         <47b8aaab-98f3-8429-961c-fdcdc2c11a41@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 09:41 +0200, Daniel Lezcano wrote:
> On 25/06/2018 09:10, Stanley Chu wrote:
> > This patch adds a new clock event for the timer
> > found on the Mediatek SoCs.
> > 
> > The Mediatek System Timer has several 32-bit timers.
> > Only one timer is used by this driver as a clock event
> > supporting oneshot events.
> > 
> > The System Timer can be run with two clocks. A 13 MHz system
> > clock and the RTC clock running at 32 KHz. This implementation
> > uses the system clock with no clock source divider.
> > 
> > The interrupts are shared between the different timers.
> > We just enable one interrupt for the clock event. The clock
> > event timer is used by all cores.
> > 
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > ---
> >  drivers/clocksource/Kconfig        |   13 ++-
> >  drivers/clocksource/Makefile       |    1 +
> >  drivers/clocksource/mtk_systimer.c |  177 ++++++++++++++++++++++++++++++++++++
> >
> 
> >  3 files changed, 189 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/clocksource/mtk_systimer.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index dec0dd8..362c110 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -442,12 +442,21 @@ config SYS_SUPPORTS_SH_CMT
> >          bool
> >  
> >  config MTK_TIMER
> > -	bool "Mediatek timer driver" if COMPILE_TEST
> > +	bool "Mediatek general purpose timer driver" if COMPILE_TEST
> >  	depends on HAS_IOMEM
> >  	select TIMER_OF
> >  	select CLKSRC_MMIO
> >  	help
> > -	  Support for Mediatek timer driver.
> > +	  Support for Mediatek General Purpose Timer (GPT) driver.
> > +
> > +config MTK_TIMER_SYSTIMER
> > +	bool "Mediatek system timer driver" if COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	select TIMER_OF
> > +	select CLKSRC_MMIO
> > +	help
> > +	  Support for Mediatek System Timer (sys_timer) driver used as
> > +	  a clock event supporting oneshot events.
> >  
> >  config SPRD_TIMER
> >  	bool "Spreadtrum timer driver" if EXPERT
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index 00caf37..cdd34b2 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
> >  obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
> >  obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
> >  obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
> > +obj-$(CONFIG_MTK_TIMER_SYSTIMER)	+= mtk_systimer.o
> >  obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
> >  obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
> >  obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
> > diff --git a/drivers/clocksource/mtk_systimer.c b/drivers/clocksource/mtk_systimer.c
> > new file mode 100644
> > index 0000000..06e74ce
> > --- /dev/null
> > +++ b/drivers/clocksource/mtk_systimer.c
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +//  Copyright (C) 2018 MediaTek Inc.
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <clocksource/arm_arch_timer.h>
> 
> Do a cleanup with the headers. They are not all necessary.
> 
> > +#define STMR_CLKEVT_DEFAULT_RATE  (13000000)
> > +
> > +/* registers */
> > +#define STMR_CON                  (0x0)
> > +#define STMR_VAL                  (0x4)
> > +
> > +/* STMR_CON */
> > +#define STMR_CON_EN               BIT(0)
> > +#define STMR_CON_IRQ_EN           BIT(1)
> > +#define STMR_CON_IRQ_CLR          BIT(4)
> > +
> > +struct mtk_stmr_clkevt_device {
> > +	void __iomem *base;
> > +	struct clock_event_device dev;
> > +};
> 
> Use the timer_of structure, that will save you some lines of code as
> well as redundant structure definition.
> 
> > +static inline struct mtk_stmr_clkevt_device*
> > +	to_mtk_clkevt_device(struct clock_event_device *c)> +{
> > +	return container_of(c, struct mtk_stmr_clkevt_device, dev);
> > +}
> > +
> > +static void mtk_stmr_reset(struct mtk_stmr_clkevt_device *evt)
> > +{
> > +	/* Clear IRQ */
> > +	writel(STMR_CON_IRQ_CLR | STMR_CON_EN, evt->base + STMR_CON);
> > +
> > +	/* Reset counter */
> > +	writel(0, evt->base + STMR_VAL);
> > +
> > +	/* Disable timer */
> > +	writel(0, evt->base + STMR_CON);
> > +}
> > +
> > +static void mtk_stmr_ack_irq(struct mtk_stmr_clkevt_device *evt)
> > +{
> > +	mtk_stmr_reset(evt);
> > +}
> > +
> > +static irqreturn_t mtk_stmr_handler(int irq, void *priv)
> > +{
> > +	struct mtk_stmr_clkevt_device *evt = priv;
> > +
> > +	mtk_stmr_ack_irq(evt);
> > +	evt->dev.event_handler(&evt->dev);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_stmr_clkevt_next_event(unsigned long ticks,
> > +				      struct clock_event_device *dev)
> 
> Indent.
> 
> > +{
> > +	struct mtk_stmr_clkevt_device *evt = to_mtk_clkevt_device(dev);
> > +
> > +	/*
> > +	 * reset timer first because we do not expect interrupt is triggered
> > +	 * by old compare value.
> > +	 */
> > +	mtk_stmr_reset(evt);
> > +
> > +	writel(STMR_CON_EN, evt->base + STMR_CON);
> > +
> > +	writel(ticks, evt->base + STMR_VAL);
> > +
> > +	writel(STMR_CON_EN | STMR_CON_IRQ_EN, evt->base + STMR_CON);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_stmr_clkevt_shutdown(struct clock_event_device *dev)
> > +{
> > +	struct mtk_stmr_clkevt_device *evt = to_mtk_clkevt_device(dev);
> > +
> > +	mtk_stmr_reset(evt);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_stmr_clkevt_resume(struct clock_event_device *clk)
> > +{
> > +	return mtk_stmr_clkevt_shutdown(clk);
> > +}
> > +
> > +static int mtk_stmr_clkevt_oneshot(struct clock_event_device *clk)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int __init mtk_stmr_init(struct device_node *node)
> > +{
> > +	struct mtk_stmr_clkevt_device *evt;
> > +	struct resource res;
> > +	u32 freq;
> > +
> > +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> > +	if (!evt)
> > +		return -ENOMEM;
> > +
> > +	evt->dev.name = "mtk-clkevt";
> > +	evt->dev.shift = 32;
> > +	evt->dev.rating = 300;
> > +	evt->dev.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
> > +	evt->dev.set_state_shutdown = mtk_stmr_clkevt_shutdown;
> > +	evt->dev.set_state_oneshot = mtk_stmr_clkevt_oneshot;
> > +	evt->dev.tick_resume = mtk_stmr_clkevt_resume;
> > +	evt->dev.set_next_event = mtk_stmr_clkevt_next_event;
> > +	evt->dev.cpumask = cpu_possible_mask;
> > +
> > +	evt->base = of_iomap(node, 0);
> > +	if (IS_ERR(evt->base)) {
> > +		pr_err("Can't get resource\n");
> > +		goto err_kzalloc;
> > +	}
> > +
> > +	mtk_stmr_reset(evt);
> > +
> > +	evt->dev.irq = irq_of_parse_and_map(node, 0);
> > +	if (evt->dev.irq <= 0) {
> > +		pr_err("Can't parse IRQ\n");
> > +		goto err_mem;
> > +	}
> > +
> > +	if (of_property_read_u32(node, "clock-frequency", &freq)) {
> > +		pr_err("Can't get clk rate\n");
> > +		freq = STMR_CLKEVT_DEFAULT_RATE;
> > +	}
> > +
> > +	evt->dev.mult = div_sc(freq, NSEC_PER_SEC, evt->dev.shift);
> > +	evt->dev.max_delta_ns = clockevent_delta2ns(0xffffffff, &evt->dev);
> > +	evt->dev.min_delta_ns = clockevent_delta2ns(3, &evt->dev);
> > +
> > +	clockevents_register_device(&evt->dev);
> > +
> > +	if (request_irq(evt->dev.irq, mtk_stmr_handler,
> > +			IRQF_TIMER | IRQF_IRQPOLL |
> > +			IRQF_TRIGGER_HIGH | IRQF_PERCPU,
> > +			"mtk-clkevt", evt)) {
> > +		pr_err("failed to setup irq %d\n", evt->dev.irq);
> > +		goto err_mem;
> > +	}
> > +
> 
> Remove all the above by using:
> 
>         ret = timer_of_init(node, &to);
>         if (ret)
>                 return ret;
> 
> 
> > +	pr_info("mtk_stmr: base=0x%lx, irq=%d, freq=%d, hz=%d\n",
> > +		(unsigned long)evt->base, evt->dev.irq, freq, HZ);
> > +
> > +	return 0;
> > +
> > +err_mem:
> > +	iounmap(evt->base);
> > +	of_address_to_resource(node, 0, &res);
> > +	release_mem_region(res.start, resource_size(&res));
> > +err_kzalloc:
> > +	kfree(evt);
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +TIMER_OF_DECLARE(mtk_systimer, "mediatek,sys_timer", mtk_stmr_init);
> > 
> 
> 
Hi Daniel,

Good suggestion for timer_of structure! We will use it and fix above all
in v2.

Thanks.
Stanley Chu

