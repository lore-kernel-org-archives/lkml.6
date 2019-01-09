Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16420665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfAINHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:07:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45878 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfAINHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:07:15 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghDZd-0005RL-WE; Wed, 09 Jan 2019 14:07:10 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mfd: rk808: Prepare rk805 for poweroff
Date:   Wed, 09 Jan 2019 14:07:09 +0100
Message-ID: <1917869.4NZ4yPfKWV@diego>
In-Reply-To: <1538465910-27233-1-git-send-email-stefan@olimex.com>
References: <1538465910-27233-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan, Lee,

Am Dienstag, 2. Oktober 2018, 09:38:29 CET schrieb Stefan Mavrodiev:
> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
> mode. The default is SLEEP mode.
> 
> However, when the kernel performs power-off (actually the ATF) the
> device will not go fully off and this will result in higher power
> consumption and inability to wake the device with RTC alarm.
> 
> The solution is to enable pm_power_off_prepare function, which will
> configure SLEEP pin for OFF function.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

just found this while cleaning my inbox and this change looks
significant and it seems hasn't been applied yet.

I guess this is still relevant, right?


Heiko

> ---
>  drivers/mfd/rk808.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6..50f3f78 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -387,6 +387,25 @@ static void rk805_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
> 
> +static void rk805_device_shutdown_prepare(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "have no rk805, so do nothing here\n");
> +
> +		return;
> +	}
> +
> +	ret = regmap_update_bits(rk808->regmap,
> +				 RK805_GPIO_IO_POL_REG,
> +				 SLP_SD_MSK, SHUTDOWN_FUN);
> +	if (ret)
> +		dev_err(&rk808_i2c_client->dev, "power off error!\n");
> +}
> +
>  static void rk808_device_shutdown(void)
>  {
>  	int ret;
> @@ -549,6 +568,10 @@ static int rk808_probe(struct i2c_client *client,
>  	if (pm_off && !pm_power_off) {
>  		rk808_i2c_client = client;
>  		pm_power_off = pm_pwroff_fn;
> +	} else if (pm_off && !pm_power_off_prepare &&
> +		   rk808->variant == RK805_ID) {
> +		rk808_i2c_client = client;
> +		pm_power_off_prepare = rk805_device_shutdown_prepare;
>  	}
> 
>  	return 0;
> @@ -564,6 +587,7 @@ static int rk808_remove(struct i2c_client *client)
> 
>  	regmap_del_irq_chip(client->irq, rk808->irq_data);
>  	pm_power_off = NULL;
> +	pm_power_off_prepare = NULL;
> 
>  	return 0;
>  }




