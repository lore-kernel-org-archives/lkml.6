Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeC1OQr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:16:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35325 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753406AbeC1OQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:16:46 -0400
Date: Wed, 28 Mar 2018 16:16:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Message-ID: <20180328141645.GF13942@piout.net>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <9761072.pX2B0LJlSJ@ada>
 <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
 <4073350.0MmxRoANOi@ada>
 <6d43177a-bbea-6a01-5fa5-1c7891e18412@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d43177a-bbea-6a01-5fa5-1c7891e18412@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2018 at 15:03:11 +0200, Daniel Lezcano wrote:
> On 28/03/2018 12:29, Alexander Dahl wrote:
> > Hello Daniel,
> > 
> > Am Dienstag, 27. März 2018, 13:30:22 CEST schrieb Daniel Lezcano:
> >> Can you can give a rough amount for the irq rate on the timer ?
> > 
> > I used itop [1] now to get a rough estimate. First with kernel v4.14.29-rt25 
> > (fully preempt RT):
> > 
> > INT                NAME          RATE             MAX
> >  19 [ vel     tc_clkevt]   397 Ints/s     (max:   432)
> >  26 [      vel     eth0]     4 Ints/s     (max:    38)
> > 
> > Next test with kernel v4.15.13 gives (slightly slower, but non-RT):
> > 
> > INT                NAME          RATE             MAX
> >  19 [ vel     tc_clkevt]   248 Ints/s     (max:   273)
> >  26 [      vel     eth0]     4 Ints/s     (max:    11)
> > 
> > With kernel v4.16-rc7 plus this patch series and tcb as clocksource:
> > 
> > INT                NAME          RATE             MAX
> >  17 [vel     timer@fffa]  2164 Ints/s     (max:  2183)
> >  26 [      vel     eth0]     5 Ints/s     (max:    10)
> > 
> > Is this the information you wanted? If not, could you point me on how to get 
> > the requested irq rate?
> 
> It is perfect. Thanks!
> 
> It confirms what I was worried about: the clocksource wraps up too
> quickly thus raising an interrupt every 400us. That is why I asked
> Alexande about a prescalar register.
> 

The code should behave exactly the same between the previous and the new
driver. The interrupt is not coming from the clocksource but from the
clockevent and it is already on the slowest clock, the 32kHz one.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
