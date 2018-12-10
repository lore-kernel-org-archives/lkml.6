Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413BC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052D52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544474911;
	bh=Jz24y8VP7n6rVZSAehKQ1D7/e6IVG6u27FnhmnpMhaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IclsU17/lVeOCs1aunzLUD9OXrdQQaYFg5/qZ81b1Bv5I0OoNvPxbPkQYMDQg/Xwt
	 3Y7bvinNAv3qzPVWLDwmxMtgawWPM+DqRRGfFhisUh/IZT386oGUts2uZwA7jtLgYC
	 +LOBi3shIVtkA0bXRttzkYycRzaoQ7rcuFU00yQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052D52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeLJUsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJUs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:48:29 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2701D20821;
        Mon, 10 Dec 2018 20:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544474908;
        bh=Jz24y8VP7n6rVZSAehKQ1D7/e6IVG6u27FnhmnpMhaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDuCAskhhYTVn22ihDlcXIGb5Bd7qdZS6KYjv/rNP7wmVIW2++62WQYdUq5Di31IM
         YI9NN8P6nKqsSfaCLBzV7/CpzSVEmzXTBRjt+8SgNXr7sO+Vxba/IQu83Fei+amnJO
         tDtJ168LHM/OEOmQYVdVuLP7n6DkH6OjxW89CpNE=
Date:   Mon, 10 Dec 2018 20:48:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
Message-ID: <20181210204824.7234d253@archlinux>
In-Reply-To: <1544425521-775-2-git-send-email-Anson.Huang@nxp.com>
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
        <1544425521-775-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 07:11:23 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The light sensor's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds optional vdd/vdda regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Comments on the other patches apply on error handling and
cleaner pattern for the error handling so I won't review this one.

Thanks,

Jonathan


> ---
> ChangeLog since V2:
>     - Add defer_probe check if the return value from devm_regulator_get_optional is ERR_PTR(-EPROBE_DEFER);
>     - Replace the "vcc" with "vdd" according to datasheet, and add optional "vdda" supply as well since
>       isl29018 also has a vdda supply.
> ---
>  drivers/iio/light/isl29018.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..477eb95 100644
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
> @@ -95,6 +96,8 @@ struct isl29018_chip {
>  	struct isl29018_scale	scale;
>  	int			prox_scheme;
>  	bool			suspended;
> +	struct regulator	*vdd_reg;
> +	struct regulator	*vdda_reg;
>  };
>  
>  static int isl29018_set_integration_time(struct isl29018_chip *chip,
> @@ -735,6 +738,28 @@ static int isl29018_probe(struct i2c_client *client,
>  
>  	mutex_init(&chip->lock);
>  
> +	chip->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (!IS_ERR(chip->vdd_reg)) {
> +		err = regulator_enable(chip->vdd_reg);
> +		if (err) {
> +			dev_err(&client->dev, "failed to enable VDD regulator\n");
> +			return err;
> +		}
> +	} else if (chip->vdd_reg == ERR_PTR(-EPROBE_DEFER)) {
> +		return -EPROBE_DEFER;
> +	}
> +
> +	chip->vdda_reg = devm_regulator_get_optional(&client->dev, "vdda");
> +	if (!IS_ERR(chip->vdda_reg)) {
> +		err = regulator_enable(chip->vdda_reg);
> +		if (err) {
> +			dev_err(&client->dev, "failed to enable VDDA regulator\n");
> +			return err;
> +		}
> +	} else if (chip->vdda_reg == ERR_PTR(-EPROBE_DEFER)) {
> +		return -EPROBE_DEFER;
> +	}
> +
>  	chip->type = dev_id;
>  	chip->calibscale = 1;
>  	chip->ucalibscale = 0;
> @@ -768,6 +793,7 @@ static int isl29018_probe(struct i2c_client *client,
>  static int isl29018_suspend(struct device *dev)
>  {
>  	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
> +	int ret;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -777,6 +803,22 @@ static int isl29018_suspend(struct device *dev)
>  	 * So we do not have much to do here.
>  	 */
>  	chip->suspended = true;
> +	if (!IS_ERR(chip->vdd_reg)) {
> +		ret = regulator_disable(chip->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDD regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return ret;
> +		}
> +	}
> +	if (!IS_ERR(chip->vdda_reg)) {
> +		ret = regulator_disable(chip->vdda_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDDA regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return ret;
> +		}
> +	}
>  
>  	mutex_unlock(&chip->lock);
>  
> @@ -790,6 +832,23 @@ static int isl29018_resume(struct device *dev)
>  
>  	mutex_lock(&chip->lock);
>  
> +	if (!IS_ERR(chip->vdd_reg)) {
> +		err = regulator_enable(chip->vdd_reg);
> +		if (err) {
> +			dev_err(dev, "failed to enable VDD regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return err;
> +		}
> +	}
> +	if (!IS_ERR(chip->vdda_reg)) {
> +		err = regulator_enable(chip->vdda_reg);
> +		if (err) {
> +			dev_err(dev, "failed to enable VDDA regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return err;
> +		}
> +	}
> +
>  	err = isl29018_chip_init(chip);
>  	if (!err)
>  		chip->suspended = false;

