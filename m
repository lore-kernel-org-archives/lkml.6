Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84320C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661304;
	bh=H9lvt2dZN2U3ZznqR+KLbXVUmdkuK4q1/fluhzNMrb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UwB77yaoAeLsxrTT9PxeH6ukTYmT3epG78wI9ZOFvGh/HPmpo6BmTG2M+L9w/QS8d
	 ZBxNycF6xN1QwFN20g1xnor2sh887h03QOBdckoLNuBHLLIbr6QtoRauC15WP4vyCj
	 W2DGGyfY96cNAWlVcOdzb7NtcB0RGvOgtFMoJ3jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfBTLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBTLPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:15:02 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F86205F4;
        Wed, 20 Feb 2019 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550661301;
        bh=H9lvt2dZN2U3ZznqR+KLbXVUmdkuK4q1/fluhzNMrb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yH+BHqqTGoKnSTEZ6WbTdkpQ+s0HuykZpbEebUMjJV4mxRPCmcthAaGnrq+3UeFYX
         nFwBjcD8zTYpbZz0vPIQEiaZHa8+9patIB+85nAsdJLpxzGycgY2epTp7bkHS2edj3
         Dgs4AobLOeDgwB9tBnu6IBDhPuCKbGZdzd9MqP/k=
Date:   Wed, 20 Feb 2019 11:14:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/7] iio: inkern: API for reading available iio channel
 attribute values
Message-ID: <20190220111447.31a6cdb7@archlinux>
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 15:29:10 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Extend the inkern API with a function for reading available
> attribute values of iio channels.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Hmm. It would have been cleaner if we'd done the generic version
in the first place rather than just having the raw value
equivalent of this.

Would you mind sending a follow up patch to convert that call
over to a simple stub around this function?
The alternative would be to convert the few users over to this
function.  Hmm. Probably best to just share the code as much as
possible and for now leave the old function in place.

Anyhow, this looks good ;)

Given the battery driver is tied up with this, it will make sense
for them to go together.  Probably a case for an immutable branch
either in iio or the relevant battery tree.

Assuming it'll be the battery tree.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The cleanup suggested above can follow at some later time.

Thanks,

Jonathan


> ---
>  drivers/iio/inkern.c         | 20 ++++++++++++++++++++
>  include/linux/iio/consumer.h | 14 ++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 06ca3f7fcc44..f19dbde3c945 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -733,6 +733,26 @@ static int iio_channel_read_avail(struct iio_channel *chan,
>  						 vals, type, length, info);
>  }
>  
> +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> +				     const int **vals, int *type, int *length,
> +				     enum iio_chan_info_enum attribute)
> +{
> +	int ret;
> +
> +	mutex_lock(&chan->indio_dev->info_exist_lock);
> +	if (!chan->indio_dev->info) {
> +		ret = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	ret = iio_channel_read_avail(chan, vals, type, length, attribute);
> +err_unlock:
> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
> +
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>  			       const int **vals, int *length)
>  {
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 9887f4f8e2a8..b2d34831ed7c 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -290,6 +290,20 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>  			       const int **vals, int *length);
>  
> +/**
> + * iio_read_avail_channel_attribute() - read available channel attribute values
> + * @chan:		The channel being queried.
> + * @vals:		Available values read back.
> + * @type:		Type of values read back.
> + * @length:		Number of entries in vals.
> + * @attribute:		info attribute to be read back.
> + *
> + * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
> + */
> +int iio_read_avail_channel_attribute(struct iio_channel *chan,
> +				     const int **vals, int *type, int *length,
> +				     enum iio_chan_info_enum attribute);
> +
>  /**
>   * iio_get_channel_type() - get the type of a channel
>   * @channel:		The channel being queried.

