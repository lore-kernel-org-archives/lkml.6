Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B14C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04FB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04FB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeGSH0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:26:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51709 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeGSH0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:26:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F0C3B207AD; Thu, 19 Jul 2018 08:44:47 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8041520731;
        Thu, 19 Jul 2018 08:44:47 +0200 (CEST)
Date:   Thu, 19 Jul 2018 08:44:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
Message-ID: <20180719084447.239a1b92@bbrezillon>
In-Reply-To: <20180718235710.18242-8-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-8-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 01:57:09 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> The plan is to replace data port readw()/writew() operations with GPIO
> callbacks provided by gpio-omap driver.  For acceptable performance the
> GPIO chip must support get/set_multiple() GPIO callbacks.
> 
> In order to avoid data corruption, we require the array of data GPIO
> descriptors obtained with gpiod_get_array() to meet some strict
> requirements:
> - all pins must belong to the same single GPIO chip,

You shouldn't care. The parallel NAND interface has WE/RE signals to
trigger a write/read on the data bus, that means you can change data
signals independently without risking data corruption as long as RE/WE
stay high (or low, I don't remember the active state on these pins). Of
course it's slower if you have to toggle data pins independently, but
that's not your problem. It's up to the HW designer to route things
correctly.

> - array index of each pin descriptor must match its hardware number,

Again, this is not really a problem. You'll just have to swap bits if
this is not the case. Not a big deal.

> - pin polarity must not be inverted,

Why?

> - pin hardware configuration must not be open drain nor open source.

This should be taken care of when requesting the pins.

> 
> Let's implement the above described sanity checks before replacing the
> readw()/writew() operations witn GPIO callbacks.  If a check fails,
> return -EINVAL to indicate the board provided GPIO setup is invalid.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 87 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index ad62c0245458..bd501f385e78 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>

Wow! This is a very very bad idea. There's a clear separation between
the GPIO consumer and the GPIO driver API for a good reason, and
you're violating this. linux/gpio/driver.h should only be included by
GPIO controller drivers.

>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -190,7 +191,9 @@ static int ams_delta_init(struct platform_device *pdev)
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	void __iomem *io_base;
>  	struct gpio_descs *data_gpiods;
> -	int err = 0;
> +	struct gpio_chip *data_gpioc;
> +	unsigned long mask, bits;
> +	int i, err = 0;
>  
>  	if (!res)
>  		return -ENXIO;
> @@ -298,6 +301,88 @@ static int ams_delta_init(struct platform_device *pdev)
>  		goto out_mtd;
>  	}
>  
> +	/* Use GPIO chip of first data GPIO pin descriptor */
> +	data_gpioc = gpiod_to_chip(data_gpiods->desc[0]);
> +
> +	/*
> +	 * For acceptable performance require the data GPIO
> +	 * chip to support get/set_multiple() callbacks.
> +	 */
> +	if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
> +		err = -EINVAL;
> +		dev_err(&pdev->dev,
> +			"data GPIO chip does not support get/set_multiple()\n");
> +		goto out_mtd;
> +	}
> +
> +	/* Verify if get_multiple() returns all pins low as initialized above */
> +	mask = (1 << data_gpiods->ndescs) - 1;
> +	err = data_gpioc->get_multiple(data_gpioc, &mask, &bits);

And this, you shouldn't do. You should instead go through the GPIO
consumer API to get the pin state (gpiod_get_raw_array_value()).

I guess you'd prefer to have the pin values in a bitmap instead of an
array of integers. That's probably something you can discuss with
Linus, see if he would accept to change the prototype of
gpiod_get_raw_array_value().

> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"data GPIO chip get_multiple() failed: %d\n", err);
> +		goto out_mtd;
> +	}
> +	if (bits) {
> +		err = -EINVAL;
> +		dev_err(&pdev->dev,
> +			"mismmatch of data GPIO initial value: %lu\n", bits);
> +		goto out_mtd;
> +	}
> +
> +	/* Verify each data GPIO pin */
> +	for (i = 0; i < data_gpiods->ndescs; i++) {
> +		/* Require all pins belong to the same GPIO chip */
> +		if (gpiod_to_chip(data_gpiods->desc[i]) != data_gpioc) {
> +			err = -EINVAL;
> +			dev_err(&pdev->dev, "GPIO chip mismatch of data bit %d\n",
> +				i);
> +			goto out_mtd;
> +		}
> +
> +		/* Require all pins active high (not inverted) */
> +		if (gpiod_is_active_low(data_gpiods->desc[i])) {
> +			err = -EINVAL;
> +			dev_err(&pdev->dev,
> +				"unsupported polarity of data GPIO bit %d\n",
> +				i);
> +			goto out_mtd;
> +		}
> +
> +		/*
> +		 * Require pin gpiod array index to match hardware pin number.
> +		 * Verified by setting the pin high with gpiod_set_raw_value()
> +		 * then reading it back with gpiochip->get() for comparison.
> +		 */
> +		gpiod_set_raw_value(data_gpiods->desc[i], 1);
> +		err = data_gpioc->get(data_gpioc, i);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +				"data bit %d GPIO chip get() failed: %d\n", i,
> +				err);
> +			goto out_mtd;
> +		}
> +		if (!err) {
> +			err = -EINVAL;
> +			dev_err(&pdev->dev, "mismatch of data GPIO bit %d value\n",
> +				i);
> +			goto out_mtd;
> +		}
> +
> +		/*
> +		 * Check for unsupported pin hardware configuration.  Use
> +		 * just verified gpiod array index as hardware pin number.
> +		 */
> +		if (gpiochip_line_is_open_drain(data_gpioc, i) ||
> +		    gpiochip_line_is_open_source(data_gpioc, i)) {
> +			err = -EINVAL;
> +			dev_err(&pdev->dev,
> +				"unsupported mode of data GPIO bit %d\n",
> +				i);
> +			goto out_mtd;
> +		}
> +	}
> +
>  	/* Scan to find existence of the device */
>  	err = nand_scan(mtd, 1);
>  	if (err)

