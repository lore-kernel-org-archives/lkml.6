Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E326C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D632555F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTWkSZLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D632555F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeF3P2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeF3P2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:28:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74B821939;
        Sat, 30 Jun 2018 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530372488;
        bh=+ypU/h0QCSgeCYjaj9iH865dSMX7EC7xuWJXimGtAWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTWkSZLuUNq3CiIzEZAZaRle0xNL8kWy3KWA5+bepnGJ6iMJluWkln27EvtIKfyns
         xQH1JrFhs9/0il9YdRJPQMEbMSFVLoCCDkzMW2PlHiUYWfT+Taq0uHmdxDFFAWkLeF
         ItSn3z08ObjnbGAu4+D3QfroWzToy9XpZSA/l/6w=
Date:   Sat, 30 Jun 2018 16:28:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum
 failed
Message-ID: <20180630162803.3a2ad759@archlinux>
In-Reply-To: <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
        <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 10:10:10 +0200
Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:

> Currently, the driver bails out if not explicitly referred to in
> DT or ACPI tables. This prevents fallback mechanisms from coming
> into effect, e.g. I2C device ID table match via DT or ACPI
> PRP0001 HID. However DT/ACPI enum should take precedence over
> the fallback, so evaluate that first.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Is the change to probe_new actually related to the rest of the change?

I can't immediately see why...  If not I would prefer that as a separate
change.

> ---
>  drivers/iio/accel/st_accel_i2c.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 6bdec8c451e0..e360da407027 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>  
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct st_sensor_data *adata;
> @@ -156,14 +155,18 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  					 client->name, sizeof(client->name));
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		ret = st_sensors_match_acpi_device(&client->dev);
> -		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
> -			return -ENODEV;
> -
> -		strlcpy(client->name, st_accel_id_table[ret].name,
> +		if ((ret >= 0) && (ret < ST_ACCEL_MAX))
> +			strlcpy(client->name, st_accel_id_table[ret].name,
>  				sizeof(client->name));
> -	} else if (!id)
> -		return -ENODEV;
> +	}
>  
> +	/*
> +	 * If OF and ACPI enumeration failed, there could still be platform
> +	 * information via fallback enumeration or explicit instantiation, so
> +	 * check if id table has been matched via client->name.
> +	 */
> +	if (!client->name)
> +		return -ENODEV;
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  
> @@ -187,7 +190,7 @@ static struct i2c_driver st_accel_driver = {
>  		.of_match_table = of_match_ptr(st_accel_of_match),
>  		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>  	},
> -	.probe = st_accel_i2c_probe,
> +	.probe_new = st_accel_i2c_probe,
>  	.remove = st_accel_i2c_remove,
>  	.id_table = st_accel_id_table,
>  };

