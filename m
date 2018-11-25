Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB50C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CCC20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRY3W0UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CCC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeKYWkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:40:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BDF20865;
        Sun, 25 Nov 2018 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543146551;
        bh=yc/BKMMV0TH6Gud/B9bpI5u6a3EiK9I6cembrh2YkIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aRY3W0ULtQbJeA77pRDH0XqgPeoT6WeGCF0hbmfhGxJE+81P78EcXss7sVSHAd12m
         0rzvGf/87kEO/qhlXnKFAh4N89UCiDadHcfXy2yaDy7QMKo+vo0W0EAW9jhs7CKqxt
         p4enPsuctVbp/EwMlXrR7GGrffUxYiExZX/6Rn/Q=
Date:   Sun, 25 Nov 2018 11:49:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Staging: iio: adt7316: Use device tree data to
 set ldac_pin
Message-ID: <20181125114907.0691c6c7@archlinux>
In-Reply-To: <20181120165436.7178-1-shreeya.patel23498@gmail.com>
References: <20181120165436.7178-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 22:24:36 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Make the driver use device tree instead of the platform data.
> Hence, use devm_gpiod_get_optional function to get the data from
> device tree for ldac-pin and accordingly make the needed changes
> in the driver.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Sorry, missed this previously.  This is definitely a non standard
gpio name, so should be prefixed in the binding and here with
adi,

I'll fix up, but please check I didn't mess it up!

Applied with that change to the togreg branch of iio.git.

Thanks,

Jonathan
 
> ---
>  drivers/staging/iio/addac/adt7316.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 3f22d1088713..deb2f7b40f60 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -177,7 +177,7 @@
>  
>  struct adt7316_chip_info {
>  	struct adt7316_bus	bus;
> -	u16			ldac_pin;
> +	struct gpio_desc	*ldac_pin;
>  	u16			int_mask;	/* 0x2f */
>  	u8			config1;
>  	u8			config2;
> @@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  		if (ret)
>  			return -EIO;
>  	} else {
> -		gpio_set_value(chip->ldac_pin, 0);
> -		gpio_set_value(chip->ldac_pin, 1);
> +		gpiod_set_value(chip->ldac_pin, 0);
> +		gpiod_set_value(chip->ldac_pin, 1);
>  	}
>  
>  	return len;
> @@ -2120,7 +2120,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	else
>  		return -ENODEV;
>  
> -	chip->ldac_pin = adt7316_platform_data[1];
> +	chip->ldac_pin = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
> +	if (IS_ERR(chip->ldac_pin)) {
> +		ret = PTR_ERR(chip->ldac_pin);
> +		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (chip->ldac_pin) {
>  		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
>  		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)

