Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB54C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0106D217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHtRxeqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0106D217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHCXsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbeHCXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:48:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA70E217A2;
        Fri,  3 Aug 2018 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533333024;
        bh=wDRLzKRYas2MqgKkewWGQ0nK3MdJIJKduo38pk44c6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bHtRxeqiqiVnR//f3QGffV7ib8fiTXtlRy1NAGMrZPSMgXdfW+hdSVGzU0W1EiQ/v
         zjyKdAejvcmRRsy6hna5O3ejLv4g5PUyJk7khUPYJEKEXuZCH0jMM1rrUSyMBIfUEQ
         7l2iJ+qNA/9vgCalEF7UgWEQmcK6KEeyaOmWu50I=
Date:   Fri, 3 Aug 2018 22:50:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 5/9] iio: tsl2772: add support for regulator
 framework
Message-ID: <20180803225017.06ac1d3b@archlinux>
In-Reply-To: <20180803001900.25371-6-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-6-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 20:18:56 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds support for the regulator framework to the tsl2772
> driver. Driver was tested using a LG Nexus 5 (hammerhead) phone with
> the two regulators and on a Raspberry Pi 2 without any regulators
> controlling the power to the sensor.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This looks fine, but will wait for the precursors.

Jonathan

> ---
>  drivers/iio/light/tsl2772.c | 95 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index ae00edf0d87e..4a11bf77a4d0 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -20,6 +20,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/platform_data/tsl2772.h>
> +#include <linux/regulator/consumer.h>
>  
>  /* Cal defs */
>  #define PROX_STAT_CAL			0
> @@ -109,6 +110,9 @@
>  
>  #define TSL2772_MAX_PROX_LEDS		2
>  
> +#define TSL2772_BOOT_MIN_SLEEP_TIME	10000
> +#define TSL2772_BOOT_MAX_SLEEP_TIME	28000
> +
>  /* Device family members */
>  enum {
>  	tsl2571,
> @@ -156,6 +160,8 @@ struct tsl2772_chip {
>  	struct mutex prox_mutex;
>  	struct mutex als_mutex;
>  	struct i2c_client *client;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
>  	u16 prox_data;
>  	struct tsl2772_als_info als_cur_info;
>  	struct tsl2772_settings settings;
> @@ -676,6 +682,52 @@ static int tsl2772_als_calibrate(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static void tsl2772_disable_regulators_action(void *_data)
> +{
> +	struct tsl2772_chip *chip = _data;
> +
> +	regulator_disable(chip->vdd_supply);
> +	regulator_disable(chip->vddio_supply);
> +}
> +
> +static int tsl2772_enable_regulator(struct tsl2772_chip *chip,
> +				    struct regulator *regulator)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(regulator);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct regulator *tsl2772_get_regulator(struct tsl2772_chip *chip,
> +					       char *name)
> +{
> +	struct regulator *regulator;
> +	int ret;
> +
> +	regulator = devm_regulator_get(&chip->client->dev, name);
> +	if (IS_ERR(regulator)) {
> +		if (PTR_ERR(regulator) != -EPROBE_DEFER)
> +			dev_err(&chip->client->dev,
> +				"Failed to get %s regulator %d\n",
> +				name, (int)PTR_ERR(regulator));
> +
> +		return regulator;
> +	}
> +
> +	ret = tsl2772_enable_regulator(chip, regulator);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	return regulator;
> +}
> +
>  static int tsl2772_chip_on(struct iio_dev *indio_dev)
>  {
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
> @@ -1733,6 +1785,27 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	chip->client = clientp;
>  	i2c_set_clientdata(clientp, indio_dev);
>  
> +	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
> +	if (IS_ERR(chip->vddio_supply))
> +		return PTR_ERR(chip->vddio_supply);
> +
> +	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
> +	if (IS_ERR(chip->vdd_supply)) {
> +		regulator_disable(chip->vddio_supply);
> +		return PTR_ERR(chip->vdd_supply);
> +	}
> +
> +	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> +			      chip);
> +	if (ret < 0) {
> +		tsl2772_disable_regulators_action(chip);
> +		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	usleep_range(TSL2772_BOOT_MIN_SLEEP_TIME, TSL2772_BOOT_MAX_SLEEP_TIME);
> +
>  	ret = i2c_smbus_read_byte_data(chip->client,
>  				       TSL2772_CMD_REG | TSL2772_CHIPID);
>  	if (ret < 0)
> @@ -1806,13 +1879,33 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  static int tsl2772_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	int ret;
>  
> -	return tsl2772_chip_off(indio_dev);
> +	ret = tsl2772_chip_off(indio_dev);
> +	regulator_disable(chip->vdd_supply);
> +	regulator_disable(chip->vddio_supply);
> +
> +	return ret;
>  }
>  
>  static int tsl2772_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = tsl2772_enable_regulator(chip, chip->vddio_supply);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tsl2772_enable_regulator(chip, chip->vdd_supply);
> +	if (ret < 0) {
> +		regulator_disable(chip->vddio_supply);
> +		return ret;
> +	}
> +
> +	usleep_range(TSL2772_BOOT_MIN_SLEEP_TIME, TSL2772_BOOT_MAX_SLEEP_TIME);
>  
>  	return tsl2772_chip_on(indio_dev);
>  }

