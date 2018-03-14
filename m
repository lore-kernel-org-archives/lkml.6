Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeCNVAB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:00:01 -0400
Received: from avasout05.plus.net ([84.93.230.250]:35272 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeCNU77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:59:59 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=J9KEEjvS c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=beXlt2xKAAAA:8
 a=SPACMrjmOz8H3TWAVbcA:9 a=mUwzUsA8ZbHA0aK7:21 a=yrFacnBGrNHf5BOi:21
 a=CjuIK1q_8ugA:10 a=gcY2M4Ci8LIz02MwfSIM:22
Date: Wed, 14 Mar 2018 20:52:27 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] Input: atmel_mxt_ts - switch ChromeOS ACPI devices
 to generic props
Message-ID: <20180314205227.GC26353@lava.h.shmanahar.org>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312190907.174301-4-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfJ61BZga71UuNPy5C9OMX9YeeQOiGQ1qjcTW6RJaFQa+Y1QxBgVt+tfnIdEsp03iMW6tlcVMjQ+ahbbH18dlBcxFp+HvqV6bW0/mpw08njdfyYvnQOBO
 3Wib46mNvw2OSmquEh/yz0zzhuNrdnV+QUF2uw3uMDoyjmXEPKaGQCHt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:08:56PM -0700, Dmitry Torokhov wrote:
> Move older ChromeOS devices describing Atmel controllers in ACPI, but not
> providing enough details to configure the controllers properly, from
> platform data over to generic device properties. This will allow us
> remove support for platform data later on, leaving only generic device
> properties in place.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 63 +++++++++++++++---------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 072b78d3c6e00..cf2aac4e79ae8 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2972,7 +2972,7 @@ mxt_parse_device_properties(struct i2c_client *client)
>  
>  struct mxt_acpi_platform_data {
>  	const char *hid;
> -	struct mxt_platform_data pdata;
> +	const struct property_entry *props;
>  };
>  
>  static unsigned int samus_touchpad_buttons[] = {
> @@ -2982,14 +2982,16 @@ static unsigned int samus_touchpad_buttons[] = {
>  	BTN_LEFT
>  };
>  
> +static const struct property_entry samus_touchpad_props[] = {
> +	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", samus_touchpad_buttons),
> +	{ }
> +};
> +
>  static struct mxt_acpi_platform_data samus_platform_data[] = {
>  	{
>  		/* Touchpad */
>  		.hid	= "ATML0000",
> -		.pdata	= {
> -			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
> -			.t19_keymap	= samus_touchpad_buttons,
> -		},
> +		.props	= samus_touchpad_props,
>  	},
>  	{
>  		/* Touchscreen */
> @@ -3007,14 +3009,16 @@ static unsigned int chromebook_tp_buttons[] = {
>  	BTN_LEFT
>  };
>  
> +static const struct property_entry chromebook_tp_props[] = {
> +	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_tp_buttons),
> +	{ }
> +};
> +
>  static struct mxt_acpi_platform_data chromebook_platform_data[] = {
>  	{
>  		/* Touchpad */
>  		.hid	= "ATML0000",
> -		.pdata	= {
> -			.t19_num_keys	= ARRAY_SIZE(chromebook_tp_buttons),
> -			.t19_keymap	= chromebook_tp_buttons,
> -		},
> +		.props	= chromebook_tp_props,
>  	},
>  	{
>  		/* Touchscreen */
> @@ -3044,7 +3048,7 @@ static const struct dmi_system_id mxt_dmi_table[] = {
>  	{ }
>  };
>  
> -static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
> +static int mxt_acpi_probe(struct i2c_client *client)
>  {
>  	struct acpi_device *adev;
>  	const struct dmi_system_id *system_id;
> @@ -3061,33 +3065,46 @@ static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
>  	 * as a threshold.
>  	 */
>  	if (client->addr < 0x40)
> -		return ERR_PTR(-ENXIO);
> +		return -ENXIO;
>  
>  	adev = ACPI_COMPANION(&client->dev);
>  	if (!adev)
> -		return ERR_PTR(-ENOENT);
> +		return -ENOENT;
>  
>  	system_id = dmi_first_match(mxt_dmi_table);
>  	if (!system_id)
> -		return ERR_PTR(-ENOENT);
> +		return -ENOENT;
>  
>  	acpi_pdata = system_id->driver_data;
>  	if (!acpi_pdata)
> -		return ERR_PTR(-ENOENT);
> +		return -ENOENT;
>  
>  	while (acpi_pdata->hid) {
> -		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid))
> -			return &acpi_pdata->pdata;
> +		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid)) {
> +			/*
> +			 * Remove previously installed properties if we
> +			 * are probing this device not for the very first
> +			 * time.
> +			 */
> +			device_remove_properties(&client->dev);
> +
> +			/*
> +			 * Now install the platform-specific properties
> +			 * that are missing from ACPI.
> +			 */
> +			device_add_properties(&client->dev, acpi_pdata->props);
> +			break;
> +		}
>  
>  		acpi_pdata++;
>  	}
>  
> -	return ERR_PTR(-ENOENT);
> +	return 0;
>  }
>  #else
> -static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
> +static int mxt_acpi_probe(struct i2c_client *client)
>  {
> -	return ERR_PTR(-ENOENT);
> +	return -ENOENT;
>  }
>  #endif
>  
> @@ -3100,10 +3117,6 @@ mxt_get_platform_data(struct i2c_client *client)
>  	if (pdata)
>  		return pdata;
>  
> -	pdata = mxt_parse_acpi(client);
> -	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
> -		return pdata;
> -
>  	return mxt_parse_device_properties(client);
>  }
>  
> @@ -3113,6 +3126,10 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	const struct mxt_platform_data *pdata;
>  	int error;
>  
> +	error = mxt_acpi_probe(client);
> +	if (error && error != -ENOENT)
> +		return error;
> +
>  	pdata = mxt_get_platform_data(client);
>  	if (IS_ERR(pdata))
>  		return PTR_ERR(pdata);
> -- 
> 2.16.2.660.g709887971b-goog
> 
