Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEVJDF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:03:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:03:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1577C604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V6 5/5] remoteproc: qcom: Add q6v5-wcss rproc ops
To: Vinod <vkoul@kernel.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
 <1526294812-23390-6-git-send-email-sricharan@codeaurora.org>
 <20180518122946.GC31996@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4d21e075-68c5-b2a7-c7fd-ce5b6a195166@codeaurora.org>
Date: Tue, 22 May 2018 14:32:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518122946.GC31996@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/18/2018 5:59 PM, Vinod wrote:
> On 14-05-18, 16:16, Sricharan R wrote:
> 
>> +static int q6v5_wcss_start(struct rproc *rproc)
>> +{
>> +	struct q6v5 *qproc = rproc->priv;
>> +	int ret = 0;
> 
> Superfluous initialization
> 

 ok.

>> +
>> +	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
>> +			      qproc->active_clk_count);
>> +	if (ret) {
>> +		dev_err(qproc->dev, "failed to enable clocks\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Release Q6 and WCSS reset */
>> +	ret = reset_control_deassert(qproc->wcss_reset);
>> +	if (ret)
>> +		dev_err(qproc->dev, "wcss_reset failed\n");
>> +
>> +	ret = reset_control_deassert(qproc->wcss_q6_reset);
>> +	if (ret)
>> +		dev_err(qproc->dev, "wcss_q6_reset failed\n");
> 
> shouldn't we abort on these two errors?
> 

 ha right. will fix it.

>> +
>> +	/* Lithium configuration - clock gating and bus arbitration */
>> +	ret = regmap_update_bits(qproc->halt_map,
>> +				 qproc->halt_nc + TCSR_GLOBAL_CFG0,
>> +				 0x1F, 0x14);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(qproc->halt_map,
>> +				 qproc->halt_nc + TCSR_GLOBAL_CFG1,
>> +				 1, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Write bootaddr to EVB so that Q6WCSS will jump there after reset */
>> +	writel(rproc->bootaddr >> 4, qproc->reg_base + QDSP6SS_RST_EVB);
>> +
>> +	ret = q6v5_reset(qproc);
>> +	if (ret)
>> +		return ret;
> 
> all these returns, aren't we leaving device in some dangling state?
> 

 hmm ok. clocks and resets have to be reverted. will add error handling here.

>> +static int q6v5_wcss_powerdown(struct q6v5 *qproc)
>> +{
>> +	unsigned int val = 0;
> 
> superfluous initialization
> 
 ok.

>> +	int ret;
>> +
>> +	/* 1 - Assert WCSS/Q6 HALTREQ */
>> +	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
>> +
>> +	/* 2 - Enable WCSSAON_CONFIG */
>> +	val = readl(qproc->rmb_base + SSCAON_CONFIG);
>> +	val |= SSCAON_ENABLE;
>> +	writel(val, qproc->rmb_base + SSCAON_CONFIG);
>> +
>> +	/* 3 - Set SSCAON_CONFIG */
>> +	val |= BIT(15);
>> +	val &= ~BIT(16);
>> +	val &= ~BIT(17);
>> +	val &= ~BIT(18);
> 
> shouldn't bit 15 thru 18 be defined on what they mean?
> 

 hmm, ok. would define them.

>> +static int q6v5_q6_powerdown(struct q6v5 *qproc)
>> +{
>> +	int i = 0, ret;
>> +	unsigned int val = 0;
>> +
>> +	/* 1 - Halt Q6 bus interface */
>> +	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
>> +
>> +	/* 2 - Disable Q6 Core clock */
>> +	val = readl(qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
>> +	val &= ~Q6SS_CLK_ENABLE;
>> +	writel(val, qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
>> +
>> +	/* 3 - Clamp I/O */
>> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	val |= Q6SS_CLAMP_IO;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* 4 - Clamp WL */
>> +	val |= QDSS_BHS_ON;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* 5 - Clear Erase standby */
>> +	val &= ~Q6SS_L2DATA_STBY_N;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* 6 - Clear Sleep RTN */
>> +	val &= ~Q6SS_SLP_RET_N;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* 7 - turn off QDSP6 memory foot/head switch one bank at a time */
>> +	for (i = 0; i < 20; i++) {
>> +		val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
>> +		val &= ~BIT(i);
>> +		writel(val, qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
>> +		mdelay(1);
>> +	}
>> +	/* 8 - Assert QMC memory RTN */
>> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	val |= QDSP6v56_CLAMP_QMC_MEM;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* 9 - Turn off BHS */
>> +	val &= ~QDSP6v56_BHS_ON;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	udelay(1);
>> +	/* 10 - Wait till BHS Reset is done */
> 
> would help in readability if you can be consistent and add empty lines after each
> step as done for rest of the routine
> 
 ok.

>> +static int q6v5_wcss_stop(struct rproc *rproc)
>> +{
>> +	struct q6v5 *qproc = rproc->priv;
>> +	int ret = 0;
> 
> this one too, I think if you run with sparse, it should warn you about these
> 

 ok, sure would check.

>> +
>> +	qproc->running = false;
>> +
>> +	/* WCSS powerdown */
>> +	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit),
>> +				    BIT(qproc->stop_bit));
>> +
>> +	ret = wait_for_completion_timeout(&qproc->stop_done,
>> +					  msecs_to_jiffies(5000));
>> +	if (ret == 0) {
>> +		dev_err(qproc->dev, "timed out on wait\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit), 0);
>> +
>> +	ret = q6v5_wcss_powerdown(qproc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Q6 Power down */
>> +	ret = q6v5_q6_powerdown(qproc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> this could be optimized to:
>         return q6v5_q6_powerdown()
> 

 ok.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
