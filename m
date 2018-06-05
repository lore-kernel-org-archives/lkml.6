Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeFEReb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:34:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43515 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeFERe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:34:29 -0400
X-Google-Smtp-Source: ADUXVKKVJKdIDw87UyMao9HsAigx0SONYuZZdkH/Xvz3Xvywtnwm5zyIE1EFlJLi56hi9Xl0Mw+l5Q==
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, phil.edworthy@renesas.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        linux-arm-kernel@lists.infradead.org
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
Date: Tue, 5 Jun 2018 10:34:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 04:28, Michel Pollet wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/smp-r9a06g032.c | 79 ++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
> 
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index 1939f52..d7fc98f 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
>  smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
> +smp-$(CONFIG_ARCH_R9A06G032)	+= smp-r9a06g032.o
>  smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
>  
>  # PM objects
> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c b/arch/arm/mach-shmobile/smp-r9a06g032.c
> new file mode 100644
> index 0000000..cd40e6e
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * R9A06G032 Second CA7 enabler.
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + * Derived from action,s500-smp
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/smp.h>
> +
> +/*
> + * The second CPU is parked in ROM at boot time. It requires waking it after
> + * writing an address into the BOOTADDR register of sysctrl.
> + *
> + * So the default value of the "cpu-release-addr" corresponds to BOOTADDR...
> + *
> + * *However* the BOOTADDR register is not available when the kernel
> + * starts in NONSEC mode.
> + *
> + * So for NONSEC mode, the bootloader re-parks the second CPU into a pen
> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a SRAM address,
> + * which is not restricted.

The binding document for cpu-release-addr does not have a definition for 32 bit
arm.  The existing definition is only 64 bit arm.  Please add the definition
for 32 bit arm to patch 1.

-Frank


> + */
> +
> +static void __iomem *cpu_bootaddr;
> +
> +static DEFINE_SPINLOCK(cpu_lock);
> +
> +static int r9a06g032_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	if (!cpu_bootaddr)
> +		return -ENODEV;
> +
> +	spin_lock(&cpu_lock);
> +
> +	writel(__pa_symbol(secondary_startup), cpu_bootaddr);
> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +	spin_unlock(&cpu_lock);
> +
> +	return 0;
> +}
> +
> +static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *dn;
> +	int ret;
> +	u32 bootaddr;
> +
> +	dn = of_get_cpu_node(1, NULL);
> +	if (!dn) {
> +		pr_err("CPU#1: missing device tree node\n");
> +		return;
> +	}
> +	/*
> +	 * Determine the address from which the CPU is polling.
> +	 * The bootloader *does* change this property
> +	 */
> +	ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
> +	of_node_put(dn);
> +	if (ret) {
> +		pr_err("CPU#1: invalid cpu-release-addr property\n");
> +		return;
> +	}
> +	pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
> +
> +	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
> +}
> +
> +static const struct smp_operations r9a06g032_smp_ops __initconst = {
> +	.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
> +	.smp_boot_secondary = r9a06g032_smp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(r9a06g032_smp, "renesas,r9a06g032-smp", &r9a06g032_smp_ops);
> 
