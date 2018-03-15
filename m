Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeCOO6M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:58:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeCOO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:58:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3438060134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Allow LPIs to be disabled from the
 command line
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
 <20180313172103.24281-4-marc.zyngier@arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <f3fee732-2c07-e303-4ec2-2d79668b868e@codeaurora.org>
Date: Thu, 15 Mar 2018 09:58:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180313172103.24281-4-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 03/13/2018 12:21 PM, Marc Zyngier wrote:
> For most GICv3 implementations, enabling LPIs is a one way switch.
> Once they're on, there is no turning back, which completely kills
> kexec (pending tables will always be live, and we can't tell the
> secondary kernel where they are).
> 
> This is really annoying if you plan to use Linux as a bootloader,
> as it pretty much guarantees that the secondary kernel won't be
> able to use MSIs, and may even see some memory corruption. Bad.
> 
> A workaround for this unfortunate situation is to allow the kernel
> not to enable LPIs, even if the feature is present in the HW. This
> would allow Linux-as-a-bootloader to leave LPIs alone, and let the
> secondary kernel to do whatever it wants with them.
> 
> Let's introduce a boolean "irqchip.gicv3_nolpi" command line option
> that serves that purpose.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  drivers/irqchip/irq-gic-v3.c                    | 10 +++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1d1d53f85ddd..60130231db3b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1743,6 +1743,14 @@
>  			of a GICv2 controller even if the memory range
>  			exposed by the device tree is too small.
>  
> +	irqchip.gicv3_nolpi=
> +			[ARM, ARM64]
> +			Force the kernel to ignore the availability of
> +			LPIs (and by consequence ITSs). Intended for system
> +			that use the kernel as a bootloader, and thus want
> +			to let secondary kernels in charge of setting up
> +			LPIs.
> +
>  	irqfixup	[HW]
>  			When an interrupt is not handled search all handlers
>  			for it. Intended to get systems with badly broken
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 0ea02504115d..3e9eeb6cb294 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -613,9 +613,17 @@ static void gic_cpu_sys_reg_init(void)
>  		pr_crit_once("RSS is required but GICD doesn't support it\n");
>  }
>  
> +static bool gicv3_nolpi;
> +
> +static int __init gicv3_nolpi_cfg(char *buf)
> +{
> +	return strtobool(buf, &gicv3_nolpi);
> +}
> +early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
> +
>  static int gic_dist_supports_lpis(void)
>  {
> -	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
> +	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;

Thanks for this patch series especially for KDUMP case. It would be nice if we disable GIC-ITS and
GICR-LPI functionality completely to avoid in flight LPIs which were triggered by first kernel.

  
>  }
>  
>  static void gic_cpu_init(void)
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
