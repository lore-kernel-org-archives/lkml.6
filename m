Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeCPFwM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:52:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:52:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CA7560390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 4/7] soc: qcom: rpmpd: Add support for get/set performance
 state
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-5-rnayak@codeaurora.org>
 <20180316043535.GQ15832@vireshk-i7>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <36687f34-449d-643c-251f-4469322db21e@codeaurora.org>
Date: Fri, 16 Mar 2018 11:22:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180316043535.GQ15832@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/16/2018 10:05 AM, Viresh Kumar wrote:
> On 16-03-18, 09:38, Rajendra Nayak wrote:
>> With genpd now expecting powerdomain drivers supporting performance
>> state to support get/set performance state callbacks, add support for it
>> in the rpmpd driver.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/soc/qcom/rpmpd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> index c8754d867c33..4058c5b450c6 100644
>> --- a/drivers/soc/qcom/rpmpd.c
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>>  #include <linux/soc/qcom/smd-rpm.h>
>>  
>>  #include <dt-bindings/mfd/qcom-rpm.h>
>> @@ -29,6 +30,8 @@
>>  #define KEY_ENABLE		0x6e657773 /* swen */
>>  #define KEY_FLOOR_CORNER	0x636676   /* vfc */
>>  
>> +#define MAX_RPMPD_STATE		6
>> +
>>  #define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)		\
>>  	static struct rpmpd _platform##_##_active;			\
>>  	static struct rpmpd _platform##_##_name = {			\
>> @@ -222,6 +225,43 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
>>  	return ret;
>>  }
>>  
>> +static int rpmpd_set_performance(struct generic_pm_domain *domain,
>> +			     unsigned int state)
>> +{
>> +	int ret = 0;
>> +	struct rpmpd *pd = domain_to_rpmpd(domain);
>> +
>> +	mutex_lock(&rpmpd_lock);
>> +
>> +	if (state > MAX_RPMPD_STATE)
>> +		goto out;
>> +
>> +	pd->corner = state;
>> +
>> +	if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
>> +		goto out;
>> +
>> +	ret = rpmpd_aggregate_corner(pd);
>> +
>> +out:
>> +	mutex_unlock(&rpmpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
>> +					  struct dev_pm_opp *opp)
>> +{
>> +	struct device_node *np;
>> +	unsigned int corner = 0;
>> +
>> +	np = dev_pm_opp_get_of_node(opp);
>> +	of_property_read_u32(np, "qcom,level", &corner);
> 
> Don't we want to error out or do something else in case of an error ?

yes, I missed the error checks, will add.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
