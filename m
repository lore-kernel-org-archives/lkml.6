Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DDC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29FB21A4B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545498882;
	bh=SlwRFVr8o1+pHSQuVQJyZat0WNfmHfVXNZY+I3zGvTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=f+s0YbX/4QXp1Jx1UsesEDl8vBlHSKDC/2lhXbNo80rsxi09eLIZ8WzGe0eUio+k9
	 yajb0WfQ5B3JMlnEiyrB2uTSujg5ifcu/PmMFLR4AiKbwB2dHTqIbdJ0wVrI9P5S++
	 bO+/TtngaB0rabVPXSO/Sctisdi6eeT0Gtx7coyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391096AbeLVROl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeLVROl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:14:41 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2DB21A48;
        Sat, 22 Dec 2018 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545498879;
        bh=SlwRFVr8o1+pHSQuVQJyZat0WNfmHfVXNZY+I3zGvTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ux69gp4YuA7BsGGSUaF0N7mLVo7lkDx4yunoP2u8kb2Praz4/W3jn9ESl4F1Nt56p
         P7WDjOnmOMXZCj0sujKdQjqu3xhj20ajZt8I6DPiYbuWadHroequUjapT2zBSHO7LJ
         obq2pX/9gCGlIZQEfP2R6qryyVwV32vVhO31wEG4=
Date:   Sat, 22 Dec 2018 17:14:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7] iio: light: isl29018: add vcc regulator operation
 support
Message-ID: <20181222171434.4eca4ea4@archlinux>
In-Reply-To: <1545016752-9865-1-git-send-email-Anson.Huang@nxp.com>
References: <1545016752-9865-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 03:25:17 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The light sensor's power supply could be controllable by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds vcc regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Hi Anson

See below.

> ---
> ChangeLog since V6
>     - using devm_regulator_get() instead of devm_regulator_get_optional() since the regulator is
>       there anyway, if dtb does NOT specify one, regulator framework will assign dummy regulator for it;
>     - Setup devm action for cleaning up regulator resource for error handling.
> ---
>  drivers/iio/light/isl29018.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..63f7b9d 100644
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
> @@ -708,6 +710,17 @@ static const char *isl29018_match_acpi_device(struct device *dev, int *data)
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
> +		dev_err(regmap_get_device(chip->regmap),
> +			"failed to disable VCC regulator!\n");
> +}
> +
>  static int isl29018_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -742,6 +755,37 @@ static int isl29018_probe(struct i2c_client *client,
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
> +	chip->regmap = devm_regmap_init_i2c(client,
> +				isl29018_chip_info_tbl[dev_id].regmap_cfg);
> +	if (IS_ERR(chip->regmap)) {
> +		err = PTR_ERR(chip->regmap);
> +		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
> +		regulator_disable(chip->vcc_reg);
> +		return err;
> +	}
> +
> +	err = devm_add_action(&client->dev, isl29018_disable_regulator_action,
> +				 chip);
> +	if (err) {

I'm a little confused, why not do this before devm_regmap_init_i2c.
That way you won't have to disable the regulator in that one error path.
Also, devm_add_action_or_reset will call isl29018_disable_regulator_action for
you on error.

> +		isl29018_disable_regulator_action(chip);
> +		dev_err(&client->dev, "failed to setup regulator cleanup action!\n");
> +		return err;
> +	}
> +
>  	chip->regmap = devm_regmap_init_i2c(client,
>  				isl29018_chip_info_tbl[dev_id].regmap_cfg);
>  	if (IS_ERR(chip->regmap)) {
> @@ -768,6 +812,7 @@ static int isl29018_probe(struct i2c_client *client,
>  static int isl29018_suspend(struct device *dev)
>  {
>  	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
> +	int ret;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -777,6 +822,12 @@ static int isl29018_suspend(struct device *dev)
>  	 * So we do not have much to do here.
>  	 */
>  	chip->suspended = true;
> +	ret = regulator_disable(chip->vcc_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to disable VCC regulator\n");
> +		mutex_unlock(&chip->lock);
> +		return ret;

Given you are about to unlock anyway a common pattern is to not
check ret until after the unlock, thus simplifying the code.

> +	}
>  
>  	mutex_unlock(&chip->lock);
>  
> @@ -790,6 +841,13 @@ static int isl29018_resume(struct device *dev)
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

