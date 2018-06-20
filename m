Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296EEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E148820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeFTJrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:47:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47501 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753989AbeFTJrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:47:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3FADF2092B; Wed, 20 Jun 2018 11:46:59 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DBB9203EC;
        Wed, 20 Jun 2018 11:46:49 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:46:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
Message-ID: <20180620094649.GA2766@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 11:03:40+0200, Thomas Gleixner wrote:
> > +/*
> > + * Clocksource and clockevent using the same channel(s)
> > + */
> > +static u64 tc_get_cycles(struct clocksource *cs)
> > +{
> > +	u32 lower, upper;
> > +
> > +	do {
> > +		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
> > +		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > +	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
> > +
> > +	return (upper << 16) | lower;
> > +}
> 
> For timekeeping the win of this is dubious. With a 5Mhz clock the 32bit
> part wraps around in ~859 seconds, which is plenty even for NOHZ.
> 
> So I really would avoid the double read/compare/eventually repeat magic and
> just use the lower 32bits for performance sake. I assume the same is true
> for sched_clock(), but I might be wrong.
> 

Agreed, this is why this is only used with the 16 bit counters (the
register is 32 bit wide but the counter only have 16 bits. For the 32
bit counters, tc_get_cycles32 is used and only use one counter.

> > +static int tcb_clkevt_next_event(unsigned long delta,
> > +				 struct clock_event_device *d)
> > +{
> > +	u32 old, next, cur;
> > +
> > +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > +	next = old + delta;
> > +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> > +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > +
> > +	/* check whether the delta elapsed while setting the register */
> > +	if ((next < old && cur < old && cur > next) ||
> > +	    (next > old && (cur < old || cur > next))) {
> > +		/*
> > +		 * Clear the CPCS bit in the status register to avoid
> > +		 * generating a spurious interrupt next time a valid
> > +		 * timer event is configured.
> > +		 */
> > +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> > +		return -ETIME;
> > +	}
> 
> Aarg. Doesn;t that timer block have a simple count down and fire mode?
> These compare equal timers suck.

It only counts up...


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
