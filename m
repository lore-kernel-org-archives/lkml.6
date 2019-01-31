Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76052C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B772218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SFvJP/xX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PsyI+huW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfAaRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:32:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfAaRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:32:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6DDC06047C; Thu, 31 Jan 2019 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548955976;
        bh=ZnlWAYwcgzh4fsKbKk4ZtZt5q3jUSb6mxHn6GZPJPW0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SFvJP/xXTIJBYemnMNrCN3mYY6h1RNIS2O2ALyhAMIUuIUxfMfx8WDNj/jm2crOSo
         m3k3idulBvEioybPz+R7wiz2NDv9xeWbGxp7fDezuSWV6GP5G4mpBl7AEHAMH4dtCC
         XGb8Hrts9tpYMWx0BJVEQJtDlkHB+ooVCpXH5FFM=
Received: from [192.168.225.112] (unknown [49.32.238.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC66A602CB;
        Thu, 31 Jan 2019 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548955975;
        bh=ZnlWAYwcgzh4fsKbKk4ZtZt5q3jUSb6mxHn6GZPJPW0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PsyI+huWzh5+jy+7Spb+9iL8I/Kpco59BQkJFQ+S34q72wOd/VyDEJNanEwpwLjY0
         8Oy33KPuHPziBx1cbvpcuTzh//RgAl/Qz3me21B+6hDc11pQujrfJlK57TsomLnB9t
         3YpzbXXP9xMsY+GWfzI/kx2B3LT9rkSKtzU7hlBg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC66A602CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1548242520-13773-1-git-send-email-tdas@codeaurora.org>
 <20190123182054.GK261387@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <93feea14-df5c-f7c6-1b11-2484dd94f60b@codeaurora.org>
Date:   Thu, 31 Jan 2019 23:02:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123182054.GK261387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2019 11:50 PM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> On Wed, Jan 23, 2019 at 04:52:00PM +0530, Taniya Das wrote:
>> Add support to read the voltage look up table and populate OPP for all
>> corresponding CPUS for consumers like the energy model could use the
>> frequency and voltage from the OPP tables. Also update the logic to not add
>> duplicate OPPs.
>>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 46 +++++++++++++++++++++++++++++++--------
>>   1 file changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index d83939a..402ce81 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -10,18 +10,21 @@
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/slab.h>
>>
>>   #define LUT_MAX_ENTRIES			40U
>>   #define LUT_SRC				GENMASK(31, 30)
>>   #define LUT_L_VAL			GENMASK(7, 0)
>>   #define LUT_CORE_COUNT			GENMASK(18, 16)
>> +#define LUT_VOLT			GENMASK(11, 0)
>>   #define LUT_ROW_SIZE			32
>>   #define CLK_HW_DIV			2
>>
>>   /* Register offsets */
>>   #define REG_ENABLE			0x0
>> -#define REG_LUT_TABLE			0x110
>> +#define REG_FREQ_LUT			0x110
>> +#define REG_VOLT_LUT			0x114
>>   #define REG_PERF_STATE			0x920
>>
>>   static unsigned long cpu_hw_rate, xo_rate;
>> @@ -70,11 +73,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>>   	return policy->freq_table[index].frequency;
>>   }
>>
>> -static int qcom_cpufreq_hw_read_lut(struct device *dev,
>> +static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   				    struct cpufreq_policy *policy,
>>   				    void __iomem *base)
>>   {
>>   	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
>> +	u32 volt;
>>   	unsigned int max_cores = cpumask_weight(policy->cpus);
>>   	struct cpufreq_frequency_table	*table;
>>
>> @@ -83,23 +87,28 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   		return -ENOMEM;
>>
>>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> -		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
>> +		data = readl_relaxed(base + REG_FREQ_LUT +
>> +				      i * LUT_ROW_SIZE);
>>   		src = FIELD_GET(LUT_SRC, data);
>>   		lval = FIELD_GET(LUT_L_VAL, data);
>>   		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>>
>> +		data = readl_relaxed(base + REG_VOLT_LUT +
>> +				      i * LUT_ROW_SIZE);
>> +		volt = FIELD_GET(LUT_VOLT, data) * 1000;
>> +
>>   		if (src)
>>   			freq = xo_rate * lval / 1000;
>>   		else
>>   			freq = cpu_hw_rate / 1000;
>>
>> -		/* Ignore boosts in the middle of the table */
>> -		if (core_count != max_cores) {
>> -			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>> -		} else {
>> +		if (freq != prev_freq && core_count == max_cores) {
>>   			table[i].frequency = freq;
>> -			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>> +			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> +			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>>   				freq, core_count);
>> +		} else {
>> +			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>>   		}
>>
>>   		/*
>> @@ -116,6 +125,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   			if (prev_cc != max_cores) {
>>   				prev->frequency = prev_freq;
>>   				prev->flags = CPUFREQ_BOOST_FREQ;
>> +				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>>   			}
>>
>>   			break;
>> @@ -127,6 +137,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>   	table[i].frequency = CPUFREQ_TABLE_END;
>>   	policy->freq_table = table;
>> +	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
>>
>>   	return 0;
>>   }
>> @@ -159,10 +170,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   	struct device *dev = &global_pdev->dev;
>>   	struct of_phandle_args args;
>>   	struct device_node *cpu_np;
>> +	struct device *cpu_dev;
>>   	struct resource *res;
>>   	void __iomem *base;
>>   	int ret, index;
>>
>> +	cpu_dev = get_cpu_device(policy->cpu);
>> +	if (!cpu_dev) {
>> +		pr_err("%s: failed to get cpu%d device\n", __func__,
>> +		       policy->cpu);
>> +		return -ENODEV;
>> +	}
>> +
>>   	cpu_np = of_cpu_device_node_get(policy->cpu);
>>   	if (!cpu_np)
>>   		return -EINVAL;
>> @@ -199,12 +218,19 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>
>>   	policy->driver_data = base + REG_PERF_STATE;
>>
>> -	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
>> +	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
>>   	if (ret) {
>>   		dev_err(dev, "Domain-%d failed to read LUT\n", index);
>>   		goto error;
>>   	}
>>
>> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (ret <= 0) {
>> +		dev_err(cpu_dev, "Failed to add OPPs\n");
>> +		ret = -EINVAL;
> 
> nit: in seems -ENODEV would be more correct, it's also what
> dev_pm_opp_get_opp_count() would return if the device had no OPP table:
> https://elixir.bootlin.com/linux/v4.20.4/source/drivers/opp/core.c#L65
> 

Thanks updating it in the next patch.

>> +		goto error;
>> +	}
>> +
>>   	policy->fast_switch_possible = true;
>>
>>   	return 0;
>> @@ -215,8 +241,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>
>>   static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>   {
>> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
>>   	void __iomem *base = policy->driver_data - REG_PERF_STATE;
>>
>> +	dev_pm_opp_remove_all_dynamic(cpu_dev);
>>   	kfree(policy->freq_table);
>>   	devm_iounmap(&global_pdev->dev, base);
> 
> Other than the nit about the return value:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Also re-tested it, so the earlier Tested-by tag is applicable again :)
> 
> Thanks
> 
> Matthias
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
