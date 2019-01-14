Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2R0Ww9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36576 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so15167441lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Tn/EFhs98eW0ffaWyqrAkjxL5wKmlxFqBOZ6ai8owE=;
        b=C2R0Ww9uSYLPg8u1uv7jKLtyg89Tb55OMTXU+Ozy0E3q4K6AxTt4lqhwd1NxC04Vsf
         Gb5GLkBXGs5W4WOAny3B3JIimokaYfUGg02/rDH+yRCaSGoCNV3MkXs4RI/uIyoUb5AW
         GPji3mIwMgxbFcywV4out/b3i3zVvAiQvd6R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Tn/EFhs98eW0ffaWyqrAkjxL5wKmlxFqBOZ6ai8owE=;
        b=n42mMXuVqRtTz82MeRMx+3aGgUnKzA4vj6Q62tfE1nkhKtH4BDg0JNzChzSDZkZbZ2
         //8qNYKpMOBee5Ucz96ckIstTveSzpx5/BRUv3GLfGDqLf3xhHeoD57IBoCi4Pg/G2Fw
         U8B8z4BlmhcEiNbUvO95h9Pb3d8n89w21Ok0UZ9V5uOJMd/PJk11KdsJ8mILUmJtNi8n
         wUpMFctiXSedNejy+7e3aFX3PCQIaD4JjoMlj1hhb9CWB4ymdNtbm+pk/nBMVQwDaJOs
         KIE9NTG/ahoox7JeHBJaPVS5Y0EogB74lbvVce1pbvpO8bRKGdLzjXiu/oL7nkArJK9x
         SuFg==
X-Gm-Message-State: AJcUukfuwv+LdX67cy5DZGsbgzT31RGMhDcP/oUf43vZOug6M1Qy6Kis
        lhgMB8vUuxjPrPBsAIZnbZg1IqqonRr2L6qKOaVMeA==
X-Google-Smtp-Source: ALg8bN60HMnK50dYfHA1xDv/v0Hrl9fjczhjPqL+PRZhQTASbkL0eKypnkKPalJlsKQ/RjKhiL7XHGljiFXdjFEAIeE=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr12288263lfd.149.1547461260452;
 Mon, 14 Jan 2019 02:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20190113135844.13109-1-j.neuschaefer@gmx.net> <20190113135844.13109-2-j.neuschaefer@gmx.net>
In-Reply-To: <20190113135844.13109-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 11:20:49 +0100
Message-ID: <CACRpkdYyMwu+hFQF4PUSb8N8zo3QEFt5=curhsdTFP1FCtGpNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: hlwd: Add basic IRQ support
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thanks for the patch! It is looking very good.
Some minor comments:

On Sun, Jan 13, 2019 at 3:00 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

>         select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP

Nice!

> +static void hlwd_gpio_irqhandler(struct irq_desc *desc)
> +{
> +       struct hlwd_gpio *hlwd =3D
> +               gpiochip_get_data(irq_desc_get_handler_data(desc));
> +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +       unsigned long flags;
> +       unsigned long pending;
> +       int hwirq;
> +
> +       spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
> +       pending =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTFLAG);
> +       pending &=3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTMASK);

Please just access IO directly instead through the helper.
ioread32be()/iowrite32be() I suppose?

> +static void hlwd_gpio_irq_ack(struct irq_data *data)
> +{
> +       struct hlwd_gpio *hlwd =3D
> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +
> +       hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTFLAG, BIT(data->hw=
irq));

Dito.

> +       spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
> +       mask =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTMASK);
> +       mask &=3D ~BIT(data->hwirq);
> +       hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTMASK, mask);

Dito.

> +       spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
> +       mask =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTMASK);
> +       mask |=3D BIT(data->hwirq);
> +       hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTMASK, mask);

Dito.

> +       switch (flow_type) {
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               level =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTL=
VL);
> +               level |=3D BIT(data->hwirq);
> +               hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTLVL, level=
);
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               level =3D hlwd->gpioc.read_reg(hlwd->regs + HW_GPIOB_INTL=
VL);
> +               level &=3D ~BIT(data->hwirq);
> +               hlwd->gpioc.write_reg(hlwd->regs + HW_GPIOB_INTLVL, level=
);
> +               break;

Dito.

> +       hlwd->irqc.name =3D "GPIO";

What about using something device-unique?

hlwd->irqc.name =3D dev_name(&pdev->dev);

for example?

otherwise it looks fine!

Yours,
Linus Walleij
