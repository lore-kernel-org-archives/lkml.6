Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966249AbeE2TDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:03:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965819AbeE2TD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:03:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5DDD60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
To: Rajendra Nayak <rnayak@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
 <6f8e5fe2-199d-ba1f-19d7-2faf276075f3@codeaurora.org>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <06684883-43d8-be4b-b6ec-7f128c680d50@codeaurora.org>
Date: Tue, 29 May 2018 12:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <6f8e5fe2-199d-ba1f-19d7-2faf276075f3@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajendra,

On 05/29/2018 03:19 AM, Rajendra Nayak wrote:
> On 05/26/2018 06:38 AM, David Collins wrote:
>> On 05/25/2018 03:01 AM, Rajendra Nayak wrote:
>>> The RPMh powerdomain driver aggregates the corner votes from various
...
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index a7a405178967..1faed239701d 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
>>>  
>>>  	  Say y here if you intend to boot the modem remoteproc.
>>>  
>>> +config QCOM_RPMHPD
>>> +	tristate "Qualcomm RPMh Powerdomain driver"
>>
>> s/Qualcomm/Qualcomm Technologies, Inc./
> 
> All other config options in qcom/Kconfig use 'Qualcomm XYZ feature'
> for the comment. Maybe I will leave it that way for consistency?

I don't have a strong opinion about it.  I just want the legal folks to be
happy.  I'm fine with whatever achieves that goal.


>>> +
>>> +struct rpmhpd_desc {
>>> +	struct rpmhpd **rpmhpds;
>>> +	size_t num_pds;
>>> +};
>>
>> This struct could be removed and the per-platform arrays could instead be
>> NULL terminated.
> 
> Yes, but I would prefer it this way unless you have strong objections.
> Just makes it easier to do the allocations at probe for genpd_onecell_data structures.

I'm fine if you keep it as-is.  I mentioned the alternative because
Stephen had requested the same modification on my qcom-rpmh-regulator
driver patch [1].  Other reviewers may care about this point.


>> Is there an API to determine the currently operating performance state of
>> a given power domain?  Is this information accessible from userspace?  We
>> will definitely need this for general debugging.
> 
> A quick look shows me its not. I agree its a necessary feature for debug.
> I will add a patch to expose it via debugfs

Thanks


>>> +static int rpmhpd_probe(struct platform_device *pdev)
>>> +{
>>> +	int i, ret;
>>> +	size_t num;
>>> +	struct genpd_onecell_data *data;
>>> +	struct rpmhpd **rpmhpds;
>>> +	const struct rpmhpd_desc *desc;
>>> +
>>> +	desc = of_device_get_match_data(&pdev->dev);
>>> +	if (!desc)
>>> +		return -EINVAL;
>>> +
>>> +	rpmhpds = desc->rpmhpds;
>>> +	num = desc->num_pds;
>>> +
>>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
>>> +				     GFP_KERNEL);
>>> +	data->num_domains = num;
>>> +
>>> +	ret = cmd_db_ready();
>>> +	if (ret) {
>>> +		if (ret != -EPROBE_DEFER)
>>> +			dev_err(&pdev->dev, "Command DB unavailable, ret=%d\n",
>>> +				ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	for (i = 0; i < num; i++) {
>>> +		if (!rpmhpds[i])
>>> +			continue;
>>
>> Why is this check needed?
> 
> Just to check/ignore if there are any holes.
> maybe I should atleast throw a warning instead of silently ignoring it?

A warning message might be a good idea if this condition should ever be
reached but also doesn't necessarily imply that probing must be ceased.
It looks like of_genpd_add_provider_onecell() ignores the NULL initialized
data->domains[i] values so it should be safe to leave the holes in and not
decrement num_domains accordingly.

Take care,
David

[1]: https://lkml.org/lkml/2018/3/21/681

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
