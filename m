Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFCC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEDF21A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn5PfxGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEDF21A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeHFNPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:15:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39591 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeHFNPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:15:09 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so10652049ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kgyf+xozKBERQ/3jTZWyHubUeF9g8qmF9GMdrpyuHg=;
        b=Hn5PfxGY9VeXtd1JVZ9z+7XY/kpanOGzMKp38t8fOv90Z+y0SLcXGdhLX3A7DWR4Pb
         lpm22QSncoLBONvROz90BBOyyNkDl1vazz9BxbTqiohl7udGHc+bVVQVTcEjaY/mzbyH
         maFxRzqiE2dBR0Ux0lEi+vGkGREDP+W47/SLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kgyf+xozKBERQ/3jTZWyHubUeF9g8qmF9GMdrpyuHg=;
        b=dDR7xsDzaMGZx677pP0mnUyJn2CuT9Pq+T76BrSHKXGoxhfl9DU82Xqx96a+aASPZE
         D30rmDQnm927tiF/B4K1oqFh0jXsckv9P36hWEF1+iuOz42oDdxRTTuK0EpgAFnetDIN
         sJeRLa+U07/xaxeeJWJILVf9+bFdUzTHAonpvC6u/rirujmIGNnHlBuUR1K1NxE2ey+L
         MhRqsvs8WhK9ynlhiW1gg6qK0tMajVsDy52/JQkaaTbvWachcYWm7nlr+I1odAq9EzWE
         ox5l1RqVrD4yCR5wNshrmlvhq0dj3ycYo3sOUIpaRnYeg3vZdLVTIY6oHdn34A8wwxbk
         VkDg==
X-Gm-Message-State: AOUpUlFPyco6ZCEnuEO5EenvqvwAHBe/NR0DtQW2OpM0ndAyPVkAeyZJ
        lZNA86r3iMLnC2GCITmSt7XCx3O/UNdSAesRjTQKfzrq
X-Google-Smtp-Source: AA+uWPzRo4vouDXnCCplavPjkNK9iwMnmkz+XlDL/ei03F1kg/M+PI/j7BfApAUMOzNSegGx2z7iII/0+oohPMBjTK0=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr14328616iof.304.1533553595887;
 Mon, 06 Aug 2018 04:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180725122621.31713-1-quentin.schulz@bootlin.com> <20180725122621.31713-2-quentin.schulz@bootlin.com>
In-Reply-To: <20180725122621.31713-2-quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Aug 2018 13:06:23 +0200
Message-ID: <CACRpkdbq2Q-J8scsuaUS0hP1x12xh0zd+RMrCp0TYB773bOAdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: add support for interrupt controller
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin, sorry for delays!

On Wed, Jul 25, 2018 at 2:27 PM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:

> This GPIO controller can serve as an interrupt controller as well on the
> GPIOs it handles.
>
> An interrupt is generated whenever a GPIO line changes and the
> interrupt for this GPIO line is enabled. This means that both the
> changes from low to high and high to low generate an interrupt.
>
> For some use cases, it makes sense to ignore the high to low change and
> not generate an interrupt. Such a use case is a line that is hold in a
> level high/low manner until the event holding the line gets acked.
> This can be achieved by making sure the interrupt on the GPIO controller
> side gets acked and masked only after the line gets hold in its default
> state, this is what's done with the fasteoi functions.
>
> Only IRQ_TYPE_EDGE_BOTH and IRQ_TYPE_LEVEL_HIGH are supported for now.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Patch applied, it's such a pretty and straight-forward patch.
Also IRQ is probably very nice to have, so let's get this in and
supported.

Please consider addressing the following in follow-up patch(es):

> +static int ocelot_irq_set_type(struct irq_data *data, unsigned int type);

Can't you just move the function above so you don't have to forward-declare
this?

> +static struct irq_chip ocelot_eoi_irqchip = {
> +       .name           = "gpio",
> +       .irq_mask       = ocelot_irq_mask,
> +       .irq_eoi        = ocelot_irq_ack,
> +       .irq_unmask     = ocelot_irq_unmask,
> +       .flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,

As you see the latter part of the define is "IF_HANDLED".

> +       .irq_set_type   = ocelot_irq_set_type,
> +};
> +
> +static struct irq_chip ocelot_irqchip = {
> +       .name           = "gpio",
> +       .irq_mask       = ocelot_irq_mask,
> +       .irq_ack        = ocelot_irq_ack,
> +       .irq_unmask     = ocelot_irq_unmask,
> +       .irq_set_type   = ocelot_irq_set_type,
> +};

Is it really neccessary to have two irqchips?

Is this to separate ACK and EOI because the EOI version
doesn't survive an ACK?

Yours,
Linus Walleij
