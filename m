Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD16C21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBR6t+WC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA1M4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:56:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32994 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfA1M4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:56:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so11786452lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtYsgjFGu6fAODHL+RAHV/6ZYs/aiT/WhaxSVGIhloY=;
        b=cBR6t+WC2Ukh0PB0s//+SgVjRTKp7lnA/rRGXo03WZVKUuHGu6/DLdFX2AkSL4ybNi
         iMYuiCnYZLpqX6fv57yFvC7Asckg/d4M5WtacC9LVEr8iUmpDKgD8fCcOoIHIC961lYu
         dKUfbEUelx4JnDjVjjZeRk8GcHlnWF2xSXfmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtYsgjFGu6fAODHL+RAHV/6ZYs/aiT/WhaxSVGIhloY=;
        b=NgpSqnv0U+GRtCbYaWZ6deHQa6c+ogr57ehGGtIkg70ezuoJM/tWOP7iDbzVWwkWVY
         e+BBX6BT6WDqlDYtSu4fIuadopuqz4OA9g/XnV5qKGkikb7X1LVh2PERWnNzJvg3/2A1
         ldIixdzD49NHXjxFqwuE/cqHLRqml0MmoztWyukxf7NKAlK7eEfnPxEtnyZh/DWR6qGd
         54FOKl9Cm1tb3CwiiVXZ8VTGkMoV7UhpPAO5A9hAfA3Dlx9VnEEZIwo9dh/EGM/KDSTe
         pkvGThcC9jJ6jVqEz4A3jQTIIw7s1w0BLKkvRTbL1yKXdLimD89z3KsxWH7kqySNrTrC
         ZL9w==
X-Gm-Message-State: AJcUukfU7J9fGYpeW+ATOcM/lg3rJ9f0IEArsJAKXwhJH8OAJ/4ogs11
        ErjKt4PPJFVi+qAadESoqcBWprgnnD15bZJN3xxRYg==
X-Google-Smtp-Source: ALg8bN4Lnb5MlosMti7CxpmKM3ix2ZEAcCkA3F0gobYMeVRgLDOQw63GJDaJubA7rFK8iKZqQyzebGdCxn+kPCGWyjA=
X-Received: by 2002:a19:db82:: with SMTP id t2mr16199018lfi.130.1548680161599;
 Mon, 28 Jan 2019 04:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20190125110509.GA29310@localhost.localdomain>
In-Reply-To: <20190125110509.GA29310@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 13:55:48 +0100
Message-ID: <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] gpio: Initial support for ROHM bd70528 GPIO block
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti!

Thanks for your patch!

On Fri, Jan 25, 2019 at 12:05 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> controlled by GPIO framework.
>
> IRQs are handled by regmap-irq and GPIO driver is not
> aware of the irq usage.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This is overall a very nicely written driver.

Just small comments:

> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>

Why interrupt? You do not use it.

> +static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +       int val, ret;
> +
> +       /* Do we need to do something to IRQs here? */

Well you don't support IRQs yet so no problem as long as they're masked?

> +       ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
> +       if (ret) {
> +               dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
> +               return ret;
> +       }
> +
> +       return !(val & BD70528_GPIO_OUT_EN_MASK);
> +}
> +
> +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                  unsigned long config)

This is very nice. With Thomas Petazzoni's ongoing work you will be
able to also support pull up/down if you need it.

> +static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +
> +       /* Do we need to do something to IRQs here? */

Hmmm?

Apart from that it looks good. Feel free to add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
on the next iteration.

Yours,
Linus Walleij
