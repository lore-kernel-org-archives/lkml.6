Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC27C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EBA20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJ3KUiHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EBA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeICXtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:49:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeICXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:49:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so516420pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNrjegIrqKNOn1+SvnxBYld18ip0DTLWnH7Y1qQXgMo=;
        b=jJ3KUiHQRZXFrWp2RuJentGGAK5HyNw2jbTgqcFnfC6F/sTgr7E0z20BS2V8NogVMu
         xuV7P9cmIBsWd45WDexFUPkEO15spP3wHVnoIG4gxHvsBnbjqXGq0dVgtBBd2JuudxIE
         pfYf6sTVmKkQdcxE6yQsS1D4vYLfUujKnJSOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNrjegIrqKNOn1+SvnxBYld18ip0DTLWnH7Y1qQXgMo=;
        b=A4DuEtKH5sYauLfgWZQo6G7Tg9t7HkX1DZyB3lPSt8+iQtLKV/onCrJeCzpLameoiP
         81cGOtF/3BziubfuO0j5IVoWDw3aF9wUSV9N4LZU5VJy2uuCDXQJcINP4BPjjZs+85ha
         Gge4zME7nrTwS6rAm98LYEWmapWHjxJMQA6y11lYOsfIL3TbXTHcBQlJjhaoJSya1xlA
         EQc8klfn1ZDlRU9tj5qMS8DQGFxGfQlZtXDrYPLe4q2Aq8i0fXOgIslHQ14CfNbGIgT5
         cUa3p4jbGHorzRH7xceVIlic0aRS+jnXLL/SF1c0EFXWdYpRFB8QVS71OGf8mFCHFdNH
         JfHw==
X-Gm-Message-State: APzg51A8WjlIVVUHi5z507CLJEWgVuje8RJ9jObZ951vp3bOKN1pY19K
        NQNCVf4x94wUYF8k84PioBgULg==
X-Google-Smtp-Source: ANB0Vdbmg+Oa1kWIE8bXiO4KMIhg5Dw2pdqmHCY1ox0BDgvD6xzTMlBbe3u2MhJEmiOOISXRKmu/mA==
X-Received: by 2002:a62:2f84:: with SMTP id v126-v6mr31123454pfv.115.1536002873905;
        Mon, 03 Sep 2018 12:27:53 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h4-v6sm31648227pfe.49.2018.09.03.12.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:27:53 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:31:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, mka@chromium.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 2/6] reset: qcom: PDC Global (Power Domain Controller)
 reset controller
Message-ID: <20180903193147.GH3456@tuxbook-pro>
References: <20180829191215.10071-1-sibis@codeaurora.org>
 <20180829191215.10071-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829191215.10071-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 12:12 PDT 2018, Sibi Sankar wrote:

> Add reset controller for SDM845 SoCs to control reset signals provided
> by PDC Global for Modem, Compute, Display, GPU, Debug, AOP, Sensors,
> Audio, SP and APPS
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/reset/Kconfig          |   9 +++
>  drivers/reset/Makefile         |   1 +
>  drivers/reset/reset-qcom-pdc.c | 124 +++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 drivers/reset/reset-qcom-pdc.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 13d28fdbdbb5..c21da9fe51ec 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -98,6 +98,15 @@ config RESET_QCOM_AOSS
>  	  reset signals provided by AOSS for Modem, Venus, ADSP,
>  	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
>  
> +config RESET_QCOM_PDC
> +	tristate "Qualcomm PDC Reset Driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables the PDC (Power Domain Controller) reset driver
> +	  for Qualcomm Technologies Inc SDM845 SoCs. Say Y if you want
> +	  to control reset signals provided by PDC for Modem, Compute,
> +	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
> +
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
>  	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4243c38228e2..d08e8b90046a 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>  obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
> +obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
> new file mode 100644
> index 000000000000..ab74bccd4a5b
> --- /dev/null
> +++ b/drivers/reset/reset-qcom-pdc.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +
> +#define RPMH_PDC_SYNC_RESET	0x100
> +
> +struct qcom_pdc_reset_map {
> +	u8 bit;
> +};
> +
> +struct qcom_pdc_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config sdm845_pdc_regmap_config = {
> +	.name		= "pdc-reset",
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x20000,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_pdc_reset_map sdm845_pdc_resets[] = {
> +	[PDC_APPS_SYNC_RESET] = {0},
> +	[PDC_SP_SYNC_RESET] = {1},
> +	[PDC_AUDIO_SYNC_RESET] = {2},
> +	[PDC_SENSORS_SYNC_RESET] = {3},
> +	[PDC_AOP_SYNC_RESET] = {4},
> +	[PDC_DEBUG_SYNC_RESET] = {5},
> +	[PDC_GPU_SYNC_RESET] = {6},
> +	[PDC_DISPLAY_SYNC_RESET] = {7},
> +	[PDC_COMPUTE_SYNC_RESET] = {8},
> +	[PDC_MODEM_SYNC_RESET] = {9},
> +};
> +
> +static inline struct qcom_pdc_reset_data *to_qcom_pdc_reset_data(
> +				struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct qcom_pdc_reset_data, rcdev);
> +}
> +
> +static int qcom_pdc_control_assert(struct reset_controller_dev *rcdev,
> +					unsigned long idx)
> +{
> +	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
> +
> +	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
> +				  BIT(sdm845_pdc_resets[idx].bit),
> +				  BIT(sdm845_pdc_resets[idx].bit));
> +}
> +
> +static int qcom_pdc_control_deassert(struct reset_controller_dev *rcdev,
> +					unsigned long idx)
> +{
> +	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
> +
> +	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
> +				  BIT(sdm845_pdc_resets[idx].bit), 0);
> +}
> +
> +static const struct reset_control_ops qcom_pdc_reset_ops = {
> +	.assert = qcom_pdc_control_assert,
> +	.deassert = qcom_pdc_control_deassert,
> +};
> +
> +static int qcom_pdc_reset_probe(struct platform_device *pdev)
> +{
> +	struct qcom_pdc_reset_data *data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data->regmap = devm_regmap_init_mmio(dev, base,
> +					     &sdm845_pdc_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "Unable to initialize regmap\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.ops = &qcom_pdc_reset_ops;
> +	data->rcdev.nr_resets = ARRAY_SIZE(sdm845_pdc_resets);
> +	data->rcdev.of_node = dev->of_node;
> +
> +	return devm_reset_controller_register(dev, &data->rcdev);
> +}
> +
> +static const struct of_device_id qcom_pdc_reset_of_match[] = {
> +	{ .compatible = "qcom,sdm845-pdc-global" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_pdc_reset_of_match);
> +
> +static struct platform_driver qcom_pdc_reset_driver = {
> +	.probe = qcom_pdc_reset_probe,
> +	.driver = {
> +		.name = "qcom_pdc_reset",
> +		.of_match_table = qcom_pdc_reset_of_match,
> +	},
> +};
> +module_platform_driver(qcom_pdc_reset_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PDC Reset Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
