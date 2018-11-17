Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E16C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C38220817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8cDSNk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C38220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKRD0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeKRD0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:26:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150C8206BA;
        Sat, 17 Nov 2018 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542474541;
        bh=dKg6ALVXaFQE47SjX1hqptgdEl6lCD5QORh07rss5fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l8cDSNk2g9NQw+6FqDPi2qBxCRiTJZEjaoXp3L9FMqhyy8oCBwN4d12HRLbPj1mOi
         dVMU4iO/ooTkz0foO5M57Oe8JFuF0St9alU0S1/c2q4GeCXS5EpbcqG7hn4gFjmDZZ
         qyZvIFBZgkbI+3hVM7oy6+480us3+iyztd/9qcPc=
Date:   Sat, 17 Nov 2018 17:08:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Staging: iio: adt7316: Use device tree data to
 assign irq_type
Message-ID: <20181117170856.5637f708@archlinux>
In-Reply-To: <20181116230455.25073-1-shreeya.patel23498@gmail.com>
References: <20181116230455.25073-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018 04:34:55 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> ADT7316 driver no more uses platform data and hence use device tree
> data instead of platform data for assigning irq_type field.
> Switch case figures out the type of irq and if it's the default case
> then assign the default value to the irq_type i.e.
> irq_type = IRQF_TRIGGER_LOW
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I think this set of 3 patches around irq type are fine.  If no
one else finds any issues, I'll pick up in v2.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9c72538baf9e..c647875a64f5 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int irq_type = IRQF_TRIGGER_LOW;
> +	int irq_type;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (chip->bus.irq > 0) {
> -		if (adt7316_platform_data[0])
> -			irq_type = adt7316_platform_data[0];
> +		irq_type =
> +			irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +
> +		switch (irq_type) {
> +		case IRQF_TRIGGER_HIGH:
> +		case IRQF_TRIGGER_RISING:
> +			break;
> +		case IRQF_TRIGGER_LOW:
> +		case IRQF_TRIGGER_FALLING:
> +			break;
> +		default:
> +			dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
> +				 irq_type);
> +			irq_type = IRQF_TRIGGER_LOW;
> +			break;
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, chip->bus.irq,
>  						NULL,

