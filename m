Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeFAGnG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:43:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:43:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F0216021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 4/5] remoteproc: qcom: q6v5-pil: Use common q6v5
 helpers
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-5-bjorn.andersson@linaro.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <9c520689-99f3-843b-8653-6867a2a4fa1d@codeaurora.org>
Date: Fri, 1 Jun 2018 12:12:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523052054.19025-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/23/2018 10:50 AM, Bjorn Andersson wrote:
> Migrate the MSS remoteproc driver to use the newly extracted helper
> functions.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/Kconfig         |   4 +
>  drivers/remoteproc/qcom_q6v5_pil.c | 157 +++--------------------------
>  2 files changed, 19 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index d51d155cf8bd..2316908e9788 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -116,6 +116,10 @@ config QCOM_Q6V5_PIL
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> +	select QCOM_Q6V5_COMMON

 The below three are duplicate.

> +	select QCOM_RPROC_COMMON
> +	select QCOM_SCM
> +	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM

<..>

> @@ -946,16 +934,10 @@ static int q6v5_stop(struct rproc *rproc)
>  
>  	qproc->running = false;
>  
> -	qcom_smem_state_update_bits(qproc->state,
> -				    BIT(qproc->stop_bit), BIT(qproc->stop_bit));
> -
> -	ret = wait_for_completion_timeout(&qproc->stop_done,
> -					  msecs_to_jiffies(5000));
> -	if (ret == 0)
> +	ret = qcom_q6v5_request_stop(&qproc->q6v5);
> +	if (ret == -ETIMEDOUT)
>  		dev_err(qproc->dev, "timed out on wait\n");
>  
> -	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit), 0);
> -
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
> @@ -976,9 +958,8 @@ static int q6v5_stop(struct rproc *rproc)
>  
>  	q6v5_reset_assert(qproc);
>  
> -	disable_irq(qproc->handover_irq);
> -
> -	if (!qproc->proxy_unvoted) {
> +	ret = qcom_q6v5_unprepare(&qproc->q6v5);
> +	if (ret) {
>  		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
>  				 qproc->proxy_clk_count);
>  		q6v5_regulator_disable(qproc, qproc->proxy_regs,

 Nit, can qcom_msa_handover api be used instead here ?

 Rest all looks good,
    reviewed-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
