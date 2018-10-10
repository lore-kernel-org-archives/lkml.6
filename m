Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7262087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmtvrId5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7262087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJJVhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:37:51 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42569 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeJJVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:37:50 -0400
Received: by mail-qt1-f178.google.com with SMTP id j46-v6so5779355qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Fxiad6cc/3fq3UifSXDlk63Z8fy6hTBMX0VnSR4y92A=;
        b=VmtvrId5kJohqPV31isdvo3dFhQ/qXFdYIXTBaGb4FO8U8uVisoPfPZP/VCV/Rz0sS
         OLfia6YJgetxNzdv7qdNa0kyDaIppSeBofBoxfxbr8mPsNDaaPPj4FPGEnf/g9x8evKM
         cZ/rcpkzFiNbCFaPGKTzOrKRNY8dR/spRjPBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Fxiad6cc/3fq3UifSXDlk63Z8fy6hTBMX0VnSR4y92A=;
        b=dgGflsFl589hmWt+HMp4fVFCwt0EujAuUbO2XwLleQD6sldUIyBSgwGP6rzWBZUWmd
         3sZn/Ia7Qodm1q76Uyl3dNJ/6s+yCFxhMqBVnFqLIIJViYGpsZXI1fXP/0TnUAGilwGR
         CAQkFBg3JnU9KhHc6A7Erri7ah++9Lwpwlokds0VOI8QkDG+I1VD/dPyJLnEE4vgfqBX
         68N/+KXfIfOvjchOZzMdLBxHwJRzWA0qJ44NHfsRB/w6RFHlOClnMdBWX+PxgJpZZCG9
         55jmrz9QyLuFhV9FcFypxz2CRnZTCL2L7bM2VMC/uL3WhYb/xCeySnq7YeVebyRndASn
         RYwQ==
X-Gm-Message-State: ABuFfojpqsLTXjKVcSPdm9Ge96i4cy3TZ86qz70wsflyMjdXnn8KJuCQ
        yzsXawWzi0Ukaj0NGAuKXZlVLg==
X-Google-Smtp-Source: ACcGV604w1XQAKqjFJ4FqNnRHT45GoX46HUdFrbSx1Zp2q2iuRsFWBhaUL6Bu8Y9/tf/+GPBqHP0ZA==
X-Received: by 2002:a0c:b04b:: with SMTP id l11-v6mr27132750qvc.139.1539180927683;
        Wed, 10 Oct 2018 07:15:27 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id g34-v6sm14611886qta.79.2018.10.10.07.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 07:15:26 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Javi Merino <javi.merino@kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010054449.GC2768@tesla>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BBE097C.50202@linaro.org>
Date:   Wed, 10 Oct 2018 10:15:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010054449.GC2768@tesla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Javi,

Thanks for the interest.

On 10/10/2018 01:44 AM, Javi Merino wrote:
> On Tue, Oct 09, 2018 at 12:24:55PM -0400, Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity.
> 
> Interesting, I would have sworn that I tested this years ago by
> lowering the maximum frequency of a cpufreq domain, and the scheduler
> reacted accordingly to the new maximum capacities of the cpus.
> 
>>           This patch series attempts to address this issue.
>> The benefits identified are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The delta between the maximum possible capacity of a cpu and
>> maximum available capacity of a cpu due to thermal event can
>> be considered as thermal pressure. Instantaneous thermal pressure
>> is hard to record and can sometime be erroneous as there can be mismatch
>> between the actual capping of capacity and scheduler recording it.
>> Thus solution is to have a weighted average per cpu value for thermal
>> pressure over time. The weight reflects the amount of time the cpu has
>> spent at a capped maximum frequency. To accumulate, average and
>> appropriately decay thermal pressure, this patch series uses pelt
>> signals and reuses the available framework that does a similar
>> bookkeeping of rt/dl task utilization.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on hikey960 mainline kernel with debian file system.
>> Further aobench (An occlusion renderer for benchmarking realworld
>> floating point performance) showed the following results on hikey960
>> with debain.
>>
>>                                         Result          Standard        Standard
>>                                         (Time secs)     Error           Deviation
>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>
>> Thara Gopinath (7):
>>   sched/pelt: Add option to make load and util calculations frequency
>>     invariant
>>   sched/pelt.c: Add support to track thermal pressure
>>   sched: Add infrastructure to store and update instantaneous thermal
>>     pressure
>>   sched: Initialize per cpu thermal pressure structure
>>   sched/fair: Enable CFS periodic tick to update thermal pressure
>>   sched/fair: update cpu_capcity to reflect thermal pressure
>>   thermal/cpu-cooling: Update thermal pressure in case of a maximum
>>     frequency capping
>>
>>  drivers/base/arch_topology.c  |  1 +
>>  drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
> 
> thermal?  There are other ways in which the maximum frequency of a cpu
> can be limited, for example from userspace via scaling_max_freq.

Yes there are other ways in which maximum frequency of a cpu can be
capped. The difference probably is that in case of a user-space cap, the
time duration the cpu remains in the capped state is significantly
higher than capping due to a thermal event. So may be the response of
the scheduler should be different in that scenario (like rebuilding the
capacities of all cpus etc).

This patch series does not rebuild the scheduler structures. This just
tells the scheduler that some cpu capacity is stolen.
> 
> When something (anything) changes the maximum frequency of a cpufreq
> policy, the scheduler should be notified.  I think this change should
> be done in cpufreq instead to make it generic and not particular to
> a given maximum frequency "capper".

I am glad to hear you say this!  So far, all I have heard whenever I
bring up this topic is issues with such an update from cpufreq(delays,
lost updates etc). Personally, I have not seen these issues enough to
comment on them. I will really like to hear more about these issues for
an update from cpufreq here on the list.

For me, the patch series is a mechanism to let scheduler know that a
thermal event has stolen some cpu capacity. The update itself can happen
from any framework which can track the event and we all mutually agree on.

Regards
Thara

> 
> Cheers,
> Javi
> 


-- 
Regards
Thara
