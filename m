Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E14BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94A820895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94A820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeJMNbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:31:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeJMNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:31:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EF667207A3; Sat, 13 Oct 2018 07:55:37 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A3D6820717;
        Sat, 13 Oct 2018 07:55:37 +0200 (CEST)
Date:   Sat, 13 Oct 2018 07:55:37 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: Provide helper for polling GPIO
 R/B pin
Message-ID: <20181013075537.291e145f@bbrezillon>
In-Reply-To: <20181012204101.26274-1-jmkrzyszt@gmail.com>
References: <20181003120028.9257-1-jmkrzyszt@gmail.com>
        <20181012204101.26274-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Fri, 12 Oct 2018 22:41:00 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Each controller driver with access to NAND R/B pin over GPIO would have 
> to reimplement the polling loop otherwise.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Changelog:
> v2:
> New patch - v1 consisted of only one patch (the followning one)
> 
> 
>  drivers/mtd/nand/raw/nand_base.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/rawnand.h      | 10 ++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 05bd0779fe9b..ff1ac4a3c647 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -45,6 +45,9 @@
>  #include <linux/io.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
> +#ifdef CONFIG_GPIOLIB
> +#include <linux/gpio/consumer.h>
> +#endif

The ifdef is not needed here, linux/gpio/consumer.h already has dummy
wrappers when CONFIG_GPIOLIB is not enabled.

>  
>  #include "internals.h"
>  
> @@ -531,6 +534,41 @@ int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>  };
>  EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
>  
> +#ifdef CONFIG_GPIOLIB
> +/**
> + * nand_gpio_waitrdy - Poll R/B GPIO pin until ready
> + * @chip: NAND chip structure
> + * @gpiod: GPIO descriptor of R/B pin
> + * @timeout_ms: Timeout in ms
> + *
> + * Poll the R/B GPIO pin until it becomes ready. If that does not happen
> + * whitin the specified timeout, -ETIMEDOUT is returned.
> + *
> + * This helper is intended to be used when the controller has access to the
> + * NAND R/B pin over GPIO.
> + *
> + * Be aware that calling this helper from an ->exec_op() implementation means
> + * ->exec_op() must be re-entrant.

This is not true for this function: it does not call nand_exec_op().

> + *
> + * Return 0 if the R/B pin indicates chip is ready, a negative error otherwise.
> + */
> +int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
> +		      unsigned long timeout_ms)
> +{
> +	/* Wait until command is processed or timeout occurs */
> +	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
> +	do {
> +		if (gpiod_get_value_cansleep(gpiod))
> +			return 0;
> +
> +		cond_resched();
> +	} while	(time_before(jiffies, timeout_ms));

> +
> +	return gpiod_get_value_cansleep(gpiod) ? 0 : -ETIMEDOUT;
> +};
> +EXPORT_SYMBOL_GPL(nand_gpio_waitrdy);
> +#endif

Hm, I don't see any other helpers defined in #ifdef blocks though most
of them are optionals and are most of the time not used by drivers.
Let's keep things consistent (at the expense of embedding unused code
in nand.o) and remove the #ifdef here. If someone starts complaining
about the size of the rawnand core, we'll consider doing that.

> +
>  /**
>   * panic_nand_get_device - [GENERIC] Get chip for selected access
>   * @chip: the nand chip descriptor
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index e10b126e148f..09f0ed1345b1 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1346,4 +1346,14 @@ void nand_release(struct nand_chip *chip);
>   */
>  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms);
>  
> +#ifdef CONFIG_GPIOLIB
> +struct gpio_desc;
> +/*
> + * External helper for controller drivers that have to implement the WAITRDY
> + * instruction and do have GPIO pin to check it.
> + */

You can drop this comment, this is already explained in the kerneldoc
header above the function def.

> +int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
> +		      unsigned long timeout_ms);
> +#endif
> +
>  #endif /* __LINUX_MTD_RAWNAND_H */

Regards,

Boris
