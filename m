Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296DC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F6217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546710403;
	bh=tnspQe1zgh51q23x0ZskxmrKMCSVWl6A8hUR/wZzaNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j4DoA9rC1eORYrIITnz2+vYOZiqvetC9M+PUJ7J1+ILJDsDqQ/MZFT7mWC65GyliG
	 Bwok3vibUPP6c1vhl31g/XTnYwmlN8d/dSfqYutcK37OhRf6qaWN55RqZUZtu2p0MS
	 CbJV4PypydPmAs3iuk1MlNzaawRMM/Xmcdc+XsFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAERqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfAERqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:46:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAD521871;
        Sat,  5 Jan 2019 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546710401;
        bh=tnspQe1zgh51q23x0ZskxmrKMCSVWl6A8hUR/wZzaNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C2M5wKYSAuTf1ze+iUPnJhXp/f7NY75umkekwPVP3Vr516E5I1yafL1TOezwVr50m
         Aglw2SNX69bb2NVLK99CryTuwjQzLpMdM33IYCrS+F1fkY02xRT7wC0CRZ4rO8hnUl
         PyVJm098n8d1XNq6qY+l+3/kbnUYFt79/6obpDNM=
Date:   Sat, 5 Jan 2019 17:46:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Message-ID: <20190105174636.4971accb@archlinux>
In-Reply-To: <1545545266-6741-1-git-send-email-Anson.Huang@nxp.com>
References: <1545545266-6741-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 06:12:30 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The magnetometer's power supplies could be controllable on some platforms,
> such as i.MX6Q-SABRESD board, the mag3110's power supplies are controlled
> by a GPIO fixed regulator, need to make sure the regulators are enabled
> before any communication with mag3110, this patch adds vdd/vddio regulator
> operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Same comment on not combining the error handling.  It's simply
harder to read to save a few lines of code.

Otherwise, looks fine, though I would ideally like an ack from
Peter on this as it's his driver. If he's busy though I think this
should be safe enough without.

thanks,

Jonathan

> ---
> ChangeLog since V5:
>     Make sure both vdd and vddio regulators are aquired before enabling any one of them.
> ---
>  drivers/iio/magnetometer/mag3110.c | 88 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index f063355..f56a99a 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -20,6 +20,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define MAG3110_STATUS 0x00
>  #define MAG3110_OUT_X 0x01 /* MSB first */
> @@ -56,6 +57,8 @@ struct mag3110_data {
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  	int sleep_val;
> +	struct regulator *vdd_reg;
> +	struct regulator *vddio_reg;
>  };
>  
>  static int mag3110_request(struct mag3110_data *data)
> @@ -469,17 +472,44 @@ static int mag3110_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
> -	if (ret < 0)
> -		return ret;
> -	if (ret != MAG3110_DEVICE_ID)
> -		return -ENODEV;
> -
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +
> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
> +	if (IS_ERR(data->vdd_reg) || IS_ERR(data->vddio_reg)) {
> +		if (PTR_ERR(data->vdd_reg) == -EPROBE_DEFER ||
> +			PTR_ERR(data->vddio_reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		dev_err(&client->dev, "failed to get VDD/VDDIO regulator!\n");
> +		return IS_ERR(data->vdd_reg) ?
> +		       PTR_ERR(data->vdd_reg) : PTR_ERR(data->vddio_reg);
> +	}
> +
> +	ret = regulator_enable(data->vdd_reg);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable VDD regulator!\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(data->vddio_reg);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
> +		goto disable_regulator_vdd;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
> +	if (ret < 0)
> +		goto disable_regulators;
> +	if (ret != MAG3110_DEVICE_ID) {
> +		ret = -ENODEV;
> +		goto disable_regulators;
> +	}
> +
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> @@ -499,7 +529,7 @@ static int mag3110_probe(struct i2c_client *client,
>  
>  	ret = mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
>  		MAG3110_CTRL_AUTO_MRST_EN);
> @@ -520,16 +550,24 @@ static int mag3110_probe(struct i2c_client *client,
>  	iio_triggered_buffer_cleanup(indio_dev);
>  standby_on_error:
>  	mag3110_standby(iio_priv(indio_dev));
> +disable_regulators:
> +	regulator_disable(data->vddio_reg);
> +disable_regulator_vdd:
> +	regulator_disable(data->vdd_reg);
> +
>  	return ret;
>  }
>  
>  static int mag3110_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mag3110_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mag3110_standby(iio_priv(indio_dev));
> +	regulator_disable(data->vddio_reg);
> +	regulator_disable(data->vdd_reg);
>  
>  	return 0;
>  }
> @@ -537,14 +575,48 @@ static int mag3110_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int mag3110_suspend(struct device *dev)
>  {
> -	return mag3110_standby(iio_priv(i2c_get_clientdata(
> +	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
> +	int ret;
> +
> +	ret = mag3110_standby(iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev))));
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_disable(data->vddio_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to disable VDDIO regulator\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_disable(data->vdd_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to disable VDD regulator\n");
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int mag3110_resume(struct device *dev)
>  {
>  	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VDD regulator\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(data->vddio_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VDDIO regulator\n");
> +		regulator_disable(data->vdd_reg);
> +		return ret;
> +	}
>  
>  	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>  		data->ctrl_reg1);

