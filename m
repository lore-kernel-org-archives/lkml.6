Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8048C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0262086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4x+e46x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0262086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJJXGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:06:15 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:37337 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:06:15 -0400
Received: by mail-qt1-f182.google.com with SMTP id d14-v6so6169687qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=l1bSVOBOfWgTTh2/RT8WbCO263xaYmNCjohnbvYsV18=;
        b=V4x+e46xDhVtTgPFM50n7FMQUgJ4mqWt7CVrBloKdgR5kJ7bWVrdsEdAv2WhZV8PU1
         3kmhoEKrH/ENtxFDXD95U0DDmpAhNpQ2xkfxHbFgdUy8Iyw2y6Ml4W2Qcm1ApN7Yjwz6
         BBC3ZRjdY3PfFJBBfzT1z7TzUCI8xQuzWd95o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=l1bSVOBOfWgTTh2/RT8WbCO263xaYmNCjohnbvYsV18=;
        b=IKUGrBrU2QNZ+fAmA2UI7uAsE77nJIWfVy/DiTozXZeiJJ/GeuY/8OV5NkNqsLq04c
         o1UHobyv3FJQTGB1TC1D1sItAgXweahI2PX+bEPG9zJp4VE4NsV3JqkTAMR1RmP374Dc
         4MnlizVVgOvjwLzgXEuWfYQkKBAusW5ROmR2eU1MlTjoKqKEPMvvimBbV09OHjrI5tU9
         4pJYUHkr93iYSydbTSnPo4Ms8tn5G03tLKt2gnZZD8QCbsJvOjYB0S+gnQaxbF0dcHkY
         Eu0mZL++rls3jVNG3bdOQGdDqEE7T2/Vvfk3D+EQH7PVCj83uv442aMiyP1pjbUbCIG/
         TMQQ==
X-Gm-Message-State: ABuFfohpTbj2ur+z1hGBQ4CuU3v/2m25HGo6oibaFyHqakOloyW66fN8
        ChPpJYV1JWFO/TGpJMlP95Z4mg==
X-Google-Smtp-Source: ACcGV63MyB9O2EpcTEYLdo6XNiUkYxEuZwwGkKdvlPc604VjvPZ3LX625KL5JQMepXQ5oQOof7MT7Q==
X-Received: by 2002:a0c:b346:: with SMTP id a6-v6mr28056805qvf.160.1539186210198;
        Wed, 10 Oct 2018 08:43:30 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id w127-v6sm11139406qkb.51.2018.10.10.08.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:43:29 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BBE1E1F.3030308@linaro.org>
Date:   Wed, 10 Oct 2018 11:43:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010061751.GA37224@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,
Thank you for the review.

On 10/10/2018 02:17 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity. This patch series attempts to address this issue.
>> The benefits identif

ied are better task placement among available
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
> 
> Wow, +13% speedup, impressive! We definitely want this outcome.
> 
> I'm wondering what happens if we do not track and decay the thermal load at all at the PELT 
> level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal 
> events we receive from the CPU.

The problem with instantaneous update is that sometimes thermal events
happen at a much faster pace than cpu_capacity is updated in
the scheduler. This means that at the moment when scheduler uses the
value, it might not be correct anymore.

Having said that, today Android common kernel has a solution which
instantaneously updates cpu_capacity in case of a thermal event.
To give a bit of background on the evolution of the solution I have
proposed, below is a time line of analysis I have done.

1.  I started this activity by analyzing the existing framework on
android common kernel. I ran android benchmark tests (Jankbench,
Vellamo, Geekbench) with and without the existing instantaneous update
mechanism. I found that there is no real performance difference to be
observed with an instantaneous updated of cpu_capacity at least in my
test scenarios.
2. Then I developed an algorithm to track, accumulate and decay the
capacity capping i.e an algorithm without using the pelt signals(this
was prior to the new pelt framework in mainline). With this android
benchmarks showed performance improvements. At this point I also ported
the solution to mainline kernel and ran the aobench analysis which again
showed a performance improvement.
3. Finally with the new pelt framework in place, I replaced my algorithm
with the one used for rt and dl utilization tracking which is the
current patch series. I have not been able to run tests with this on
Android yet.

All tests were performed on hikey960.
I have a Google spreadsheet, documenting results at various stages of
analysis. I am not sure how to share it with the group here.


> 
> You describe the averaging as:
> 
>> Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can 
>> be mismatch between the actual capping of capacity and scheduler recording it.
> 
> Not sure I follow the argument here: are there bogus thermal throttling events? If so then
> they are hopefully not frequent enough and should average out over time even if we follow
> it instantly.

No bogus events. It is more like sometimes capping happens at a much
faster rate than cpu_capacity is updated and the scheduler looses these
events.

> 
> I.e. what is 'can sometimes be erroneous', exactly?
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara
