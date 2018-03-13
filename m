Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbeCMNj7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:39:59 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:13231 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeCMNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:39:54 -0400
Subject: Re: [3/3] irqchip/gic-v3: Bounds check redistributor accesses
To: Punit Agrawal <punit.agrawal@arm.com>, <linux-kernel@vger.kernel.org>
CC: <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        "Menon, Nishanth" <nm@ti.com>
References: <20171011094148.15674-4-punit.agrawal@arm.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <28f9c1cd-e1df-f4db-32b4-c9ca0f0f256a@ti.com>
Date: Tue, 13 Mar 2018 19:08:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171011094148.15674-4-punit.agrawal@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Wednesday 11 October 2017 03:11 PM, Punit Agrawal wrote:
> The kernel crashes while iterating over a redistributor that is
> in-correctly sized by the platform firmware or doesn't contain the last
> record.
> 
> Prevent the crash by checking accesses against the size of the region
> provided by the firmware. While we are at it, warn the user about
> incorrect region size.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Sorry to bring up an old thread. Just wanted to check what is the status
on this series.

This will also be useful when we try to boot linux + hypervisor with
less number of cores than the SoC supports. For example:
- SoC has 4 cores and Linux tries to boot with 2 cores.
- then a type-2 hypervisor gets installed.
- Hypervisor tries to boot a VM with linux on core 1.

Now the VM boot will fail while it iterates over all the GICR regions
till GICR_TYPER is found. Hypervisor will trap any accesses to GICR
regions of any invalid cpus(cpu 2, cpu 3 in this case).

If the $patch is not the right approach, can you suggest on how to
handle the above scenario?

Thanks and regards,
Lokesh

> ---
>  drivers/irqchip/irq-gic-v3.c | 48 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 881d327c53fa..754d936c95e5 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -429,11 +429,21 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
>  	int i;
>  
>  	for (i = 0; i < gic_data.nr_redist_regions; i++) {
> -		void __iomem *ptr = gic_data.redist_regions[i].redist_base;
>  		struct resource *res = &gic_data.redist_regions[i].res;
> -		u64 typer;
> +		void __iomem *ptr, *base;
> +		u64 typer, size, stride;
>  		u32 reg;
>  
> +		ptr = base = gic_data.redist_regions[i].redist_base;
> +		size = resource_size(res);
> +
> +		stride = gic_data.redist_stride ?: SZ_64K * 2;
> +		if (ptr + stride > base + size) {
> +			pr_warn("Insufficient size for redistributor region @%llx. Skipping\n",
> +				res->start);
> +			continue;
> +		}
> +
>  		reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
>  		if (reg != GIC_PIDR2_ARCH_GICv3 &&
>  		    reg != GIC_PIDR2_ARCH_GICv4) { /* We're in trouble... */
> @@ -442,7 +452,28 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
>  		}
>  
>  		do {
> +			/*
> +			 * We can access GICR_TYPER as we have already
> +			 * checked that we have atleast 128kB or
> +			 * redist_stride
> +			 */
>  			typer = gic_read_typer(ptr + GICR_TYPER);
> +			if (!gic_data.redist_stride &&
> +			    (typer & GICR_TYPER_VLPIS)) {
> +				/* VLPI_base + reserved page */
> +				stride += SZ_64K * 2;
> +
> +				/*
> +				 * We are larger than we thought, do
> +				 * we still fit?
> +				 */
> +				if (ptr + stride > base + size) {
> +					pr_warn("No last record found in redistributor region @%llx\n",
> +						gic_data.redist_regions[i].res.start);
> +					break;
> +				}
> +			}
> +
>  			ret = fn(gic_data.redist_regions + i, ptr);
>  			if (!ret)
>  				return 0;
> @@ -450,12 +481,13 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
>  			if (gic_data.redist_regions[i].single_redist)
>  				break;
>  
> -			if (gic_data.redist_stride) {
> -				ptr += gic_data.redist_stride;
> -			} else {
> -				ptr += SZ_64K * 2; /* Skip RD_base + SGI_base */
> -				if (typer & GICR_TYPER_VLPIS)
> -					ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
> +			ptr += stride;
> +
> +			stride = gic_data.redist_stride ?: SZ_64K * 2;
> +			if (ptr + stride > base + size) {
> +				pr_warn("No last record found in redistributor region @%llx\n",
> +					gic_data.redist_regions[i].res.start);
> +				break;
>  			}
>  		} while (!(typer & GICR_TYPER_LAST));
>  	}
> 
