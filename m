Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29537C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC7D2722A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC7D2722A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbeF1KdG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:33:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6933 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932246AbeF1KdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:33:04 -0400
X-UUID: 0dee3c4d8f244f248709a9fafb5400bb-20180628
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1231348746; Thu, 28 Jun 2018 18:32:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 18:32:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 18:32:56 +0800
Message-ID: <1530181976.17448.45.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support
 for Mediatek SoCs
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 28 Jun 2018 18:32:56 +0800
In-Reply-To: <8cff2306-ba78-a537-599e-14a4363ed71d@linaro.org>
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
         <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
         <8cff2306-ba78-a537-599e-14a4363ed71d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 12:01 +0200, Daniel Lezcano wrote:
> On 27/06/2018 09:53, Stanley Chu wrote:
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
> > The interrupts are shared between the different timers.
> > We just enable one interrupt for the clock event. The clock
> > event timer is used by all cores.
> > 
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > ---
> >  drivers/clocksource/Kconfig        |   13 +++-
> >  drivers/clocksource/Makefile       |    1 +
> >  drivers/clocksource/mtk_systimer.c |  132 ++++++++++++++++++++++++++++++++++++
> 
> Please merge mtk_systimer.c and mtk_timer.c into a single file:
> 
> timer-mediatek.c
> 
> Patch 1:
> 
>  git mv mtk_timer.c timer-mediatek.c
>  Change the name in Makefile
> 
> Patch 2:
> 
>  Change function prefix name to _gpt_
> 
> Patch 2.1 [optional but recommended] :
> 
>  Move the gpt's init code to timer-of
> 
> Patch 3:
> 
>  Add code for syst in timer-mediatek.c
> 

Thanks for suggestion.
Will do above all in v3.

> 
> 
> A couple of comments below.
> 
> >  3 files changed, 144 insertions(+), 2 deletions(-)
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
> > index 0000000..77161bb
> > --- /dev/null
> > +++ b/drivers/clocksource/mtk_systimer.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +//  Copyright (C) 2018 MediaTek Inc.
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/io.h>
> > +#include "timer-of.h"
> > +
> > +/* registers */
> > +#define STMR_CON                  (0x0)
> > +#define STMR_VAL                  (0x4)
> > +
> > +#define TIMER_REG_CON(to)         (timer_of_base(to) + STMR_CON)
> > +#define TIMER_REG_VAL(to)         (timer_of_base(to) + STMR_VAL)
> > +
> > +/* STMR_CON */
> > +#define STMR_CON_EN               BIT(0)
> > +#define STMR_CON_IRQ_EN           BIT(1)
> > +#define STMR_CON_IRQ_CLR          BIT(4)
> > +
> > +#define TIMER_SYNC_TICKS          3
> > +
> > +static void mtk_stmr_reset(struct timer_of *to)
> > +{
> > +	/* Clear IRQ */
> > +	writel(STMR_CON_IRQ_CLR | STMR_CON_EN, TIMER_REG_CON(to));
> > +
> > +	/* Reset counter */
> > +	writel(0, TIMER_REG_VAL(to));
> > +
> > +	/* Disable timer */
> > +	writel(0, TIMER_REG_CON(to));
> 
> Wouldn't make sense to clear the interrupt after disabling the timer ?
> 
The comment may mislead readers.

The first step, we do both things in the same time,
1. Clear interrupt status.
2. Disable interrupt engine in timer hardware, so the interrupt cannot
come repeatedly.

After that, we shall be safe enough to do followings.

> > +}
> > +
> > +static void mtk_stmr_ack_irq(struct timer_of *to)
> > +{
> > +	mtk_stmr_reset(to);
> > +}
> > +
> > +static irqreturn_t mtk_stmr_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
> > +	struct timer_of *to = to_timer_of(clkevt);
> > +
> > +	mtk_stmr_ack_irq(to);
> > +	clkevt->event_handler(clkevt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_stmr_clkevt_next_event(unsigned long ticks,
> > +				      struct clock_event_device *clkevt)
> > +{
> > +	struct timer_of *to = to_timer_of(clkevt);
> > +
> > +	/*
> > +	 * reset timer first because we do not expect interrupt is triggered
> > +	 * by old compare value.
> > +	 */
> > +	mtk_stmr_reset(to);
> > +
> > +	writel(STMR_CON_EN, TIMER_REG_CON(to));
> > +
> > +	writel(ticks, TIMER_REG_VAL(to));
> > +
> > +	writel(STMR_CON_EN | STMR_CON_IRQ_EN, TIMER_REG_CON(to));
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_stmr_clkevt_shutdown(struct clock_event_device *clkevt)
> > +{
> > +	mtk_stmr_reset(to_timer_of(clkevt));
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_stmr_clkevt_resume(struct clock_event_device *clkevt)
> > +{
> > +	return mtk_stmr_clkevt_shutdown(clkevt);
> > +}
> > +
> > +static int mtk_stmr_clkevt_oneshot(struct clock_event_device *clkevt)
> > +{
> > +	return 0;
> > +}
> > +
> > +static struct timer_of to = {
> > +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> > +
> > +	.clkevt = {
> > +		.name = "mtk-clkevt",
> > +		.rating = 300,
> > +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
> > +		.set_state_shutdown = mtk_stmr_clkevt_shutdown,
> > +		.set_state_oneshot = mtk_stmr_clkevt_oneshot,
> > +		.tick_resume = mtk_stmr_clkevt_resume,
> > +		.set_next_event = mtk_stmr_clkevt_next_event,
> > +		.cpumask = cpu_possible_mask,
> > +	},
> > +
> > +	.of_irq = {
> > +		.handler = mtk_stmr_handler,
> > +		.flags = IRQF_TIMER | IRQF_IRQPOLL | IRQF_TRIGGER_HIGH |
> 
> Why do you need IRQF_TRIGGER_HIGH ?
> 
> > +			 IRQF_PERCPU,
> 
> Why IRQF_PERCPU ?
> 

Both flags are wrong and will be removed.

> > +	},
> > +};
> > +
> > +static int __init mtk_stmr_init(struct device_node *node)
> > +{
> > +	int ret;
> > +
> > +	ret = timer_of_init(node, &to);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mtk_stmr_reset(&to);
> > +
> > +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> > +					TIMER_SYNC_TICKS, 0xffffffff);
> > +
> > +	pr_info("mtk_stmr: irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
> > +		timer_of_irq(&to), timer_of_rate(&to),
> > +		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);
> > +
> > +	return ret;
> > +}
> > +
> > +TIMER_OF_DECLARE(mtk_systimer, "mediatek,sys_timer", mtk_stmr_init);
> 
> No "mediatek,sys_timer" but eg. "mediatek,mt6765", so it is consistent
> with the DT binding.

We will sort out bindings of these two timers in v3.

> 
> 

Thanks.
Stanley Chu

