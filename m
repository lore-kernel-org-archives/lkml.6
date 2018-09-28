Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9001F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9001F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeI1ULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:11:05 -0400
Received: from foss.arm.com ([217.140.101.70]:50484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbeI1ULE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:11:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26511596;
        Fri, 28 Sep 2018 06:47:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44353F5B7;
        Fri, 28 Sep 2018 06:47:10 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:47:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] firmware/psci: Fix cpu_resume entry points with
 THUMB2_KERNEL
Message-ID: <20180928134704.deonmn5hozam74tz@lakrids.cambridge.arm.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <20180927192711.26455-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927192711.26455-2-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:27:09PM -0700, Florian Fainelli wrote:
> When THUMB2_KERNEL is enabled, we would be failing to resume from an
> idle or system suspend call where the reentry point is set to
> cpu_resume() because that function is in Thumb2. Utilize
> cpu_resume_arm() for ARM 32-bit kernels which takes care of the mode
> switching for us.

Looking at the PSCI spec, if bit[0] of the entry point address is set,
the CPU should be placed into thumb state.

So either there's a FW bug here, or perhaps we're stripping bit[0] when
we do the __pa_symbol() dance.

Which firmware have you seen this with?

Thanks,
Mark.

> Fixes: 8b6f2499ac45 ("ARM: 8511/1: ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware")
> Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/firmware/psci.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c80ec1d03274..f8b154384483 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -400,9 +400,14 @@ int psci_cpu_init_idle(unsigned int cpu)
>  static int psci_suspend_finisher(unsigned long index)
>  {
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	unsigned long reentry;
>  
> -	return psci_ops.cpu_suspend(state[index - 1],
> -				    __pa_symbol(cpu_resume));
> +#ifdef CONFIG_ARM
> +	reentry = __pa_symbol(cpu_resume_arm);
> +#else
> +	reentry = __pa_symbol(cpu_resume);
> +#endif
> +	return psci_ops.cpu_suspend(state[index - 1], reentry);
>  }
>  
>  int psci_cpu_suspend_enter(unsigned long index)
> @@ -437,8 +442,15 @@ CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
>  
>  static int psci_system_suspend(unsigned long unused)
>  {
> +	unsigned long reentry;
> +
> +#ifdef CONFIG_ARM
> +	reentry = __pa_symbol(cpu_resume_arm);
> +#else
> +	reentry = __pa_symbol(cpu_resume);
> +#endif
>  	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
> -			      __pa_symbol(cpu_resume), 0, 0);
> +			      reentry, 0, 0);
>  }
>  
>  static int psci_system_suspend_enter(suspend_state_t state)
> -- 
> 2.17.1
> 
