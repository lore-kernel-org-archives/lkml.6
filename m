Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC0Jfs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:35:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53075 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeC0Jfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:35:46 -0400
X-Google-Smtp-Source: AG47ELtaOT98XDnq7I8e6B8PCyCwHM8DarvCOPEa73JUCU/fvoU/jpNpuDmTXfG5XpxXS1CocDa6aQ==
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
To: Leo Yan <leo.yan@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, kevin.wangtao@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <20180307170923.GA6543@localhost.localdomain>
 <1c07a155-d8e8-480f-937a-6022cda15d0b@linaro.org>
 <20180308120352.mko2b775ppquverb@oak.lan>
 <20180326143046.GA18782@leoy-ThinkPad-X240s>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a3ec7322-f48c-911d-bce0-3696666b6f0d@linaro.org>
Date: Tue, 27 Mar 2018 11:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326143046.GA18782@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2018 16:30, Leo Yan wrote:
> On Thu, Mar 08, 2018 at 12:03:52PM +0000, Daniel Thompson wrote:
>> On Wed, Mar 07, 2018 at 07:57:17PM +0100, Daniel Lezcano wrote:
>>>>> The preliminary benchmarks show the following changes:
>>>>>
>>>>> On the hikey6220, dhrystone shows a throughtput increase of 40% for an
>>>>> increase of the latency of 16% while sysbench shows a latency increase
>>>>> of 5%.
>>>>
>>>> I don't follow these numbers. Throughput increase while injecting idle?
>>>> compared to what? percentages of what? Please be more specific to better
>>>> describer your work..
>>>
>>> The dhrystone throughput is based on the virtual timer, when we are
>>> running, it is at max opp, so the throughput increases. But regarding
>>> the real time, it takes obviously more time to achieve as we are
>>> artificially inserting idle cycles. With the cpufreq governor, we run at
>>> a lower opp, so the throughput is less for dhrystone but it takes less
>>> time to achieve.
>>>
>>> Percentages are comparing cpufreq vs cpuidle cooling devices. I will
>>> take care of presenting the results in a more clear way in the next version.
>>
>> I think we should also note that the current hikey settings for cpufreq
>> are very badly tuned for this platform. It has a single temp threshold
>> and it jumps from max freq to min freq.
>>
>> IIRC Leo's work on Hikey thermals correctly it would be much better if 
>> it used the power-allocator thermal governor or if if copied some of 
>> the Samsung 32-bit platform by configuring the step governor with a 
>> graduated with a slightly lower threshold that moves two stops back in 
>> the OPP table (which is still fairly high clock speed... but it
>> thermally sustainable).
> 
> I think Daniel L. is working on this patch set with 'power-allocator'
> governor, and the parameters 'sustainable-power = <3326>' and
> 'dynamic-power-coefficient = <311>' are profiling value on Hikey
> platform.  Now we only consider dynamic power and skip static leakage
> for 'power-allocator' governor.  And all these parameters are merged
> into Linux mainline kernel.
> 
> Daniel L. could correct me if I misunderstand the testing conditions.

Well, the first iteration is without the powerallocator governor API. It
was tested with the step-wise governor only. But you are right by saying
it will use the dynamic-power-coefficient and sustainable-power and will
implement the power allocator version of the API. I'm working on the
power allocator version for the idle injection + OPP change as we need
to compute the capacity equivalence between the idle-injection cycles +
OPP and the lower OPP in order to change the OPP for optimized power /
performance trade-off.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
