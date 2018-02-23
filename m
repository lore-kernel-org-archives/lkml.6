Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBWJLF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:11:05 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40364 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBWJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:11:02 -0500
X-Google-Smtp-Source: AG47ELtmy2UEvz6jNO5D/ppCUMfiQC57/ZiM12cAx58+2zL9+n8Ds4qMTrU9Lk3Y0u4dV9kr52ZyfQ==
Subject: Re: [PATCH V2 4/7] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-5-git-send-email-daniel.lezcano@linaro.org>
 <20180223052416.GE26947@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1dd1fe8a-d7e7-b4c7-9114-c9de41fc9284@linaro.org>
Date: Fri, 23 Feb 2018 10:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223052416.GE26947@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 06:24, Viresh Kumar wrote:
> On 21-02-18, 16:29, Daniel Lezcano wrote:
>> The next changes will add new way to cool down a CPU. In order to
>> sanitize and make the overall cpu cooling code consistent and robust
>> we must prevent the cpu cooling devices to co-exists with the same
>> purpose at the same time in the kernel.
>>
>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>> cooling strategy can be chosen.
> 
> Daniel T. already raised his concern (which I share too) about the
> multi-platform builds, where we would want this to be runtime
> selectable. I am fine with your approach of making that possible later
> on, but I would really like that to be merged before the combo thing
> comes in. So, I would suggest to merge stuff in this order:
> 
> - this series
> - runtime selectable strategy
> - combo stuff
> 
> I hope that would be fine ?

Yes, for me it is ok. So meanwhile we can also check the cpufreq cooling
device unregistering at suspend/resume/hotplug and hopefully that will
simplify the addition of the combo cooling device.


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig       | 20 +++++++++++++++++---
>>  drivers/thermal/cpu_cooling.c |  2 ++
>>  include/linux/cpu_cooling.h   |  6 +++---
>>  3 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index b6adc54..5aaae1b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
>>  	  allocating and limiting power to devices.
>>  
>>  config CPU_THERMAL
>> -	bool "generic cpu cooling support"
>> -	depends on CPU_FREQ
>> +	bool "Generic cpu cooling support"
>>  	depends on THERMAL_OF
>>  	help
>> +	  Enable the CPU cooling features. If the system has no active
>> +	  cooling device available, this option allows to use the CPU
>> +	  as a cooling device.
>> +
>> +choice
>> +	prompt "CPU cooling strategies"
>> +	depends on CPU_THERMAL
>> +	default CPU_FREQ_THERMAL
>> +	help
>> +	  Select the CPU cooling strategy.
>> +
>> +config CPU_FREQ_THERMAL
>> +        bool "CPU frequency cooling strategy"
>> +	depends on CPU_FREQ
>> +	help
>>  	  This implements the generic cpu cooling mechanism through frequency
>>  	  reduction. An ACPI version of this already exists
>>  	  (drivers/acpi/processor_thermal.c).
>>  	  This will be useful for platforms using the generic thermal interface
>>  	  and not the ACPI interface.
>>  
>> -	  If you want this support, you should say Y here.
> 
> Should this line be moved to the CPU_THERMAL section above ?
> 

Probably, I will double check it.

[ ... ]

>> -#endif	/* CONFIG_CPU_THERMAL */
>> +#endif	/* CONFIG_CPU_FREQ_THERMAL */
>>  
>>  #endif /* __CPU_COOLING_H__ */
> 
> drivers/cpufreq/Kconfig:        # if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> drivers/cpufreq/Kconfig:        depends on !CPU_THERMAL || THERMAL
> drivers/cpufreq/Kconfig:        depends on !CPU_THERMAL || THERMAL
> drivers/cpufreq/Kconfig.arm:    # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> drivers/cpufreq/Kconfig.arm:    depends on !CPU_THERMAL || THERMAL
> drivers/cpufreq/Kconfig.arm:    depends on !CPU_THERMAL || THERMAL
> 
> All of these need to use CPU_FREQ_THERMAL now>
> include/trace/events/thermal.h:#ifdef CONFIG_CPU_THERMAL
> include/trace/events/thermal.h:#endif /* CONFIG_CPU_THERMAL */

Ok.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
