Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCNU7b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:59:31 -0400
Received: from avasout06.plus.net ([212.159.14.18]:42037 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCNU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:59:29 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fL8XI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=beXlt2xKAAAA:8
 a=fxZjIJLCPaIycJdo6jkA:9 a=aP5k2Ks-GnYjluUe:21 a=SeZQ477pr3i55Sbe:21
 a=CjuIK1q_8ugA:10 a=gcY2M4Ci8LIz02MwfSIM:22
Date: Wed, 14 Mar 2018 20:51:55 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] Input: atmel_mxt_ts - switch from OF to generic
 device properties
Message-ID: <20180314205155.GB26353@lava.h.shmanahar.org>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312190907.174301-3-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfI/qYdZxJS3pbHwtjm6wcmogfLjIlWzfxkPiyTmYMH4vHklhkUGoxqdIMk60rkZplJaOO13+jQO+j/+DFw5pf87dF18g4PnOQqpWw+Vij4j8Qfue1l6x
 04kcS7PrIthnA/HHl/LtKKgA1owmLkB4hs6nTvjyiWhgSMMzJCvA3vt4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:08:55PM -0700, Dmitry Torokhov wrote:
> Instead of using OF-specific APIs to fecth device properties, let's switch
> to generic device properties API. This will allow us to use device
> properties on legacy ChromeOS devices and get rid of platform data down
> the road.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 59 ++++++++++++------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 1aabfae1297ba..072b78d3c6e00 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/property.h>
>  #include <asm/unaligned.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
> @@ -2920,47 +2921,52 @@ static void mxt_input_close(struct input_dev *dev)
>  	mxt_stop(data);
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> +static const struct mxt_platform_data *
> +mxt_parse_device_properties(struct i2c_client *client)
>  {
> +	static const char keymap_property[] = "linux,gpio-keymap";
>  	struct mxt_platform_data *pdata;
> -	struct device_node *np = client->dev.of_node;
>  	u32 *keymap;
> -	int proplen, ret;
> -
> -	if (!np)
> -		return ERR_PTR(-ENOENT);
> +	int n_keys;
> +	int error;
>  
>  	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (of_find_property(np, "linux,gpio-keymap", &proplen)) {
> -		pdata->t19_num_keys = proplen / sizeof(u32);
> +	if (device_property_present(&client->dev, keymap_property)) {
> +		n_keys = device_property_read_u32_array(&client->dev,
> +							keymap_property,
> +							NULL, 0);
> +		if (n_keys <= 0) {
> +			error = n_keys < 0 ? n_keys : -EINVAL;
> +			dev_err(&client->dev,
> +				"invalid/malformed '%s' property: %d\n",
> +				keymap_property, error);
> +			return ERR_PTR(error);
> +		}
>  
> -		keymap = devm_kzalloc(&client->dev,
> -				pdata->t19_num_keys * sizeof(keymap[0]),
> -				GFP_KERNEL);
> +		keymap = devm_kmalloc_array(&client->dev, n_keys, sizeof(u32),
> +					    GFP_KERNEL);
>  		if (!keymap)
>  			return ERR_PTR(-ENOMEM);
>  
> -		ret = of_property_read_u32_array(np, "linux,gpio-keymap",
> -						 keymap, pdata->t19_num_keys);
> -		if (ret)
> -			dev_warn(&client->dev,
> -				 "Couldn't read linux,gpio-keymap: %d\n", ret);
> +		error = device_property_read_u32_array(&client->dev,
> +						       keymap_property,
> +						       keymap, n_keys);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to parse '%s' property: %d\n",
> +				keymap_property, error);
> +			return ERR_PTR(error);
> +		}
>  
>  		pdata->t19_keymap = keymap;
> +		pdata->t19_num_keys = n_keys;
>  	}
>  
>  	return pdata;
>  }
> -#else
> -static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> -{
> -	return ERR_PTR(-ENOENT);
> -}
> -#endif
>  
>  #ifdef CONFIG_ACPI
>  
> @@ -3094,16 +3100,11 @@ mxt_get_platform_data(struct i2c_client *client)
>  	if (pdata)
>  		return pdata;
>  
> -	pdata = mxt_parse_dt(client);
> -	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
> -		return pdata;
> -
>  	pdata = mxt_parse_acpi(client);
>  	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
>  		return pdata;
>  
> -	dev_err(&client->dev, "No platform data specified\n");
> -	return ERR_PTR(-EINVAL);
> +	return mxt_parse_device_properties(client);
>  }
>  
>  static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
> -- 
> 2.16.2.660.g709887971b-goog
> 
