Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63298C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244F20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544285534;
	bh=cimpes1rh1STQSzkQndE+MoFUC2JHbN1Xcq1Dqxi/tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jAFbCeyJuXZlLfkrZWySm4QNGyy/Xb8gxePNfDivLguvFviWvxCRg5vNr9HRl2Qts
	 PJngtTPlre9zCMT4aRfxtE2JeVtPal2CAqf+2xlZoOJQBm7sn029VOMdJmMqQT+Rtt
	 SeWjkrMH7xjskGhSdSZsrPNqou/XVAi4fvnrF1XM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLHQMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLHQMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:12:13 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30C02081C;
        Sat,  8 Dec 2018 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544285532;
        bh=cimpes1rh1STQSzkQndE+MoFUC2JHbN1Xcq1Dqxi/tU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rmzl8lzlochnUlFsNsh4NgH9/0yA7ewghUL9gVKf1tQ+mkzuHpamyg9+F50yhTB1X
         s5TtKmprqiy5tnJH2xHYEauRYbbHUYLQ4jhS59GvevJmTu0BSHScFa2pxulyknZR+4
         DN6MdGaS95nRub77uQJVmePXGTdL0rMyMm2JeKcs=
Date:   Sat, 8 Dec 2018 16:12:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Staging: iio: adt7316: Move interrupt related
 code
Message-ID: <20181208161207.47ee755c@archlinux>
In-Reply-To: <20181208151638.8759-3-shreeya.patel23498@gmail.com>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
        <20181208151638.8759-3-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Dec 2018 20:46:37 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> There is a function adt7316_irq_setup() where irq_type is being
> set. It would be good to move devm_request_threaded_irq() function
> and assignment of chip->config1 in adt7316_irq_setup() to unclutter
> the code in probe function.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
As commented below, this didn't end up as tidy as it might have been.
It would I think have been simpler before patch 1 or just merged with it.

Anyhow, I might combine the two whilst applying. However before I do
that I'd like to leave this on list for a few days to let Alex
or others have time for another look before I apply it.

All heading in the right direction!

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 34 ++++++++++++++---------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 86b2c3d53588..97dd48153293 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1807,11 +1807,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static int adt7316_setup_irq(struct device *dev, int irq)
> +static int adt7316_setup_irq(struct iio_dev *indio_dev)

Hmm. This has ended up a lot more complex than ideal due
to the effective two layers of rework.  

I would either have done patches 1 and 2 as one patch or
reordered them so the rework preceded the change
to DT.  It's not that important but it would have lead
to code that was easier to review.


>  {
> -	int irq_type;
> +	struct adt7316_chip_info *chip = iio_priv(indio_dev);
> +	int irq_type, ret;
>  
> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
>  
>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:
> @@ -1821,13 +1822,23 @@ static int adt7316_setup_irq(struct device *dev, int irq)
>  	case IRQF_TRIGGER_FALLING:
>  		break;
>  	default:
> -		dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
> +		dev_info(&indio_dev->dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
>  			 irq_type);
>  		irq_type = IRQF_TRIGGER_LOW;
>  		break;
>  	}
>  
> -	return irq_type;
> +	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
> +					NULL, adt7316_event_handler,
> +					irq_type | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (irq_type & IRQF_TRIGGER_HIGH)
> +		chip->config1 |= ADT7316_INT_POLARITY;
> +
> +	return ret;
>  }
>  
>  /*
> @@ -2124,7 +2135,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	int irq_type;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2168,19 +2178,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (chip->bus.irq > 0) {
> -		irq_type = adt7316_setup_irq(dev, chip->bus.irq);
> -
> -		ret = devm_request_threaded_irq(dev, chip->bus.irq,
> -						NULL,
> -						adt7316_event_handler,
> -						irq_type | IRQF_ONESHOT,
> -						indio_dev->name,
> -						indio_dev);
> +		ret = adt7316_setup_irq(indio_dev);
>  		if (ret)
>  			return ret;
> -
> -		if (irq_type & IRQF_TRIGGER_HIGH)
> -			chip->config1 |= ADT7316_INT_POLARITY;
>  	}
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);

