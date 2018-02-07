Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeBGJEy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:04:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42773 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeBGJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:04:52 -0500
X-Google-Smtp-Source: AH8x227cmwCw1sD+qS19cF4V0Upro4Qz5UveUfxRczoLYTto+2Dqsc/ExYGj6jKWklMMAxsMmfxe8Q==
Date: Wed, 7 Feb 2018 14:34:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20180207090448.GP28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18, 16:34, Daniel Lezcano wrote:
> The next changes will add new way to cool down a CPU. In order to
> sanitize and make the overall cpu cooling code consistent and robust
> we must prevent the cpu cooling devices to co-exists with the same
> purpose at the same time in the kernel.
> 
> Make the CPU cooling device a choice in the Kconfig, so only one CPU
> cooling strategy can be chosen.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 315ae29..925e73b 100644
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

Perhaps you should start using this macro in code in this patch
itself.

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
> +endchoice
>  
>  config CLOCK_THERMAL
>  	bool "Generic clock cooling support"
> -- 
> 2.7.4

-- 
viresh
