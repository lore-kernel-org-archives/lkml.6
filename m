Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeFEGTa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeFEGT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:19:28 -0400
Date: Tue, 5 Jun 2018 11:49:19 +0530
From: Vinod <vkoul@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180605061919.GQ16230@vkoul-mobl>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 11:12, Sricharan R wrote:

> +config QCOM_Q6V5_WCSS
> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
> +	depends on OF && ARCH_QCOM
> +	depends on QCOM_SMEM
> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n

Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM

> +/* QDSP6SS Register Offsets */
> +#define QDSP6SS_RESET_REG		0x014
> +#define QDSP6SS_GFMUX_CTL_REG		0x020
> +#define QDSP6SS_PWR_CTL_REG		0x030
> +#define QDSP6SS_MEM_PWR_CTL		0x0B0
> +
> +/* AXI Halt Register Offsets */
> +#define AXI_HALTREQ_REG			0x0
> +#define AXI_HALTACK_REG			0x4
> +#define AXI_IDLE_REG			0x8
> +
> +#define HALT_ACK_TIMEOUT_MS		100
> +
> +/* QDSP6SS_RESET */
> +#define Q6SS_STOP_CORE			BIT(0)
> +#define Q6SS_CORE_ARES			BIT(1)
> +#define Q6SS_BUS_ARES_ENABLE		BIT(2)

Wouldn't it be nice if the defines are all consistent, some of them are
QDSP6SS_xxx, some Q6SS_ some are not

Please do pick one and make it consistent :)

> +/* QDSP6v56 parameters */
> +#define QDSP6v56_LDO_BYP		BIT(25)
> +#define QDSP6v56_BHS_ON		BIT(24)
> +#define QDSP6v56_CLAMP_WL		BIT(21)
> +#define QDSP6v56_CLAMP_QMC_MEM		BIT(22)
> +#define HALT_CHECK_MAX_LOOPS		200
> +#define QDSP6SS_XO_CBCR		0x0038

GENMASK() perhaps?

> +static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
> +{
> +	int ret;
> +	u32 val;
> +	int i;

        int ret, i;

> +static int q6v5_wcss_start(struct rproc *rproc)
> +{
> +	struct q6v5_wcss *wcss = rproc->priv;
> +	int ret;
> +
> +	qcom_q6v5_prepare(&wcss->q6v5);
> +
> +	/* Release Q6 and WCSS reset */
> +	ret = reset_control_deassert(wcss->wcss_reset);
> +	if (ret) {
> +		dev_err(wcss->dev, "wcss_reset failed\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(wcss->wcss_q6_reset);
> +	if (ret) {
> +		dev_err(wcss->dev, "wcss_q6_reset failed\n");
> +		goto wcss_reset;
> +	}
> +
> +	/* Lithium configuration - clock gating and bus arbitration */
> +	ret = regmap_update_bits(wcss->halt_map,
> +				 wcss->halt_nc + TCSR_GLOBAL_CFG0,
> +				 0x1F, 0x14);

magic numbers??

> +static int q6v5_wcss_powerdown(struct q6v5_wcss *wcss)
> +{
> +	int ret;
> +	u32 val;
> +
> +	/* 1 - Assert WCSS/Q6 HALTREQ */
> +	q6v5_wcss_halt_axi_port(wcss, wcss->halt_map, wcss->halt_wcss);
> +
> +	/* 2 - Enable WCSSAON_CONFIG */
> +	val = readl(wcss->rmb_base + SSCAON_CONFIG);
> +	val |= SSCAON_ENABLE;
> +	writel(val, wcss->rmb_base + SSCAON_CONFIG);
> +
> +	/* 3 - Set SSCAON_CONFIG */
> +	val |= BIT(15);
> +	val &= ~BIT(16);
> +	val &= ~BIT(17);
> +	val &= ~BIT(18);

wouldn't it be nice to define these bits?

> +static int q6v5_q6_powerdown(struct q6v5_wcss *wcss)
> +{
> +	int ret;
> +	u32 val;
> +	int i;

        int ret, i;
-- 
~Vinod
