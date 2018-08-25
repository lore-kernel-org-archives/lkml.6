Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E7208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnguh+aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5E7208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeHYMdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYMdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:33:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A5F208C0;
        Sat, 25 Aug 2018 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535187335;
        bh=YK1leXHhoxD9UGkbCQCLVugi2DmCL9Goyz508mchoIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qnguh+aCv7UPyHHoAWfzpWmYcIwThQ37XrbF5u00YnfeqI8GC0HjJBglD13WJGVk7
         kdwDHV0sbNLtit3e/EQdYA4GGm75a3nz/4rb8kXm4NFwgrh5BumCYVvtA2BaZwc3HA
         PWcJ3hpVapQ9a6FMoKX+bepzOq1WNG3KToPgsmc0=
Date:   Sat, 25 Aug 2018 09:55:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: make vref regulator optional
Message-ID: <20180825095531.374af32f@archlinux>
In-Reply-To: <20180824202447.21804-1-marcus.folkesson@gmail.com>
References: <20180824202447.21804-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:24:47 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The `vref` regulator is declared as optional in the device-tree binding,
> but the driver does require it.
> 
> Go for the device-tree binding and make the `vref` regulator optional.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hmm. 
If you do a voltage get on a stub regulator it will return an
error (IIRC).

So I am unconvinced this actually makes any real difference?

What am I missing?

Jonathan

> ---
>  drivers/iio/dac/ti-dac5571.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index f6dcd8bce2b0..bf21cc312096 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -251,6 +251,9 @@ static int dac5571_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> +		if (!data->vref)
> +			return -EOPNOTSUPP;
> +
>  		ret = regulator_get_voltage(data->vref);
>  		if (ret < 0)
>  			return ret;
> @@ -335,13 +338,21 @@ static int dac5571_probe(struct i2c_client *client,
>  	indio_dev->num_channels = spec->num_channels;
>  	data->spec = spec;
>  
> -	data->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(data->vref))
> -		return PTR_ERR(data->vref);
> +	data->vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(data->vref)) {
> +		if (PTR_ERR(data->vref) == -ENODEV) {
> +			data->vref = NULL;
> +		} else {
> +			dev_err(dev, "failed to get regulator (%ld)\n",
> +					PTR_ERR(data->vref));
> +			return PTR_ERR(data->vref);

That is as likely as not a deferred probe so it should not be
as noisy as this.  It may happen during a normal boot process a lot
of times.


> +		}
>  
> -	ret = regulator_enable(data->vref);
> -	if (ret < 0)
> -		return ret;
> +	} else {
> +		ret = regulator_enable(data->vref);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	mutex_init(&data->lock);
>  
> @@ -373,7 +384,9 @@ static int dac5571_probe(struct i2c_client *client,
>  	return 0;
>  
>   err:
> -	regulator_disable(data->vref);
> +	if (data->vref)
> +		regulator_disable(data->vref);
> +
>  	return ret;
>  }
>  
> @@ -383,7 +396,8 @@ static int dac5571_remove(struct i2c_client *i2c)
>  	struct dac5571_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	regulator_disable(data->vref);
> +	if (data->vref)
> +		regulator_disable(data->vref);
>  
>  	return 0;
>  }

