Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDTRpN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:45:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:45:11 -0400
Message-ID: <7b4976b0a8a642767bd4e0a5e9d7fb6c9dc86ec9.camel@collabora.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix reset-gpio for level based
 irqs
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com
Date: Fri, 20 Apr 2018 14:44:02 -0300
In-Reply-To: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, 2018-04-20 at 19:24 +0200, Sebastian Reichel wrote:
> The current reset-gpio support triggers an interrupt storm on platforms
> using the maxtouch with level based interrupt. The Motorola Droid 4,
> which I used for some of the tests is not affected, since it uses a level
> based interrupt.
> 

I found this confusing. Interrupt storm happen with level-based interrupts,
but the Droid4 is not affected?

> This change avoids the interrupt storm by enabling the device while
> its interrupt is disabled. The following mxt_initialize() requires,
> that the device is responsive (at least mxt224E is unresponsive for
> ~22ms), so we wait some time. We don't wait for leaving bootloader
> mode anymore, since mxt_initialize() checks for it anyways.
> 

IMHO, having some more or less arbritrary sleeps is almost
always a problem. This value might be enough for some platform,
might be too short for some other, and then it might get too large
for someone else.

> This fixes a boot problem on GE PPD (watchdog kills device) and also
> has been tested on the Droid 4.
> 
> Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 5d9699fe1b55..f8a9f2a47e78 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -194,6 +194,7 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> +#define MXT_RESET_GPIO_TIME	20	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
> @@ -3167,20 +3168,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
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

Can't we enable the IRQ here, just before the wait...

> -		error = mxt_wait_for_completion(data, &data->bl_completion,
> -						MXT_RESET_TIMEOUT);

... and then disable it back afterwards?

> -		if (error)
> -			return error;
> -		data->in_bootloader = false;
> +		msleep(MXT_RESET_TIME);

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
> 
