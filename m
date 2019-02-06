Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DDEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D2220823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odbKFU41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfBFSRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:17:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:16:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so3450060pls.8;
        Wed, 06 Feb 2019 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4svNntTjlaLyshcZZiCMNpXvYjJ0xBwUDuvpOY/f3Q=;
        b=odbKFU41+O/oq+3ZNYSVqVTKpYdVStwzvYiK7zb+SyhaDtOMkz7/8ztjCAGApLQ6X4
         lPU5k6G1dGAMzgKsxUdM+QGlGuqyhM+EHybmON+MLNZeXZHXW4EU/PKXhcsmYBCN+Y/L
         cs+keiLqwBfGVB87IlhDNJVcV5FidGxYnCjpnqrV1X4c8MGRv4+s9UlzqRW9Zqq9AUs1
         zuYdGldHI0BCG6cKp1Xn3Il3zBZSZA/olfz83JTWdaNFjNiKcD5zx/pFzZ33ziJxguQB
         kqBC1tUt4SuHbHbEEH1B51u7a5qkjyueg2YT/YuDHGcsOXVKwEKlaa44GMvtZG60g3cA
         AEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4svNntTjlaLyshcZZiCMNpXvYjJ0xBwUDuvpOY/f3Q=;
        b=J17ttNIxN5xKyJekhKKSTqzSt1NqZxAv0GGP4YdJOWNCK+SaSHtVOHEjDf8cLebatu
         gr+A+UumGFngjQQ3Ys+Jw9vs7bMPdvX1XanPFGz8WH1s4XdphzKmG2kcznnqOLFBVTsZ
         bDs3DY3K8K2JwR5xfaXrY1SD72JZ2vFrR81aW+v0+5yX0iai0aNjbu4k2nrQ8kQK0Hi0
         Ygb08cMrQdShKFRY0xWARGx9jsfZljidXXXRJH5u/opLrEigIN4AnRhG4sHBP0qe2TV8
         yvpcBxafDfkZXLU8WFtcMjS1rTg0BrxqyI+C3mHtSxVrWR3kIkeasni01VkjTjpEQgxC
         /GRA==
X-Gm-Message-State: AHQUAuZKALe87hb54zald3tIEUYejbzQr9nHSbkKu+zOB6bH8u3JUp+o
        4Hy1mErPV6vNRrgjRnZ8T60=
X-Google-Smtp-Source: AHgI3IaPKhxW+XsiuHW9apZbvXX8ic4RK/e/IMg2orBuQEqfezG39OU/ROJ9xfgK8LCMt7rgHxkdLQ==
X-Received: by 2002:a17:902:704c:: with SMTP id h12mr12392899plt.30.1549477017990;
        Wed, 06 Feb 2019 10:16:57 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m20sm14136600pgb.56.2019.02.06.10.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:16:57 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:16:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v4 2/3] Input: add new vibrator driver for various MSM
 SOCs
Message-ID: <20190206181655.GA174258@dtor-ws>
References: <20190206013329.18195-1-masneyb@onstation.org>
 <20190206013329.18195-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206013329.18195-3-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:33:28PM -0500, Brian Masney wrote:
> This patch adds a new vibrator driver that supports various Qualcomm
> MSM SOCs. Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Applied together with binding patch, thank you.

> ---
> Changes since v3:
> - Made msm_vibrator_write a function instead of a macro.
> - Check for -EPROBE_DEFER for gpio and clk for consistency with the
>   regulator.
> - Check for NULL return value from devm_ioremap() instead of using
>   IS_ERR()
> - Don't set dev.parent
> - Use platform_get_drvdata() in suspend and resume
> 
>  drivers/input/misc/Kconfig        |  10 ++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/msm-vibrator.c | 282 ++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 drivers/input/misc/msm-vibrator.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2be9bc5..e39aef84f357 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -117,6 +117,16 @@ config INPUT_E3X0_BUTTON
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called e3x0_button.
>  
> +config INPUT_MSM_VIBRATOR
> +	tristate "Qualcomm MSM vibrator driver"
> +	select INPUT_FF_MEMLESS
> +	help
> +	  Support for the vibrator that is found on various Qualcomm MSM
> +	  SOCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called msm_vibrator.
> +
>  config INPUT_PCSPKR
>  	tristate "PC Speaker support"
>  	depends on PCSPKR_PLATFORM
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1ff68f..96a6419cb1f2 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
>  obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
>  obj-$(CONFIG_INPUT_MMA8450)		+= mma8450.o
> +obj-$(CONFIG_INPUT_MSM_VIBRATOR)	+= msm-vibrator.o
>  obj-$(CONFIG_INPUT_PALMAS_PWRBUTTON)	+= palmas-pwrbutton.o
>  obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
>  obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
> diff --git a/drivers/input/misc/msm-vibrator.c b/drivers/input/misc/msm-vibrator.c
> new file mode 100644
> index 000000000000..c06941021447
> --- /dev/null
> +++ b/drivers/input/misc/msm-vibrator.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm MSM vibrator driver
> + *
> + * Copyright (c) 2018 Brian Masney <masneyb@onstation.org>
> + *
> + * Based on qcom,pwm-vibrator.c from:
> + * Copyright (c) 2018 Jonathan Marek <jonathan@marek.ca>
> + *
> + * Based on msm_pwm_vibrator.c from downstream Android sources:
> + * Copyright (C) 2009-2014 LGE, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define REG_CMD_RCGR           0x00
> +#define REG_CFG_RCGR           0x04
> +#define REG_M                  0x08
> +#define REG_N                  0x0C
> +#define REG_D                  0x10
> +#define REG_CBCR               0x24
> +#define MMSS_CC_M_DEFAULT      1
> +
> +struct msm_vibrator {
> +	struct input_dev *input;
> +	struct mutex mutex;
> +	struct work_struct worker;
> +	void __iomem *base;
> +	struct regulator *vcc;
> +	struct clk *clk;
> +	struct gpio_desc *enable_gpio;
> +	u16 magnitude;
> +	bool enabled;
> +};
> +
> +static void msm_vibrator_write(struct msm_vibrator *vibrator, int offset,
> +			       u32 value)
> +{
> +	writel(value, vibrator->base + offset);
> +}
> +
> +static int msm_vibrator_start(struct msm_vibrator *vibrator)
> +{
> +	int d_reg_val, ret = 0;
> +
> +	mutex_lock(&vibrator->mutex);
> +
> +	if (!vibrator->enabled) {
> +		ret = clk_set_rate(vibrator->clk, 24000);
> +		if (ret) {
> +			dev_err(&vibrator->input->dev,
> +				"Failed to set clock rate: %d\n", ret);
> +			goto unlock;
> +		}
> +
> +		ret = clk_prepare_enable(vibrator->clk);
> +		if (ret) {
> +			dev_err(&vibrator->input->dev,
> +				"Failed to enable clock: %d\n", ret);
> +			goto unlock;
> +		}
> +
> +		ret = regulator_enable(vibrator->vcc);
> +		if (ret) {
> +			dev_err(&vibrator->input->dev,
> +				"Failed to enable regulator: %d\n", ret);
> +			clk_disable(vibrator->clk);
> +			goto unlock;
> +		}
> +
> +		gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
> +
> +		vibrator->enabled = true;
> +	}
> +
> +	d_reg_val = 127 - ((126 * vibrator->magnitude) / 0xffff);
> +	msm_vibrator_write(vibrator, REG_CFG_RCGR,
> +			   (2 << 12) | /* dual edge mode */
> +			   (0 << 8) |  /* cxo */
> +			   (7 << 0));
> +	msm_vibrator_write(vibrator, REG_M, 1);
> +	msm_vibrator_write(vibrator, REG_N, 128);
> +	msm_vibrator_write(vibrator, REG_D, d_reg_val);
> +	msm_vibrator_write(vibrator, REG_CMD_RCGR, 1);
> +	msm_vibrator_write(vibrator, REG_CBCR, 1);
> +
> +unlock:
> +	mutex_unlock(&vibrator->mutex);
> +
> +	return ret;
> +}
> +
> +static void msm_vibrator_stop(struct msm_vibrator *vibrator)
> +{
> +	mutex_lock(&vibrator->mutex);
> +
> +	if (vibrator->enabled) {
> +		gpiod_set_value_cansleep(vibrator->enable_gpio, 0);
> +		regulator_disable(vibrator->vcc);
> +		clk_disable(vibrator->clk);
> +		vibrator->enabled = false;
> +	}
> +
> +	mutex_unlock(&vibrator->mutex);
> +}
> +
> +static void msm_vibrator_worker(struct work_struct *work)
> +{
> +	struct msm_vibrator *vibrator = container_of(work,
> +						     struct msm_vibrator,
> +						     worker);
> +
> +	if (vibrator->magnitude)
> +		msm_vibrator_start(vibrator);
> +	else
> +		msm_vibrator_stop(vibrator);
> +}
> +
> +static int msm_vibrator_play_effect(struct input_dev *dev, void *data,
> +				    struct ff_effect *effect)
> +{
> +	struct msm_vibrator *vibrator = input_get_drvdata(dev);
> +
> +	mutex_lock(&vibrator->mutex);
> +
> +	if (effect->u.rumble.strong_magnitude > 0)
> +		vibrator->magnitude = effect->u.rumble.strong_magnitude;
> +	else
> +		vibrator->magnitude = effect->u.rumble.weak_magnitude;
> +
> +	mutex_unlock(&vibrator->mutex);
> +
> +	schedule_work(&vibrator->worker);
> +
> +	return 0;
> +}
> +
> +static void msm_vibrator_close(struct input_dev *input)
> +{
> +	struct msm_vibrator *vibrator = input_get_drvdata(input);
> +
> +	cancel_work_sync(&vibrator->worker);
> +	msm_vibrator_stop(vibrator);
> +}
> +
> +static int msm_vibrator_probe(struct platform_device *pdev)
> +{
> +	struct msm_vibrator *vibrator;
> +	struct resource *res;
> +	int ret;
> +
> +	vibrator = devm_kzalloc(&pdev->dev, sizeof(*vibrator), GFP_KERNEL);
> +	if (!vibrator)
> +		return -ENOMEM;
> +
> +	vibrator->input = devm_input_allocate_device(&pdev->dev);
> +	if (!vibrator->input)
> +		return -ENOMEM;
> +
> +	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(vibrator->vcc)) {
> +		if (PTR_ERR(vibrator->vcc) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get regulator: %ld\n",
> +				PTR_ERR(vibrator->vcc));
> +		return PTR_ERR(vibrator->vcc);
> +	}
> +
> +	vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(vibrator->enable_gpio)) {
> +		if (PTR_ERR(vibrator->enable_gpio) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get enable gpio: %ld\n",
> +				PTR_ERR(vibrator->enable_gpio));
> +		return PTR_ERR(vibrator->enable_gpio);
> +	}
> +
> +	vibrator->clk = devm_clk_get(&pdev->dev, "pwm");
> +	if (IS_ERR(vibrator->clk)) {
> +		if (PTR_ERR(vibrator->clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
> +				PTR_ERR(vibrator->clk));
> +		return PTR_ERR(vibrator->clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	vibrator->base = devm_ioremap(&pdev->dev, res->start,
> +				     resource_size(res));
> +	if (!vibrator->base) {
> +		dev_err(&pdev->dev, "Failed to iomap resource: %ld\n",
> +			PTR_ERR(vibrator->base));
> +		return -ENOMEM;
> +	}
> +
> +	vibrator->enabled = false;
> +	mutex_init(&vibrator->mutex);
> +	INIT_WORK(&vibrator->worker, msm_vibrator_worker);
> +
> +	vibrator->input->name = "msm-vibrator";
> +	vibrator->input->id.bustype = BUS_HOST;
> +	vibrator->input->close = msm_vibrator_close;
> +
> +	input_set_drvdata(vibrator->input, vibrator);
> +	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +	ret = input_ff_create_memless(vibrator->input, NULL,
> +				      msm_vibrator_play_effect);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create ff memless: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = input_register_device(vibrator->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register input device: %d", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct msm_vibrator *vibrator = platform_get_drvdata(pdev);
> +
> +	cancel_work_sync(&vibrator->worker);
> +
> +	if (vibrator->enabled)
> +		msm_vibrator_stop(vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct msm_vibrator *vibrator = platform_get_drvdata(pdev);
> +
> +	if (vibrator->enabled)
> +		msm_vibrator_start(vibrator);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(msm_vibrator_pm_ops, msm_vibrator_suspend,
> +			 msm_vibrator_resume);
> +
> +static const struct of_device_id msm_vibrator_of_match[] = {
> +	{ .compatible = "qcom,msm8226-vibrator" },
> +	{ .compatible = "qcom,msm8974-vibrator" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, msm_vibrator_of_match);
> +
> +static struct platform_driver msm_vibrator_driver = {
> +	.probe	= msm_vibrator_probe,
> +	.driver	= {
> +		.name = "msm-vibrator",
> +		.pm = &msm_vibrator_pm_ops,
> +		.of_match_table = of_match_ptr(msm_vibrator_of_match),
> +	},
> +};
> +module_platform_driver(msm_vibrator_driver);
> +
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
> +MODULE_DESCRIPTION("Qualcomm MSM vibrator driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.2
> 

-- 
Dmitry
