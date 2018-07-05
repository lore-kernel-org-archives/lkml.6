Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711EBC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476624148
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2476624148
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeGEBEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:04:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4133 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752957AbeGEBEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:04:12 -0400
X-UUID: 22e00c850b134c1fbb768d97d8bc2f45-20180705
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 427529456; Thu, 05 Jul 2018 09:04:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 5 Jul 2018 09:04:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 5 Jul 2018 09:04:01 +0800
Message-ID: <1530752641.17448.79.camel@mtkswgap22>
Subject: Re: [PATCH v6 5/5] clocksource/drivers/timer-mediatek: Add support
 for system timer
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 5 Jul 2018 09:04:01 +0800
In-Reply-To: <2cb9177c-0586-4432-94a2-df46fe64cc3b@linaro.org>
References: <1530715820-3406-1-git-send-email-stanley.chu@mediatek.com>
         <1530715820-3406-6-git-send-email-stanley.chu@mediatek.com>
         <2cb9177c-0586-4432-94a2-df46fe64cc3b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 02:13 +0200, Daniel Lezcano wrote:
> On 04/07/2018 16:50, Stanley Chu wrote:

Hi Daniel,

Well remove duplicate one in v7.

> > +
> > +static void __iomem *gpt_sched_reg __read_mostly;
> 
> duplicate 'gpt_sched_reg' variable.
> 
> 
> > +static void mtk_syst_ack_irq(struct timer_of *to)
> > +{
> > +	/* Clear and disable interrupt */
> > +	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> > +}
> > +
> > +static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *clkevt = dev_id;
> > +	struct timer_of *to = to_timer_of(clkevt);
> > +
> > +	mtk_syst_ack_irq(to);
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
> > +	/* Enable clock to allow timeout tick update later */
> > +	writel(SYST_CON_EN, SYST_CON_REG(to));
> > +
> > +	/*
> > +	 * Write new timeout ticks. Timer shall start countdown
> > +	 * after timeout ticks are updated.
> > +	 */
> > +	writel(ticks, SYST_VAL_REG(to));
> > +
> > +	/* Enable interrupt */
> > +	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> > +{
> > +	/* Disable timer */
> > +	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> > +{
> > +	return mtk_syst_clkevt_shutdown(clkevt);
> > +}
> > +
> > +static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> > +{
> > +	return 0;
> > +}
> > +
> >  static u64 notrace mtk_gpt_read_sched_clock(void)
> >  {
> >  	return readl_relaxed(gpt_sched_reg);
> > @@ -186,6 +266,34 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
> >  	},
> >  };
> >  
> > +static int __init mtk_syst_init(struct device_node *node)
> > +{
> > +	int ret;
> > +
> > +	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
> > +	to.clkevt.set_state_shutdown = mtk_syst_clkevt_shutdown;
> > +	to.clkevt.set_state_oneshot = mtk_syst_clkevt_oneshot;
> > +	to.clkevt.tick_resume = mtk_syst_clkevt_resume;
> > +	to.clkevt.set_next_event = mtk_syst_clkevt_next_event;
> > +	to.of_irq.handler = mtk_syst_handler;
> > +
> > +	ret = timer_of_init(node, &to);
> > +	if (ret)
> > +		goto err;
> > +
> > +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> > +					TIMER_SYNC_TICKS, 0xffffffff);
> > +
> > +	pr_info("irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
> > +		timer_of_irq(&to), timer_of_rate(&to),
> > +		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);
> 
> Please remove this trace. Most of this information is already available
> in /proc/timer_list.
> 
> However, if you think it is worth to add this trace, do a proposition in
> the time framework directly so all drivers can benefit this change.
> 

OK! Will remove this log in v7.

> > +	return 0;
> > +err:
> > +	timer_of_cleanup(&to);
> > +	return ret;
> > +}
> > +
> >  static int __init mtk_gpt_init(struct device_node *node)
> >  {
> >  	int ret;
> > @@ -218,9 +326,9 @@ static int __init mtk_gpt_init(struct device_node *node)
> >  	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
> >  
> >  	return 0;
> > -
> >  err:
> >  	timer_of_cleanup(&to);
> >  	return ret;
> >  }
> >  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> > +TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> > 
> 
> 


