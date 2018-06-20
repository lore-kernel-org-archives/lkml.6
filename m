Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F698C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFAD20883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFAD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFTLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:55:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbeFTLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:55:12 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVbhb-0004Xu-5g; Wed, 20 Jun 2018 13:55:07 +0200
Date:   Wed, 20 Jun 2018 13:55:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20180620111833.GE7737@piout.net>
Message-ID: <alpine.DEB.2.21.1806201354530.10546@nanos.tec.linutronix.de>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com> <20180619211929.22908-3-alexandre.belloni@bootlin.com> <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de> <20180620094649.GA2766@piout.net> <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
 <20180620103259.GA7737@piout.net> <alpine.DEB.2.21.1806201244110.10546@nanos.tec.linutronix.de> <20180620111833.GE7737@piout.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Alexandre Belloni wrote:
> On 20/06/2018 12:58:01+0200, Thomas Gleixner wrote:
> > > There are only a count up and count up then down modes. As the counter
> > > value is in a read only register, the only configurable starting value
> > > is 0 so it will always start by counting up. I'm pretty sure the up/down
> > > mode will not help us.
> > 
> > Hmm, fair enough.
> > 
> > Though the manual says:
> > 
> >      A trigger resets the counter and starts the counter clock. Three types
> >      of triggers are common to both modes, and a fourth external trigger is
> >      available to each mode.
> > 
> >      ...
> > 
> >      Software Trigger: Each channel has a software trigger, available by
> >      setting SWTRG in TC_CCR.
> > 
> > So the question is whether you can't do the following:
> > 
> >      stop_counter()
> >      issue_sw_trigger()  ---> resets the counter to zero
> >      write_compare()
> >      start_counter()
> > 
> > So that should avoid all te mess with comparing to the free running counter
> > as long as you have two blocks of counters, but then one of them will be
> > 16bit only assumed that there are always 3 counter channels in the TC.
> > 
> > Just a thought, but the code you have should work as well.
> > 
> 
> Ah yes, sure, I misunderstood your first comment then. the driver will
> register one or two clockevent devices, depending on the number of
> available channels.
> 
> The first one is based on the clocksource counter and does the counter
> comparison you don't like. the second one uses its own channel in the
> way you describe (set RC, reset counter, start counter).
> 
> This was necessary because some people are running out of TCB channels
> as they use the remaining ones as PWMs. But it is still better to use
> one channel as clocksource and clockevent that use the PIT.

Fair enough.

