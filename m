Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530592086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUizLL1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBGSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:18:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36907 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBGSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:18:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so307710plr.4;
        Thu, 07 Feb 2019 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yqYYiqjS6eJr9g7jLPNaaxd40OapnbzFHmDcUHc4DwQ=;
        b=aUizLL1DZBI1MpfVhWKXxJjV1SYoMV4WI0FetOUsG4ongauB5cPq+tw0hTHFX7CPJU
         pGLFEKsvkTnUsILsZVej+C6rr38Ei4Py5ul0c2ewEf/4TuMmAqF3427NfdA0J03gwtAd
         +czVLV6Ge+/kg2Rhf0PKH8mwtcIUAuwHMhv4NJLpAs2jcET/nuV0gFgw4Wz8/w2PF50M
         OlvZ0OnDDc1CWZ3SdztnC6ei3FEzgPzYvQ+ZcBAjZ168/nT2/zkM99we1mOpD1OKFFYo
         ZpPJbueiuRBbD/e/OsdRPlAzU95BUxUdmKIFsP6NVkedfJyGDZ0bnLxWQIiXcKh8UY1G
         TCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqYYiqjS6eJr9g7jLPNaaxd40OapnbzFHmDcUHc4DwQ=;
        b=sD78ExLl94M0dl5eKvGfCdG1fl/NPxoEaF0VuDhjqFGvvPWYQSI/bhRwGM/cn381MM
         6mkYbaNjfjVGnssHUkbU0xka/FcKG3Xf9tBxBhlrETjdcOQRDC9RYN2vgHkNKDKHGoQB
         EUYAhSIqliSEPNyFIki7msenYCnutjuEPFZsoMVIHTbjz8xojYEuzrwZ8BO92B13XxaR
         fA58S1d3fvY22tcspkrfO3YHuWwVeARTUhMt68NsEyYxqnuMM2O4H+gJg8f2d6LHWXm2
         H5is7A10JoJpdSVi67uuPD8Ems86lRERvJyZTkK5VNyU1sFQSFFS4WwdlAk5A3Jhwaqz
         eH1A==
X-Gm-Message-State: AHQUAublhTwL+Y80iegZ19aCMNgXybBDXLBbsz2PArHnTb4d43DGFPvH
        kHuV3Hbxmhk7/8tQaqE/4z8=
X-Google-Smtp-Source: AHgI3IYpMOj4jqhQpxDRi9FHrtQjAYfGhOF7Wyzq+9VYIHxpSFVEI4/oC+JiMFZEza3bvdihWZyGMg==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr17539959plg.171.1549563509093;
        Thu, 07 Feb 2019 10:18:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm11972086pfn.177.2019.02.07.10.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:18:27 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:18:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] hwmon: pwm-fan: Add optional regulator support
Message-ID: <20190207181826.GA27492@roeck-us.net>
References: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
 <1549557480-14436-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549557480-14436-3-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:38:00PM +0100, Stefan Wahren wrote:
> This adds optional regulator support to the pwm-fan driver. This is
> necessary for pwm fans which are powered by a switchable supply.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/pwm-fan.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 2c94482..344915c 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  #include <linux/thermal.h>
>  
> @@ -31,6 +32,7 @@
>  struct pwm_fan_ctx {
>  	struct mutex lock;
>  	struct pwm_device *pwm;
> +	struct regulator *reg_en;
>  	unsigned int pwm_value;
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
> @@ -231,6 +233,21 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ctx);
>  
> +	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
> +	if (IS_ERR(ctx->reg_en)) {
> +		if (PTR_ERR(ctx->reg_en) == -ENODEV)
> +			ctx->reg_en = NULL;
> +		else
> +			return PTR_ERR(ctx->reg_en);

		if PTR_ERR(ctx->reg_en) != -ENODEV)
			return PTR_ERR(ctx->reg_en);
		ctx->reg_en = NULL;

would be a bit easier to read and avoid an else.

> +	} else {
> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable fan supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	ctx->pwm_value = MAX_PWM;
>  
>  	/* Set duty cycle to maximum allowed and enable PWM output */
> @@ -241,7 +258,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	ret = pwm_apply_state(ctx->pwm, &state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to configure PWM\n");
> -		return ret;
> +		goto err_reg_disable;
>  	}
>  
>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
> @@ -277,6 +294,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	state.enabled = false;
>  	pwm_apply_state(ctx->pwm, &state);
>  
> +err_reg_disable:
> +	if (ctx->reg_en)
> +		regulator_disable(ctx->reg_en);
> +
>  	return ret;
>  }
>  
> @@ -287,6 +308,10 @@ static int pwm_fan_remove(struct platform_device *pdev)
>  	thermal_cooling_device_unregister(ctx->cdev);
>  	if (ctx->pwm_value)
>  		pwm_disable(ctx->pwm);
> +
> +	if (ctx->reg_en)
> +		regulator_disable(ctx->reg_en);
> +
>  	return 0;
>  }
>  
> @@ -299,6 +324,12 @@ static int pwm_fan_suspend(struct device *dev)
>  
>  	pwm_get_args(ctx->pwm, &args);
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_disable(ctx->reg_en);
> +		if (ret)
> +			dev_err(dev, "Failed to disable fan supply: %d\n", ret);

This is a bit weird. The error is returned to the caller, but only if
ctx->pwm_value is 0. Otherwise it is ignored. This warrants an explanation
(and some selling) if it is on purpose.

> +	}
> +
>  	if (ctx->pwm_value) {
>  		ret = pwm_config(ctx->pwm, 0, args.period);
>  		if (ret < 0)
> @@ -317,6 +348,12 @@ static int pwm_fan_resume(struct device *dev)
>  	unsigned long duty;
>  	int ret;
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret)
> +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);

Does it really make sense here to ignore this error ? After all,
the fan will likely not work if that error really happens. Doesn't
that count as resume failure ?

> +	}
> +
>  	if (ctx->pwm_value == 0)
>  		return 0;
>  
> -- 
> 2.7.4
> 
