Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F620831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et3dhWPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817F620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKTAKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:10:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34159 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeKTAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:09:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so26182345ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKL07o7rMhHLAxJrBlPEYpgLw3cT/dJX6NRCkJ7ifeY=;
        b=Et3dhWPa9/m8nWSrCSnZajOoBLdpWK2ygMK3ZbMc0RUs94GNEmhZfveozYR1g1uK2R
         9/1lk/GSyLPEzJw2npYGhtKoqYbyoiSL5zAncmQYbPs1MbEq20qLyKR/HZNJxMRwTcMS
         wjg8ed4+dLs0uHARWZUx8xj2fcgQ7hwZiUyGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKL07o7rMhHLAxJrBlPEYpgLw3cT/dJX6NRCkJ7ifeY=;
        b=o0/zFLYmtaHXX9mSTMFE53rQH8ka1Aa8evV6kzUS6bARMpWSokz8vEv9xKl4Q1KEoJ
         bLqb55s1fpuaf0iSmW3JzBR12cbZ4BjTxuVq+icV41lyMW8IO+zyU1HvqLPjXZ3Q1smY
         dbz/K8ck3HToCYe/lnFBDRmIXFoKFXU587AD+YXcSiT2ZClFjn9H5QAtWDtl8qT/k0by
         1SKjUw7EiMTC0sITXVYTrLYe/HvDMbfFXhdXIAFhNdDtRpwCrKjcISetLQSFuNR3E9MH
         UTlVgwEdvfkqH9LB5HCAl8q3m1R8A+DO3Sc32Axbt1THpFBK49CdnDMejj4H+7I3NGo9
         e/sw==
X-Gm-Message-State: AA+aEWYF3xJWNs0O1ps2qmKYPQC0eDr7qJ1Uv2pWFTJTJoBRnFhzAs5f
        dQmYi7IjnLRV5RAc9QrVsGU9a6Q0JHCn2dKQhc7XCw==
X-Google-Smtp-Source: AFSGD/VcDlfLYJPh+Ev4BpmrnnZ5i0ZFDf6VEDfagIaNehAUehq18zt1hOqKs7xZEkSPqoLeLNE3ZJ5lfKuBU/0ILpQ=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr7013303ljk.4.1542635177786;
 Mon, 19 Nov 2018 05:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20181115133201.29092-1-fe@dev.tdt.de> <20181115133201.29092-2-fe@dev.tdt.de>
In-Reply-To: <20181115133201.29092-2-fe@dev.tdt.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:46:06 +0100
Message-ID: <CACRpkdZx-GgfgfGmB6KmTjzBEMnKyq3pUsHsgaZ1uBooN_sj9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: Add driver for PC Engines APU boards
To:     fe@dev.tdt.de
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, piotr.krol@3mdeb.com,
        Eckert.Florian@googlemail.com, Darren Hart <dvhart@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 2:32 PM Florian Eckert <fe@dev.tdt.de> wrote:

> Add a new device driver "gpio-apu" which will handle the GPIOs on APU2
> and APU3 devices from PC Engines.
>
> APU2 (https://pcengines.ch/schema/apu2c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
>
> APU3 (https://pcengines.ch/schema/apu3c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
> - G33 is "simswap" connected to SIM switch IC to swap the SIM between
>   mPCIe2 and mPCIe3 slot
>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

This is looking better and better! Thanks to everyone helping out
and thanks for your perseverance Florian!

> +config GPIO_APU
> +       tristate "PC Engines APU2/APU3 GPIO support"
> +       depends on X86
> +       select GPIO_GENERIC

Excellent idea.

But it seems you are not using this. You would be using
it if you used bgpio_init() but if I understand correctly this
driver cannot use that because this GPIO is something like
one register per pin, correct?

Let me suggest:

> +struct apu_gpio_pdata {
> +       struct platform_device *pdev;
> +       struct gpio_chip *chip;

Make that a real member of this struct and not a pointer.
I.e. just remove the "*".

> +static struct apu_gpio_pdata *apu_gpio;

Why a static local? It seems you can just pass around
the pointer.

> +static int gpio_apu_get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ~ioread32(apu_gpio->addr[offset]);
> +       val = (val >> APU_GPIO_BIT_DIR) & 1;

I would just:

#include <linux/bits.h>

val = ~ioread32(apu_gpio->addr[offset]);
spin_unlock();

return !!(val & BIT(APU_GPIO_BIT_DIR));

This clamps the value to [0,1] in a nice way.

> +static int gpio_apu_get_data(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ioread32(apu_gpio->addr[offset]);
> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return (val >> APU_GPIO_BIT_RD) & 1;

return !!(val & BIT(APU_GPIO_BIT_RD));

> +       return devm_gpiochip_add_data(&pdev->dev, apu_gpio->chip, NULL);

Instead of passing NULL pas apu_gpio as the last argument and in
all callbacks you can use:

struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(gc);

To get a pointer to the per-instance state container.

Yours,
Linus Walleij
