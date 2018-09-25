Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55702C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E675620870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk61sQdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E675620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeIYORl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:17:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33220 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeIYORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:17:40 -0400
Received: by mail-it1-f194.google.com with SMTP id j198-v6so6617230ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zgk5CodURpobbnmEdCLxvm9fiVEYu2H5EtrgmpevAFI=;
        b=Dk61sQdpAY785zQ9TV+v3SRQ5jCP7PRR2Nzbsy+XXmcbuaPbKR+ucTQiaAux3HbX7B
         lmq4nWz0DMILJFcyCSAkiStG82QOjLTziXlDypbtk28gcnXbewnvZpiEhcb22G6Zd2TI
         nP5KrIiZFSs8G8q5s0MGBipXXQg8AyAqVFWiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zgk5CodURpobbnmEdCLxvm9fiVEYu2H5EtrgmpevAFI=;
        b=Y+dWRxS6u4zGC/smNoD24NK8Ic0OeiGudc6XadWKT3/nKi8KkJvSCyE64DTA+uGNu7
         wiUS/QLIVplKSmMtZWDU8tQkcJQBcLnF2+9k4jiJ3ywLTDoH/8Y2orvj/icj9bNy+vGA
         0e9iHhklQH872z+wMWOj5Of3a2d8iz2snkHvASG8fgggKKO6RtRSnfnp2mMCh3LePDOq
         2LeKGu1/ecoPg4Wgf5zTebT5puosIuuuSoIZONOl7btyVgTEqer8nT+UQo1AfrYNwtFr
         9wgUIpztFC3qtDJueJZq1eLikKAZJk6ea+0dP9GC5tBxm/x6KbyQ2re7TdUk4ZJtANyK
         btSg==
X-Gm-Message-State: ABuFfoj5ix609IcRwd3bznBse9AwJTsH40U3pG1744spmSDcuOOBqcAX
        6ev+4S044OoVnJgd/7geRSUuubuD/360LyonGa7gnw==
X-Google-Smtp-Source: ACcGV606rw7qX7ryFw1TqfT/grqfa9RfkeTseZUK0PqQrfoJweaSBGQF9sOpYcXg00wh81sTAN88tMMlVYbZlCapdww=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr1827021ite.16.1537863078725;
 Tue, 25 Sep 2018 01:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180921102546.12745-1-thierry.reding@gmail.com> <20180921102546.12745-7-thierry.reding@gmail.com>
In-Reply-To: <20180921102546.12745-7-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 10:11:06 +0200
Message-ID: <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
Subject: Re: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry!

Thanks for the patch!

I am a bit ignorant about irqdomains so I will probably need an ACK
from some irq maintainer before I can apply this.

On Fri, Sep 21, 2018 at 12:25 PM Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Hierarchical IRQ domains can be used to stack different IRQ controllers
> on top of each other. One specific use-case where this can be useful is
> if a power management controller has top-level controls for wakeup
> interrupts. In such cases, the power management controller can be a
> parent to other interrupt controllers and program additional registers
> when an IRQ has its wake capability enabled or disabled.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

While I think it is really important that we start supporting hierarchical
irqdomains in the gpiolib core, I want a more complete approach,
so that drivers that need hierarchical handling of irqdomains
can get the same support from gpiolib as they get for simple
domains.

> @@ -1918,7 +1918,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
>                 type = IRQ_TYPE_NONE;
>         }
>
> -       gpiochip->to_irq = gpiochip_to_irq;
> +       if (!gpiochip->to_irq)
> +               gpiochip->to_irq = gpiochip_to_irq;

So here you let the drivers override the .to_irq() function and that
I think gets confusing as we are asking gpiolib to handle our
irqchip.


> -       gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
> -                                                    gpiochip->irq.first,
> -                                                    ops, gpiochip);
> +       if (gpiochip->irq.parent_domain)
> +               gpiochip->irq.domain = irq_domain_add_hierarchy(gpiochip->irq.parent_domain,
> +                                                               0, gpiochip->ngpio,
> +                                                               np, ops, gpiochip);
> +       else
> +               gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
> +                                                            gpiochip->irq.first,
> +                                                            ops, gpiochip);

So this part is great: if we pass in a parent domain the core helps us
create the hierarchy.

But the stuff in .to_irq() should also be handled in the gpiolib core:
the irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec) for
example. That way you should not need any external .to_irq() function.

I can't see if you need to pull more stuff into the core to accomplish
that, but I think in essence the core gpiolib needs to be more helpful
with hierarchies.

Yours,
Linus Walleij
