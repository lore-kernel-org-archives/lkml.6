Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E483C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B942087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B942087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJHU3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:29:18 -0400
Received: from foss.arm.com ([217.140.101.70]:50122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbeJHU3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:29:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B987ED1;
        Mon,  8 Oct 2018 06:17:37 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091433F5B7;
        Mon,  8 Oct 2018 06:17:34 -0700 (PDT)
Subject: Re: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <Mark.Rutland@arm.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
 <20181008125009.3721-5-m.szyprowski@samsung.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
Date:   Mon, 8 Oct 2018 14:17:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008125009.3721-5-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark Rutland

Hi Marek,

On 08/10/18 13:50, Marek Szyprowski wrote:
> Use common infrastructure for ARM Architected Timers erratum to enable
> support for systems with broken CPU firmware (timer registers not
> properly configured). This mode has been already availabled on ARM
> (32bits) architecture. This enables to run Linux kernel on ARM64 boards
> using physical architected timers instead of the virtual ones. Examples
> of such system with broken firmware are Samsung Exynos5433 SoC based
> TM2(e) boards, which is already deployed for years and updating firmware
> is not possible.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/clocksource/Kconfig          | 11 +++++++++++
>   drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
>   2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a11f4ba98b05..a30752579b03 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>   	  The workaround will be dynamically enabled when an affected
>   	  core is detected.
>   
> +config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
> +	bool "Workaround for arch timer registers not configured by firmware"
> +	default y
> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
> +	depends on ARM_ARCH_TIMER && ARM64
> +	help
> +	  This option enables a workaround for boards, on which arch timer
> +	  registers are not properly configured by the board firmware.
> +	  The workaround will be dynamically enabled when an affected
> +	  board is detected.
> +

I'm sorry, but I'm strongly pushing back on this.

This horrible hack was accepted with the express condition that it would 
be limited to ARMv7 platforms (on the ground that we never really 
documented the arch timer boot requirements on that version of the 
architecture), and would never proliferate on arm64. From day 1, we 
established what the boot protocol was, and we mandated that either:

- kernel is entered at EL2 on all CPUs
- cntvoff_el2 is zeroed on all CPUs

and we've got most people to fix their firmware, or live with the 
consequences. If these machines cannot receive a non-broken firmware, 
what are the odds that they will receive a mainline kernel?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
