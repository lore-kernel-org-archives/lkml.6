Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBWFYX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:24:23 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36599 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:24:21 -0500
X-Google-Smtp-Source: AH8x225159zi8Mn3kOI/sPO66UoxgfoSg4KzfmBo/s9pf8ea/3KCMrr/oQX6l5w23JXcbrmyyu8oeg==
Date: Fri, 23 Feb 2018 10:54:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 4/7] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20180223052416.GE26947@vireshk-i7>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-5-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519226968-19821-5-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-18, 16:29, Daniel Lezcano wrote:
> The next changes will add new way to cool down a CPU. In order to
> sanitize and make the overall cpu cooling code consistent and robust
> we must prevent the cpu cooling devices to co-exists with the same
> purpose at the same time in the kernel.
> 
> Make the CPU cooling device a choice in the Kconfig, so only one CPU
> cooling strategy can be chosen.

Daniel T. already raised his concern (which I share too) about the
multi-platform builds, where we would want this to be runtime
selectable. I am fine with your approach of making that possible later
on, but I would really like that to be merged before the combo thing
comes in. So, I would suggest to merge stuff in this order:

- this series
- runtime selectable strategy
- combo stuff

I hope that would be fine ?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig       | 20 +++++++++++++++++---
>  drivers/thermal/cpu_cooling.c |  2 ++
>  include/linux/cpu_cooling.h   |  6 +++---
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b6adc54..5aaae1b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
>  	  allocating and limiting power to devices.
>  
>  config CPU_THERMAL
> -	bool "generic cpu cooling support"
> -	depends on CPU_FREQ
> +	bool "Generic cpu cooling support"
>  	depends on THERMAL_OF
>  	help
> +	  Enable the CPU cooling features. If the system has no active
> +	  cooling device available, this option allows to use the CPU
> +	  as a cooling device.
> +
> +choice
> +	prompt "CPU cooling strategies"
> +	depends on CPU_THERMAL
> +	default CPU_FREQ_THERMAL
> +	help
> +	  Select the CPU cooling strategy.
> +
> +config CPU_FREQ_THERMAL
> +        bool "CPU frequency cooling strategy"
> +	depends on CPU_FREQ
> +	help
>  	  This implements the generic cpu cooling mechanism through frequency
>  	  reduction. An ACPI version of this already exists
>  	  (drivers/acpi/processor_thermal.c).
>  	  This will be useful for platforms using the generic thermal interface
>  	  and not the ACPI interface.
>  
> -	  If you want this support, you should say Y here.

Should this line be moved to the CPU_THERMAL section above ?

> +endchoice
>  
>  config CLOCK_THERMAL
>  	bool "Generic clock cooling support"
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 7bdc19f..5c219dc 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -22,6 +22,7 @@
>  
>  #include <trace/events/thermal.h>
>  
> +#ifdef CONFIG_CPU_FREQ_THERMAL
>  /*
>   * Cooling state <-> CPUFreq frequency
>   *
> @@ -926,3 +927,4 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> +#endif /* CONFIG_CPU_FREQ_THERMAL */
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index d4292eb..c0accc7 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -33,7 +33,7 @@ struct cpufreq_policy;
>  typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
>  			    unsigned long voltage, u32 *power);
>  
> -#ifdef CONFIG_CPU_THERMAL
> +#ifdef CONFIG_CPU_FREQ_THERMAL
>  /**
>   * cpufreq_cooling_register - function to create cpufreq cooling device.
>   * @policy: cpufreq policy.
> @@ -84,7 +84,7 @@ of_cpufreq_power_cooling_register(struct device_node *np,
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
>  
> -#else /* !CONFIG_CPU_THERMAL */
> +#else /* !CONFIG_CPU_FREQ_THERMAL */
>  static inline struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> @@ -118,6 +118,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
>  	return;
>  }
> -#endif	/* CONFIG_CPU_THERMAL */
> +#endif	/* CONFIG_CPU_FREQ_THERMAL */
>  
>  #endif /* __CPU_COOLING_H__ */

drivers/cpufreq/Kconfig:        # if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
drivers/cpufreq/Kconfig:        depends on !CPU_THERMAL || THERMAL
drivers/cpufreq/Kconfig:        depends on !CPU_THERMAL || THERMAL
drivers/cpufreq/Kconfig.arm:    # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
drivers/cpufreq/Kconfig.arm:    depends on !CPU_THERMAL || THERMAL
drivers/cpufreq/Kconfig.arm:    depends on !CPU_THERMAL || THERMAL

All of these need to use CPU_FREQ_THERMAL now.

include/trace/events/thermal.h:#ifdef CONFIG_CPU_THERMAL
include/trace/events/thermal.h:#endif /* CONFIG_CPU_THERMAL */

And this too.

-- 
viresh
