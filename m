Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5578C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X14xApZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B75B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJKAyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:54:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44893 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJKAyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:54:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so3664428qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AvOu5UtQ+X1loc84g9+TLLQvMEjt3kN5GRi6JKZC6yY=;
        b=X14xApZ7mZkQpAHiPjOcpyI3/F6G3FVGLMFeQajPWhYAW+VQ7dqdzlzIgmy3afb3SP
         VrAfhpTM0Dl/bDSQP5P59ev8cZA+KlRXyTe8pwwSHjfU7Mx01HmLR5x9wBGcdELhRUUd
         NboG4PPM3Z6qp8/tQKu9h+qO0hTzyDtiuAQ6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AvOu5UtQ+X1loc84g9+TLLQvMEjt3kN5GRi6JKZC6yY=;
        b=cUhzIgFGba+1kmswmdXSj+4AtAEehmy6boap4ESBvf/P1q7vSi3Aj7lOPUwrjc6xA1
         72TpSUkHpoxz5T7XBzv01j8aPG5xHsneEPJkqzbIEXYPz2jSX9vm4BeQsraEz3ZVOo0M
         SzMBv1qwz4wW5hI24LyKL8tkuDpy3uOGcn1fyEAmIl2HnyX2ll8PoS5DViujtV29Rxk7
         QHqQSc1ffZRvX3CTIA4Ay6VzVM2A/1KnZJd+D+jcKD7lPXey3mY7mDAVZp14Q7xvqVIw
         iPRQ39GBZ734X+xJinWYiO9hP8oILd336XLsv3bdxTdLePxc0F+7jNx+sTjHXcg/1IEx
         qkiA==
X-Gm-Message-State: ABuFfog8RwRV7MTlKkQdYJEZgbTi/jXloE+tCpyZLHiRAZZMZzeLJ6Be
        fGaBdqt+3UsLUsLaiFx1wJvHkA==
X-Google-Smtp-Source: ACcGV62/2pFM4M1XCyXPVAF1mNlBodG8jv0MztD3DJu5bmiNwxtZC0+AsUmD9+V8UWXJePTGanYiBw==
X-Received: by 2002:a37:7041:: with SMTP id l62-v6mr26625978qkc.294.1539192660440;
        Wed, 10 Oct 2018 10:31:00 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id p3-v6sm8414477qtp.55.2018.10.10.10.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 10:30:59 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BBE3751.7000908@linaro.org>
Date:   Wed, 10 Oct 2018 13:30:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lukasz,

On 10/10/2018 11:35 AM, Lukasz Luba wrote:
> Hi Thara,
> 
> I have run it on Exynos5433 mainline.
> When it is enabled with step_wise thermal governor,
> some of my tests are showing ~30-50% regression (i.e. hackbench),
> dhrystone ~10%.

That is interesting. If I understand correctly, dhrystone spawns 16
threads or so and floods the system. In "theory", such a test should not
see any performance improvement and degradation. What is the thermal
activity like in your system? I will try running one of these tests on
hikey960.
> 
> Could you tell me which thermal governor was used in your case?
> Please also share the name of that benchmark, i will give it a try.
> Is it single threaded compute-intensive?

Step-wise governor.
I use aobench which is part of phoronix-test-suite.

Regards
Thara

> 
> Regards,
> Lukasz
> 
> On 10/09/2018 06:24 PM, Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity. This patch series attempts to address this issue.
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
>>                                          Result          Standard        Standard
>>                                          (Time secs)     Error           Deviation
>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>
>> Thara Gopinath (7):
>>    sched/pelt: Add option to make load and util calculations frequency
>>      invariant
>>    sched/pelt.c: Add support to track thermal pressure
>>    sched: Add infrastructure to store and update instantaneous thermal
>>      pressure
>>    sched: Initialize per cpu thermal pressure structure
>>    sched/fair: Enable CFS periodic tick to update thermal pressure
>>    sched/fair: update cpu_capcity to reflect thermal pressure
>>    thermal/cpu-cooling: Update thermal pressure in case of a maximum
>>      frequency capping
>>
>>   drivers/base/arch_topology.c  |  1 +
>>   drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
>>   include/linux/sched.h         | 14 +++++++++
>>   kernel/sched/Makefile         |  2 +-
>>   kernel/sched/core.c           |  2 ++
>>   kernel/sched/fair.c           |  4 +++
>>   kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
>>   kernel/sched/pelt.h           |  7 +++++
>>   kernel/sched/sched.h          |  1 +
>>   kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/thermal.h        | 13 +++++++++
>>   11 files changed, 157 insertions(+), 13 deletions(-)
>>   create mode 100644 kernel/sched/thermal.c
>>   create mode 100644 kernel/sched/thermal.h
>>


-- 
Regards
Thara
