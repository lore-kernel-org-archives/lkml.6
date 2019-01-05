Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4EC43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A53E213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546710182;
	bh=rqV0bvZPt5syymSMYXgKuj7BjCfJE1qIL4LJKV2igxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DNLdyfsyIEWqkkZWylFgE7s9wnG0gDWFciSoma32uXsiSb5sICBa02710M0pH/Hdv
	 20lwb4nn3P74llJkH/IXz/TgIlNd4wVkOBM/R6BV5fEKkbaNkJK4FFXNZ2wlPCn9UP
	 BshH2VrWRDop7PpievrXTBgwc1zwMvS5WhJhrehE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAERnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfAERnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:43:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0C42087F;
        Sat,  5 Jan 2019 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546710179;
        bh=rqV0bvZPt5syymSMYXgKuj7BjCfJE1qIL4LJKV2igxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vCVwZ5Tt8oObYWPE8EMAFdtOzC9uRlHoUApoemNGEl2q9Z8zdv7c8oiK6zAHdRJf3
         jDKkYT+Q63sZHiW7GR2l7nfWpgG3aKphD1tztLlQdQ6f2VSxBaVwjwxvvt7fp5Xu+s
         bJixZ8LDjcrbn0AoRrpkEyhNhgn0Po5NxVRTwtyA=
Date:   Sat, 5 Jan 2019 17:42:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V8] iio: light: isl29018: add vcc regulator operation
 support
Message-ID: <20190105174254.49f95395@archlinux>
In-Reply-To: <1545547310-22203-1-git-send-email-Anson.Huang@nxp.com>
References: <1545547310-22203-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 06:46:32 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The light sensor's power supply could be controllable by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds vcc regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

One comment inline on handling the error from devm_add_action.

Jonathan

> ---
> ChangeLog Since V7:
>     - move devm_add_action to before devm_regmap_init_i2c call to save code of disabling regulator;
>     - simply the error check logic in isl29018_suspend.
> ---
>  drivers/iio/light/isl29018.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..ec6ce89 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -23,6 +23,7 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -95,6 +96,7 @@ struct isl29018_chip {
>  	struct isl29018_scale	scale;
>  	int			prox_scheme;
>  	bool			suspended;
> +	struct regulator	*vcc_reg;
>  };
>  
>  static int isl29018_set_integration_time(struct isl29018_chip *chip,
> @@ -708,6 +710,16 @@ static const char *isl29018_match_acpi_device(struct device *dev, int *data)
>  	return dev_name(dev);
>  }
>  
> +static void isl29018_disable_regulator_action(void *_data)
> +{
> +	struct isl29018_chip *chip = _data;
> +	int err;
> +
> +	err = regulator_disable(chip->vcc_reg);
> +	if (err)
> +		pr_err("failed to disable isl29018's VCC regulator!\n");
> +}
> +
>  static int isl29018_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -742,6 +754,28 @@ static int isl29018_probe(struct i2c_client *client,
>  	chip->scale = isl29018_scales[chip->int_time][0];
>  	chip->suspended = false;
>  
> +	chip->vcc_reg = devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(chip->vcc_reg)) {
> +		err = PTR_ERR(chip->vcc_reg);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&client->dev, "failed to get VCC regulator!\n");
> +		return err;
> +	}
> +
> +	err = regulator_enable(chip->vcc_reg);
> +	if (err) {
> +		dev_err(&client->dev, "failed to enable VCC regulator!\n");
> +		return err;
> +	}
> +
> +	err = devm_add_action(&client->dev, isl29018_disable_regulator_action,
> +				 chip);

Use devm_add_action_or_reset, then you don't need to call
the disable if an error occurs in the add_action part...

> +	if (err) {
> +		isl29018_disable_regulator_action(chip);

(will get rid of the line above).

> +		dev_err(&client->dev, "failed to setup regulator cleanup action!\n");
> +		return err;
> +	}
> +
>  	chip->regmap = devm_regmap_init_i2c(client,
>  				isl29018_chip_info_tbl[dev_id].regmap_cfg);
>  	if (IS_ERR(chip->regmap)) {
> @@ -768,6 +802,7 @@ static int isl29018_probe(struct i2c_client *client,
>  static int isl29018_suspend(struct device *dev)
>  {
>  	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
> +	int ret;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -777,10 +812,13 @@ static int isl29018_suspend(struct device *dev)
>  	 * So we do not have much to do here.
>  	 */
>  	chip->suspended = true;
> +	ret = regulator_disable(chip->vcc_reg);
> +	if (ret)
> +		dev_err(dev, "failed to disable VCC regulator\n");
>  
>  	mutex_unlock(&chip->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int isl29018_resume(struct device *dev)
> @@ -790,6 +828,13 @@ static int isl29018_resume(struct device *dev)
>  
>  	mutex_lock(&chip->lock);
>  
> +	err = regulator_enable(chip->vcc_reg);
> +	if (err) {
> +		dev_err(dev, "failed to enable VCC regulator\n");
> +		mutex_unlock(&chip->lock);
> +		return err;
> +	}
> +
>  	err = isl29018_chip_init(chip);
>  	if (!err)
>  		chip->suspended = false;

