Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D80C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F64120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PZNqXvgA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fch1AwEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfAQHGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:06:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfAQHGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:06:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 057FB6079C; Thu, 17 Jan 2019 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547708764;
        bh=3yFT0kaW8fsevXgSuhk2zDV4NYcTTfxcSZAnUU0S2hs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PZNqXvgAoIwT/wMdrK8tyzkxpW94GkCRNAS0KZE+wh86vnsrQKxgpqrlbntcajPDH
         SjPGvbmTSsdrJsQLKPrS9PZ4y1OcJ4bk2G2YRMQSp16zv7O9J8ot6S6pxARZGYu1P3
         QuD8o9j/Go6fXgs6klIi7oqnq2pOrfu/dnU1KoA8=
Received: from [192.168.225.247] (unknown [49.33.245.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA770606E1;
        Thu, 17 Jan 2019 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547708763;
        bh=3yFT0kaW8fsevXgSuhk2zDV4NYcTTfxcSZAnUU0S2hs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fch1AwEvG4FoGu3VjkfkFGd0bWR/EY6RMlquOQ1HZnjqM+M293FHn2VML2HV4Jx+J
         6tQo9OYGR0GXLIgvW+PptOesb4s0OuWmfJiATWCSH16O+drid5m6N703eFMcIWRM0K
         5AgT6WRBZwFAyFHCG8xU6shyDlzS0tR18RMYooz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA770606E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>,
        evgreen@google.com
References: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
 <20190109085400.mscuzezwxta4fpfh@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <09114ef8-6ea7-ea92-caab-d5ea2904523f@codeaurora.org>
Date:   Thu, 17 Jan 2019 12:35:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109085400.mscuzezwxta4fpfh@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 1/9/2019 2:24 PM, Viresh Kumar wrote:
> On 09-01-19, 13:37, Taniya Das wrote:
>> @@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
> You are only using this "dev" parameter for dev_dbg(), instead of that
> pass cpu_dev pointer.
> 

Sure, will clean it up to use cpu_dev.

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
> 
> and then all the above sites can be simplified a bit.
> 
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
> 
> Rather say "Failed to add OPPs\n".
> 

Sure will update it.

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
> 
> This is platform device's device structure, while you added the OPPs
> using cpu_dev. You sure this will work ?
> 

Hmm, yeah, would update it in the next patch.

>>   	kfree(policy->freq_table);
>>   	devm_iounmap(&global_pdev->dev, base);
>>
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
