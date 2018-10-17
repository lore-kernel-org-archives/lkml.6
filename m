Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CDECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CD420658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRqHCNyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CD420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJRAUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:20:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41810 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRAUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:20:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id l41-v6so30691702qtl.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iNM2n6BlDhj5BCTHFnjmqv+8aMrp/w65o+CoQC2jUeo=;
        b=KRqHCNyhw7B51V4aOIODjzKkIzqfh4wjqeG7sIhWcU8VgvJX8zqLSdvo2TnuhcD1yh
         yBHeqxBhYLPJts0dS1ZiHX5CvwRipxZBr84UUvXsdzMK7KG277ssBwnM74DgCeLpjJwo
         lM9XkYyf6w/24KZ1S9EGQ5VGHH7QstEDVD3cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iNM2n6BlDhj5BCTHFnjmqv+8aMrp/w65o+CoQC2jUeo=;
        b=InIjyY9EtgcmfGPtBO5OK83Vp+vvdyTpqhH9inFKVyaJHOfsGyI+NInzXtrfQcE2FJ
         NUOIkaJN351qyPuuyv+eXrGlEaTT4mqqu/m0nFlCwlDkP+Gl+Mlr/fmxirDbYr8Ag027
         cvTEEZzjjrjTZa8TwdgrSS4CSM7jisHbkUCZ4X83h17lj5kyyszB5xLoW/pci3u5YlQ5
         xDgN9UJC77oMcJlFqCd+KgsW0tVa2jn1d/z6fkKUnpwSHFFTiSlk3Qe0cKwEDP1lSWzy
         1vg4REnRbKXPddwlnbqfcJZoZnFbMAzhFannteZy5mOON2zqEj4Ghnu+JD9JqNAIWhf8
         NKHA==
X-Gm-Message-State: ABuFfogQkmLbXAw9O4sYUu5gT07T+w0gS2dtCtJifsQI48GcbFVK0iBg
        HHHJkWYpl3PeGwkVhTP6ISHjdQ==
X-Google-Smtp-Source: ACcGV61dTJPeTSKnZOoXjOciXpHC3CyfcJdTVCX2+xzxzrZH3f11cJgK5TEb9M+UmBVxRWRDWyzNEw==
X-Received: by 2002:ac8:c0b:: with SMTP id k11-v6mr25849475qti.31.1539793456493;
        Wed, 17 Oct 2018 09:24:16 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id 140-v6sm12506610qkj.13.2018.10.17.09.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:24:15 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        l.luba@partner.samsung.com
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
 <5BBE3751.7000908@linaro.org>
 <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
 <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        b.zolnierkie@samsung.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BC7622E.6000201@linaro.org>
Date:   Wed, 17 Oct 2018 12:24:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 01:11 PM, Vincent Guittot wrote:
> Hi Lukasz,
> 
> On Thu, 11 Oct 2018 at 13:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>>
>> On 10/10/2018 07:30 PM, Thara Gopinath wrote:
>>> Hello Lukasz,
>>>
>>> On 10/10/2018 11:35 AM, Lukasz Luba wrote:
>>>> Hi Thara,
>>>>
>>>> I have run it on Exynos5433 mainline.
>>>> When it is enabled with step_wise thermal governor,
>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>> dhrystone ~10%.
>>>
>>> That is interesting. If I understand correctly, dhrystone spawns 16
>>> threads or so and floods the system. In "theory", such a test should not
>>> see any performance improvement and degradation. What is the thermal
>>> activity like in your system? I will try running one of these tests on
>>> hikey960.
>> I use this dhrystone implementation:
>> https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
>> It does not span new threads/processes and I pinned it to a single cpu.
>>
>> My thermal setup is probably different than yours.
>> You have (on hikey960) probably 1 sensor for whole SoC and one thermal
>> zone (if it is this mainline file:
>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
>> This thermal zone has two cooling devices - two clusters with dvfs.
>> Your temperature signal read out from that sensor is probably much
>> smoother. When you have sensor inside cluster, the rising factor
>> can be even 20deg/s (for big cores).
>> In my case, there are 4 thermal zones, each cluster has it's private
>> sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
>> which is recommended for IPA.
>>>>
>>>> Could you tell me which thermal governor was used in your case?
>>>> Please also share the name of that benchmark, i will give it a try.
>>>> Is it single threaded compute-intensive?
>>>
>>> Step-wise governor.
>>> I use aobench which is part of phoronix-test-suite.
>>>
>>> Regards
>>> Thara
>>>
>> I have built this aobench and run it pinned to single big cpu:
>> time taskset -c 4 ./aobench
> 
> Why have you pinned the test only on CPU4 ?
> Goal of thermal pressure is to inform the scheduler of reduced compute
> capacity and help the scheduler to take better decision in tasks
> placement.

Hi Lukasz,

I agree with Vincent's observation. I had not seen this earlier. Pinning
a task to a cpu will obviously prevent migration. The performance
regression could be due to as Vincent mentioned below other tasks in the
system. On another note, which cpufreq governor are you using? Is the
core being bumped up to highest possible OPP during the test?

Regards
Thara
> So I would not expect perf impact on your test as the bench will stay
> pinned on the cpu4
> That being said you obviously have perf impact as shown below in your results
> And other tasks on the system are not pinned and might come and
> disturb your bench
> 
>> The results:
>> 3min-5:30min [mainline]
>> 5:15min-5:50min [+patchset]
>>
>> The idea is definitely worth to investigate further.
> 
> Yes I agree
> 
> Vincent
>>
>> Regards,
>> Lukasz
>>
>>
>>


-- 
Regards
Thara
