Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC0McD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:32:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35641 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeC0McB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:32:01 -0400
X-Google-Smtp-Source: AIpwx4+9XpBRDi9A2IUG5bEBDW++s9VyC3SWMkTzYAgBqKaDVNFLSnO2O9sbONDDDlTvfNzfMtX5hQ==
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Leo Yan <leo.yan@linaro.org>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, vincent.guittot@linaro.org,
        amit.kachhap@gmail.com, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180327020331.GA21693@leoy-ThinkPad-X240s>
 <8ee2cb0d-9afe-6626-0911-90ff6660bf8a@linaro.org>
 <20180327122836.GD10639@localhost.localdomain>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <719e1d94-170c-f208-d4a2-f3e882b1e20e@linaro.org>
Date: Tue, 27 Mar 2018 14:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327122836.GD10639@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 14:28, Juri Lelli wrote:
> Hi Daniel,
> 
> On 27/03/18 12:26, Daniel Lezcano wrote:
>> On 27/03/2018 04:03, Leo Yan wrote:
>>> Hi Daniel,
>>>
>>> On Wed, Feb 21, 2018 at 04:29:27PM +0100, Daniel Lezcano wrote:
>>>> The cpu idle cooling driver performs synchronized idle injection across all
>>>> cpus belonging to the same cluster and offers a new method to cool down a SoC.
>>>>
>>>> Each cluster has its own idle cooling device, each core has its own idle
>>>> injection thread, each idle injection thread uses play_idle to enter idle.  In
>>>> order to reach the deepest idle state, each cooling device has the idle
>>>> injection threads synchronized together.
>>>>
>>>> It has some similarity with the intel power clamp driver but it is actually
>>>> designed to work on the ARM architecture via the DT with a mathematical proof
>>>> with the power model which comes with the Documentation.
>>>>
>>>> The idle injection cycle is fixed while the running cycle is variable. That
>>>> allows to have control on the device reactivity for the user experience. At
>>>> the mitigation point the idle threads are unparked, they play idle the
>>>> specified amount of time and they schedule themselves. The last thread sets
>>>> the next idle injection deadline and when the timer expires it wakes up all
>>>> the threads which in turn play idle again. Meanwhile the running cycle is
>>>> changed by set_cur_state.  When the mitigation ends, the threads are parked.
>>>> The algorithm is self adaptive, so there is no need to handle hotplugging.
>>>
>>> The idle injection threads are RT threads (FIFO) and I saw in
>>> play_idle() set/clear flag PF_IDLE for it.  Will these idle injection
>>> threads utilization be accounted into RT utilization?
>>>
>>> If idle injection threads utilization is accounted as RT tasks
>>> utilization, will this impact CPUFreq governor 'schedutil' for OPP
>>> selection?
>>
>> Hi Leo,
>>
>> The idle injection task has a very low utilization when it is not in the
>> play_idle function, basically it wakes up, sets a timer and play_idle().
>>
>> Regarding the use case, the idle injection is the base brick for an
>> combo cooling device with cpufreq + cpuidle. When the idle injection is
>> used alone, it is because there is no cpufreq driver for the platform.
>> If there is a cpufreq driver, then we should endup with the cpu cooling
>> device where we have control of the OPP (and there is no idle injection
>> threads) or the combo cooling device.
>>
>> Except I'm missing something, the idle injection threads won't impact
>> the OPP selection.
> 
> Mmm, they actually might. schedutil selects max OPP as soon as it sees
> an RT thread. I fear these guys might generate unwanted spikes. Maybe
> you can filter them out?

Yes, absolutely. Leo pointed it also.

We might want to change the check at:

https://elixir.bootlin.com/linux/v4.16-rc7/source/kernel/sched/cpufreq_schedutil.c#L364

in order to ignore PF_IDLE tagged tasks.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
