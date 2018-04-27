Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbeD0KlV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:41:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36773 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeD0KlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:41:19 -0400
Message-ID: <1524825675.17614.6.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] reset: qcom: AOSS (always on subsystem) reset
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date: Fri, 27 Apr 2018 12:41:15 +0200
In-Reply-To: <20180425150843.26657-3-sibis@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
         <20180425150843.26657-3-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 20:38 +0530, Sibi Sankar wrote:
> Add reset controller driver for Qualcomm SDM845 SoC to
> control reset signals provided by AOSS for Modem, Venus
> ADSP, GPU, Camera, Wireless, Display subsystem
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/reset/Kconfig           |   9 +++
>  drivers/reset/Makefile          |   1 +
>  drivers/reset/reset-qcom-aoss.c | 133 ++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/reset/reset-qcom-aoss.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index c0b292be1b72..756ad2b27d0f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -82,6 +82,15 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
> +config RESET_QCOM_AOSS
> +	bool "Qcom AOSS Reset Driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables the AOSS (always on subsystem) reset driver
> +	  for Qualcomm SDM845 SoCs. Say Y if you want to control
> +	  reset signals provided by AOSS for Modem, Venus, ADSP,
> +	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
> +
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
>  	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index c1261dcfe9ad..6881e4d287f0 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
> +obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
> new file mode 100644
> index 000000000000..3b0bbb387f7b
> --- /dev/null
> +++ b/drivers/reset/reset-qcom-aoss.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +
> +struct qcom_aoss_reset_map {
> +	unsigned int reg;
> +};
> +
> +struct qcom_aoss_desc {
> +	const struct qcom_aoss_reset_map *resets;
> +	size_t num_resets;
> +};
> +
> +struct qcom_aoss_reset_data {
> +	struct reset_controller_dev rcdev;
> +	void __iomem *base;
> +	const struct qcom_aoss_desc *desc;
> +};
> +
> +static const struct qcom_aoss_reset_map sdm845_aoss_resets[] = {
> +	[AOSS_CC_MSS_RESTART] = {0x0},
> +	[AOSS_CC_CAMSS_RESTART] = {0x1000},
> +	[AOSS_CC_VENUS_RESTART] = {0x2000},
> +	[AOSS_CC_GPU_RESTART] = {0x3000},
> +	[AOSS_CC_DISPSS_RESTART] = {0x4000},
> +	[AOSS_CC_WCSS_RESTART] = {0x10000},
> +	[AOSS_CC_LPASS_RESTART] = {0x20000},
> +};
> +
> +static const struct qcom_aoss_desc sdm845_aoss_desc = {
> +	.resets = sdm845_aoss_resets,
> +	.num_resets = ARRAY_SIZE(sdm845_aoss_resets),
> +};
> +
> +static inline struct qcom_aoss_reset_data *to_qcom_aoss_reset_data(
> +				struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct qcom_aoss_reset_data, rcdev);
> +}
> +
> +static int qcom_aoss_control_assert(struct reset_controller_dev *rcdev,
> +				    unsigned long idx)
> +{
> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
> +	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
> +
> +	writel(1, data->base + map->reg);
> +	/* Wait 6 32kHz sleep cycles for reset */
> +	usleep_range(200, 210);
> +	return 0;
> +}
> +
> +static int qcom_aoss_control_deassert(struct reset_controller_dev *rcdev,
> +				      unsigned long idx)
> +{
> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
> +	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
> +
> +	writel(0, data->base + map->reg);
> +	/* Wait 6 32kHz sleep cycles for reset */
> +	usleep_range(200, 210);

6 32 kHz cycles are about 188 µs (184 µs for 32.768 kHz).
Just out of curiosity, is the minimum increased to 200 µs on purpose, or
to have a nice round number? The maximum seems oddly small, unless it is
essential to wait less than 7 cycles.

The driver looks good to me now. I plan to apply patches 1 and 2 with
Rob's ack.
Is it ok to merge them independently from the remoteproc driver, or is
there a dependency?

regards
Philipp
