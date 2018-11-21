Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD5208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBOOmflr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBD5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbeKVIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:48:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53119 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbeKVIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:48:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so7003476wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3k3dA/09JQdik6f9Z1SVXJKmLaera0zSGQVoml7KjlY=;
        b=JBOOmflrp/NPBMikn4wlYPy6XYFz25Jp1Pyjdw4djBIVT7M3C8If7e14S+ceiHl86v
         8/f5HdkFbMMl7REtsAmCexQH+FSL/8dm3r2fmFXm+aP4SA9Lgw2yQczpVbywWg+Y7Ntk
         32Tos1ZsB1E2wOW3bCSv5JUW1HoVpkw9ZrdTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3k3dA/09JQdik6f9Z1SVXJKmLaera0zSGQVoml7KjlY=;
        b=c40aolcz+KOA94j4vmNZEksC7y1j6rFA3rj9mSdOQPjPBEesK4RjsvU+YaqEE4LWXB
         6p+KXrVzkbQ6oZZYyxf8xA4Ho8g58LghDlTSSUrLuyrjCwpIT+gQtQRhR2iEAo7lvv0z
         0ApGWntPXZT5HW1wa9AMy2pwbLQoW2fizcETYlFNPfjsTLrkPaFCWE9bKlyP4JorNtZx
         zywlFTKp0+9VLRqf5EzigtpWUnGSOSLGGzsIkuGJ8JmSY8d/tDMlmITRHgvT9vqojrU8
         EwqdHAxkBntPYvfay3ZudCbvUQpIR+NaZJHZa6Qjt5yH9icPOhvvo10HxEiV8FvHwXXU
         6cuw==
X-Gm-Message-State: AGRZ1gILjzIN/CyH1DeH0nkuGHQyA2QtYXGVNDMXv4dWdPeUEU+3pEcU
        yC1F3boAQLvarbD2/Iw7YBi1Dg==
X-Google-Smtp-Source: AJdET5d82SKSyJO7OMIxoibagIflJEMt3CUQoP48pPNL8kt+aNKvLAnFEuYspUO4mbMNrH7SMsnrgQ==
X-Received: by 2002:a1c:f81:: with SMTP id 123-v6mr7195940wmp.37.1542838331957;
        Wed, 21 Nov 2018 14:12:11 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id a125-v6sm2213922wmf.8.2018.11.21.14.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:12:11 -0800 (PST)
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030085845.az2dstibnrcl7im4@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
Date:   Wed, 21 Nov 2018 23:12:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030085845.az2dstibnrcl7im4@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 09:58, Viresh Kumar wrote:
> s/dmpis/dmips/ in $subject
> 
> On 29-10-18, 17:23, Daniel Lezcano wrote:
>> In the case of assymetric SoC with the same micro-architecture, we
> 
>                  asymmetric ?
> 
>> have a group of CPUs with smaller OPPs than the other group. One
>> example is the 96boards dragonboard 820c. There is no dmips/MHz
>> difference between both groups, so no need to specify the values in
>> the DT. Unfortunately, without these defined, there is no scaling
>> capacity comutation triggered, so we need to write
> 
>            computation
> 
>> 'capacity-dmips-mhz' for each CPU with the same value in order to
>> force the scaled capacity computation.
>>
>> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
>> 'capacity-dmips-mhz' is defined in the DT.
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
>>  drivers/base/arch_topology.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 7311641..7d594a6 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -205,6 +205,21 @@ static struct notifier_block init_cpu_capacity_notifier = {
>>  	.notifier_call = init_cpu_capacity_callback,
>>  };
>>  
>> +static int topology_set_default_capacity(void)
>> +{
>> +	int cpu;
>> +
>> +	raw_capacity = kzalloc(num_possible_cpus() * sizeof(*raw_capacity),
>> +			       GFP_KERNEL);
>> +	if (!raw_capacity)
>> +		return -ENOMEM;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;
> 
> This isn't actually required as the value of raw_capacity isn't used
> anymore after this point in code. Rather it is forcefully updated in
> init_cpu_capacity_callback():
> 
> raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
>                     policy->cpuinfo.max_freq / 1000UL;
> 
> Maybe it is better to allocate raw_capacity once at boot and use
> another global variable as flag (raw_capacity is used as a flag right
> now at many places).

Can we keep the proposed change as is to simply fix the default value?

I want to do a separate change with a raw_capacity rewrite and remove
the workqueue freeing it.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

