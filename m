Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeEHK55 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:57:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50976 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeEHK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:57:55 -0400
Date: Tue, 8 May 2018 11:57:32 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: maxime.ripard@bootlin.com, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/11] ARM: smp: Add initialization of CNTVOFF
Message-ID: <20180508105732.GZ16141@n2100.armlinux.org.uk>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
 <20180420211022.11759-6-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420211022.11759-6-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:10:16PM +0200, Mylène Josserand wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/common/Makefile              |  1 +
>  arch/arm/common/secure_cntvoff.S      | 31 +++++++++++++++++++++++++++++++
>  arch/arm/include/asm/secure_cntvoff.h |  8 ++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/common/secure_cntvoff.S
>  create mode 100644 arch/arm/include/asm/secure_cntvoff.h
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 70b4a14ed993..1e9f7af8f70f 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
>  obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
>  obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
> +obj-$(CONFIG_SMP)		+= secure_cntvoff.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
>  CFLAGS_REMOVE_mcpm_entry.o	= -pg
> diff --git a/arch/arm/common/secure_cntvoff.S b/arch/arm/common/secure_cntvoff.S
> new file mode 100644
> index 000000000000..68a4a8344319
> --- /dev/null
> +++ b/arch/arm/common/secure_cntvoff.S
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0

For assembly files, the SPDX specifier is of this format:

/* SPDX-License-Identifier: <SPDX License Expression> */

Please see Documentation/process/license-rules.rst for more
information, and fix your specifier to conform to the requirements.
Thanks.

> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + *
> + * Initialization of CNTVOFF register from secure mode
> + *
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +ENTRY(secure_cntvoff_init)
> +	.arch	armv7-a
> +	/*
> +	 * CNTVOFF has to be initialized either from non-secure Hypervisor
> +	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
> +	 * then it should be handled by the secure code

This should also state that this code must not be executed if
virtualisation extensions are not present (which should be obvious)
as the mcrr instruction becomes unpredictable in that case.

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
> +ENDPROC(secure_cntvoff_init)
> diff --git a/arch/arm/include/asm/secure_cntvoff.h b/arch/arm/include/asm/secure_cntvoff.h
> new file mode 100644
> index 000000000000..1f93aee1f630
> --- /dev/null
> +++ b/arch/arm/include/asm/secure_cntvoff.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This one conforms.

> +
> +#ifndef __ASMARM_ARCH_CNTVOFF_H
> +#define __ASMARM_ARCH_CNTVOFF_H
> +
> +extern void secure_cntvoff_init(void);
> +
> +#endif
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
