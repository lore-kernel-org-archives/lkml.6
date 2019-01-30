Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8B7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1F2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfA3Xy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:54:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53572 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA3Xy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:54:28 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 46bfe9b463a924f0; Thu, 31 Jan 2019 00:54:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Taniya Das <tdas@codeaurora.org>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date:   Thu, 31 Jan 2019 00:53:19 +0100
Message-ID: <4397205.6VUyJNULaB@aspire.rjw.lan>
In-Reply-To: <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org> <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548737236.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 29, 2019 5:55:07 AM CET Amit Kucheria wrote:
> The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
> driver to register as a cooling device and cool down the platform by
> throttling the CPU frequency. In order to be able to auto-register a
> cpufreq driver as a cooling device from the cpufreq core, we need access
> to code inside cpu_cooling.c which, in turn, accesses code inside
> thermal core.
> 
> CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
> (e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
> CONFIG_CPU_FREQ is compiled in. This leads to following error:
> 
> drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
> cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
> drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
> cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'
> 
> Given that platforms using CPU_THERMAL usually want it compiled-in so it
> is available early in boot, make CPU_THERMAL depend on THERMAL being
> compiled-in instead of allowing it to be a module.
> 
> As a result of this change, get rid of the ugly (!CPU_THERMAL ||
> THERMAL) dependency in all cpufreq drivers using CPU_THERMAL.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig     | 3 ---
>  drivers/cpufreq/Kconfig.arm | 5 -----
>  drivers/thermal/Kconfig     | 1 +
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 608af20a3494..b22e6bba71f1 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -207,8 +207,6 @@ comment "CPU frequency scaling drivers"
>  config CPUFREQ_DT
>  	tristate "Generic DT based cpufreq driver"
>  	depends on HAVE_CLK && OF
> -	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> -	depends on !CPU_THERMAL || THERMAL
>  	select CPUFREQ_DT_PLATDEV
>  	select PM_OPP
>  	help
> @@ -327,7 +325,6 @@ endif
>  config QORIQ_CPUFREQ
>  	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>  	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
> -	depends on !CPU_THERMAL || THERMAL
>  	select CLK_QORIQ
>  	help
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 688f10227793..ca8567c3152c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -29,8 +29,6 @@ config ARM_ARMADA_37XX_CPUFREQ
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
>  	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
> -	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> -	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
>  	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> @@ -38,7 +36,6 @@ config ARM_BIG_LITTLE_CPUFREQ
>  config ARM_SCPI_CPUFREQ
>  	tristate "SCPI based CPUfreq driver"
>  	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> -	depends on !CPU_THERMAL || THERMAL
>  	help
>  	  This adds the CPUfreq driver support for ARM platforms using SCPI
>  	  protocol for CPU power management.
> @@ -93,7 +90,6 @@ config ARM_KIRKWOOD_CPUFREQ
>  config ARM_MEDIATEK_CPUFREQ
>  	tristate "CPU Frequency scaling support for MediaTek SoCs"
>  	depends on ARCH_MEDIATEK && REGULATOR
> -	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
>  	  This adds the CPUFreq driver support for MediaTek SoCs.
> @@ -233,7 +229,6 @@ config ARM_SA1110_CPUFREQ
>  config ARM_SCMI_CPUFREQ
>  	tristate "SCMI based CPUfreq driver"
>  	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> -	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
>  	  This adds the CPUfreq driver support for ARM platforms using SCMI
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 30323426902e..58bb7d72dc2b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -152,6 +152,7 @@ config CPU_THERMAL
>  	bool "generic cpu cooling support"
>  	depends on CPU_FREQ
>  	depends on THERMAL_OF
> +	depends on THERMAL=y
>  	help
>  	  This implements the generic cpu cooling mechanism through frequency
>  	  reduction. An ACPI version of this already exists
> 

Applied, thanks!


