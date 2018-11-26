Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23269C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D580C20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W364BUJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D580C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeKZVCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:02:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:02:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so18189566wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JUflMH9nHJ4QglcOT/HXW3nLKZmF6gxHXJWquZY1L/4=;
        b=W364BUJYqukkxRRJdAy+EZe7bqxeJmAKWEJSmrFrURgJf4AO4CDz41vhfYGs1KioV9
         eJoIbjFSbe+Rxl44agOefmAQs5ZA/6rdpZOJ6znX4JWXIw9K4AC20uTpjkCffjplrrl1
         15U7PxI6N9YFd+qEMPGbOYu6v+vBPShC8ujrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUflMH9nHJ4QglcOT/HXW3nLKZmF6gxHXJWquZY1L/4=;
        b=Pj5XtFdLbPgHyFahnJS3A8GfQtjOdvHiB1dTuzVhizwjDAio2TiraCk5JXENgHYS6v
         bOGb8ShuchR99mEA5N/+OMasVkxrVOVNPVwD0ge19qXKut12EhZ5g8Mjbdnj/o8u5NAc
         KaMfhbXL39UykKDG0aUk8FPtlY3D4fsaPsb9X3CViPYebm8rMimx91JhgmFYs2MdpOJJ
         NxkGHBLZ/fhJTlc8xGjM9PIaa1HG5fAjw53ByvAWilcGdVxinAsZqvWgi0+lGyxPjsGV
         gxVyEUjoKBNw9Ty8eehKXHx9VSOea+/3aRmrZu5WYE5oc8no9FKnS9cA7Vk/VUGDeSWz
         jc8w==
X-Gm-Message-State: AA+aEWbv5YLuLFuUk6GCjTEtThfCdxuIscyWuKk1ZLXlGaT41XM8W6YY
        yxtbjqO0Asysdxi/GaKQ1CX55g==
X-Google-Smtp-Source: AFSGD/WFCRZJigM4ObsUlJQPZpdWHTiVx2NBm3tJgrMnX6kvS9tdeS17dBvKvO9Kc+P9SeCecFKcvA==
X-Received: by 2002:adf:b190:: with SMTP id q16mr23006313wra.95.1543226924969;
        Mon, 26 Nov 2018 02:08:44 -0800 (PST)
Received: from [192.168.0.40] (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.googlemail.com with ESMTPSA id t131sm15196745wmt.1.2018.11.26.02.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 02:08:43 -0800 (PST)
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Quentin Perret <quentin.perret@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
Date:   Mon, 26 Nov 2018 11:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 10:52, Quentin Perret wrote:
> On Monday 26 Nov 2018 at 09:44:21 (+0100), Daniel Lezcano wrote:
>> In the case of asymmetric SoC with the same micro-architecture, we
>> have a group of CPUs with smaller OPPs than the other group. One
>> example is the 96boards dragonboard 820c. There is no dmips/MHz
>> difference between both groups, so no need to specify the values in
>> the DT. Unfortunately, without these defined, there is no scaling
>> capacity computation triggered, so we need to write
>> 'capacity-dmips-mhz' for each CPU with the same value in order to
>> force the scaled capacity computation.
>>
>> In order to fix this situation, allocate 'raw_capacity' so the pointer
>> is set and the init_cpu_capacity_callback() function can be called.
>>
>> This was tested on db820c:
>>  - specified values in the DT (correct results)
>>  - partial values defined in the DT (error + fallback to defaults)
>>  - no specified values in the DT (correct results)
>>
>> correct results are:
>>   cat /sys/devices/system/cpu/cpu*/cpu_capacity
>>    758
>>    758
>>   1024
>>   1024
>>
>>   ... respectively for CPU0, CPU1, CPU2 and CPU3.
>>
>> That reflects the capacity for the max frequencies 1593600 and 2150400.
>>
>> Cc: Chris Redpath <chris.redpath@linaro.org>
>> Cc: Quentin Perret <quentin.perret@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
>> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
>> Cc: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/base/arch_topology.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index fd5325b..e0c5b60 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
>>  	 * until we have the necessary code to parse the cpu capacity, so
>>  	 * skip registering cpufreq notifier.
>>  	 */
>> -	if (!acpi_disabled || !raw_capacity)
>> +	if (!acpi_disabled)
>>  		return -EINVAL;
>>  
>> +	if (!raw_capacity) {
>> +
>> +		pr_info("cpu_capacity: No capacity defined in DT, set default "
>> +		       "values to %ld\n", SCHED_CAPACITY_SCALE);
>> +
>> +		raw_capacity = kmalloc_array(num_possible_cpus(),
>> +					     sizeof(*raw_capacity), GFP_KERNEL);
>> +		if (!raw_capacity)
>> +			return -ENOMEM;
>> +	}
>> +
>>  	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
>>  		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
>>  		return -ENOMEM;
>> -- 
>> 2.7.4
> 
> With this, if the DT is partially filled, we will still do the frequency
> scaling thing now right ?

Right, if the DT is partially filled. We end up with the error, the
raw_capacity is free and set to NULL.

register_cpufreq_notifier() will allocate it and the capacity is computed.

> I'm not sure if this is the expected behaviour. If the DT is partially
> filled, we probably want to have 1024 of capacity for all CPUs to match
> the doc.

Yes if they have the same number of OPP which is the case of 99% of the
boards (excluding the big Little). Otherwise setting all CPU with a
capacity of 1024 but having different OPP (like qcom gold-silver arch)
does not make sense and the patch fix this.

> Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
> top of topology_parse_cpu_capacity() ?

I prefer to update the documentation, it makes more sense than adding
more cumbersome tests in the current code.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

