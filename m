Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05979C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75AE20896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75AE20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeKNIEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:04:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39546 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:04:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 49D2229EE7;
        Tue, 13 Nov 2018 17:04:10 -0500 (EST)
Date:   Wed, 14 Nov 2018 09:04:36 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource API
In-Reply-To: <alpine.LNX.2.21.1811130826260.356@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1811132137180.371@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au> <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de>
 <alpine.LNX.2.21.1811130826260.356@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, I wrote:

> On Mon, 12 Nov 2018, Thomas Gleixner wrote:
> 
> > > +static u32 clk_total;
> > > +
> > > +#define PCC_TIMER_CLOCK_FREQ 1000000
> > > +#define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
> > > +
> > >  static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
> > >  {
> > > +    irq_handler_t tick_handler = dev_id;
> > > +    unsigned long flags;
> > > +
> > > +    local_irq_save(flags);
> > 
> > No need for local_irq_save() here. Interrupt handlers are guaranteed to be
> > called with interrupts disabled.
> > 
> 
> That's not the case on m68k, as I understand it. However, the CPU 
> interrupt level does prevent interrupt handlers from nesting.
> 

What I mean by that is, the interrupt level (IPL) prevents interrupt 
handlers from being re-entered. But a handler can still get interrupted by 
a higher priority interrupt request. In the past I've had to add defensive 
locking because of this.

In these patches I've assumed it was possible for some higher priority 
interrupt handler to perform a clocksource read after the timer handler 
started executing. Hence the use of local_irq_save/restore.

To be sure, I've just run a quick test and confirmed that the timer 
handler can indeed get interrupted by the ethernet interrupt handler.

-- 
