Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEVGbX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:31:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVGbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:31:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49104601E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5 3/8] remoteproc: Move proxy unvote to handover irq
 handler
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-4-sibis@codeaurora.org> <20180522043511.GW14924@minitux>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <310ca259-d4d2-240d-f0a6-057456c1bf5e@codeaurora.org>
Date: Tue, 22 May 2018 12:01:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180522043511.GW14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review.

On 05/22/2018 10:05 AM, Bjorn Andersson wrote:
> On Mon 21 May 10:27 PDT 2018, Sibi Sankar wrote:
> 
>> Introduce interrupt handler for smp2p ready interrupt to
>> handle start completion. Move the proxy votes for clocks
>> and regulators to the handover interrupt context.
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> I added the "synchronization logic" of patch 4 to this one, to make it
> functional and after testing on db820c I merged patch 3 through 8 into
> rproc-next.
> 

making the q6v5_request_irq return the irq number seems more elegant
unlike the approach I took earlier.

> I skipped the remainder of patch 4, as I think the ready_irq should be
> included and I wonder if irq management can remove the need for the
> "running" variable.
>

will include the ready_irq as well. I think we may need to keep
"running" for coredump but will check if it can substituted with
irq management.

> I also moved the enable_irq before we actually start the core, since
> it's been shown downstream that the smp2p irq might fire fast enough for
> us to miss it (and the smp2p driver does not redeliver interrupts).
> 
> Regards,
> Bjorn
> 
>> ---
>>   drivers/remoteproc/qcom_q6v5_pil.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
>> index 76a0c00aa04a..6333bdcd9448 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -809,11 +809,6 @@ static int q6v5_start(struct rproc *rproc)
>>   			"Failed to reclaim mba buffer system may become unstable\n");
>>   	qproc->running = true;
>>   
>> -	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
>> -			 qproc->proxy_clk_count);
>> -	q6v5_regulator_disable(qproc, qproc->proxy_regs,
>> -			       qproc->proxy_reg_count);
>> -
>>   	return 0;
>>   
>>   reclaim_mpss:
>> @@ -892,6 +887,12 @@ static int q6v5_stop(struct rproc *rproc)
>>   	WARN_ON(ret);
>>   
>>   	reset_control_assert(qproc->mss_restart);
>> +
>> +	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
>> +			 qproc->proxy_clk_count);
>> +	q6v5_regulator_disable(qproc, qproc->proxy_regs,
>> +			       qproc->proxy_reg_count);
>> +
>>   	q6v5_clk_disable(qproc->dev, qproc->active_clks,
>>   			 qproc->active_clk_count);
>>   	q6v5_regulator_disable(qproc, qproc->active_regs,
>> @@ -959,7 +960,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *dev)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
>> +static irqreturn_t q6v5_ready_interrupt(int irq, void *dev)
>>   {
>>   	struct q6v5 *qproc = dev;
>>   
>> @@ -967,6 +968,18 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
>> +{
>> +	struct q6v5 *qproc = dev;
>> +
>> +	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
>> +			 qproc->proxy_clk_count);
>> +	q6v5_regulator_disable(qproc, qproc->proxy_regs,
>> +			       qproc->proxy_reg_count);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static irqreturn_t q6v5_stop_ack_interrupt(int irq, void *dev)
>>   {
>>   	struct q6v5 *qproc = dev;
>> @@ -1194,6 +1207,10 @@ static int q6v5_probe(struct platform_device *pdev)
>>   	if (ret < 0)
>>   		goto free_rproc;
>>   
>> +	ret = q6v5_request_irq(qproc, pdev, "ready", q6v5_ready_interrupt);
>> +	if (ret < 0)
>> +		goto free_rproc;
>> +
>>   	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt);
>>   	if (ret < 0)
>>   		goto free_rproc;
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
