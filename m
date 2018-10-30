Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A403C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A2720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kl88a5T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A2720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJ3Rcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:32:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36252 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3Rcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:32:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so10416384wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJ5YBm0RDwtMaQVWXizp2zxzgKmqAzFC71V/yRtLN7s=;
        b=kl88a5T0WMsrkwywqAiuBLL8/oeMDB5r8whxNkCMz4TTC4VCDXJbUzKntE5ALlv31A
         nXu0pihAEM1UdMpqv0Cx2PYECbnuJ+bx5PFVFPBLfoQawvYCgK3LtGoFXW+f6J1HN9/9
         sYbtEbwK6wauwtIJx3LYpCLunGBecOtywMXE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJ5YBm0RDwtMaQVWXizp2zxzgKmqAzFC71V/yRtLN7s=;
        b=B+HRcNYaQjK2nfMogE3iJsNgLjYV31yvahjFKItGRC2tDV60mFIntOysDWAU0uwRLA
         7MBvZtz9lsDH6IT2T0ZnrywaWCxtM9uME03Rxyl/ek2flh8RSYfGsp5KOt/FIBb7Wk9R
         K4k43TuAtGuhqpsh1ginc1TPE0sTnQDiYHvJqwMmI41haU6jLOqvHLB8gnEjo3bsoYDC
         Gr5SQOKTfgLKW+xsVeRA7WXJtCZzsF+cb0z/KVSLg4pMvR3ADzS+NfT0aVG1xn1iZEol
         BJyQ8XxooMXykkKY2lg1ob83DOg3zO8DCstX2Rmw5v0GE4is103nVzudrmHCSvjiAEms
         60/A==
X-Gm-Message-State: AGRZ1gLtAEcs766f56GsZNxHM8SWR3GD9UwxTZZjRurPEdVPq4YRKb0h
        KnrkMRucbRpdemkryi+oxhy20w==
X-Google-Smtp-Source: AJdET5eHtDWG7OvuET4UfNpMsf2DsYxX3cAFBBDm7W4W3H3cijnSZx6Pc2VUWGfOP0KVz+Si0P/yfA==
X-Received: by 2002:a1c:3e8d:: with SMTP id l135-v6mr913249wma.13.1540888798553;
        Tue, 30 Oct 2018 01:39:58 -0700 (PDT)
Received: from [192.168.0.40] (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.googlemail.com with ESMTPSA id l9-v6sm3054785wrf.4.2018.10.30.01.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:39:57 -0700 (PDT)
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
 <20181030071313.rq2d4cmfrla5boc7@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39cacba7-07e7-b06b-1502-0dc4496c58a8@linaro.org>
Date:   Tue, 30 Oct 2018 09:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030071313.rq2d4cmfrla5boc7@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 08:13, Viresh Kumar wrote:
> On 29-10-18, 17:23, Daniel Lezcano wrote:
>> In the case of assymetric SoC with the same micro-architecture, we
>> have a group of CPUs with smaller OPPs than the other group. One
>> example is the 96boards dragonboard 820c. There is no dmips/MHz
>> difference between both groups, so no need to specify the values in
>> the DT. Unfortunately, without these defined, there is no scaling
>> capacity comutation triggered, so we need to write
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
> 
> kmalloc ?
> 
>> +	if (!raw_capacity)
>> +		return -ENOMEM;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		raw_capacity[cpu] = SCHED_CAPACITY_SCALE;
> 
> It makes it look as if it is important to set default values to
> SCHED_CAPACITY_SCALE while that is not the case. Maybe add a comment
> that all CPUs are assumed to have same capacity now. Maybe initialize
> to 1 instead ? Not sure if that would be better or not.

SCHED_CAPACITY_SCALE is the default value in this file.

eg.

DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE
...
pr_err("cpu_capacity: partial information: fallback to 1024 for all
CPUs\n");
...

So I prefer to use the SCHED_CAPACITY_SCALE for consistency.

>> +
>> +	return 0;
>> +}
>> +
>>  static int __init register_cpufreq_notifier(void)
>>  {
>>  	int ret;
>> @@ -214,9 +229,19 @@ static int __init register_cpufreq_notifier(void)
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
> 
> So we will end up doing this also for the case where the DT is
> partially filled with the capacity info and we already printed error
> messages for it. Should we really do that ?

Yes, it is the default behavior as stated in the documentation:

"capacity-dmips-mhz property is all-or-nothing: if it is specified for a
cpu node, it has to be specified for every other cpu nodes, or the
system will fall back to the default capacity value for every CPU."

and also in the error message:

pr_err("cpu_capacity: partial information: fallback to 1024 for all
CPUs\n");

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

