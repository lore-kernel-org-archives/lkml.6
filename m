Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF282C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7F206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIaWGeYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F7F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeIZNaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:30:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34491 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeIZNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:30:04 -0400
Received: by mail-it1-f193.google.com with SMTP id o72-v6so7980165ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osUziOuG23n5B6AY/pT7L2m1tikQbC3XCjroKbhjTrY=;
        b=CIaWGeYfrRA00Xttd8C8AkmNWIPzjf2pWb4srFQPnuJIGPgUoMc8P9jPruuIuOddF+
         safeLNNm9hNVC8d0YAvolJAnHT/FAq9h6bXQXO7wflLIctdmDZTh58sR6/AJFEf5rf3S
         Ey/K4G6DzdwZDmwfkPoc98D76TfWo7x6dUzIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osUziOuG23n5B6AY/pT7L2m1tikQbC3XCjroKbhjTrY=;
        b=Z+QM4y5Uc91jHXA1ddJeM8LhXVHmzJTxJY+bQmoRSxOGof7cUMVg+eXc9S30VXNN0G
         q8ak5ENY5kA2xWMb1M1WX1MXEL1YoIqKqqm8nkq9qx886XjjcFJd3WleYBpi8sQ7f7+J
         dqKQcDMmfcHx4ii1Lre1I3kPZ6mUnyQBNyuGg67Q7YCeS6+1cIxgWNTPbAnnkgsAScIq
         kqrFPExSBNDGe2tbyJ0NxfoUjK8M2uek9R7tGuwNnY0np6s4Vbm5Xp8QfBgyhAlkGwyI
         jnqSf23AXBhJSpjPvWh2x/xmrYCz0z2uw40EMt0SESrFOzCfnoJ/GQF9UpZVIqeKGdOv
         emCw==
X-Gm-Message-State: ABuFfohEwC5Py8/p/2crHLfvCYahAiW2Z7CiigmfuFBO41PwJqP2J8sX
        20j3J3PfP/d3RYlYVt9n6190JXWjLM9EL8XoPcNU1A==
X-Google-Smtp-Source: ACcGV60UiuLYyDXaUQzVtsIBkVY3fzevZA65Xh9hGrVIFDa0A9YjajfPm9jG2lIuA9THPE57K6MtpyO0LgCywZvHTos=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr4025500itd.130.1537946313423;
 Wed, 26 Sep 2018 00:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com> <20180911150925.19460-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180911150925.19460-2-Eugeniy.Paltsev@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:18:21 +0200
Message-ID: <CACRpkdawC77DMggf1ye1=tXUDbzBqWfw9=OVV5w49Aip6cKGug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] GPIO: add single-register GPIO via CREG driver
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

sorry for the delay, the driver is different from what I'm
used to so I needed focuses attention and it took some time.

On Tue, Sep 11, 2018 at 5:09 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:

> Add single-register MMIO GPIO driver for complex cases where
> only several fields in register belong to GPIO lines and each GPIO
> line owns a field with different length and on/off value.
>
> Such CREG GPIOs are used in Synopsys AXS10x and HSDK boards.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v2->v3:
>  * Move parameters into a lookup table instead of device tree.
>  * Use the ngpios attribute for instead of snps,ngpios.

This is looking good! Just a few small things I want you to fix
(we can certainly queue this for the next kernel):

> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/of_gpio.h>

Replace this with:
#include <linux/gpio/driver.h>

Drivers should only need to include that file. (Also move away from
mm_gpio_chip as per below.)

> +#include "gpiolib.h"

Why?

> +struct creg_gpio {
> +       struct of_mm_gpio_chip mmchip;

I would prefer to move away from using this. Just create a regular driver
please. Just struct gpio_chip and add a member
void __iomem *base; instead of referring to mmchip.regs.

In fact I want to rewrite all mm_gpio_chips but I just haven't had time.

> +static void creg_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)

Please rename the variable "gpio" to "offset".

This is clearer because "gpio" becomes quite ambigous.

> +static int creg_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +       return 0; /* output */
> +}

I think with the recent code changes in gpiolib you do not need to define
this function at all.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=devel&id=ae9847f48a4b4bff0335da20be63ac84d94eb54c

> +static int creg_gpio_xlate(struct gpio_chip *gc,
> +                          const struct of_phandle_args *gpiospec, u32 *flags)
> +{
> +       if (gpiospec->args_count != 1) {
> +               dev_err(&gc->gpiodev->dev, "invalid args_count: %d\n",
> +                       gpiospec->args_count);
> +               return -EINVAL;
> +       }
> +
> +       if (gpiospec->args[0] >= gc->ngpio) {
> +               dev_err(&gc->gpiodev->dev, "gpio number is too big: %d\n",
> +                       gpiospec->args[0]);
> +               return -EINVAL;
> +       }
> +
> +       return gpiospec->args[0];
> +}

Another reason to not use mm_gpio_chip: just rely on standard twocell
translation and you can delete this.

> +       /* Check that we suit in 32 bit register */

s/suit/fit

Yours,
Linus Walleij
