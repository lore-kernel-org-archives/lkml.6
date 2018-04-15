Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDOTd3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 15:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752464AbeDOTd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 15:33:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DC82172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:33:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
Subject: Re: [PATCH v3 06/11] iio: inkern: add module put/get on iio dev
 module when requesting channels
Message-ID: <20180415203321.1aaaf91e@archlinux>
In-Reply-To: <1523350677-27106-7-git-send-email-eugen.hristev@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
        <1523350677-27106-7-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 11:57:52 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> When requesting channels for a particular consumer device,
> besides requesting the device (incrementing the reference counter), also
> do it for the driver module of the iio dev. This will avoid the situation
> where the producer IIO device can be removed and the consumer is still
> present in the kernel.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/inkern.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ec98790..68d9b87 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> @@ -152,6 +153,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
>  	if (index < 0)
>  		goto err_put;
>  	channel->channel = &indio_dev->channels[index];
> +	try_module_get(channel->indio_dev->driver_module);

And if it fails? (the module we are trying to get is going away...)

We should try and handle it I think. Be it by just erroring out of here.


>  
>  	return 0;
>  
> @@ -256,8 +258,10 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
>  	return chans;
>  
>  error_free_chans:
> -	for (i = 0; i < mapind; i++)
> +	for (i = 0; i < mapind; i++) {
> +		module_put(chans[i].indio_dev->driver_module);
>  		iio_device_put(chans[i].indio_dev);
> +	}
>  	kfree(chans);
>  	return ERR_PTR(ret);
>  }
> @@ -351,6 +355,7 @@ void iio_channel_release(struct iio_channel *channel)
>  {
>  	if (!channel)
>  		return;
> +	module_put(channel->indio_dev->driver_module);
>  	iio_device_put(channel->indio_dev);
>  	kfree(channel);
>  }
> @@ -482,6 +487,7 @@ void iio_channel_release_all(struct iio_channel *channels)
>  	struct iio_channel *chan = &channels[0];
>  
>  	while (chan->indio_dev) {
> +		module_put(chan->indio_dev->driver_module);
>  		iio_device_put(chan->indio_dev);
>  		chan++;
>  	}
