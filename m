Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeEUQ57 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:57:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeEUQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:57:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEC7D60262
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v4 5/5] remoteproc: qcom: Always assert and deassert reset
 signals in SDM845
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180425150843.26657-1-sibis@codeaurora.org>
 <20180425150843.26657-6-sibis@codeaurora.org>
 <20180518214708.GU14924@minitux>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <e4422d6e-c151-0823-606f-e43a9ae62f80@codeaurora.org>
Date: Mon, 21 May 2018 22:27:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180518214708.GU14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review. Will make all the required changes in v5.

On 05/19/2018 03:17 AM, Bjorn Andersson wrote:
> On Wed 25 Apr 08:08 PDT 2018, Sibi Sankar wrote:
> 
>> SDM845 brings a new reset signal ALT_RESET which is a part of the MSS
>> subsystem hence requires some of the active clks to be enabled before
>> assert/deassert
>>
>> Reset the modem if the BOOT FSM does timeout
>>
>> Reset assert/deassert sequence vary across SoCs adding reset, adding
>> start/stop helper functions to handle SoC specific reset sequences
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/remoteproc/qcom_q6v5_pil.c | 81 ++++++++++++++++++++++++++++--
>>   1 file changed, 76 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> [..]
>> @@ -349,6 +356,32 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
>>   	return 0;
>>   }
>>   
>> +static int q6v5_reset_assert(struct q6v5 *qproc)
>> +{
>> +	return reset_control_assert(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_reset_deassert(struct q6v5 *qproc)
>> +{
>> +	return reset_control_deassert(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_alt_reset_assert(struct q6v5 *qproc)
>> +{
>> +	return reset_control_reset(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_alt_reset_deassert(struct q6v5 *qproc)
>> +{
>> +	/* Ensure alt reset is written before restart reg */
>> +	writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
>> +
>> +	reset_control_reset(qproc->mss_restart);
>> +
>> +	writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
>> +	return 0;
>> +}
>> +
> 
> Rather than having these four functions and scattering jumps to some
> function pointer in the code I think it will be shorter and cleaner to
> just have the q6v5_reset_{asert,deassert}() functions and in there check
> if has_alt_reset and take appropriate action.
> 

yes this seems simpler

>>   static int q6v5_rmb_pbl_wait(struct q6v5 *qproc, int ms)
>>   {
>>   	unsigned long timeout;
>> @@ -424,6 +457,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>>   				val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
>>   		if (ret) {
>>   			dev_err(qproc->dev, "Boot FSM failed to complete.\n");
>> +			/* Reset the modem so that boot FSM is in reset state */
>> +			qproc->reset_deassert(qproc);
> 
> 
> A thing like this typically should go into it's own patch, to keep a
> clear record of why it was changed, but as this is simply amending the
> previous patch it indicates that that one wasn't complete.
> 
> So if you reorder the two patches you can just put this directly into
> the sdm845 patch, making it "complete".
> 
> (This also means that I want to merge the handover vs ready interrupt
> patch before that one, so please include it in the next revision of the
> series).
> 

Will re-order them.


>>   			return ret;
>>   		}
>>   
>> @@ -792,12 +827,20 @@ static int q6v5_start(struct rproc *rproc)
>>   		dev_err(qproc->dev, "failed to enable supplies\n");
>>   		goto disable_proxy_clk;
>>   	}
>> -	ret = reset_control_deassert(qproc->mss_restart);
>> +
>> +	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
>> +			      qproc->reset_clk_count);
> 
> Remind me, why can't you always enable the active clock before
> deasserting reset? That way we wouldn't have to split out the iface
> clock handling to be just slightly longer than the active clocks.
> 

Have to introduce reset clks for backward compatibility, both msm8916
and msm8996 require the mss_reset to be deasserted before enabling
the active clks.

>>   	if (ret) {
>> -		dev_err(qproc->dev, "failed to deassert mss restart\n");
>> +		dev_err(qproc->dev, "failed to enable reset clocks\n");
>>   		goto disable_vdd;
>>   	}
>>   
>> +	ret = qproc->reset_deassert(qproc);
>> +	if (ret) {
>> +		dev_err(qproc->dev, "failed to deassert mss restart\n");
>> +		goto disable_reset_clks;
>> +	}
>> +
> [..]
>> @@ -1335,8 +1399,11 @@ static const struct rproc_hexagon_res sdm845_mss = {
>>   			"prng",
>>   			NULL
>>   	},
>> -	.active_clk_names = (char*[]){
>> +	.reset_clk_names = (char*[]){
>>   			"iface",
>> +			NULL
>> +	},
>> +	.active_clk_names = (char*[]){
> 
> Again, if you reorder your patches to first add the support for
> alt_reset and then introduce sdm845 you don't need to modify the
> previous patch directly to make it work.
> 

yeah I'll re-order them

>>   			"bus",
>>   			"mem",
>>   			"gpll0_mss",
> 
> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
