Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11152075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jEn9Ti2R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h1a49Amu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfAIIIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:08:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfAIIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:08:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5724760247; Wed,  9 Jan 2019 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547021321;
        bh=6eQXaUxnUOaIy+Qdv+6bUx3t9PglpDExfpO9ZZteCk0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jEn9Ti2R3iLxnsryWAjqLRXUzL5EooxH4/YV4j5FVC2uQ8bUHbfdMxWjre9cXLoH2
         BdAA2F/D6io4PXyFxBy4ceZ8WQlhRgU+7oe05XiKOM/eB/xv8323E8vw3+8jVAf9Oh
         ujkr+nNCVB5vIn9Xhnso6zDrI3OsFINVSFlU2zq0=
Received: from [192.168.225.247] (unknown [49.32.204.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C84A60247;
        Wed,  9 Jan 2019 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547021320;
        bh=6eQXaUxnUOaIy+Qdv+6bUx3t9PglpDExfpO9ZZteCk0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h1a49AmuqHeAnXUP4igpQ2wZ491QmUharWZkVtlxaDVF6YgphfLcX38ETnxzunfL0
         km0fp09rEf2ND60V6xli6P3N/O1J/oEpU3KU895b6j3OFdykESDRGx+EOoqk/N5f6E
         2LU3Z8JJVoYtxwZhSsC/jIBj8Bcl7HkkOiJZ4fjU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C84A60247
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
 <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
 <20190108000214.GR261387@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <8bb26f9b-4aa1-a0e7-ec48-667f096b961f@codeaurora.org>
Date:   Wed, 9 Jan 2019 13:38:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108000214.GR261387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2019 5:32 AM, Matthias Kaehlcke wrote:
> Hi Taniya.
> 
> On Mon, Dec 24, 2018 at 12:29:18AM +0530, Taniya Das wrote:
> 
>> Could you help validating with the patch below?
> 
> ...
> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 7559b87..23338b2 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -81,7 +81,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>          u32 volt;
>>          unsigned int max_cores = cpumask_weight(policy->cpus);
>>          struct cpufreq_frequency_table  *table;
>> -       unsigned long cpu_r;
>>
>>          table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>          if (!table)
>> @@ -110,6 +109,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>                          table[i].frequency = freq;
>>                          dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>>                                  freq, core_count);
>> +                       dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +                                       freq * 1000, volt);
>>                  }
>>
>>                  /*
>> @@ -126,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>                          if (prev_cc != max_cores) {
>>                                  prev->frequency = prev_freq;
>>                                  prev->flags = CPUFREQ_BOOST_FREQ;
>> +                               dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +                                               prev_freq * 1000, volt);
>>                          }
>>
>>                          break;
>> @@ -133,12 +136,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>                  prev_cc = core_count;
>>                  prev_freq = freq;
>> -
>> -               freq *= 1000;
>> -               for_each_cpu(cpu_r, policy->cpus)
>> -                       dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
>>          }
>>
>> +       dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu),
>> policy->cpus);
>>          table[i].frequency = CPUFREQ_TABLE_END;
>>          policy->freq_table = table;
>>
>> @@ -245,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct
>> cpufreq_policy *policy)
>>   {
>>          void __iomem *base = policy->driver_data - REG_PERF_STATE;
>>
>> +       dev_pm_opp_cpumask_remove_table(policy->cpus);
> 
> Evan found that this doesn't actually remove dynamically added
> OPPs. You'll have to use the shiny new dev_pm_opp_remove_all_dynamic()
> (https://lore.kernel.org/patchwork/patch/1028942/) instead.
> 
> Cheers
> 
> Matthias
> 

Thanks, updated the next patch to use the new API.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
