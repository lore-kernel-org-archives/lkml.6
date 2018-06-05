Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeFEM4z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:56:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeFEM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:56:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AFAC6037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Vinod <vkoul@kernel.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
Date: Tue, 5 Jun 2018 18:26:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605061919.GQ16230@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 6/5/2018 11:49 AM, Vinod wrote:
> On 05-06-18, 11:12, Sricharan R wrote:
> 
>> +config QCOM_Q6V5_WCSS
>> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>> +	depends on OF && ARCH_QCOM
>> +	depends on QCOM_SMEM
>> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> 
> Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
> happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
> 
  RPMSG_QCOM_GLINK_SMEM=n should be for the COMPILE_TEST. Probably that
  means that it should be corrected here and for ADSP, Q6V5_PIL as well.
  Bjorn, is that correct ?, should it be, below ?
 
  depends on (RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)) || (RPMSG_QCOM_GLINK_SMEM || (COMPILE_TEST && RPMSG_QCOM_GLINK_SMEM=n))

>> +/* QDSP6SS Register Offsets */
>> +#define QDSP6SS_RESET_REG		0x014
>> +#define QDSP6SS_GFMUX_CTL_REG		0x020
>> +#define QDSP6SS_PWR_CTL_REG		0x030
>> +#define QDSP6SS_MEM_PWR_CTL		0x0B0
>> +
>> +/* AXI Halt Register Offsets */
>> +#define AXI_HALTREQ_REG			0x0
>> +#define AXI_HALTACK_REG			0x4
>> +#define AXI_IDLE_REG			0x8
>> +
>> +#define HALT_ACK_TIMEOUT_MS		100
>> +
>> +/* QDSP6SS_RESET */
>> +#define Q6SS_STOP_CORE			BIT(0)
>> +#define Q6SS_CORE_ARES			BIT(1)
>> +#define Q6SS_BUS_ARES_ENABLE		BIT(2)
> 
> Wouldn't it be nice if the defines are all consistent, some of them are
> QDSP6SS_xxx, some Q6SS_ some are not
> 
> Please do pick one and make it consistent :)
> 

 ok.

>> +/* QDSP6v56 parameters */
>> +#define QDSP6v56_LDO_BYP		BIT(25)
>> +#define QDSP6v56_BHS_ON		BIT(24)
>> +#define QDSP6v56_CLAMP_WL		BIT(21)
>> +#define QDSP6v56_CLAMP_QMC_MEM		BIT(22)
>> +#define HALT_CHECK_MAX_LOOPS		200
>> +#define QDSP6SS_XO_CBCR		0x0038
> 
> GENMASK() perhaps?
> 

 ok.

>> +static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
>> +{
>> +	int ret;
>> +	u32 val;
>> +	int i;
> 
>         int ret, i;
> 
>> +static int q6v5_wcss_start(struct rproc *rproc)
>> +{
>> +	struct q6v5_wcss *wcss = rproc->priv;
>> +	int ret;
>> +
>> +	qcom_q6v5_prepare(&wcss->q6v5);
>> +
>> +	/* Release Q6 and WCSS reset */
>> +	ret = reset_control_deassert(wcss->wcss_reset);
>> +	if (ret) {
>> +		dev_err(wcss->dev, "wcss_reset failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = reset_control_deassert(wcss->wcss_q6_reset);
>> +	if (ret) {
>> +		dev_err(wcss->dev, "wcss_q6_reset failed\n");
>> +		goto wcss_reset;
>> +	}
>> +
>> +	/* Lithium configuration - clock gating and bus arbitration */
>> +	ret = regmap_update_bits(wcss->halt_map,
>> +				 wcss->halt_nc + TCSR_GLOBAL_CFG0,
>> +				 0x1F, 0x14);
> 
> magic numbers??
> 

 ok, will find out what it is for this one and below.
 But atleast from register map could not find out and
 these are sort of hardcoded sequences coming from the hw
 folks. So will have to reach out to them to find the specifics.

>> +static int q6v5_wcss_powerdown(struct q6v5_wcss *wcss)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	/* 1 - Assert WCSS/Q6 HALTREQ */
>> +	q6v5_wcss_halt_axi_port(wcss, wcss->halt_map, wcss->halt_wcss);
>> +
>> +	/* 2 - Enable WCSSAON_CONFIG */
>> +	val = readl(wcss->rmb_base + SSCAON_CONFIG);
>> +	val |= SSCAON_ENABLE;
>> +	writel(val, wcss->rmb_base + SSCAON_CONFIG);
>> +
>> +	/* 3 - Set SSCAON_CONFIG */
>> +	val |= BIT(15);
>> +	val &= ~BIT(16);
>> +	val &= ~BIT(17);
>> +	val &= ~BIT(18);
> 
> wouldn't it be nice to define these bits?
> 
>> +static int q6v5_q6_powerdown(struct q6v5_wcss *wcss)
>> +{
>> +	int ret;
>> +	u32 val;
>> +	int i;
> 
>         int ret, i;
> 

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
