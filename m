Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C162D2089D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C162D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeGDOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:24:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28753 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752334AbeGDOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:24:11 -0400
X-UUID: a6af2e2d8989496cacefc2a9ac416942-20180704
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 71388901; Wed, 04 Jul 2018 22:24:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 22:24:05 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 22:24:05 +0800
Message-ID: <1530714245.17448.77.camel@mtkswgap22>
Subject: Re: [PATCH v5 5/5] clocksource/drivers/timer-mediatek: Add support
 for system timer
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 4 Jul 2018 22:24:05 +0800
In-Reply-To: <alpine.DEB.2.21.1807041108110.1816@nanos.tec.linutronix.de>
References: <1530669383-17516-1-git-send-email-stanley.chu@mediatek.com>
         <1530669383-17516-6-git-send-email-stanley.chu@mediatek.com>
         <alpine.DEB.2.21.1807041108110.1816@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 11:27 +0200, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Stanley Chu wrote:

Hi Thomas,

Thanks so much for very constructive comments.

Summary of below response,

1, Yes. System timer has a "clock enable (i.e., SYST_CON_EN)" design
which not only start timer to countdown but also be required to make
interrupt function work.

In other words, SYST_CON_EN shall be set before user changes interrupt
related registers, for example, enable or disable interrupt.

2. The driver certainly has to be optimized and redundant register
operations shall be removed.

Both things will be done in v6.

> > +/* system timer */
> > +#define SYST_CON                (0x0)
> > +#define SYST_VAL                (0x4)
> > +
> > +#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> > +#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> > +
> > +#define SYST_CON_EN              BIT(0)
> > +#define SYST_CON_IRQ_EN          BIT(1)
> > +#define SYST_CON_IRQ_CLR         BIT(4)
> > +
> > +static void __iomem *gpt_sched_reg __read_mostly;
> > +
> > +static void mtk_syst_reset(struct timer_of *to)
> > +{
> > +	/* clear and disable interrupt */
> > +	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> > +
> > +	/* reset counter */
> > +	writel(0, SYST_VAL_REG(to));
> > +
> > +	/* disable timer */
> > +	writel(0, SYST_CON_REG(to));
> 
> Not having any insight into the inner workings of that hardware. This
> sequence does not make any sense.
> 
> You first clear and disable the interrupt, but leave the counter
> running. Then you reset the counter and _after_ that you disable the
> timer.
> 
> Is that a workaround for yet another completely misdesigned piece of timer
> hardware or is it just the software implementation which makes no sense?
> 
> If it's a workaround for HW stupidity then you really want to document it
> proper.
> 
> If not then, what's wrong with doing the obvious:
> {
> 	writel(SYST_CON_IRQ_CLR, SYST_CON_REG(to));
> }

As above summary said, SYST_CON_EN shall be set to
1. Change interrupt function.
2. Allow timeout tick to be updated.

We will document those as comments in v6.

> 
> which clears the interrupt and disables the timer in one go. Writing the
> counter is not required at all because the next_event() function will write
> it again and the counter value is irrelevant once the timer is disabled.
> 
> > +static void mtk_syst_ack_irq(struct timer_of *to)
> > +{
> > +	mtk_syst_reset(to);
> > +}
> > +
> > +static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
> 
> No type casts from and to void. They are completely pointless.

Will be fixed in v6.

> 
> > +	struct timer_of *to = to_timer_of(clkevt);
> > +
> > +	mtk_syst_ack_irq(to);
> 
> So you do the full dance here.

Here full dance is not necessary and we only need to "clear and disable
interrupt".

Will be optimized in v6.

> 
> > +	clkevt->event_handler(clkevt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_syst_clkevt_next_event(unsigned long ticks,
> > +				      struct clock_event_device *clkevt)
> > +{
> > +	struct timer_of *to = to_timer_of(clkevt);
> > +
> > +	/*
> > +	 * reset timer first because we do not expect interrupt is triggered
> > +	 * by old compare value.
> > +	 */
> > +	mtk_syst_reset(to);
> 
> And here, which gets called through the event_handler.

Timer reset here is not necessary.

Will be removed in v6.

> 
> > +
> > +	writel(SYST_CON_EN, SYST_CON_REG(to));
> 
> Why are you enabling the timer _before_ setting the new counter value? This
> does not make any sense at least not w/o a comment explaining WHY this
> needs to be so convoluted.

As above response in mtk_syst_reset().

> 
> > +	writel(ticks, SYST_VAL_REG(to));
> > +
> > +	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> 
> With a sane hardware implementation the whole thing can be boiled down to:
> 
> {
> 	writel(ticks, SYST_VAL_REG(to));
> 	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> }
> 
> There is no need to do the whole reset thing, unless the hardware is
> broken. Either you manage to overwrite the timer in time or not. The extra
> work of writing the control register before that is a cosmetic 'makes me
> feel' good hack, which just makes the normal case slower. If you have an
> occasional spurious interrupt, fine, but you can get them anyway.
> 

Yes, we have reviewed reset timing and found most of them are not
necessary actually.

We will optimize driver in v6.

> Thanks,
> 
> 	tglx


Thanks,
Stanley Chu

> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek





