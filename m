Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCGS6l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:58:41 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40584 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:57:21 -0500
X-Google-Smtp-Source: AG47ELtnMLjaS0I8SYEs4P0FtTdNkFeUpYJVoR8lGcl4q1DN/FVwJQ9gfvWdMTbjejxku0aGj2mZPw==
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
To: Eduardo Valentin <edubezval@gmail.com>
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <20180307170923.GA6543@localhost.localdomain>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1c07a155-d8e8-480f-937a-6022cda15d0b@linaro.org>
Date: Wed, 7 Mar 2018 19:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307170923.GA6543@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eduardo,


On 07/03/2018 18:09, Eduardo Valentin wrote:
> Hello Daniel,
> 
> On Wed, Feb 21, 2018 at 04:29:21PM +0100, Daniel Lezcano wrote:
>> Changelog:
>>   V2:
>>      - Dropped the cpu combo cooling device
>>      - Added the acked-by tags
>>      - Replaced task array by a percpu structure
>>      - Fixed the copyright dates
>>      - Fixed the extra lines
>>      - Fixed the compilation macros to be reused
>>      - Fixed the list node removal
>>      - Massaged a couple of function names
>>
>>
>> The following series provides a new way to cool down a SoC by reducing
>> the dissipated power on the CPUs. Based on the initial work from Kevin
>> Wangtao, the series implements a CPU cooling device based on idle
>> injection, relying on the cpuidle framework.
> 
> Nice! Glad to see that Linaro took this work again. I have a few
> questions, as follows.
> 
>>
>> The patchset is designed to have the current DT binding for the
>> cpufreq cooling device to be compatible with the new cooling devices.
>>
>> Different cpu cooling devices can not co-exist on the system, the cpu
>> cooling device is enabled or not, and one cooling strategy is selected
>> (cpufreq or cpuidle). It is not possible to have all of them available
>> at the same time. However, the goal is to enable them all and be able
>> to switch from one to another at runtime but that needs a rework of the
>> thermal framework which is orthogonal to the feature we are providing.
>>
> 
> Can you please elaborate on the limitations you found? Please be more
> specific.

I did not found the limitation because the dynamic change was not
implemented. My concern is principally regarding the change when we are
mitigating, I'm not sure the thermal framework supports that for the moment.

This is why Viresh proposed to first add the idle injection and then
support the dynamic change before resending the combo cooling device.

>> This series is divided into two parts.
>>
>> The first part just provides trivial changes for the copyright and
>> removes an unused field in the cpu freq cooling device structure.
>>
> 
> Ok..
> 
>> The second part provides the idle injection cooling device, allowing a SoC
>> without a cpufreq driver to use this cooling device as an alternative.
>>
> 
> which is awesome!
> 
> 
>> The preliminary benchmarks show the following changes:
>>
>> On the hikey6220, dhrystone shows a throughtput increase of 40% for an
>> increase of the latency of 16% while sysbench shows a latency increase
>> of 5%.
> 
> I don't follow these numbers. Throughput increase while injecting idle?
> compared to what? percentages of what? Please be more specific to better
> describer your work..

The dhrystone throughput is based on the virtual timer, when we are
running, it is at max opp, so the throughput increases. But regarding
the real time, it takes obviously more time to achieve as we are
artificially inserting idle cycles. With the cpufreq governor, we run at
a lower opp, so the throughput is less for dhrystone but it takes less
time to achieve.

Percentages are comparing cpufreq vs cpuidle cooling devices. I will
take care of presenting the results in a more clear way in the next version.

>> Initially, the first version provided also the cpuidle + cpufreq combo
>> cooling device but regarding the latest comments, there is a misfit with
>> how the cpufreq cooling device and suspend/resume/cpu hotplug/module
>> loading|unloading behave together while the combo cooling device was
>> designed assuming the cpufreq cooling device was always there. This
>> dynamic is investigated and the combo cooling device will be posted
>> separetely after this series gets merged.
> 
> Yeah, this is one of the confusing parts. Could you please
> remind us of the limitations here? Why can't we enable CPUfreq
> on higher trip points and CPUidle on lower trip points, for example?

Sorry, I'm not getting the question. We don't want to enable cpuidle or
cpufreq at certain point but combine the cooling effect of both in order
to get the best tradeoff power / performance.

Let me give an example with a simple SoC - one core.

Let's say we have 4 OPPs and a core-sleep idle state. Respectively, the
OPPs consume 100mW, 500mW, 2W, 4W. Now the CPU is in an intensive work
running at the highest OPP, thus consuming 4W. The temperature increases
and reaches 75°C which is the mitigation point and where the sustainable
power is 1.7W.

 - With the cpufreq cooling device, we can't have 4W, so we go back and
forth between 2W and 500mW.

 - With the cpuidle cooling device, we are at the highest OPP (there is
no cpufreq driver) and we insert 47.5% of idle duration

 - With the combo cooling device, we compute the round-up OPP (here 2W)
and we insert idle cycles for the remaining power to reach the
sustainable power, so 15%.

With the combo, we increase the performances for the same requested
power. There is no yet the state2power callbacks but we expect the
combination of dropping the static leakage and the higher OPP to give
better results in terms of performance and mitigation on energy eager
CPUs like the recent big ARM cpus with the IPA governor.

Going straight to the point of your question above, we can see the
cpufreq cooling device and the cpuidle cooling device have to
collaborate. If we unregister the cpufreq device, we have to do the math
for the power again in the combo cooling device. It is not a problem by
itself but needs an extra reflexion in the current code.

> Specially from a system design point of view, the system engineer
> typically would benefit of idle injections to achieve overall
> average CPU frequencies in a more granular fashion, for example,
> achieving performance vs. cooling between available real
> frequencies, avoiding real switches.
>
> Also, there is a major design question here. After Linaro's attempt
> to send a cpufreq+cpuidle cooling device(s), there was an attempt
> to generalize and extend intel powerclamp driver. 

I'm not aware of such attempt.

> Do you mind
> explaining why refactoring intel powerclamp is not possible? Basic
> idea is the same, no?

Basically the idea is the same: run synchronized idle thread and call
play_idle(). That is all. Putting apart the intel_powerclamp is very x86
centric and contains a plethora of code not fitting our purpose, it
increases the idle duration while we are increasing the number of idle
cycles but keep the idle duration constant in order to have a control on
the latency for the user interactivity. If you compare the idle
injection threads codes (powerclamp and cpuidle cooling device), you
will also notice they are very different in terms of implementation.

The combo cooling device collaborates with the cpufreq cooling device
and reuses the DT binding, and finally it uses the power information
provided in the DT. The idle injection is a brick to the combo cooling
device.

Initially I thought we should refactor the intel_powerclamp but it
appears the combo cooling device reuses the cpufreq and cpuidle cooling
device, making sense to have them all in a single file and evolving to a
single cooling device with different strategies.



>> Daniel Lezcano (7):
>>   thermal/drivers/cpu_cooling: Fixup the header and copyright
>>   thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
>>   thermal/drivers/cpu_cooling: Remove pointless field
>>   thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
>>   thermal/drivers/cpu_cooling: Add idle cooling device documentation
>>   thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
>>   cpuidle/drivers/cpuidle-arm: Register the cooling device
>>
>>  Documentation/thermal/cpu-idle-cooling.txt | 165 ++++++++++
>>  drivers/cpuidle/cpuidle-arm.c              |   5 +
>>  drivers/thermal/Kconfig                    |  30 +-
>>  drivers/thermal/cpu_cooling.c              | 480 +++++++++++++++++++++++++++--
>>  include/linux/cpu_cooling.h                |  15 +-
>>  5 files changed, 668 insertions(+), 27 deletions(-)
>>  create mode 100644 Documentation/thermal/cpu-idle-cooling.txt
>>
>> -- 
>> 2.7.4
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
