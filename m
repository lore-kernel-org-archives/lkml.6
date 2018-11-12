Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D75C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35A020817
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35A020817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeKMEcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:32:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:32:12 -0500
Received: from node-1w7jr9qsvbxfi9ota9omrl6fe.ipv6.telus.net ([2001:569:7bc5:1000:8103:8419:bf24:e6ca])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gMH5e-0004g1-1F; Mon, 12 Nov 2018 19:37:38 +0100
Date:   Mon, 12 Nov 2018 10:37:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Finn Thain <fthain@telegraphics.com.au>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource API
In-Reply-To: <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au>
Message-ID: <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au>
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

Finn,

On Mon, 12 Nov 2018, Finn Thain wrote:

First of all, thanks for tackling this!

> +static u32 clk_total;
> +
> +#define PCC_TIMER_CLOCK_FREQ 1000000
> +#define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
> +
>  static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
>  {
> +    irq_handler_t tick_handler = dev_id;
> +    unsigned long flags;
> +
> +    local_irq_save(flags);

No need for local_irq_save() here. Interrupt handlers are guaranteed to be
called with interrupts disabled.

>      *(volatile unsigned char *)0xfff4201b |= 8;
> +    clk_total += PCC_TIMER_CYCLES;

Looking at the read function below, I assume that this magic 0xfff42008
register counts up to PCC_TIMER_CYCLES, which triggers the timer interrupt
and then starts from 0 again. And looking at the programming manual
actually confirms that assumption (COC is set in the control reg).

> -u32 mvme16x_gettimeoffset(void)
> +static u64 mvme16x_read_clk(struct clocksource *cs)
>  {
> -    return (*(volatile u32 *)0xfff42008) * 1000;
> +    u32 count = *(volatile u32 *)0xfff42008;
> +
> +    return clk_total + count;
>  }

There is a problem with that approach. Assume the following situation:

				Counter value (HZ = 100)
       local_irq_disable()	
       ...
       ktime_get()		9999
       ....			10000 -> 0 (interrupt is triggered)
       ktime_get()		1

IOW, time goes backwards.

There are two ways to solve that:

 1) Take the overflow bits in the timer control register into account,
    which makes time readout even slower because you need to do it like
    this:

    do {
       ovfl = read(TCR1);
       now = read(TCNT1);
    while (ovfl != read(TCR1));
    ....
  

 2) Use Timer2 in freerunning mode which means it will use the full 32bit
    and then wrap back to 0. That's fine and the clocksource core handles
    that.

    That removes the clk_total thing and just works.

Thanks,

	tglx
