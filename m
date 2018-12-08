Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF72C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60320868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544270954;
	bh=MNqAi+h0GzVw/uwN1kKOG2YCKEsVTu8/5IqmKcBVR3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sPJ4cTPA5PDC/IDTnj9P3qrzFQK+CHzDpj8g8rwDPkrbmQZAOjfTrUkmVxPLUxamu
	 xbRiifR2rABWmFJtst3X5MjjLyhCxD/sWc/s4fd2e+F2xLk1IHxgchru/vy95xSxti
	 Gw3NvXt4Cp5DvcuY+pvugJnvSZRrLHBv9y5v6RHs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeLHMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeLHMJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:09:12 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56C82081C;
        Sat,  8 Dec 2018 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544270951;
        bh=MNqAi+h0GzVw/uwN1kKOG2YCKEsVTu8/5IqmKcBVR3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hj/d5Op/AQd2BQLcqeMfgXdik/UCE63nkbeuFeQ/jEdcKnJPlrNvS24IEpZOb6ta9
         E9kruG9479wrH+2Wa5WLVgFqjy2nZpT1G5uwcAV5lsQaTYiRRCm6cj8UGnQHTU2/Bq
         zUVLCKOvePUIEkk4DDnqFFXsHHU3pCq5wXG1YCrk=
Date:   Sat, 8 Dec 2018 12:09:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] iio: light: isl29018: add optional vcc regulator
 operation support
Message-ID: <20181208120907.4cd1a755@archlinux>
In-Reply-To: <1544066850-22617-1-git-send-email-Anson.Huang@nxp.com>
References: <1544066850-22617-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 03:33:16 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The light sensor's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds optional vcc regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> 	replace "VDD" with "VCC" since the regulator name is vcc_reg.
Fabio has raised naming concerns so I'll assume we'll see a v3 with that.

One other comment inline.

Jonathan

> ---
>  drivers/iio/light/isl29018.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..87dcbce 100644
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
> @@ -735,6 +737,15 @@ static int isl29018_probe(struct i2c_client *client,
>  
>  	mutex_init(&chip->lock);
>  
> +	chip->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");
> +	if (!IS_ERR(chip->vcc_reg)) {

We should probably handle the case of deferred explicitly rather than
assuming all errors mean the regulator hasn't been provided.

> +		err = regulator_enable(chip->vcc_reg);
> +		if (err) {
> +			dev_err(&client->dev, "failed to enable VCC regulator\n");
> +			return err;
> +		}
> +	}
> +
>  	chip->type = dev_id;
>  	chip->calibscale = 1;
>  	chip->ucalibscale = 0;
> @@ -768,6 +779,7 @@ static int isl29018_probe(struct i2c_client *client,
>  static int isl29018_suspend(struct device *dev)
>  {
>  	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
> +	int ret;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -777,6 +789,14 @@ static int isl29018_suspend(struct device *dev)
>  	 * So we do not have much to do here.
>  	 */
>  	chip->suspended = true;
> +	if (!IS_ERR(chip->vcc_reg)) {
> +		ret = regulator_disable(chip->vcc_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VCC regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return ret;
> +		}
> +	}
>  
>  	mutex_unlock(&chip->lock);
>  
> @@ -790,6 +810,15 @@ static int isl29018_resume(struct device *dev)
>  
>  	mutex_lock(&chip->lock);
>  
> +	if (!IS_ERR(chip->vcc_reg)) {
> +		err = regulator_enable(chip->vcc_reg);
> +		if (err) {
> +			dev_err(dev, "failed to enable VCC regulator\n");
> +			mutex_unlock(&chip->lock);
> +			return err;
> +		}
> +	}
> +
>  	err = isl29018_chip_init(chip);
>  	if (!err)
>  		chip->suspended = false;

