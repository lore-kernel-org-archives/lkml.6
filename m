Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959EBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5997620871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5997620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754046AbeFTKdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:33:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48606 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeFTKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:33:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0D07207EB; Wed, 20 Jun 2018 12:33:08 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8AAF9206D8;
        Wed, 20 Jun 2018 12:32:58 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:32:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
Message-ID: <20180620103259.GA7737@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
 <20180620094649.GA2766@piout.net>
 <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 12:07:00+0200, Thomas Gleixner wrote:
> > > > +static int tcb_clkevt_next_event(unsigned long delta,
> > > > +				 struct clock_event_device *d)
> > > > +{
> > > > +	u32 old, next, cur;
> > > > +
> > > > +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > > +	next = old + delta;
> > > > +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> > > > +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > > +
> > > > +	/* check whether the delta elapsed while setting the register */
> > > > +	if ((next < old && cur < old && cur > next) ||
> > > > +	    (next > old && (cur < old || cur > next))) {
> > > > +		/*
> > > > +		 * Clear the CPCS bit in the status register to avoid
> > > > +		 * generating a spurious interrupt next time a valid
> > > > +		 * timer event is configured.
> > > > +		 */
> > > > +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> > > > +		return -ETIME;
> > > > +	}
> > > 
> > > Aarg. Doesn;t that timer block have a simple count down and fire mode?
> > > These compare equal timers suck.
> > 
> > It only counts up...
> 
> Have you tried to play with that waveform stuff?
> 

There are only a count up and count up then down modes. As the counter
value is in a read only register, the only configurable starting value
is 0 so it will always start by counting up. I'm pretty sure the up/down
mode will not help us.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
