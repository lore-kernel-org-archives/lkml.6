Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeERMWo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeERMWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:22:39 -0400
Date: Fri, 18 May 2018 17:52:33 +0530
From: Vinod <vkoul@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Subject: Re: [PATCH V6 3/5] remoteproc: qcom: Split the head and tail of the
 q5v5-pil rproc reset function
Message-ID: <20180518122233.GB31996@vkoul-mobl>
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
 <1526294812-23390-4-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526294812-23390-4-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-18, 16:16, Sricharan R wrote:

> +static int q6v5_reset(struct q6v5 *qproc)
> +{
> +	u32 ret;
> +	int val, i;
> +
> +	/* Assert resets, stop core */
> +	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
> +	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
> +	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
> +
> +	/* BHS require xo cbcr to be enabled */
> +	val = readl(qproc->reg_base + QDSP6SS_XO_CBCR);
> +	val |= 0x1;
> +	writel(val, qproc->reg_base + QDSP6SS_XO_CBCR);

consider adding a updatel macro which does read, update and write for you...

> +
> +	/* Read CLKOFF bit to go low indicating CLK is enabled */
> +	ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_XO_CBCR,
> +				 val, !(val & BIT(31)), 1,
> +				 HALT_CHECK_MAX_LOOPS);
> +	if (ret) {
> +		dev_err(qproc->dev,
> +			"xo cbcr enabling timed out (rc:%d)\n", ret);
> +		return ret;
> +	}
> +	/* Enable power block headswitch and wait for it to stabilize */
> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +	val |= QDSP6v56_BHS_ON;
> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +	val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);

why is this read required

> +	udelay(1);
> +
> +	/* Put LDO in bypass mode */
> +	val |= QDSP6v56_LDO_BYP;
> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +
> +	/* Deassert QDSP6 compiler memory clamp */
> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +	val &= ~QDSP6v56_CLAMP_QMC_MEM;
> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +
> +	/* Deassert memory peripheral sleep and L2 memory standby */
> +	val |= Q6SS_L2DATA_STBY_N | Q6SS_SLP_RET_N;
> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> +
> +	/* Turn on L1, L2, ETB and JU memories 1 at a time */
> +	val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
> +	for (i = 19; i >= 0; i--) {

where is the magic number 19 coming from?
-- 
~Vinod
