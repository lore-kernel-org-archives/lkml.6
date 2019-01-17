Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A28BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AAD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W1PdOtzb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W1PdOtzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfAQLBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:01:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfAQLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:01:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B6F0E602FC; Thu, 17 Jan 2019 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547722863;
        bh=ngHcUQdgaDg27ZDalfltCxcxDmEi/r/O9loqQ/wLuKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W1PdOtzbBhBj/3ow+z1UeTEv2DXv80MxSGQiGSHZ23zXQweCUD3ClO2qJt1jk5xc3
         cWKP27ZdvJTA4HiSBE0tddR40i8AWgDNhtR9/iGE14FGVQfSWCAsUR89sdDg+YruJj
         VskDJPsggr45/w0jX86jJoJ0bRiUarnpRqRxhz6Q=
Received: from [192.168.225.247] (unknown [49.33.245.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6186E602FC;
        Thu, 17 Jan 2019 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547722863;
        bh=ngHcUQdgaDg27ZDalfltCxcxDmEi/r/O9loqQ/wLuKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W1PdOtzbBhBj/3ow+z1UeTEv2DXv80MxSGQiGSHZ23zXQweCUD3ClO2qJt1jk5xc3
         cWKP27ZdvJTA4HiSBE0tddR40i8AWgDNhtR9/iGE14FGVQfSWCAsUR89sdDg+YruJj
         VskDJPsggr45/w0jX86jJoJ0bRiUarnpRqRxhz6Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6186E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
References: <1547708936-25661-1-git-send-email-tdas@codeaurora.org>
 <20190117072716.iy3glrtdpobsh5u2@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d9cf7ab9-a5f9-5c1a-940b-5ddb12d8ff9a@codeaurora.org>
Date:   Thu, 17 Jan 2019 16:30:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117072716.iy3glrtdpobsh5u2@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2019 12:57 PM, Viresh Kumar wrote:
> On 17-01-19, 12:38, Taniya Das wrote:
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
>> @@ -199,12 +218,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>
>>   	policy->driver_data = base + REG_PERF_STATE;
>>
>> -	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
>> +	ret = qcom_cpufreq_hw_read_lut(policy, base);
> 
> I asked you to pass cpu_dev here instead of dev and you said okay in
> the previous version of the patch. Didn't like it ?
> 

:(, sent the next patch for review.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
