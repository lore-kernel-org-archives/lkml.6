Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B743C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D2215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D2215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI0R5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:57:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50984 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbeI0R5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:57:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2614B2071E; Thu, 27 Sep 2018 13:39:13 +0200 (CEST)
Received: from bbrezillon (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 00B17206D0;
        Thu, 27 Sep 2018 13:39:02 +0200 (CEST)
Date:   Thu, 27 Sep 2018 13:39:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 7/8] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20180927133903.43195296@bbrezillon>
In-Reply-To: <20180905143643.9871-8-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
        <20180905143643.9871-8-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 16:36:42 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> +static int gpio_flash_probe_gpios(struct platform_device *pdev,
> +				  struct async_state *state)
> +{
> +	struct physmap_flash_data *pdata;
> +	struct device_node *dn;
> +	struct resource *gpios = NULL;
> +	int i;
> +
> +	dn = pdev->dev.of_node;
> +	if (dn) {
> +		state->gpio_count = of_gpio_count(dn);
> +	} else {
> +		pdata = dev_get_platdata(&pdev->dev);
> +		if (!pdata)
> +			return -EINVAL;
> +		gpios = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +		if (IS_ERR(gpios) || !gpios->end)
> +			return -EINVAL;
> +		state->gpio_count = gpios->end;
> +	}
> +
> +	state->gpio_addrs = devm_kzalloc(&pdev->dev,
> +					 sizeof(state->gpio_addrs[0])
> +						* state->gpio_count,
> +					 GFP_KERNEL);
> +	if (!state->gpio_addrs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < state->gpio_count; i++) {
> +		long gpio;
> +		int ret;
> +
> +		if (dn)
> +			gpio = of_get_gpio(dn, i);
> +		else
> +			gpio = ((unsigned long *)gpios->start)[i];
> +

Hm, we should probably switch to GPIO descs (instead of GPIO numbers)
before adding DT support. This should make the code much more simpler
and remove one more user of the old/deprecated GPIO API.

> +		if (gpio < 0)
> +			return gpio;
> +
> +		ret =  devm_gpio_request(&pdev->dev, gpio, DRIVER_NAME);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to request gpio %ld\n",
> +				gpio);
> +			return ret;
> +		}
> +		state->gpio_addrs[i] = gpio;
> +		gpio_direction_output(state->gpio_addrs[i], 0);
> +	}
> +
> +	return 0;
> +}
