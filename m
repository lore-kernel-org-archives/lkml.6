Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83075C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A35F2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A35F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJJXh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:37:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeJJXh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5EDED1;
        Wed, 10 Oct 2018 09:15:04 -0700 (PDT)
Received: from [10.1.194.42] (patratel.cambridge.arm.com [10.1.194.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AD1E3F5B3;
        Wed, 10 Oct 2018 09:15:02 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Quentin Perret <quentin.perret@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
 <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
 <20181010134755.jrigtogbxwaz2izb@queper01-lin>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <ad3492f2-f5a9-97ea-8068-d4df2d9288ce@arm.com>
Date:   Wed, 10 Oct 2018 17:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010134755.jrigtogbxwaz2izb@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 10/10/18 14:47, Quentin Perret wrote:
> On Wednesday 10 Oct 2018 at 15:27:57 (+0200), Vincent Guittot wrote:
>> On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
>>>
>>> On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
>>>> This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
>>>> it assume that the max capacity is unchanged but some capacity is
>>>> momentary stolen by thermal.
>>>>  If you want to reflect immediately all thermal capping change, you
>>>> have to update this field and all related fields and struct around
>>>
>>> I don't follow you here. I never said I wanted to change
>>> cpu_capacity_orig. I don't think we should do that actually. Changing
>>> capacity_of (which is updated during LB IIRC) is just fine. The question
>>> is about what you want to do there: reflect an averaged value or the
>>> instantaneous one.
>>
>> Sorry I though your were speaking about updating this cpu_capacity_orig.
> 
> N/p, communication via email can easily become confusing :-)
> 
>> With using instantaneous max  value in capacity_of(), we are back to
>> the problem raised by Thara that  the value will most probably not
>> reflect the current capping value when it is used in LB, because LB
>> period can quite long on busy CPU (default max value is 32*sd_weight
>> ms)
> 
> But averaging the capping value over time doesn't make LB happen more
> often ... That will help you account for capping that happened in the
> past, but it's not obvious this is actually a good thing. Probably not
> all the time anyway.
> 
> Say a CPU was capped at 50% of it's capacity, then the cap is removed.
> At that point it'll take 100ms+ for the thermal signal to decay and let
> the scheduler know about the newly available capacity. That can probably
> be a performance hit in some use cases ... And the other way around, it
> can also take forever for the scheduler to notice that a CPU has a
> reduced capacity before reacting to it.
> 
> If you want to filter out very short transient capping events to avoid
> over-reacting in the scheduler (is this actually happening ?), then
> maybe the average should be done on the cooling device side or something
> like that ?
> 

I think there isn't just the issue of the *occasional* overreaction of a
thermal governor due to noise in the temperature sensors or some spike
in environmental temperature that determines a delayed reaction in the
scheduler due to when capacity is updated.

I'm seeing a bigger issue for *sustained* high temperatures that are not
treated effectively by governors. Depending on the platform, heat can
be dissipated over longer or shorter periods of time. This can determine
a seesaw effect on the maximum frequency: it determines the temperature
is over a threshold and it starts capping, but heat is not dissipated
quickly enough for that to reflect in the value of the temperature sensor,
so it continues to cap; when the temperature gets to normal, capping
is lifted, which in turn results access to higher OPPs and a return to
high temperatures, etc.

What will happen is that, *depending on platform* and the moment when
capacity is updated, you can see either a CPU with a capacity of 1024, or
let's say 800, or (on hikey960 :)) around 500, and back and forth
between them.

Because of these I tend to think that a regulated (averaged) value of
thermal pressure is better than an instantaneous one. Thermal mitigation
measures are there for the well-being and safety of a device, not for
optimizations so it can and should be allowed to overreact, or have a
delayed reaction. But ping-pong-ing tasks back and forth between CPUs
due to changes in CPU capacity is harmful for performance. What would be
awesome to achieve with this is (close to) optimal use of restricted
capacities of CPUs, and I tend to believe instantaneous and most probably
out of date capacity values would not lead to this.

But this is almost a gut feeling and of course it should be validated on
devices with different thermal characteristics. Given the high variation
between devices with regards to this I'd be reluctant to tie it to the
PELT half life.

Regards,
Ionela.

> Thanks,
> Quentin
> 
