Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4CECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5321A20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phc4s1pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5321A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeGUSjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeGUSjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:39:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9067A20854;
        Sat, 21 Jul 2018 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532195144;
        bh=1FhawPyZx5SHVIC4RhIxeG3V9qvR0sGtNzyV2Ydynls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Phc4s1pUk6LhiSrKzaIZJhqAXeX1WNUD+xVNJHLcNVHfrvJXr4VSrFrlndTHlpR5P
         1rCzIx1xv2jLqqytOfmLu5TQc/r6gLcr94+0L0oWeKyd7+DdCV6HouiSDOKa7lfwHQ
         nlPVVqRfDCz3iWjJU5EX+Mlng268v498lakRVZ+0=
Date:   Sat, 21 Jul 2018 18:45:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 5/7] iio: tsl2772: add support for regulator
 framework
Message-ID: <20180721184538.158c57d9@archlinux>
In-Reply-To: <20180717084158.23532-6-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
        <20180717084158.23532-6-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 04:41:56 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds support for the regulator framework to the tsl2772
> driver. Driver was tested using a LG Nexus 5 (hammerhead) phone with
> the two regulators and on a Raspberry Pi 2 without any regulators
> controlling the power to the sensor.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
There is an ordering issue in probe and hence the tear down.  Fixing
it is unfortunately going to make the rest of the handling more complex...

Jonathan

> ---
>  .../devicetree/bindings/iio/light/tsl2772.txt |  4 +
>  drivers/iio/light/tsl2772.c                   | 82 ++++++++++++++++++-
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> index ab553d52b9fc..bfde8b2c8790 100644
> --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> @@ -21,6 +21,8 @@ Optional properties:
>                           TSL2772_DIODE_BOTH.
>    - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
>                           or TSL2772_13_mA.
> +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> +  - vddio-supply: phandle to the regulator that provides power to the bus.
>    - interrupt-parent: should be the phandle for the interrupt controller
>    - interrupts: the sole interrupt generated by the device
>  
> @@ -35,5 +37,7 @@ tsl2772@39 {
>  	compatible = "amstaos,tsl2772";
>  	reg = <0x39>;
>  	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> +	vdd-supply = <&pm8941_l17>;
> +	vddio-supply = <&pm8941_lvs1>;
>  	amstaos,prox_diode = <TSL2772_DIODE0>;
>  };
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 0be57f2ecb02..f6a27f8b3ca7 100644
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
> @@ -146,6 +147,9 @@ struct tsl2772_chip {
>  	struct mutex prox_mutex;
>  	struct mutex als_mutex;
>  	struct i2c_client *client;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
> +	bool regulators_enabled;
>  	u16 prox_data;
>  	struct tsl2772_als_info als_cur_info;
>  	struct tsl2772_settings settings;
> @@ -609,6 +613,46 @@ static int tsl2772_als_calibrate(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static int tsl2772_enable_regulators(struct tsl2772_chip *chip)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(chip->vddio_supply);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(chip->vdd_supply);
> +	if (ret < 0) {
> +		regulator_disable(chip->vddio_supply);
> +		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	chip->regulators_enabled = true;
> +
> +	return 0;
> +}
> +
> +static void tsl2772_disable_regulators(struct tsl2772_chip *chip)
> +{
> +	if (!chip->regulators_enabled)
> +		return;
> +
> +	regulator_disable(chip->vdd_supply);
> +	regulator_disable(chip->vddio_supply);
> +
> +	chip->regulators_enabled = false;

hmm. this gets fiddly so I can see why you are using
this flag to avoid missbalanced enables / disables.

> +}
> +
> +static void tsl2772_disable_regulators_action(void *_data)
> +{
> +	tsl2772_disable_regulators(_data);
> +}
> +
>  static int tsl2772_chip_on(struct iio_dev *indio_dev)
>  {
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
> @@ -666,6 +710,10 @@ static int tsl2772_chip_on(struct iio_dev *indio_dev)
>  	chip->als_gain_time_scale = als_time_us *
>  		tsl2772_als_gain[chip->settings.als_gain];
>  
> +	ret = tsl2772_enable_regulators(chip);
> +	if (ret < 0)
> +		return ret;
> +
>  	/*
>  	 * TSL2772 Specific power-on / adc enable sequence
>  	 * Power on the device 1st.
> @@ -724,10 +772,13 @@ static int tsl2772_chip_on(struct iio_dev *indio_dev)
>  static int tsl2772_chip_off(struct iio_dev *indio_dev)
>  {
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	int ret;
>  
>  	/* turn device off */
>  	chip->tsl2772_chip_status = TSL2772_CHIP_SUSPENDED;
> -	return tsl2772_write_control_reg(chip, 0x00);
> +	ret = tsl2772_write_control_reg(chip, 0x00);
> +	tsl2772_disable_regulators(chip);

Blank line here would be nice.

> +	return ret;
>  }
>  
>  /**
> @@ -1666,6 +1717,35 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	chip->client = clientp;
>  	i2c_set_clientdata(clientp, indio_dev);
>  
> +	chip->vddio_supply = devm_regulator_get(&clientp->dev, "vddio");
> +	if (IS_ERR(chip->vddio_supply)) {
> +		if (PTR_ERR(chip->vddio_supply) != -EPROBE_DEFER)
> +			dev_err(&clientp->dev,
> +				"Failed to get vddio regulator %d\n",
> +				(int)PTR_ERR(chip->vddio_supply));
> +
> +		return PTR_ERR(chip->vddio_supply);
> +	}
> +
> +	chip->vdd_supply = devm_regulator_get(&clientp->dev, "vdd");
> +	if (IS_ERR(chip->vdd_supply)) {
> +		if (PTR_ERR(chip->vdd_supply) != -EPROBE_DEFER)
> +			dev_err(&clientp->dev,
> +				"Failed to get vdd regulator %d\n",
> +				(int)PTR_ERR(chip->vdd_supply));
> +
> +		return PTR_ERR(chip->vdd_supply);
> +	}
> +
> +	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> +			      chip);

Can't do them together. you need to think about where you might
get a failure.  What if it is after the first enable but before the
second?  In that case you've just left a regulator on as we haven't done this
setup yet.

> +	if (ret < 0) {
> +		tsl2772_disable_regulators_action(chip);
> +		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	ret = i2c_smbus_read_byte_data(chip->client,
>  				       TSL2772_CMD_REG | TSL2772_CHIPID);
>  	if (ret < 0)

