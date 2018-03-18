Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbeCRWpR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:45:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35243 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeCRWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:45:12 -0400
X-Google-Smtp-Source: AG47ELssPAX3ChwTPa11TKYAdYOn6hA5PLE6ItXr58cW+zSN/YjvYdLu1016FPn0v/kfHT7NKixc3w==
Date: Sun, 18 Mar 2018 15:45:11 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 2/7] reset: qcom: AOSS (always on subsystem) reset
 controller
Message-ID: <20180318224511.GD5626@tuxbook-pro>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-3-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7fc7769..d06bd1d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -81,6 +81,16 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
> +config RESET_QCOM_AOSS
> +	bool "Qcom AOSS Reset Driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select MFD_SYSCON

Drop syscon

> +	help
> +	  This enables the AOSS (always on subsystem) reset driver
> +	  for Qualcomm SDM845 SoCs. Say Y if you want to control
> +	  reset signals provided by AOSS for Modem, Venus, ADSP,
> +	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
> +
[..]
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
[..]
> +static const struct regmap_config sdm845_aoss_regmap_config = {
> +	.name		= "aoss-reset",
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x20000,
> +	.fast_io	= true,
> +};

Is there a particular reason why you're setting up a regmap and not just
operate on the ioremap region directly with readl/writel? It would save
you a few lines of code and some runtime memory.

> +
> +static const struct qcom_aoss_reset_map sdm845_aoss_resets[] = {
> +	[AOSS_CC_MSS_RESTART] = { 0x0, 0 },
> +	[AOSS_CC_CAMSS_RESTART] = { 0x1000, 0 },
> +	[AOSS_CC_VENUS_RESTART] = { 0x2000, 0 },
> +	[AOSS_CC_GPU_RESTART] = { 0x3000, 0 },
> +	[AOSS_CC_DISPSS_RESTART] = { 0x4000, 0 },
> +	[AOSS_CC_WCSS_RESTART] = { 0x10000, 0 },
> +	[AOSS_CC_LPASS_RESTART] = { 0x20000, 0 },

Do you have a case where bit != 0? If not please drop the bit until it's
necessary.

> +};
> +
> +static const struct qcom_aoss_desc sdm845_aoss_desc = {
> +	.config = &sdm845_aoss_regmap_config,
> +	.resets = sdm845_aoss_resets,
> +	/* Wait 6 32kHz sleep cycles for reset */
> +	.delay = 200,

Please move this constant into qcom_aoss_control_reset(), until there's
a need for it to be configurable.

> +	.num_resets = ARRAY_SIZE(sdm845_aoss_resets),
> +};
> +
[..]
> +static int qcom_aoss_control_reset(struct reset_controller_dev *rcdev,
> +					unsigned long idx)
> +{
> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
> +	int ret;
> +
> +	ret = qcom_aoss_control_assert(rcdev, idx);
> +	if (ret)
> +		return ret;
> +
> +	udelay(data->desc->delay);

Per Documentation/timers/timers-howto.txt please use usleep_range() when
delays are between 10us and 20ms.

> +
> +	return qcom_aoss_control_deassert(rcdev, idx);
> +}

Regards,
Bjorn
