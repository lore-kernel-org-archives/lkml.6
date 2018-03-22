Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeCVWK0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:10:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCVWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:10:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45C026055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 7/7] remoteproc: qcom: Always assert and deassert reset
 signals in SDM845
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-8-git-send-email-sibis@codeaurora.org>
 <20180318224631.GH5626@tuxbook-pro>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <ddc8713a-ea65-f38f-3a4e-07a7908e8be6@codeaurora.org>
Date: Fri, 23 Mar 2018 03:40:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180318224631.GH5626@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review

On 03/19/2018 04:16 AM, Bjorn Andersson wrote:
> On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> [..]
>> +struct q6v5_reset_ops {
>> +	int (*reset_start)(struct q6v5 *qproc);
>> +	int (*reset_stop)(struct q6v5 *qproc);
>> +};
> 
> Please add these two ops directly in q6v5 instead and please keep the
> naming "reset_assert" and "reset_deassert".
> 

sure will do

>> +
>>   enum {
>>   	MSS_MSM8916,
>>   	MSS_MSM8974,
>> @@ -343,6 +354,52 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
>>   	return 0;
>>   }
>>   
>> +static void alt_reset_restart(struct q6v5 *qproc, u32 restart)
>> +{
>> +	writel(restart, qproc->rmb_base + RMB_MBA_ALT_RESET);
> 
> Just move this write into q6v5_sdm_reset_start()
> 

sure will do

>> +}
>> +
>> +static int q6v5_msm_reset_stop(struct q6v5 *qproc)
>> +{
>> +	return reset_control_assert(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_msm_reset_start(struct q6v5 *qproc)
>> +{
>> +	return reset_control_deassert(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_sdm_reset_stop(struct q6v5 *qproc)
>> +{
>> +	return reset_control_reset(qproc->mss_restart);
>> +}
>> +
>> +static int q6v5_sdm_reset_start(struct q6v5 *qproc)
>> +{
>> +	int ret;
>> +
>> +	alt_reset_restart(qproc, 1);
>> +	/* Ensure alt reset is written before restart reg */
> 
> That's not what udelay does ;)
> 
> If you want to make sure that the register is written and then give it
> 100us delay until you reset the reset you have to readl() the same
> register back after the writel()
> 
> I think the delay deserves a comment on what we're waiting for.
>

the delay can be removed for the reasons stated below

>> +	udelay(100);
> 
> Use usleep_range() for delays longer than 10us.
>
>> +
>> +	ret = reset_control_reset(qproc->mss_restart);
>> +
>> +	udelay(100);
> 
> Same as the delay above, what are we waiting for?
>

The point is to wait for 6 32khz sleep cycles both after assert and
after de-assert of the aoss mss reset line. So moving the udelay to
the aoss reset controller should have been right thing to do. alt_reset
shouldn't need delays in between will remove them.

>> +	alt_reset_restart(qproc, 0);
>> +
>> +	return ret;
>> +}
>> +
> [..]
>> @@ -1179,6 +1251,12 @@ static int q6v5_probe(struct platform_device *pdev)
>>   	qproc->dev = &pdev->dev;
>>   	qproc->rproc = rproc;
>>   	platform_set_drvdata(pdev, qproc);
>> +	qproc->version = desc->version;
>> +
>> +	if (qproc->version == MSS_SDM845)
>> +		qproc->ops = &q6v5_sdm_ops;
>> +	else
>> +		qproc->ops = &q6v5_msm_ops;
> 
> Can we carry a boolean for "has_alt_reset" or something that picks the
> new reset ops, rather than picking by version?
>

Though alt_reset is specific to SDM845 SoCs it also includes another
reset controller (pdc_sync) in the modem bringup sequence, it isn't
included it in the patch series since it doesn't seem to affect the
modem start/stop functionality. Knowing that it may be added wouldn't
version be a better choice here?

> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
