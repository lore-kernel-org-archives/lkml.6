Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB429ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7CB208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pl54qqcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7CB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeISKi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:38:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:38:28 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8J52Jbr050684;
        Wed, 19 Sep 2018 00:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537333339;
        bh=IY+dFm13u+lX1MqyKCrBRaqr9DyvUdXifBHArFWIrQE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pl54qqcleZz07Fm7DtN/6pVduHpksoNjUjD8uDYPyc9ZEaG0JHedo4NrxATe16z1n
         vxLo/ACUfeCIynd7mWiFbqDolE2WaD9o+BvsmgZmJW74/m4g7e3EEb3UI1CdkxDLyk
         UOW6TFStb74qdg5FcdCeb6Pl4QbAqpv9CfKtbMbQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52JtZ025140;
        Wed, 19 Sep 2018 00:02:19 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 00:02:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 00:02:19 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52GHY022929;
        Wed, 19 Sep 2018 00:02:17 -0500
Subject: Re: [PATCH 3/5] gpio: davinci: Allocate the correct amount of memory
 for controller
To:     "Andrew F. Davis" <afd@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-3-afd@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <1cc3aa9b-a736-ee14-d414-8a2b1c4ea659@ti.com>
Date:   Wed, 19 Sep 2018 10:32:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180831191326.25106-3-afd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
> Previously we created a controller structure per bank of GPIO pins. This
> has since been changed to one per controller, but the allocation size
> was not changed. Fix this here.
> 
> This also leaves the variable 'nbank' unused, instead of removing it,
> move it down and use it to clean up a loop. For loops with multiple
> initializers and/or iteration expressions, especially ones that don't
> use those loop counters are quite hard to follow, fix this.
> 

Tested for gpio interrupts on k2g and da850-lcdk

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Keerthy <j-keerthy@ti.com>

> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 14d1729927d3..121a7948f785 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -165,7 +165,7 @@ davinci_gpio_get_pdata(struct platform_device *pdev)
>  
>  static int davinci_gpio_probe(struct platform_device *pdev)
>  {
> -	int gpio, bank, i, ret = 0;
> +	int bank, i, ret = 0;
>  	unsigned int ngpio, nbank, nirq;
>  	struct davinci_gpio_controller *chips;
>  	struct davinci_gpio_platform_data *pdata;
> @@ -204,10 +204,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  	else
>  		nirq = DIV_ROUND_UP(ngpio, 16);
>  
> -	nbank = DIV_ROUND_UP(ngpio, 32);
> -	chips = devm_kcalloc(dev,
> -			     nbank, sizeof(struct davinci_gpio_controller),
> -			     GFP_KERNEL);
> +	chips = devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
>  	if (!chips)
>  		return -ENOMEM;
>  
> @@ -247,7 +244,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  #endif
>  	spin_lock_init(&chips->lock);
>  
> -	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
> +	nbank = DIV_ROUND_UP(ngpio, 32);
> +	for (bank = 0; bank < nbank; bank++)
>  		chips->regs[bank] = gpio_base + offset_array[bank];
>  
>  	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
> 
