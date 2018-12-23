Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A094C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA2B21738
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K8Z1J5DS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xx7SNRCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbeLWS7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 13:59:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeLWS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 13:59:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C3A166053B; Sun, 23 Dec 2018 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545591569;
        bh=pl4ZE4417A+jYdHndbo0Jm6VnkbCRBDjEm55DOdzg+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K8Z1J5DSrJQ3lruXaeRvIUqdTKyOLG8KIhE+GFfZqihEwCYD2BftjgbxcoYopCL+s
         q0iwAt080+JhdalWUINiGk9ixVKEuA2RZw9Z2Q5gC/cJgB+FuvBJ+DlJs+lJLZlH6E
         UMosthAiBcMLYg7pyhskqydzCz8xCecBp59UzTLg=
Received: from [192.168.225.247] (unknown [49.32.97.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABA12602A7;
        Sun, 23 Dec 2018 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545591568;
        bh=pl4ZE4417A+jYdHndbo0Jm6VnkbCRBDjEm55DOdzg+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xx7SNRCoCPG7l+nesFRcG37tJzO8jVToqNg59fy1j/Kge8wyCQ3Di3J7hpmNoovvx
         /2x1LU5HW7BIv6YhQGhkidG9B33qKmG5Qgz6kBK/+N1EJ3mBTYhOKjXi9U3+2xHpx8
         WBAf/uNFI7QQayKNeo9e0xUPNnEfBpY58jtMyEg8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABA12602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <20181221205752.GD261387@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
Date:   Mon, 24 Dec 2018 00:29:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221205752.GD261387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

Thanks for your review comments.

On 12/22/2018 2:27 AM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> On Fri, Dec 21, 2018 at 11:36:48PM +0530, Taniya Das wrote:
>> Add support to read the voltage look up table and populate OPP for all
>> corresponding CPUS.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 32 ++++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index d83939a..7559b87 100644
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
>> +#define REG_FREQ_LUT_TABLE		0x110
>> +#define REG_VOLT_LUT_TABLE		0x114
> 
> The new names suggest that there is a LUT for frequencies and another
> one for voltages. I don't have access to hardware documentation, but
> from the code and offsets in this driver it seems there is a single
> table at offset 0x110, with a 'row' of 32 bytes per OPP. Within this
> row the frequency (and other values) is located at offset 0, the
> voltage at offset 4.
> 
> I'd suggest to keep REG_LUT_TABLE, add a define LUT_OFFSET_VOLTAGE/MV
> (or similar) and adjust the math in qcom_cpufreq_hw_read_lut() to use
> REG_LUT_TABLE as base offset.
> 

These names are as per HW documentation and the math is kept as per the 
documentation for reading the voltage.

>>   #define REG_PERF_STATE			0x920
>>
>>   static unsigned long cpu_hw_rate, xo_rate;
>> @@ -75,19 +78,26 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   				    void __iomem *base)
>>   {
>>   	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
>> +	u32 volt;
>>   	unsigned int max_cores = cpumask_weight(policy->cpus);
>>   	struct cpufreq_frequency_table	*table;
>> +	unsigned long cpu_r;
> 
> nit: why 'cpu_r' and not just 'cpu'?
> 
> (if it is needed at all, see my comment below)
> 
>>
>>   	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>   	if (!table)
>>   		return -ENOMEM;
>>
>>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> -		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
>> +		data = readl_relaxed(base + REG_FREQ_LUT_TABLE +
>> +				      i * LUT_ROW_SIZE);
>>   		src = FIELD_GET(LUT_SRC, data);
>>   		lval = FIELD_GET(LUT_L_VAL, data);
>>   		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>>
>> +		data = readl_relaxed(base + REG_VOLT_LUT_TABLE +
>> +				      i * LUT_ROW_SIZE);
>> +		volt = FIELD_GET(LUT_VOLT, data) * 1000;
>> +
>>   		if (src)
>>   			freq = xo_rate * lval / 1000;
>>   		else
>> @@ -123,6 +133,10 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>   		prev_cc = core_count;
>>   		prev_freq = freq;
>> +
>> +		freq *= 1000;
>> +		for_each_cpu(cpu_r, policy->cpus)
>> +			dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
> 
> Are you sure we want to duplicate the OPP entries for all CPUs in the
> cluster? IIUC the frequencies of the cores in a cluster can't be
> changed individually, hence the cores should have a shared table. I
> think dev_pm_opp_get_sharing_cpus() does what you need.
> 
> You currently also add OPPs for invalid frequencies. From my SDM845
> device:
> 
> cat /sys/devices/system/cpu/cpufreq/policy4/scaling_available_freq
>    => 825600 902400 979200 1056000 1209600 1286400 1363200 1459200
>    1536000 1612800 1689600 1766400 1843200 1920000 1996800 2092800
>    2169600 2246400 2323200 2400000 2476800 2553600 2649600
> 
> cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
> 2803200
> 
> ls /sys/kernel/debug/opp/cpu4/
> opp:1056000000  opp:1612800000  opp:2092800000  opp:2553600000  opp:825600000
> opp:1209600000  opp:1689600000  opp:2169600000  opp:2649600000  opp:902400000
> opp:1286400000  opp:1766400000  opp:2246400000  opp:2707200000  opp:979200000
> opp:1363200000  opp:1843200000  opp:2323200000  opp:2764800000
> opp:1459200000  opp:1920000000  opp:2400000000  opp:2784000000
> opp:1536000000  opp:1996800000  opp:2476800000  opp:2803200000
> 
> There are OPP entries for 2707200000, 2764800000 and 2784000000 Hz,
> however these frequencies appear neither in available_frequencies nor
> boost_frequencies.
> 
>>   	}
>>

Could you help validating with the patch below?

>>   	table[i].frequency = CPUFREQ_TABLE_END;
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
> 
> I suppose we want to remove the OPPs when the cpufreq driver is
> unloaded, looks like dev_pm_opp_cpumask_remove_table() should do the
> trick.
> 
> Cheers
> 
> Matthias
> 

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
b/drivers/cpufreq/qcom-cpufreq-hw.c
index 7559b87..23338b2 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -81,7 +81,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
         u32 volt;
         unsigned int max_cores = cpumask_weight(policy->cpus);
         struct cpufreq_frequency_table  *table;
-       unsigned long cpu_r;

         table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
         if (!table)
@@ -110,6 +109,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
                         table[i].frequency = freq;
                         dev_dbg(dev, "index=%d freq=%d, core_count 
%d\n", i,
                                 freq, core_count);
+                       dev_pm_opp_add(get_cpu_device(policy->cpu),
+                                       freq * 1000, volt);
                 }

                 /*
@@ -126,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
                         if (prev_cc != max_cores) {
                                 prev->frequency = prev_freq;
                                 prev->flags = CPUFREQ_BOOST_FREQ;
+                               dev_pm_opp_add(get_cpu_device(policy->cpu),
+                                               prev_freq * 1000, volt);
                         }

                         break;
@@ -133,12 +136,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

                 prev_cc = core_count;
                 prev_freq = freq;
-
-               freq *= 1000;
-               for_each_cpu(cpu_r, policy->cpus)
-                       dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
         }

+       dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), 
policy->cpus);
         table[i].frequency = CPUFREQ_TABLE_END;
         policy->freq_table = table;

@@ -245,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct 
cpufreq_policy *policy)
  {
         void __iomem *base = policy->driver_data - REG_PERF_STATE;

+       dev_pm_opp_cpumask_remove_table(policy->cpus);
         kfree(policy->freq_table);
         devm_iounmap(&global_pdev->dev, base);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
