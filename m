Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E38C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6A20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544271039;
	bh=RiRYLWr09MEcKXc9xrhWMx9Ao2fgrpYIzHfa/YR4J8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ejvg0+8DDUZvfC19wG/AAkIKZSW4iSekdsxXbOxv1YAmvbhn4KJL0phKzRhcPJyYW
	 ZkvTHg4u4+Q+8LzcAvbaMhoaWjtliuK2k2EPD1YUOomqYO4/ipKPr1jTmga+XkD9T6
	 VY501ZfUaEI4O1nsCdUkuCxoj/hGAHhZYAkcQoAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLHMKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:10:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9A72064D;
        Sat,  8 Dec 2018 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544271035;
        bh=RiRYLWr09MEcKXc9xrhWMx9Ao2fgrpYIzHfa/YR4J8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2kMnv8zJE/VwFD59nhaCDDTU8/P5ByzgRB8U3zljmhFdHfgpNkK7krEmAYu4vovry
         MzsqlcGFW1DvbtfGfGIw9BZA1y8tXkkL24phQDjTpvZ4dy3YJW2zWArxgT3wyFUTd/
         vppzZKigM0VByyX6Tx8blkXr2SecvR6oAFrYPMYM=
Date:   Sat, 8 Dec 2018 12:10:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "harinath922@gmail.com" <harinath922@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] iio: accell: mma8452: add optional vcc regulator
 operation support
Message-ID: <20181208121030.57e081dc@archlinux>
In-Reply-To: <1544077059-4471-2-git-send-email-Anson.Huang@nxp.com>
References: <1544077059-4471-1-git-send-email-Anson.Huang@nxp.com>
        <1544077059-4471-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 06:23:33 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The accelerometer's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the mma8451's
> power supply is controlled by a GPIO fixed regulator, need to make
> sure the regulator is enabled before any communication with mma8451,
> this patch adds optional vcc regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/iio/accel/mma8452.c | 88 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 421a0a8..8f6123f 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -31,6 +31,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -107,6 +108,7 @@ struct mma8452_data {
>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
>  	int sleep_val;
> +	struct regulator *vcc_reg;
>  };
>  
>   /**
> @@ -1533,6 +1535,14 @@ static int mma8452_probe(struct i2c_client *client,
>  	data->client = client;
>  	mutex_init(&data->lock);
>  	data->chip_info = match->data;
> +	data->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");
> +	if (!IS_ERR(data->vcc_reg)) {

Make sure it's the 'right' error to indicate there isn't a regulator
rather than a deferred response for example.


> +		ret = regulator_enable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to enable VCC regulator\n");
> +			return ret;
> +		}
> +	}
>  
>  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
>  	if (ret < 0)
> @@ -1667,6 +1677,8 @@ static int mma8452_probe(struct i2c_client *client,
>  static int mma8452_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_device_unregister(indio_dev);
>  
> @@ -1678,6 +1690,14 @@ static int mma8452_remove(struct i2c_client *client)
>  	mma8452_trigger_cleanup(indio_dev);
>  	mma8452_standby(iio_priv(indio_dev));
>  
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_disable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to disable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1696,6 +1716,14 @@ static int mma8452_runtime_suspend(struct device *dev)
>  		return -EAGAIN;
>  	}
>  
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_disable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1705,6 +1733,14 @@ static int mma8452_runtime_resume(struct device *dev)
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, sleep_val;
>  
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_enable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = mma8452_active(data);
>  	if (ret < 0)
>  		return ret;
> @@ -1723,14 +1759,62 @@ static int mma8452_runtime_resume(struct device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int mma8452_suspend(struct device *dev)
>  {
> -	return mma8452_standby(iio_priv(i2c_get_clientdata(
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_enable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = mma8452_standby(iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev))));
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_disable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static int mma8452_resume(struct device *dev)
>  {
> -	return mma8452_active(iio_priv(i2c_get_clientdata(
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_enable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = mma8452_active(iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev))));
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(data->vcc_reg)) {
> +		ret = regulator_disable(data->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VCC regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  #endif
>  

