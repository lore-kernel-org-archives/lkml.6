Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC2IBb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:01:31 -0400
Received: from mail.thorsis.com ([92.198.35.195]:41247 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeC2IBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:01:30 -0400
From: Alexander Dahl <ada@thorsis.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Date: Thu, 29 Mar 2018 10:01:26 +0200
Message-ID: <3478710.yJBBt3uoRT@ada>
In-Reply-To: <20180328155033.GH13942@piout.net>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com> <20180328153135.GG13942@piout.net> <20180328155033.GH13942@piout.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T81aiK026562

Hei hei,

Am Mittwoch, 28. März 2018, 17:50:33 CEST schrieb Alexandre Belloni:
> On 28/03/2018 at 17:31:35 +0200, Alexandre Belloni wrote:
> > > Do you have an explanation of why the rate is much higher ?
> > 
> > The core is giving deltas of 31 clocks instead of much more than that, I
> > guess I messed up the initialization somewhere.
> 
> I did mess up.
> 
> Alexander, can you test that:

Well, I just did.

> 
> diff --git a/drivers/clocksource/timer-atmel-tcb.c
> b/drivers/clocksource/timer-atmel-tcb.c index 7fde9cfbf203..bbbacf8c46b0
> 100644
> --- a/drivers/clocksource/timer-atmel-tcb.c
> +++ b/drivers/clocksource/timer-atmel-tcb.c
> @@ -222,7 +222,7 @@ static int __init tc_clkevt_register(struct device_node
> *node, goto err_slow;
>  	clk_disable(tce.clk);
> 
> -	clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
> +	clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
> 
>  	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
>  			  tce.clkevt.name, &tce);
> 
> This will behave exactly the same as before on 16bits TCB and will have
> much less interrupts on 32 bits platforms.

This is the result:

INT                NAME          RATE             MAX
 17 [vel     timer@fffa]  1837 Ints/s     (max:  1912)
 26 [      vel     eth0]     3 Ints/s     (max:    11)

This is not much lower than the ~2150 I reported yesterday?

I'm sorry I can just test this on at91sam9g20 currently, I have no 
understanding of the subsystem, I can't do a decent review.

Greets
Alex
