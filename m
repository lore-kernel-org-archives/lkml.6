Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BC3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B8621916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfBQOiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:38:02 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34829 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfBQOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:38:02 -0500
Received: from webmail.gandi.net (webmail6.sd4.0x35.net [10.200.201.6])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPA id 6C4FAC0005;
        Sun, 17 Feb 2019 14:37:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Feb 2019 15:37:58 +0100
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/7] iio: inkern: API for reading available iio channel
 attribute values
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
Message-ID: <0fb5a3fef7c4a790b208cf0f3651c059@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is supposed to contain 5 patches, not 7. So this patch is 
actually 1/5. My apologies for the mistake.

Artur

On 2019-02-17 15:29, Artur Rojek wrote:
> Extend the inkern API with a function for reading available
> attribute values of iio channels.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/iio/inkern.c         | 20 ++++++++++++++++++++
>  include/linux/iio/consumer.h | 14 ++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 06ca3f7fcc44..f19dbde3c945 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -733,6 +733,26 @@ static int iio_channel_read_avail(struct 
> iio_channel *chan,
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
> diff --git a/include/linux/iio/consumer.h 
> b/include/linux/iio/consumer.h
> index 9887f4f8e2a8..b2d34831ed7c 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -290,6 +290,20 @@ int iio_read_max_channel_raw(struct iio_channel
> *chan, int *val);
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>  			       const int **vals, int *length);
> 
> +/**
> + * iio_read_avail_channel_attribute() - read available channel 
> attribute values
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

