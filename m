Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030517AbeEXRjj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:39:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34815 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEXRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:39:30 -0400
X-Google-Smtp-Source: AB8JxZozTKFYijzbvtamWVWgxrrUWVT03TZyFBWnoBvI+5xz+8C8EzW2ywB9ZlAjZdOyY39rCCoadw==
Date: Thu, 24 May 2018 10:39:26 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v9 01/15] ARM: Add Krait L2 register accessor functions
Message-ID: <20180524173926.GC14924@minitux>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Mar 06:38 PST 2018, Sricharan R wrote:

> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Krait CPUs have a handful of L2 cache controller registers that
> live behind a cp15 based indirection register. First you program
> the indirection register (l2cpselr) to point the L2 'window'
> register (l2cpdr) at what you want to read/write.  Then you
> read/write the 'window' register to do what you want. The
> l2cpselr register is not banked per-cpu so we must lock around
> accesses to it to prevent other CPUs from re-pointing l2cpdr
> underneath us.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This should have your signed-off-by here as well.

Apart from that:

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/common/Kconfig                   |  3 ++
>  arch/arm/common/Makefile                  |  1 +
>  arch/arm/common/krait-l2-accessors.c      | 48 +++++++++++++++++++++++++++++++
>  arch/arm/include/asm/krait-l2-accessors.h | 10 +++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 arch/arm/common/krait-l2-accessors.c
>  create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
> 
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index e5ad070..c8e1986 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -7,6 +7,9 @@ config DMABOUNCE
>  	bool
>  	select ZONE_DMA
>  
> +config KRAIT_L2_ACCESSORS
> +	bool
> +
>  config SHARP_LOCOMO
>  	bool
>  
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 70b4a14..eec6cd1 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -7,6 +7,7 @@ obj-y				+= firmware.o
>  
>  obj-$(CONFIG_SA1111)		+= sa1111.o
>  obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
> +obj-$(CONFIG_KRAIT_L2_ACCESSORS) += krait-l2-accessors.o
>  obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
>  obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
> diff --git a/arch/arm/common/krait-l2-accessors.c b/arch/arm/common/krait-l2-accessors.c
> new file mode 100644
> index 0000000..9a97dda
> --- /dev/null
> +++ b/arch/arm/common/krait-l2-accessors.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include <linux/spinlock.h>
> +#include <linux/export.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/krait-l2-accessors.h>
> +
> +static DEFINE_RAW_SPINLOCK(krait_l2_lock);
> +
> +void krait_set_l2_indirect_reg(u32 addr, u32 val)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&krait_l2_lock, flags);
> +	/*
> +	 * Select the L2 window by poking l2cpselr, then write to the window
> +	 * via l2cpdr.
> +	 */
> +	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
> +	isb();
> +	asm volatile ("mcr p15, 3, %0, c15, c0, 7 @ l2cpdr" : : "r" (val));
> +	isb();
> +
> +	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
> +}
> +EXPORT_SYMBOL(krait_set_l2_indirect_reg);
> +
> +u32 krait_get_l2_indirect_reg(u32 addr)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&krait_l2_lock, flags);
> +	/*
> +	 * Select the L2 window by poking l2cpselr, then read from the window
> +	 * via l2cpdr.
> +	 */
> +	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
> +	isb();
> +	asm volatile ("mrc p15, 3, %0, c15, c0, 7 @ l2cpdr" : "=r" (val));
> +
> +	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(krait_get_l2_indirect_reg);
> diff --git a/arch/arm/include/asm/krait-l2-accessors.h b/arch/arm/include/asm/krait-l2-accessors.h
> new file mode 100644
> index 0000000..dd7c474
> --- /dev/null
> +++ b/arch/arm/include/asm/krait-l2-accessors.h
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#ifndef __ASMARM_KRAIT_L2_ACCESSORS_H
> +#define __ASMARM_KRAIT_L2_ACCESSORS_H
> +
> +extern void krait_set_l2_indirect_reg(u32 addr, u32 val);
> +extern u32 krait_get_l2_indirect_reg(u32 addr);
> +
> +#endif
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
