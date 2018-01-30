Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeA3Kef (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:34:35 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:36971 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeA3Ked (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:34:33 -0500
Date: Tue, 30 Jan 2018 11:34:21 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, kernel@pengutronix.de,
        Denis.Osterland@diehl.com
Subject: Re: [PATCH 3/4] rtc: isl1208: enable interrupt after context
 preparation
Message-ID: <20180130103421.GE2809@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-4-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123121801.4214-4-m.grzeschik@pengutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/01/2018 at 13:18:00 +0100, Michael Grzeschik wrote:
> The interrupt handler got enabled very early. If the interrupt cause is
> triggering immediately before the context is fully prepared. This can
> lead to undefined behaviour. Therefor we move the interrupt enable code
> to the end of the probe function.
> 

Can you fix it using devm_rtc_allocate_device()/rtc_register_device() as
done in https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=994ec64c0a193940be7a6fd074668b9446d3b6c3

> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index c8b4953482296..a13a4ba79004d 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -635,23 +635,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (isl1208_i2c_validate_client(client) < 0)
>  		return -ENODEV;
>  
> -	if (client->irq > 0) {
> -		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					       isl1208_rtc_interrupt,
> -					       IRQF_SHARED | IRQF_ONESHOT,
> -					       isl1208_driver.driver.name,
> -					       client);
> -		if (!rc) {
> -			device_init_wakeup(&client->dev, 1);
> -			enable_irq_wake(client->irq);
> -		} else {
> -			dev_err(&client->dev,
> -				"Unable to request irq %d, no alarm support\n",
> -				client->irq);
> -			client->irq = 0;
> -		}
> -	}
> -
>  	rtc = devm_rtc_device_register(&client->dev, isl1208_driver.driver.name,
>  				  &isl1208_rtc_ops,
>  				  THIS_MODULE);
> @@ -674,6 +657,23 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (client->irq > 0) {
> +		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					       isl1208_rtc_interrupt,
> +					       IRQF_SHARED | IRQF_ONESHOT,
> +					       isl1208_driver.driver.name,
> +					       client);
> +		if (!rc) {
> +			device_init_wakeup(&client->dev, 1);
> +			enable_irq_wake(client->irq);
> +		} else {
> +			dev_err(&client->dev,
> +				"Unable to request irq %d, no alarm support\n",
> +				client->irq);
> +			client->irq = 0;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
