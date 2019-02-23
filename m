Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B944C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB4F20657
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/LZ7hLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfBWRDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:03:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35971 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBWRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:03:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so2529122plt.3;
        Sat, 23 Feb 2019 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JKQkewid9S+ZnRN5ogKVvGR/1DZ82vhJpgTsx5PShUI=;
        b=O/LZ7hLpNCit6VNRuQvNbdVblcanInuw92aAUAbSFxyrbQV+Ox/pebSXEvtiN+iRRr
         9mAtk70iJONDkjf8iE/kZuerWm/janmk6ShoI0ZkRuRcD/jN4sPIuFudSVObwvsahVQw
         oyEDM3jlcS3F7Ug1XxVhKzLSGZhpXx6JrBOanhWg5zrZ4k6Wf99OdaKgnKdbNhO1Ia16
         KvcQRt0Gw0q0krltpVUL7GmXN5bScGINjfhLzFqyHsn+QWmsg1zaB7yda1dl2Ck1DP6b
         hccNecVi2WkMdae7tYRFxB+mjPuoV7vYq8o/QYzxaN0mX2ngBjvyxHyrZjzJfnoMEFLl
         F/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JKQkewid9S+ZnRN5ogKVvGR/1DZ82vhJpgTsx5PShUI=;
        b=rDttIc/GunlFpKLZ66x94IX67bE/7yeb1Iq+B4+YFVdVO+n1JY5oorXeSS4sieekiH
         u05jzm3Om4ojj1pF0WSp0hlP5f4oAThwa68MVziAdlIrzbTRI5mKNiqfxvtykjKqtYsC
         uR4myKS4longEVZxqwpQZppB5g50ivmTi3ThEM1ci5a3mOtEBDM0b6w6v/wURv0At1fq
         UO5c0wRv1GZ8h7nBdlAbRG8n2LzE44hkDiNTZHSqM9OeFRSMY15cEGHxg03aWmlCnMYJ
         99KY4cE0lOL9nKWQQIGGFjtEICdnKKgAYlTJKffcOh0bKxTatd4LaZFdtQYHHP05KUip
         5dTg==
X-Gm-Message-State: AHQUAuZQ+ssjyMTIFovaeSww+OGhLl2llZts6JrEyz/94mmDbS/uFy/3
        W3zJ8U/VYb4vlGXehFMVXTQ=
X-Google-Smtp-Source: AHgI3IYq6ALaLmSPoLdR4fBBJjfAu1r2voZZPPPdIRD+9hG0jLH0c8TNT2RCNytkY0zAoQzWwWEz2g==
X-Received: by 2002:a17:902:87:: with SMTP id a7mr416906pla.295.1550941418664;
        Sat, 23 Feb 2019 09:03:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t71sm5681349pgd.15.2019.02.23.09.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:03:38 -0800 (PST)
Date:   Sat, 23 Feb 2019 09:03:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] hwmon: pwm-fan: Add optional regulator support
Message-ID: <20190223170337.GA14857@roeck-us.net>
References: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
 <1550843124-10992-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550843124-10992-3-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:45:24PM +0100, Stefan Wahren wrote:
> This adds optional regulator support to the pwm-fan driver. This is
> necessary for pwm fans which are powered by a switchable supply.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 2c94482..167221c 100644
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
> +		if (PTR_ERR(ctx->reg_en) != -ENODEV)
> +			return PTR_ERR(ctx->reg_en);
> +
> +		ctx->reg_en = NULL;
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
> @@ -307,6 +332,14 @@ static int pwm_fan_suspend(struct device *dev)
>  		pwm_disable(ctx->pwm);
>  	}
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_disable(ctx->reg_en);
> +		if (ret) {
> +			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -317,6 +350,14 @@ static int pwm_fan_resume(struct device *dev)
>  	unsigned long duty;
>  	int ret;
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	if (ctx->pwm_value == 0)
>  		return 0;
>  
