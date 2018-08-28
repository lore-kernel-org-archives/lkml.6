Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D220847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OKK5n411"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40D220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeH1ELf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:11:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39776 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1ELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:11:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so347190pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6lvy9Cs1/pPfHEEeaI3JDJV/Kdhapiv6FAzglt9+JM=;
        b=OKK5n411sXfjgsurW0tB+RJVnM0Flv7eJHQqGv9Ji2HH/TYD8CCvO9DAfMUumrdTZi
         efQKutFfloKL1pcVrEXB432ly4PvWGfVHEyR1WNPurBMVSCVLP9BVmzIfdhHFx3TgoXU
         4lio8mLFM0q/S49lAyfbK9Om0qt/2k24NPHa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6lvy9Cs1/pPfHEEeaI3JDJV/Kdhapiv6FAzglt9+JM=;
        b=jTvHslfQz34CLJhdAlGjZIv4nk6R1VjRyN8K67be52+MTj8RNzjWsmSoP9s0/MeeeU
         bh6SECu8e91eHxtaqLdxn21+0b3wox+DUenflnIA7ByYKHJpOfjQulL+s4lCykRqPa0y
         5S9pZFrkzzNeR92bPbUfJx/OHIN6TKS2AcF/J62Ao7texjp18++SIlv0m3JUnQiJJWqd
         9gSRjMKTiLyZXNlEjV1TsxKmdbceAupbBcuRemwXYIQjmuazBufibb19TyNhMIZn1UYF
         XPYfkU1IFdLseL6vzij7M64IC17eE2bJTjcDFuqJKSzAgTi0NzJy2Nm8Vf1YxWuKZGXA
         ORkQ==
X-Gm-Message-State: APzg51DSTQvODZbIwurfRqw04UYPn78EcmDyY4wJQV7vCLTFsEFnRi6N
        NvHDBULJ7bgC9PU7zOO1S+KZlQ==
X-Google-Smtp-Source: ANB0VdayOTNKL3rYuLE6mt4Ftv6o51lnkzg1jhnVN1cuvsE2z/B+FXDf9MesbpKFMB3jEiXw5P1v0g==
X-Received: by 2002:a63:e14a:: with SMTP id h10-v6mr14103983pgk.358.1535415757610;
        Mon, 27 Aug 2018 17:22:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f75-v6sm537240pfk.85.2018.08.27.17.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:22:36 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:22:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 2/6] reset: qcom: PDC Global (Power Domain Controller)
 reset controller
Message-ID: <20180828002236.GX160295@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-3-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, Aug 24, 2018 at 06:48:56PM +0530, Sibi Sankar wrote:
> Add reset controller for SDM845 SoCs to control reset signals provided
> by PDC Global for Modem, Compute, Display, GPU, Debug, AOP, Sensors,
> Audio, SP and APPS
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/reset/Kconfig          |   9 +++
>  drivers/reset/Makefile         |   1 +
>  drivers/reset/reset-qcom-pdc.c | 142 +++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)
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

What exactly does APPS mean? The AP cores, the entire SoC, something
else?

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
> index 000000000000..bb6a5e5ee0f8
> --- /dev/null
> +++ b/drivers/reset/reset-qcom-pdc.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/regmap.h>
> +#include <linux/of_device.h>
> +#include <dt-bindings/reset/qcom,sdm845-pdc.h>

Headers should be sorted in alphabetical order.

> +
> +#define RPMH_PDC_SYNC_RESET	0x100
> +
> +struct qcom_pdc_reset_map {
> +	u8 bit;
> +};
> +
> +struct qcom_pdc_desc {
> +	const struct regmap_config *config;
> +	const struct qcom_pdc_reset_map *resets;
> +	size_t num_resets;
> +};

Not sure if this structure adds much value or just a layer of
indirection:

- .config is only accessed in _probe(), sdm845_pdc_regmap_config could
  be used directly
- .resets is used in _(de)assert(), sdm845_pdc_resets could be used
  directly
- .num_resets is only accessed in _probe(),
  ARRAY_SIZE(sdm845_pdc_resets) could be used instead

It probably makes sense if it is planned to support reset controllers
of other SoCs with this driver.

> +struct qcom_pdc_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +	const struct qcom_pdc_desc *desc;
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
> +static const struct qcom_pdc_desc sdm845_pdc_desc = {
> +	.config = &sdm845_pdc_regmap_config,
> +	.resets = sdm845_pdc_resets,
> +	.num_resets = ARRAY_SIZE(sdm845_pdc_resets),
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
> +	const struct qcom_pdc_reset_map *map = &data->desc->resets[idx];
> +
> +	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
> +					BIT(map->bit), BIT(map->bit));
> +}
> +
> +static int qcom_pdc_control_deassert(struct reset_controller_dev *rcdev,
> +					unsigned long idx)
> +{
> +	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
> +	const struct qcom_pdc_reset_map *map = &data->desc->resets[idx];
> +
> +	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
> +					BIT(map->bit), 0);
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
> +	const struct qcom_pdc_desc *desc;
> +	void __iomem *base;
> +	struct resource *res;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->desc = desc;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data->regmap = devm_regmap_init_mmio(dev, base, desc->config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "Unable to get pdc-global regmap");

Add missing '\n'

Say 'pdc-reset' instead of 'pdc-global'? (see also my other comment
below).

> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.ops = &qcom_pdc_reset_ops;
> +	data->rcdev.nr_resets = desc->num_resets;
> +	data->rcdev.of_node = dev->of_node;
> +
> +	return devm_reset_controller_register(dev, &data->rcdev);
> +}
> +
> +static const struct of_device_id qcom_pdc_reset_of_match[] = {
> +	{ .compatible = "qcom,sdm845-pdc-global", .data = &sdm845_pdc_desc },

Should this be 'qcom,sdm845-pdc-reset' which is more specific than
'global' and in line with the name and purpose of the driver?
Obviously this would require to adjust the bindings doc too.

Cheers

Matthias
