Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E31C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114B320643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="deijFDvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeLNNlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:41:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42018 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeLNNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:41:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so4915593lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGniGw3P2/sCM8N8VJi0tTlI78rVCQFmJacEPvmK3gs=;
        b=deijFDvXo16pLRCJ1VaUqYSeiB0pH8Ad5P6qkSz6qmDx6VUYIqFPvNBoMwikmkMUT0
         rU7ikTeVeKMDKCI8SGzIqCmfBOANXncpmIxRxibvm51IYilI2n928oMl1F8Wqzh7Tobz
         FYo9xBH+DSxQ/dmXoGyCthEPzvFx1h7Ke3zKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGniGw3P2/sCM8N8VJi0tTlI78rVCQFmJacEPvmK3gs=;
        b=T7pGvwvfIpskUpeP7qaEdHfASPBzth5V66Mzfke4GvlTJkxeFiH7bEcBatObUvhLkP
         awNen19VL0ZD8Ru+AkPARPqmchlwtFLlAqw9A7UlOrvAae5ZXgKV4DMHgP5keTYQvoFY
         1nvzZlad/QswdhNbLzlVrIDSR6lH6xzACyw7YV+1u8ePCe+opLfl/973jxCfRItaqoz+
         3xPCX0FRCBGttgUetMQeIalCtbUTGwnVrKCfz8IDJXN/lmxLRKDVedzcN9vtsF8P3gio
         q+scf3zPQT4xFDSbhMuhCG0pLhtzrd7ieRBG3N0chvHD1IRq/GQ9tAC/SG4WmQep6tH8
         12qA==
X-Gm-Message-State: AA+aEWZpWpkJSTnIwltamBq6gs2nxkNTz967Pu4JTlvobqVIClf05Avh
        wgN50EJ0/s7+Da3o8Af7WkuYdeQtrcXpMFCv60eu2A==
X-Google-Smtp-Source: AFSGD/Wam2UW2bwgAr3gEFdaWk4d//hWRe2gBmvI8OqyI6RERkCPo+14MsmYl6ZHIsbTQs/awbLS/p+q2rFOU+UEJfM=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr1895351ljp.12.1544794873921;
 Fri, 14 Dec 2018 05:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20181129170312.23625-1-thierry.reding@gmail.com> <20181129170312.23625-2-thierry.reding@gmail.com>
In-Reply-To: <20181129170312.23625-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 14:41:01 +0100
Message-ID: <CACRpkdYhgCsr2w-MgwdLDvcZXDhkvn2_sgvGW8VskK1=3kVASw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: Add support for hierarchical IRQ domains
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry!

thanks a lot for the patch! This is really in the right direction
of how I want things to go with hierarchical IRQs.

Some comments:

On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:

>  config GPIOLIB_IRQCHIP
> -       select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY

I understand that IRQ_DOMAIN_HIERARCHY implies
IRQ_DOMAIN but I kind of like if we anyway select both
(unless Kconfig dislikes it).

Otherwise it looks like we're just using hierarchies.

>  static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
>  {
> +       struct irq_domain *domain = chip->irq.domain;
> +
>         if (!gpiochip_irqchip_irq_valid(chip, offset))
>                 return -ENXIO;
>
> +       if (irq_domain_is_hierarchy(domain)) {
> +               struct irq_fwspec spec;
> +
> +               spec.fwnode = domain->fwnode;
> +               spec.param_count = 2;
> +               spec.param[0] = offset;
> +               spec.param[1] = 0;
> +
> +               return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
> +       }
> +
>         return irq_create_mapping(chip->irq.domain, offset);
>  }

This is really nice.

> -       gpiochip->to_irq = gpiochip_to_irq;
> +       /*
> +        * Allow GPIO chips to override the ->to_irq() if they really need to.
> +        * This should only be very rarely needed, the majority should be fine
> +        * with gpiochip_to_irq().
> +        */
> +       if (!gpiochip->to_irq)
> +               gpiochip->to_irq = gpiochip_to_irq;

And I see this is what your driver does, which leaves the default
domain hierarchy callback path unused.

It's better if you indirect the pointer like we do with some other
irqchip stuff (see Hans Verkuils patches), i.e. if ->to_irq
is defined, we save that function pointer and call that at the
end of the gpiochip_to_irq() pointer, then we override it
with our own.

Since the Tegra186 clearly .to_irq() clearly is mostly the
same plus some extra, this should work fine and give
lesser lines of code in that driver.

Apart from that I am a big fan of this patch!

Yours,
Linus Walleij
