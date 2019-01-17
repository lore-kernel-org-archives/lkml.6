Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D23C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA5D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="adSidZdn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X50aACIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfAQHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:04:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfAQHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:04:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6712E60866; Thu, 17 Jan 2019 07:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547708670;
        bh=WLhlOFOHmjC/9txr+zSS+e/2H6rHRKwXW3yBZKxywL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=adSidZdnhq6TExNbc5wPGuyrRHK7FG1RX8abWapQRNpN8Olu56Eiw5mTWEXCOLPF6
         XBpCYDsID1qQ9qs19fFthBDiBj3U8NBT/rcEWMID8ArBHVuG9kd8W9FN48MEvY2+qZ
         t3rDAmPIYQ79LGXrdE6417+QONGPZec2jbIPzYbw=
Received: from [192.168.225.247] (unknown [49.33.245.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CAD5605A0;
        Thu, 17 Jan 2019 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547708668;
        bh=WLhlOFOHmjC/9txr+zSS+e/2H6rHRKwXW3yBZKxywL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X50aACIptYe1UAzPxfGcIXJj1BrgBr9slAHnqQmcyjqwGsD5SFV5z3zcKR9pP8D2P
         hM7xM3Fna25tPWOoja271kdZYEj1bE+ugRqs8XGnN7CYxO/5q62wnFN1Rq/vcoDtI+
         3ytrgV7a7HhGzhWxD9FotIMEXS2RLo2f94xyGm4Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CAD5605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
 <20190115002928.GO261387@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d195d4f8-655b-988c-278f-31dfa5a9048c@codeaurora.org>
Date:   Thu, 17 Jan 2019 12:34:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115002928.GO261387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch, would incorporate in the next patch series.

On 1/15/2019 5:59 AM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> On Wed, Jan 09, 2019 at 01:37:28PM +0530, Taniya Das wrote:
>> Add support to read the voltage look up table and populate OPP for all
>> corresponding CPUS for consumers like the energy model could use the
>> frequency and voltage from the OPP tables.
>>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 33 +++++++++++++++++++++++++++++++--
>>   1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index d83939a..18f90bb 100644
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
>> @@ -75,6 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   				    void __iomem *base)
>>   {
>>   	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
>> +	u32 volt;
>>   	unsigned int max_cores = cpumask_weight(policy->cpus);
>>   	struct cpufreq_frequency_table	*table;
>>
>> @@ -83,11 +87,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
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
>> @@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>>   		} else {
>>   			table[i].frequency = freq;
>> +			dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +					freq * 1000, volt);
>>   			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>>   				freq, core_count);
>>   		}
>> @@ -116,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   			if (prev_cc != max_cores) {
>>   				prev->frequency = prev_freq;
>>   				prev->flags = CPUFREQ_BOOST_FREQ;
>> +				dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +						prev_freq * 1000, volt);
>>   			}
>>
>>   			break;
>> @@ -127,6 +140,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>   	table[i].frequency = CPUFREQ_TABLE_END;
>>   	policy->freq_table = table;
>> +	dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), policy->cpus);
>>
>>   	return 0;
>>   }
>> @@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
>> @@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto error;
>>   	}
>>
>> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (ret <= 0) {
>> +		dev_err(cpu_dev, "OPP table is not ready\n");
>> +		goto error;
>> +	}
>> +
>>   	policy->fast_switch_possible = true;
>>
>>   	return 0;
>> @@ -217,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>   	void __iomem *base = policy->driver_data - REG_PERF_STATE;
>>
>> +	dev_pm_opp_remove_all_dynamic(&global_pdev->dev);
>>   	kfree(policy->freq_table);
>>   	devm_iounmap(&global_pdev->dev, base);
> 
> With this patch I get the following message on a SDM845 platform:
> 
> [    0.847515] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 1766400000, volt: 804000, enabled: 1. New: freq: 1766400000, volt: 804000, enabled: 1
> 
> A LUT that doesn't end with a boost frequency isn't handled
> properly. The below patch fixes this.
> 
> Cheers
> 
> Matthias
> 
> 
>  From 481d7d6b190285c95f20e9e1b5ccd5c6b9910a0d Mon Sep 17 00:00:00 2001
> From: Matthias Kaehlcke <mka@chromium.org>
> Date: Mon, 14 Jan 2019 15:54:54 -0800
> Subject: [PATCH] cpufreq: qcom-hw: Don't add duplicate OPPs
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 41557329777e5a..314c8d29276b5e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -103,15 +103,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>   		else
>   			freq = cpu_hw_rate / 1000;
>   
> -		/* Ignore boosts in the middle of the table */
> -		if (core_count != max_cores) {
> -			table[i].frequency = CPUFREQ_ENTRY_INVALID;
> -		} else {
> +		if ((freq != prev_freq) && (core_count == max_cores)) {
>   			table[i].frequency = freq;
>   			dev_pm_opp_add(get_cpu_device(policy->cpu),
> -					freq * 1000, volt);
> +				       freq * 1000, volt);
>   			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>   				freq, core_count);
> +		} else {
> +			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>   		}
>   
>   		/*
> 
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
