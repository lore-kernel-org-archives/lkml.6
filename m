Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CF921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G+hixDN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfBAMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:44:23 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10034 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfBAMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:44:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c543ef50000>; Fri, 01 Feb 2019 04:43:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 04:44:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 04:44:15 -0800
Received: from [10.26.11.142] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 12:44:12 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
Date:   Fri, 1 Feb 2019 12:44:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201033621.16814-3-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549025013; bh=ExmvwM7XhJSLttWMoVXIQfFt7vVOAaLH3dfMWK45owM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G+hixDN+1CRcYtsH7X9zWudXlYPzGqYb4CBUk0yldDKTUcqdgfxIjHT1bVz2sw0YQ
         JqLTz5wtyqj2pszPS9ApEjsuRhhqu35J8e+BJpt/DD8TvfNkHhOgnx4gNfNW6o2gaa
         7oYZQdhS4TRjlUfFE+fflsgfjQwPy3vKOWt4ygxmgquF6sWvbyyExxAmw2g4t5g864
         1XdHV7iAUf8YLNzTQ3zgs5k9U5+x61T7jpZqQgiyry0UTSp3gBvABKAqinD67G1YIG
         qLjt/yXGP8oDJzEC4fzhCPzY1Wla7KG62i2kiZoroWA/tqbVMTpZlubxwQC1rnmyLB
         irwce0qwlm0jA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/02/2019 03:36, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
> 
> Also convert the original driver to use timer-of API.

It may have been nice to split this into 2 patches to make it easier to
see what is going on but not a big deal.

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v5:
>  * add ack tag from Thierry
> v4:
>  * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>  * use timer-of API
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig         |   2 +-
>  drivers/clocksource/timer-tegra20.c | 369 ++++++++++++++++++++--------
>  include/linux/cpuhotplug.h          |   1 +
>  3 files changed, 272 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..6af78534a285 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>  config TEGRA_TIMER
>  	bool "Tegra timer driver" if COMPILE_TEST
>  	select CLKSRC_MMIO
> -	depends on ARM
> +	select TIMER_OF
>  	help
>  	  Enables support for the Tegra driver.
>  
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
> index 4293943f4e2b..96a809341c9b 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -15,21 +15,24 @@
>   *
>   */
>  
> -#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/time.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/clockchips.h>
> -#include <linux/clocksource.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/sched_clock.h>
> -#include <linux/delay.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/time.h>
> +
> +#include "timer-of.h"
>  
> +#ifdef CONFIG_ARM
>  #include <asm/mach/time.h>
> +#endif
>  
>  #define RTC_SECONDS            0x08
>  #define RTC_SHADOW_SECONDS     0x0c
> @@ -43,70 +46,147 @@
>  #define TIMER2_BASE 0x8
>  #define TIMER3_BASE 0x50
>  #define TIMER4_BASE 0x58
> -
> -#define TIMER_PTV 0x0
> -#define TIMER_PCR 0x4
> -
> +#define TIMER10_BASE 0x90
> +
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +
> +#ifdef CONFIG_ARM
> +#define TIMER_BASE TIMER3_BASE
> +#else
> +#define TIMER_BASE TIMER10_BASE
> +#endif
> +#define TIMER10_IRQ_IDX		10
> +#define TIMER_FOR_CPU(cpu) (TIMER_BASE + (cpu) * 8)
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)

TIMER10_IRQ_IDX and IRQ_IDX_FOR_CPU are only applicable to ARM64 and so
we should probably not defined for ARM to avoid any confusion.

Furthermore, a lot of these TIMERx_BASE definitions are unused AFAICT.
Would be good to get rid of these.

Maybe we could just have ...

 +#ifdef CONFIG_ARM
 +#define TIMER_CPU0 3
 +#else
 +#define TIMER_CPU0 10
 +#endif
 +#define TIMER_BASE_FOR_CPU(cpu) ((TIMER_CPU0 + cpu) * 8)
 +#define TIMER_FOR_CPU(cpu) (TIMER_CPU0 + cpu)

Otherwise looks good to me.

Cheers
Jon

-- 
nvpublic
