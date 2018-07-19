Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAFECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C419420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C419420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeGSPZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:25:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17209 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeGSPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:25:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b50a3340000>; Thu, 19 Jul 2018 07:41:56 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Jul 2018 07:41:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Jul 2018 07:41:48 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Jul
 2018 14:41:46 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] gpio: tegra: Fix tegra_gpio_irq_set_type()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180717161038.21500-1-digetx@gmail.com>
Message-ID: <2384dc28-52ba-a415-9787-6ba985f767c2@nvidia.com>
Date:   Thu, 19 Jul 2018 15:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717161038.21500-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On 17/07/18 17:10, Dmitry Osipenko wrote:
> Commit 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
> broke tegra_gpio_irq_set_type() because requesting of GPIO direction must
> be done after enabling GPIO function for a pin.
> 
> This patch fixes drivers probe failure like this:
> 
>  gpio gpiochip0: (tegra-gpio): gpiochip_lock_as_irq: cannot get GPIO direction
>  tegra-gpio 6000d000.gpio: unable to lock Tegra GPIO 144 as IRQ
> 
> Fixes: 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpio/gpio-tegra.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 94396caaca75..22e7c99ed69e 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -323,13 +323,6 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  		return -EINVAL;
>  	}
>  
> -	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
> -	if (ret) {
> -		dev_err(tgi->dev,
> -			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
> -		return ret;
> -	}
> -
>  	spin_lock_irqsave(&bank->lvl_lock[port], flags);
>  
>  	val = tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
> @@ -342,6 +335,14 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, gpio), gpio, 0);
>  	tegra_gpio_enable(tgi, gpio);
>  
> +	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
> +	if (ret) {
> +		dev_err(tgi->dev,
> +			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
> +		tegra_gpio_disable(tgi, gpio);
> +		return ret;
> +	}
> +
>  	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>  		irq_set_handler_locked(d, handle_level_irq);
>  	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))

Thanks for reporting this. I am seeing this as well on Tegra20 Ventana
and Tegra30 Cardhu looking at the boot log. Given that gpiochip_lock_as_irq
is checking the direction, the above fix looks good to me. So ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
