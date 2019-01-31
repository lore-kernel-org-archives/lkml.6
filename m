Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F3C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1B520881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRz3UnnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfAaR4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:56:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39915 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfAaR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:56:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so1670722pgp.6;
        Thu, 31 Jan 2019 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAFwcmRQ+VrKG4nQJh5Kon4m4cc+l/9DNk+7txAG8QU=;
        b=KRz3UnnQ6zyjWJezDVsIj6D8UyErHJcHeacVK5bR/wcOYO4M/d6KcnKPEPauUq/Wzr
         0G+ZoW2JDqTnt0D1zeEGePDtwXtMB/IQOIWC3v59HNqHmowYRiv2DrY2/GW3H80FtMKs
         LUY3dZH9OjDwqtFI6XM9oRLCniJTug6s7rhQcS+VGqQr8GLFlkOD7P8aZYxcO4MW5o3G
         FNyT1aGyF8PDK51J1hqYnMYZI+sPU41RcWM++exmVbQ+qAa1JhKCsDCbheP44xodoayc
         VN4RQu8XPmx6015maJf7W9ZC0PcLPLpXVlCCc30zXDXn4wzrbF3Ge1jmbMVJ23wVi7ML
         QvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAFwcmRQ+VrKG4nQJh5Kon4m4cc+l/9DNk+7txAG8QU=;
        b=goWPwq0mvqEZIE1LrABBwnP+YRJTGKA60aUIG8wuoVEASwcr0bWtFNaayfjlN8DB9R
         LgEO4MLCIDYAyP0mqpOpmcsWnefd+xhrd6zdOx8ExbW7ISr9wPlrNEhJc7z4b3e3RR1G
         mPI2U+W9W8Y3IEdTAdDYpvBMCtzG9Wjd8ma1dAcb8NEYLGLxaHPiqlXE5dOcvTNlIbnt
         UZk2E3vVrckcYPIYmrOzXozIET6av/ArEqkrLNR7hr51a7IjPpYHSsEncGnn+nbjSs4Q
         rZ+EkGjXCYw4MS0Nvr2v3BpL8n3u6VJqqWyoXCB19U1X9utkExtmwD8aAVLU0RyKEjVU
         3smg==
X-Gm-Message-State: AJcUukeO9I9xr3xaLgVS99jdADQlJGZwlS3/qdU0IytJ7BS6CEyo2xyA
        GxTXAXvQkCKO184zW/lhHmU=
X-Google-Smtp-Source: ALg8bN4MpUuZQb7MEWMRh+Fy78j94nz96NvQw6TlQO1opesEaAzqe6rUvSIIf3d/6r9NNgpIhP0V0Q==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr32677537pgh.445.1548957413841;
        Thu, 31 Jan 2019 09:56:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 128sm9762852pfu.129.2019.01.31.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:56:53 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:56:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Add optional regulator support
Message-ID: <20190131175651.GA16231@roeck-us.net>
References: <1548781631-5736-1-git-send-email-stefan.wahren@i2se.com>
 <1548781631-5736-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548781631-5736-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:07:11PM +0100, Stefan Wahren wrote:
> This adds optional regulator support to the pwm-fan driver. This is
> necessary for pwm fans which are powered by a switchable supply.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/pwm-fan.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 2c94482..9e0591e 100644
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
> @@ -244,6 +246,23 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
> +	if (!IS_ERR(ctx->reg_en)) {

It is customary to handle the error case first.

> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret)
> +			dev_err(&pdev->dev,
> +				"Failed to enable fan supply: %d\n", ret);
> +	} else {
> +		switch (PTR_ERR(ctx->reg_en)) {
> +		case -ENODEV:
> +		case -ENOSYS:

Does devm_regulator_get_optional() ever return -ENOSYS ?
I glanced through other calls to devm_regulator_get_optional(),
but I don't see that check anywhere.

> +			ctx->reg_en = NULL;
> +			break;
> +		default:
> +			return PTR_ERR(ctx->reg_en);
> +		}

This is inconsistent. Provided regulators which fail to enable are
accepted, albeit with an error message, while unexpected errors from
devm_regulator_get_optional() result in a bailout. Please be consistent.

> +	}
> +
>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>  						       ctx, pwm_fan_groups);
>  	if (IS_ERR(hwmon)) {
> @@ -287,6 +306,10 @@ static int pwm_fan_remove(struct platform_device *pdev)
>  	thermal_cooling_device_unregister(ctx->cdev);
>  	if (ctx->pwm_value)
>  		pwm_disable(ctx->pwm);
> +
> +	if (ctx->reg_en)
> +		regulator_disable(ctx->reg_en);

As written, this is also called after regulator_enable() failed.
Same below.

> +
>  	return 0;
>  }
>  
> @@ -299,6 +322,12 @@ static int pwm_fan_suspend(struct device *dev)
>  
>  	pwm_get_args(ctx->pwm, &args);
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_disable(ctx->reg_en);
> +		if (ret)
> +			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> +	}
> +
>  	if (ctx->pwm_value) {
>  		ret = pwm_config(ctx->pwm, 0, args.period);
>  		if (ret < 0)
> @@ -317,6 +346,12 @@ static int pwm_fan_resume(struct device *dev)
>  	unsigned long duty;
>  	int ret;
>  
> +	if (ctx->reg_en) {
> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret)
> +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> +	}
> +
>  	if (ctx->pwm_value == 0)
>  		return 0;
>  
