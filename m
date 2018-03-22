Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeCVWdC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:33:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCVWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:33:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9833A60C54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 2/7] reset: qcom: AOSS (always on subsystem) reset
 controller
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-3-git-send-email-sibis@codeaurora.org>
 <20180318224511.GD5626@tuxbook-pro>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <386f26c8-2d7f-2066-758f-7bf1498cdaa6@codeaurora.org>
Date: Fri, 23 Mar 2018 04:02:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180318224511.GD5626@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review.

On 03/19/2018 04:15 AM, Bjorn Andersson wrote:
> On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 7fc7769..d06bd1d 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -81,6 +81,16 @@ config RESET_PISTACHIO
>>   	help
>>   	  This enables the reset driver for ImgTec Pistachio SoCs.
>>   
>> +config RESET_QCOM_AOSS
>> +	bool "Qcom AOSS Reset Driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	select MFD_SYSCON
> 
> Drop syscon
> 

will drop it

>> +	help
>> +	  This enables the AOSS (always on subsystem) reset driver
>> +	  for Qualcomm SDM845 SoCs. Say Y if you want to control
>> +	  reset signals provided by AOSS for Modem, Venus, ADSP,
>> +	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
>> +
> [..]
>> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
> [..]
>> +static const struct regmap_config sdm845_aoss_regmap_config = {
>> +	.name		= "aoss-reset",
>> +	.reg_bits	= 32,
>> +	.reg_stride	= 4,
>> +	.val_bits	= 32,
>> +	.max_register	= 0x20000,
>> +	.fast_io	= true,
>> +};
> 
> Is there a particular reason why you're setting up a regmap and not just
> operate on the ioremap region directly with readl/writel? It would save
> you a few lines of code and some runtime memory.
> 

The idea here is to reuse the driver in modified configuration as
pdc_sync restart controller which is to be used for adsp_pil. PDC sync
reset register is a single register with multiple reset lines hence
would warrant setting up a regmap. I can remove these changes and add
them when I add pdc_sync reset controller though.

>> +
>> +static const struct qcom_aoss_reset_map sdm845_aoss_resets[] = {
>> +	[AOSS_CC_MSS_RESTART] = { 0x0, 0 },
>> +	[AOSS_CC_CAMSS_RESTART] = { 0x1000, 0 },
>> +	[AOSS_CC_VENUS_RESTART] = { 0x2000, 0 },
>> +	[AOSS_CC_GPU_RESTART] = { 0x3000, 0 },
>> +	[AOSS_CC_DISPSS_RESTART] = { 0x4000, 0 },
>> +	[AOSS_CC_WCSS_RESTART] = { 0x10000, 0 },
>> +	[AOSS_CC_LPASS_RESTART] = { 0x20000, 0 },
> 
> Do you have a case where bit != 0? If not please drop the bit until it's
> necessary.
> 

had the bit variable for the above state reason.

>> +};
>> +
>> +static const struct qcom_aoss_desc sdm845_aoss_desc = {
>> +	.config = &sdm845_aoss_regmap_config,
>> +	.resets = sdm845_aoss_resets,
>> +	/* Wait 6 32kHz sleep cycles for reset */
>> +	.delay = 200,
> 
> Please move this constant into qcom_aoss_control_reset(), until there's
> a need for it to be configurable.
> 
>> +	.num_resets = ARRAY_SIZE(sdm845_aoss_resets),
>> +};
>> +
> [..]
>> +static int qcom_aoss_control_reset(struct reset_controller_dev *rcdev,
>> +					unsigned long idx)
>> +{
>> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
>> +	int ret;
>> +
>> +	ret = qcom_aoss_control_assert(rcdev, idx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	udelay(data->desc->delay);
> 
> Per Documentation/timers/timers-howto.txt please use usleep_range() when
> delays are between 10us and 20ms.
> 

will replace them

>> +
>> +	return qcom_aoss_control_deassert(rcdev, idx);
>> +}
> 
> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
