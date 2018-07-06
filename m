Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4762C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A523ED3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8A523ED3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933193AbeGFPSv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:18:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34187 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932836AbeGFPSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:18:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90A8020734; Fri,  6 Jul 2018 17:18:47 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 642302072C;
        Fri,  6 Jul 2018 17:18:47 +0200 (CEST)
Date:   Fri, 6 Jul 2018 17:18:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
Message-ID: <20180706151848.GB16084@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <0ebef205-a6c8-0da2-86b4-6b1c982a1fdf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ebef205-a6c8-0da2-86b4-6b1c982a1fdf@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 18:24:12+0200, Daniel Lezcano wrote:
> > +static void tc_clkevt2_clk_enable(struct clock_event_device *d)
> > +{
> > +	if (tce.clk_enabled)
> > +		return;
> 
> Why this test ?
> 
> > +	clk_enable(tce.clk);
> > +	tce.clk_enabled = true;
> > +}
> >
> > +static int tc_clkevt2_stop(struct clock_event_device *d)
> > +{
> > +	writel(0xff, tce.base + ATMEL_TC_IDR(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKDIS, tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static int tc_clkevt2_shutdown(struct clock_event_device *d)
> > +{
> > +	tc_clkevt2_stop(d);
> > +	if (!clockevent_state_detached(d))
> 
> Why this test ?
> 
> > +		tc_clkevt2_clk_disable(d);
> > +
> > +	return 0;
> > +}
> > +
> > +/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
> > + * because using one of the divided clocks would usually mean the
> > + * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
> > + *
> > + * A divided clock could be good for high resolution timers, since
> > + * 30.5 usec resolution can seem "low".
> > + */
> > +static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
> > +{
> > +	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
> > +		tc_clkevt2_stop(d);
> 
> Why these tests ? :)
> 

All these test are to be nice with preempt-rt else we would be disabling
then reenabling the clock in an atomic context which fails with the
preempt-rt patch.

> > +	/* By not making the gentime core emulate periodic mode on top
> > +	 * of oneshot, we get lower overhead and improved accuracy.
> > +	 */
> > +	tc_clkevt2_clk_enable(d);
> > +
> > +	/* slow clock, count up to RC, then irq and restart */
> > +	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
> > +	       ATMEL_TC_CMR_WAVESEL_UPRC,
> > +	       tce.base + ATMEL_TC_CMR(tce.channel));
> > +	writel((32768 + HZ / 2) / HZ, tce.base + ATMEL_TC_RC(tce.channel));
> 
> Do this computation at init time.
> 

Does it really matter? All the members are constant so no code will be
generated for the computation. This ends up being an immediate value
computing it at init time would mean storing it in the structure which
would incur an extra load.

> > +	/* Enable clock and interrupts on RC compare */
> > +	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
> > +	       tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static int tc_clkevt2_next_event(unsigned long delta,
> > +				 struct clock_event_device *d)
> > +{
> > +	writel(delta, tce.base + ATMEL_TC_RC(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
> > +	       tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
> > +{
> > +	unsigned int sr;
> > +
> > +	sr = readl(tce.base + ATMEL_TC_SR(tce.channel));
> > +	if (sr & ATMEL_TC_CPCS) {
> > +		tce.clkevt.event_handler(&tce.clkevt);
> > +		return IRQ_HANDLED;
> 
> Isn't an clear irq missing ?
> 

It is cleared on read.

> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +static void tc_clkevt2_suspend(struct clock_event_device *d)
> > +{
> > +	tce.cache.cmr = readl(tce.base + ATMEL_TC_CMR(tce.channel));
> > +	tce.cache.imr = readl(tce.base + ATMEL_TC_IMR(tce.channel));
> > +	tce.cache.rc = readl(tce.base + ATMEL_TC_RC(tce.channel));
> > +	tce.cache.clken = !!(readl(tce.base + ATMEL_TC_SR(tce.channel)) &
> > +				ATMEL_TC_CLKSTA);
> 
> Who is in charge of powering down the timer ?
> 

The platform code stops all the clocks when going to suspend.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
