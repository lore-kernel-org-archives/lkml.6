Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeCGPwN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40573 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934166AbeCGPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:52:02 -0500
X-Google-Smtp-Source: AG47ELvYOxZ20uoYKc6nqsyuxUUQRyztkXE4vtsEMFHv8OUGEjv8YUiZasO8h11U1ZrGI6dE3d7D7Q==
Date: Wed, 7 Mar 2018 15:51:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as
 a subdevice.
Message-ID: <20180307155158.7quxpjglnocxjxku@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-5-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has RTC host command support and instatiate
> the RTC driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [4/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [4/8] Add the Reviewed-by Gwendal.
> 
>  drivers/mfd/cros_ec_dev.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index f98e5beffca6..33fe1b439ee2 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -389,6 +389,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static const struct mfd_cell cros_ec_rtc_cell = {
> +	.name = "cros-ec-rtc",
> +};
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -437,6 +441,16 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	/* check whether this EC instance has RTC host command support */

Nit: "Check ..."

> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
> +		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +					 &cros_ec_rtc_cell, 1, NULL, 0, NULL);

Please use ARRAY_SIZE().

> +		if (retval)
> +			dev_err(ec->dev,
> +				"failed to add cros-ec-rtc device: %d\n",
> +				retval);
> +	}
> +
>  	/* Take control of the lightbar from the EC. */
>  	lb_manual_suspend_ctrl(ec, 1);
>  

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
