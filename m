Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033751AbeEXQfO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:35:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40077 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031270AbeEXQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:35:11 -0400
X-Google-Smtp-Source: AB8JxZrGBaYE814Fh4nybA5c5XTVqDbrfUZgWJosBnbrxfMEErBB801KDom2oZmRUYNeDxIptv3yHQ==
Date: Thu, 24 May 2018 09:35:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCHv2] Input: atmel_mxt_ts - fix reset-gpio for level based
 irqs
Message-ID: <20180524163507.GB177107@dtor-ws>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:58:44PM +0200, Sebastian Reichel wrote:
> The current reset-gpio support triggers an interrupt storm on platforms
> using the maxtouch with level based interrupt. The Motorola Droid 4,
> which I used for some of the tests is not affected, since it uses a edge
> based interrupt.
> 
> This change avoids the interrupt storm by enabling the device while its
> interrupt is disabled. Afterwards we wait 100ms. This is important for
> two reasons: The device is unresponsive for some time (~22ms for
> mxt224E) and the CHG (interrupt) line is not working properly for 100ms.
> We don't need to wait for any following interrupts, since the following
> mxt_initialize() checks for bootloader mode anyways.
> 
> This fixes a boot issue on GE PPD (watchdog kills device due to
> interrupt storm) and does not cause regression on Motorola Droid 4.
> 
> Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applied, thank you.

> ---
> Changes since PATCHv2:
>  * fix patch description
>  * use same timeout value for soft and gpio-reset
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 5d9699fe1b55..f97fbb0af020 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -194,6 +194,8 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> +#define MXT_RESET_GPIO_TIME	20	/* msec */
> +#define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
> @@ -1206,7 +1208,7 @@ static int mxt_soft_reset(struct mxt_data *data)
>  		return ret;
>  
>  	/* Ignore CHG line for 100ms after reset */
> -	msleep(100);
> +	msleep(MXT_RESET_INVALID_CHG);
>  
>  	mxt_acquire_irq(data);
>  
> @@ -3167,20 +3169,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return error;
>  	}
>  
> +	disable_irq(client->irq);
> +
>  	if (data->reset_gpio) {
> -		data->in_bootloader = true;
> -		msleep(MXT_RESET_TIME);
> -		reinit_completion(&data->bl_completion);
> +		msleep(MXT_RESET_GPIO_TIME);
>  		gpiod_set_value(data->reset_gpio, 1);
> -		error = mxt_wait_for_completion(data, &data->bl_completion,
> -						MXT_RESET_TIMEOUT);
> -		if (error)
> -			return error;
> -		data->in_bootloader = false;
> +		msleep(MXT_RESET_INVALID_CHG);
>  	}
>  
> -	disable_irq(client->irq);
> -
>  	error = mxt_initialize(data);
>  	if (error)
>  		return error;
> -- 
> 2.17.0
> 

-- 
Dmitry
