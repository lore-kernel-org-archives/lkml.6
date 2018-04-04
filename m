Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDDNBy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:01:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44188 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDDNBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:01:52 -0400
Subject: Re: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-8-mylene.josserand@bootlin.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
Date: Wed, 4 Apr 2018 14:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403061836.3926-8-mylene.josserand@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On 03/04/18 07:18, Mylène Josserand wrote:
> The CNTVOFF register from arch timer is uninitialized.
> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
> 
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized. Because this code can
> be used by different platforms, add this assembly file in ARM's common
> folder.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/common/Makefile           |  1 +
>  arch/arm/common/smp_cntvoff.S      | 35 +++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/smp_cntvoff.h |  8 ++++++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm/common/smp_cntvoff.S
>  create mode 100644 arch/arm/include/asm/smp_cntvoff.h
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 70b4a14ed993..83117deb86c8 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
>  obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
>  obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
> +obj-$(CONFIG_SMP)		+= smp_cntvoff.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
>  CFLAGS_REMOVE_mcpm_entry.o	= -pg
> diff --git a/arch/arm/common/smp_cntvoff.S b/arch/arm/common/smp_cntvoff.S
> new file mode 100644
> index 000000000000..65ed199a50fe
> --- /dev/null
> +++ b/arch/arm/common/smp_cntvoff.S
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Chen-Yu Tsai
> + * Copyright (c) 2018 Bootlin
> + *
> + * Chen-Yu Tsai <wens@csie.org>
> + * Mylène Josserand <mylene.josserand@bootlin.com>

Given that this is literally lifted from shmobile_init_cntvoff, the
whole attribution is a bit dubious.

> + *
> + * SMP support for sunxi based systems with Cortex A7/A15

That's not restricted to sunxi, is it?

> + *
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +ENTRY(smp_init_cntvoff)

The name doesn't quite reflect the usage constraints. This will only
work if used from secure, and is UNPREDICTABLE otherwise (see the CPS
instruction). Also, the "smp" prefix is quite misleading, as it only
affects the current CPU, and not any other.

How about secure_cntvoff_init instead? Same thing for the file name.

> +	.arch	armv7-a
> +	/*
> +	 * CNTVOFF has to be initialized either from non-secure Hypervisor
> +	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
> +	 * then it should be handled by the secure code
> +	 */
> +	cps	#MON_MODE
> +	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
> +	orr	r0, r1, #1
> +	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
> +	isb
> +	mov	r0, #0
> +	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
> +	isb
> +	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
> +	isb
> +	cps	#SVC_MODE
> +	ret	lr
> +ENDPROC(smp_init_cntvoff)
> diff --git a/arch/arm/include/asm/smp_cntvoff.h b/arch/arm/include/asm/smp_cntvoff.h
> new file mode 100644
> index 000000000000..59a95f7604ee
> --- /dev/null
> +++ b/arch/arm/include/asm/smp_cntvoff.h
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __ASMARM_ARCH_CNTVOFF_H
> +#define __ASMARM_ARCH_CNTVOFF_H
> +
> +extern void smp_init_cntvoff(void);
> +
> +#endif
> 

It'd be good to take this opportunity to refactor the shmobile code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
