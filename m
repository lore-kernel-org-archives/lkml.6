Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEVIuc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:50:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:50:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52ADB60131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V6 3/5] remoteproc: qcom: Split the head and tail of the
 q5v5-pil rproc reset function
To: Vinod <vkoul@kernel.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
 <1526294812-23390-4-git-send-email-sricharan@codeaurora.org>
 <20180518122233.GB31996@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <97221658-49a9-a61f-75ea-41559222bb38@codeaurora.org>
Date: Tue, 22 May 2018 14:20:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518122233.GB31996@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thanks for the review.

On 5/18/2018 5:52 PM, Vinod wrote:
> On 14-05-18, 16:16, Sricharan R wrote:
> 
>> +static int q6v5_reset(struct q6v5 *qproc)
>> +{
>> +	u32 ret;
>> +	int val, i;
>> +
>> +	/* Assert resets, stop core */
>> +	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
>> +	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
>> +	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
>> +
>> +	/* BHS require xo cbcr to be enabled */
>> +	val = readl(qproc->reg_base + QDSP6SS_XO_CBCR);
>> +	val |= 0x1;
>> +	writel(val, qproc->reg_base + QDSP6SS_XO_CBCR);
> 
> consider adding a updatel macro which does read, update and write for you...
> 

 ok.

>> +
>> +	/* Read CLKOFF bit to go low indicating CLK is enabled */
>> +	ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_XO_CBCR,
>> +				 val, !(val & BIT(31)), 1,
>> +				 HALT_CHECK_MAX_LOOPS);
>> +	if (ret) {
>> +		dev_err(qproc->dev,
>> +			"xo cbcr enabling timed out (rc:%d)\n", ret);
>> +		return ret;
>> +	}
>> +	/* Enable power block headswitch and wait for it to stabilize */
>> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	val |= QDSP6v56_BHS_ON;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> 
> why is this read required
> 

 It was a ditto of what was given in the programming sequence from HW folks.
 yeah, logically the readl does not look needed. Will remove and update.

>> +	udelay(1);
>> +
>> +	/* Put LDO in bypass mode */
>> +	val |= QDSP6v56_LDO_BYP;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* Deassert QDSP6 compiler memory clamp */
>> +	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +	val &= ~QDSP6v56_CLAMP_QMC_MEM;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* Deassert memory peripheral sleep and L2 memory standby */
>> +	val |= Q6SS_L2DATA_STBY_N | Q6SS_SLP_RET_N;
>> +	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>> +
>> +	/* Turn on L1, L2, ETB and JU memories 1 at a time */
>> +	val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
>> +	for (i = 19; i >= 0; i--) {
> 
> where is the magic number 19 coming from?
> 

 Its the total number of Q6's memory head/foot switch banks. Infact
 the magic was there even before my patch. But will add a Macro to fix it.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
