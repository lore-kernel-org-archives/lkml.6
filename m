Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBFEoQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:44:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBFEoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:44:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7312060558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v6 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-15-git-send-email-sricharan@codeaurora.org>
 <20180206042642.GG28462@vireshk-i7>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <993dcf5e-a9b4-9434-08cf-7d385589800b@codeaurora.org>
Date: Tue, 6 Feb 2018 10:13:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206042642.GG28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2/6/2018 9:56 AM, Viresh Kumar wrote:
> On 06-02-18, 09:38, Sricharan R wrote:
>> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
>> new file mode 100644
>> index 0000000..5b988d4
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/slab.h>
>> +#include "cpufreq-dt.h"
>> +#include <linux/nvmem-consumer.h>
> 
> I don't think you need all of these anymore, isn't it ? Can you cross check
> which ones are really required? For example, cpufreq-dt.h isn't required for
> sure.
> 
 oops. Had this in mind to fix the headers. But missed it. Sorry,
 will fix and repost.

>> +static int __init qcom_cpufreq_driver_init(void)
>> +{
>> +	struct device *cpu_dev;
>> +	struct device_node *np;
>> +	struct nvmem_cell *pvs_nvmem;
>> +	int ret;
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev)
>> +		return -ENODEV;
>> +
>> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	if (!of_device_is_compatible(np, "operating-points-v2-krait-cpu")) {
>> +		of_node_put(np);
>> +		return -ENODEV;
>> +	}
>> +
>> +	pvs_nvmem = of_nvmem_cell_get(np, NULL);
>> +	if (IS_ERR(pvs_nvmem)) {
>> +		dev_err(cpu_dev, "Could not get nvmem cell\n");
>> +		return PTR_ERR(pvs_nvmem);
>> +	}
>> +
>> +	of_node_put(np);
>> +
>> +	ret = qcom_cpufreq_populate_opps(pvs_nvmem);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return PTR_ERR(platform_device_register_simple("cpufreq-dt",
>> +						       -1, NULL, 0));
> 
> Wanna do proper error handling here? For example, unset OPP name on failure here
> so that resources get freed ?
> 

 ok, will fix things here.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
