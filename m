Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeCQNez (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 09:34:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40450 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeCQNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 09:34:54 -0400
Date: Sat, 17 Mar 2018 13:34:45 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>
Subject: Re: [PATCH v2] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
Message-ID: <20180317133445.772733ac@why.wild-wind.fr.eu.org>
In-Reply-To: <1521124287-25009-1-git-send-email-shankerd@codeaurora.org>
References: <1521124287-25009-1-git-send-email-shankerd@codeaurora.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 09:31:27 -0500
Shanker Donthineni <shankerd@codeaurora.org> wrote:

> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> Changes since v1:
>   -Moved LPI disable code to a seperate function as Marc suggested.
>   -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.
>   
>  drivers/irqchip/irq-gic-v3-its.c   | 66 ++++++++++++++++++++++++++++++--------
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1d3056f..cba71a7 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -33,6 +33,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
> +#include <linux/time64.h>
> +#include <linux/iopoll.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> @@ -1875,16 +1877,6 @@ static void its_cpu_init_lpis(void)
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
> @@ -3288,13 +3280,59 @@ static bool gic_rdists_supports_plpis(void)
>  	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
>  }
>  
> +static int redist_disable_lpis(void)
> +{
> +	void __iomem *rbase = gic_data_rdist_rd_base();
> +	u64 val;
> +	int ret;
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
> +	/* Disable LPIs */
> +	val &= ~GICR_CTLR_ENABLE_LPIS;
> +	writel_relaxed(val, rbase + GICR_CTLR);
> +
> +	/* Make sure any change to GICR_CTLR is observable by the GIC */
> +	dsb(sy);
> +
> +	/* Wait for GICR_CTLR.GICR_CTLR_ENABLE_LPIS==0 or timeout */
> +	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
> +					 !(val & GICR_CTLR_ENABLE_LPIS), 1,
> +					 USEC_PER_SEC);

Why do you need to poll on EnableLPIs? It is supposed to be immediately
written. It seems to me that the sequence should be:

- Check EnableLPis
- If set to 1, scream about bootloader being braindead
- Write EnableLPIs to 0
- Read back EnableLpis:
- If still set 1, bail out, we're doomed. Scream about the HW being
  braindead
- Poll RWP
- If timeout, bail out, the HW has locked up. Scream again.

I think this should cover the whole thing. An alternative would be to
place the poll between the write and read-back, but that doesn't change
anything.

> +	if (ret) {
> +		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
> +		return -EBUSY;
> +	}
> +
> +	/* Wait for GICR_CTLR.RWP==0 or timeout */
> +	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
> +					 !(val & GICR_CTLR_RWP), 1,
> +					 USEC_PER_SEC);
> +	if (ret) {
> +		pr_err("CPU%d: Failed to observe RWP==0 after enabling LPIs\n",
> +		       smp_processor_id());
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  int its_cpu_init(void)
>  {
> +	int ret;
> +
>  	if (!list_empty(&its_nodes)) {

nit: move 'ret' here.

> -		if (!gic_rdists_supports_plpis()) {
> -			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
> -			return -ENXIO;
> -		}
> +		ret = redist_disable_lpis();
> +		if (ret)
> +			return ret;
> +
>  		its_cpu_init_lpis();
>  		its_cpu_init_collection();
>  	}
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index c00c4c33..4d5fb60 100644
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

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
