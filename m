Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCVPvV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:51:21 -0400
Received: from foss.arm.com ([217.140.101.70]:39426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbeCVPvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:51:18 -0400
Subject: Re: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
To: Shanker Donthineni <shankerd@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
Date: Thu, 22 Mar 2018 15:51:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/18 01:58, Shanker Donthineni wrote:
> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> Changes since v2:
>   -Revert readl_relaxed_poll() usage since it's not usable in GICv3 probe().
>   -Changes to pr_xxx messages.
> 
> Changes since v1:
>   -Moved LPI disable code to a seperate function as Marc suggested.
>   -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.
> 
>  drivers/irqchip/irq-gic-v3-its.c   | 75 +++++++++++++++++++++++++++++++-------
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 2cbb19c..c1e8a8e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -33,6 +33,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
> +#include <linux/time64.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v3.h>

This hunk doesn't apply to my -next branch, but I don't think it is
actually required either...

> @@ -1875,16 +1876,6 @@ static void its_cpu_init_lpis(void)
>  		gic_data_rdist()->pend_page = pend_page;
>  	}
>  
> -	/* Disable LPIs */
> -	val = readl_relaxed(rbase + GICR_CTLR);
> -	val &= ~GICR_CTLR_ENABLE_LPIS;
> -	writel_relaxed(val, rbase + GICR_CTLR);
> -
> -	/*
> -	 * Make sure any change to the table is observable by the GIC.
> -	 */
> -	dsb(sy);
> -
>  	/* set PROPBASE */
>  	val = (page_to_phys(gic_rdists->prop_page) |
>  	       GICR_PROPBASER_InnerShareable |
> @@ -3287,13 +3278,69 @@ static bool gic_rdists_supports_plpis(void)
>  	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
>  }
>  
> +static int redist_disable_lpis(void)
> +{
> +	void __iomem *rbase = gic_data_rdist_rd_base();
> +	u64 timeout = USEC_PER_SEC;
> +	u64 val;
> +
> +	if (!gic_rdists_supports_plpis()) {
> +		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
> +		return -ENXIO;
> +	}
> +
> +	val = readl_relaxed(rbase + GICR_CTLR);
> +	if (!(val & GICR_CTLR_ENABLE_LPIS))
> +		return 0;
> +
> +	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
> +		smp_processor_id());
> +	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> +
> +	/* Disable LPIs */
> +	val &= ~GICR_CTLR_ENABLE_LPIS;
> +	writel_relaxed(val, rbase + GICR_CTLR);
> +
> +	/* Make sure any change to GICR_CTLR is observable by the GIC */
> +	dsb(sy);
> +
> +	/**
> +	 * Software must observe RWP==0 after clearing GICR_CTLR.EnableLPIs
> +	 * from 1 to 0 before programming GICR_PEND{PROP}BASER registers.
> +	 * Bail out the driver probe() in case of timeout.
> +	 */
> +	while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
> +		if (!timeout) {
> +			pr_err("CPU%d: Failed to observe RWP==0 after disabling LPIs\n",

I think you can simplify the message with something like:

	"Time-out disabling LPIs\n"

Nobody apart from you and I really want to know about RWP...

> +			       smp_processor_id());
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +		timeout--;
> +	}
> +
> +	/**
> +	 * After it has been written to 1, it is IMPLEMENTATION DEFINED whether
> +	 * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to 0.
> +	 * Bail out the driver probe() on systems where it's RES1.
> +	 */
> +	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
> +		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  int its_cpu_init(void)
>  {
>  	if (!list_empty(&its_nodes)) {
> -		if (!gic_rdists_supports_plpis()) {
> -			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
> -			return -ENXIO;
> -		}
> +		int ret;
> +
> +		ret = redist_disable_lpis();
> +		if (ret)
> +			return ret;

Just realised that this is totally broken.

Why do we have this in the loop? Checking the LPI support for each ITS
was admittedly braindead (we only need to check it once per CPU), but
now trying to disable the LPIs each time we encounter an ITS is going to
make it go crazy and taint the kernel for no reason.

> +
>  		its_cpu_init_lpis();
>  		its_cpu_init_collection();
>  	}
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index b26eccc..c6f4c48 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -106,6 +106,7 @@
>  #define GICR_PIDR2			GICD_PIDR2
>  
>  #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
> +#define GICR_CTLR_RWP			(1UL << 3)
>  
>  #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
>  
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
