Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C28C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF40A21759
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZQxCS/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF40A21759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeGGQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754229AbeGGQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:34:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A12215F1;
        Sat,  7 Jul 2018 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530981253;
        bh=KGzBPb6JbW02aSzFTBJoERC29K+cps3tmt4ljilpOUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZQxCS/7gPQzctNMVPsVfi7PnjuajKp4zElKxyI8ruQHlkoFO0LLQIQjprAGopMF4
         AjGuzzolf1zsTiQCN1rd1ZxxJN24elLkOOPKVTVzYJtzfzkpzmairggyMmjTcw20Pd
         ECP9R9kfIPioN5nCC9cU7vlGzLR70QtyX8Q3JHPs=
Date:   Sat, 7 Jul 2018 17:34:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] IIO: st_accel_i2c.c: Simplify access to driver
 data
Message-ID: <20180707173408.12d5701a@archlinux>
In-Reply-To: <954eea265614f551e1c32b02a71578cc80a32020.1530782560.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
        <954eea265614f551e1c32b02a71578cc80a32020.1530782560.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 07:41:00 +0200
Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:

> Use device_get_match_data API to simplify access to driver data.
> Let acpi_device_id table entries point to the same driver data as
> of_device_id table entries and uniquify access to driver data by using
> device_get_match_data API. Remove unused i2c_device_id .driver_data
> fields.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks and was interesting to follow the discussion I missed mid week!

Jonathan

> ---
>  drivers/iio/accel/st_accel_i2c.c | 59 ++++++++++++++------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 056dddb27236..d02298f0256c 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -14,8 +14,8 @@
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/property.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_accel.h"
>  
> @@ -107,8 +107,8 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id st_accel_acpi_match[] = {
> -	{"SMO8840", LNG2DM},
> -	{"SMO8A90", LNG2DM},
> +	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
> +	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
> @@ -117,24 +117,24 @@ MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
>  #endif
>  
>  static const struct i2c_device_id st_accel_id_table[] = {
> -	{ LSM303DLH_ACCEL_DEV_NAME, LSM303DLH },
> -	{ LSM303DLHC_ACCEL_DEV_NAME, LSM303DLHC },
> -	{ LIS3DH_ACCEL_DEV_NAME, LIS3DH },
> -	{ LSM330D_ACCEL_DEV_NAME, LSM330D },
> -	{ LSM330DL_ACCEL_DEV_NAME, LSM330DL },
> -	{ LSM330DLC_ACCEL_DEV_NAME, LSM330DLC },
> -	{ LIS331DLH_ACCEL_DEV_NAME, LIS331DLH },
> -	{ LSM303DL_ACCEL_DEV_NAME, LSM303DL },
> -	{ LSM303DLM_ACCEL_DEV_NAME, LSM303DLM },
> -	{ LSM330_ACCEL_DEV_NAME, LSM330 },
> -	{ LSM303AGR_ACCEL_DEV_NAME, LSM303AGR },
> -	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
> -	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
> -	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
> -	{ H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
> -	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
> -	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
> -	{ LIS2DW12_ACCEL_DEV_NAME, LIS2DW12 },
> +	{ LSM303DLH_ACCEL_DEV_NAME },
> +	{ LSM303DLHC_ACCEL_DEV_NAME },
> +	{ LIS3DH_ACCEL_DEV_NAME },
> +	{ LSM330D_ACCEL_DEV_NAME },
> +	{ LSM330DL_ACCEL_DEV_NAME },
> +	{ LSM330DLC_ACCEL_DEV_NAME },
> +	{ LIS331DLH_ACCEL_DEV_NAME },
> +	{ LSM303DL_ACCEL_DEV_NAME },
> +	{ LSM303DLM_ACCEL_DEV_NAME },
> +	{ LSM330_ACCEL_DEV_NAME },
> +	{ LSM303AGR_ACCEL_DEV_NAME },
> +	{ LIS2DH12_ACCEL_DEV_NAME },
> +	{ LIS3L02DQ_ACCEL_DEV_NAME },
> +	{ LNG2DM_ACCEL_DEV_NAME },
> +	{ H3LIS331DL_ACCEL_DEV_NAME },
> +	{ LIS331DL_ACCEL_DEV_NAME },
> +	{ LIS3LV02DL_ACCEL_DEV_NAME },
> +	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> @@ -144,6 +144,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  {
>  	struct iio_dev *indio_dev;
>  	struct st_sensor_data *adata;
> +	const char *match;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
> @@ -152,19 +153,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  
>  	adata = iio_priv(indio_dev);
>  
> -	if (client->dev.of_node) {
> -		st_sensors_of_name_probe(&client->dev, st_accel_of_match,
> -					 client->name, sizeof(client->name));
> -	} else if (ACPI_HANDLE(&client->dev)) {
> -		ret = st_sensors_match_acpi_device(&client->dev);
> -		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
> -			return -ENODEV;
> -
> -		strlcpy(client->name, st_accel_id_table[ret].name,
> -				sizeof(client->name));
> -	} else if (!id)
> -		return -ENODEV;
> -
> +	match = device_get_match_data(&client->dev);
> +	if (match)
> +		strlcpy(client->name, match, sizeof(client->name));
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  

