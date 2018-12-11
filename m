Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD38C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DE42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DE42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeLKDgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:36:18 -0500
Received: from anchovy1.45ru.net.au ([203.30.46.145]:46276 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeLKDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:36:17 -0500
Received: (qmail 15479 invoked by uid 5089); 11 Dec 2018 03:36:14 -0000
Received: by simscan 1.2.0 ppid: 15309, pid: 15313, t: 0.0869s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 11 Dec 2018 03:36:13 -0000
Subject: Re: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
To:     Anson Huang <anson.huang@nxp.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
 <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <d07b5970-5825-2ea6-9e27-538386927923@electromag.com.au>
Date:   Tue, 11 Dec 2018 11:36:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 11:24 am, Anson Huang wrote:
> The light sensor's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds optional vdd/vdda regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog since V3:
> 	- improve the error handling of devm_regulator_get_optional;
> 	- make sure regulators are disabled in error path.
> ---
>   drivers/iio/light/isl29018.c | 83 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..a21652b 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -23,6 +23,7 @@
>   #include <linux/mutex.h>
>   #include <linux/delay.h>
>   #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -95,6 +96,8 @@ struct isl29018_chip {
>   	struct isl29018_scale	scale;
>   	int			prox_scheme;
>   	bool			suspended;
> +	struct regulator	*vdd_reg;
> +	struct regulator	*vdda_reg;
>   };
>   
>   static int isl29018_set_integration_time(struct isl29018_chip *chip,
> @@ -735,6 +738,34 @@ static int isl29018_probe(struct i2c_client *client,
>   
>   	mutex_init(&chip->lock);
>   
> +	chip->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (!IS_ERR(chip->vdd_reg)) {
> +		err = regulator_enable(chip->vdd_reg);
> +		if (err) {
> +			dev_err(&client->dev, "failed to enable VDD regulator\n");
> +			return err;
> +		}
> +	} else {
> +		err = PTR_ERR(chip->vdd_reg);
> +		if (err != -ENODEV)
> +			return err;
> +	}
> +
> +	chip->vdda_reg = devm_regulator_get_optional(&client->dev, "vdda");
> +	if (!IS_ERR(chip->vdda_reg)) {
> +		err = regulator_enable(chip->vdda_reg);
> +		if (err) {
> +			dev_err(&client->dev, "failed to enable VDDA regulator\n");
> +			if (!IS_ERR(chip->vdd_reg))
> +				regulator_disable(chip->vdd_reg);
> +			return err;
> +		}
> +	} else {
> +		err = PTR_ERR(chip->vdda_reg);
> +		if (err != -ENODEV)
> +			return err;
maybe goto disable_regulators; to disable vdd.

> +	}
> +
>   	chip->type = dev_id;
>   	chip->calibscale = 1;
>   	chip->ucalibscale = 0;
> @@ -747,12 +778,12 @@ static int isl29018_probe(struct i2c_client *client,
>   	if (IS_ERR(chip->regmap)) {
>   		err = PTR_ERR(chip->regmap);
>   		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
> -		return err;
> +		goto disable_regulators;
>   	}
>   
>   	err = isl29018_chip_init(chip);
>   	if (err)
> -		return err;
> +		goto disable_regulators;
>   
>   	indio_dev->info = isl29018_chip_info_tbl[dev_id].indio_info;
>   	indio_dev->channels = isl29018_chip_info_tbl[dev_id].channels;
> @@ -761,13 +792,24 @@ static int isl29018_probe(struct i2c_client *client,
>   	indio_dev->dev.parent = &client->dev;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
> +	if (!err)
> +		return 0;
> +
> +disable_regulators:
> +	if (!IS_ERR(chip->vdd_reg))
> +		regulator_disable(chip->vdd_reg);
> +	if (!IS_ERR(chip->vdda_reg))
> +		regulator_disable(chip->vdda_reg);
> +
> +	return err;
>   }
>   
[snip]

-- 
Regards
Phil
