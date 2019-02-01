Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A395C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022DC218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfBARAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:00:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfBARAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA7E15BF;
        Fri,  1 Feb 2019 09:00:17 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 324B33F71E;
        Fri,  1 Feb 2019 09:00:15 -0800 (PST)
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     lantianyu1986@gmail.com
Cc:     alex.williamson@redhat.com, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        iommu@lists.linux-foundation.org, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, kys@microsoft.com, davem@davemloft.net
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa7d9f2a-fe80-b825-efe4-cfd9a0c9501d@arm.com>
Date:   Fri, 1 Feb 2019 17:00:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 10:17, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
> 
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.

AFAICS this is a Hyper-V IOAPIC driver which neither implements nor even 
touches the IOMMU API, so having it in drivers/iommu rather than, say, 
drivers/irqchip seems a bit of a stretch to me :/

Maybe this could be a good push to clean up and properly factor out the 
x86 IRQ remapping stuff, possibly to live somewhere closer to other IRQ 
layer code? I appreciate it's a bit muddied by the major x86 vendors 
both keeping their DMA virtualisation and IRQ virtualisation 
architectures together under one umbrella "IOMMU" spec, but IIRC the 
fact that intel-iommu supports building for !IOMMU_API already causes us 
a bit of grief.

Of course, I'm coming from a particular not-entirely-objective viewpoint 
where DMA remapping (SMMU) code in drivers/iommu, IRQ remapping (ITS) 
code in drivers/irqchip, and the relevant ACPI table handling (IORT) in 
drivers/acpi is the norm, but even though that largely falls out of a 
less-tightly-coupled system architecture it does seem perfectly logical 
either way.

Robin.

(who has admittedly been drinking the Cambridge water for many years now...)

> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>   drivers/iommu/Kconfig         |   7 ++
>   drivers/iommu/Makefile        |   1 +
>   drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/irq_remapping.c |   3 +
>   drivers/iommu/irq_remapping.h |   1 +
>   5 files changed, 201 insertions(+)
>   create mode 100644 drivers/iommu/hyperv-iommu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 45d7021..5c397c0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -437,4 +437,11 @@ config QCOM_IOMMU
>   	help
>   	  Support for IOMMU on certain Qualcomm SoCs.
>   
> +config HYPERV_IOMMU
> +	bool "Hyper-V stub IOMMU support"
> +	depends on HYPERV
> +	help
> +	    Hyper-V stub IOMMU driver provides capability to run
> +	    Linux guest with X2APIC mode enabled.
> +
>   endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a158a68..8c71a15 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
> +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> new file mode 100644
> index 0000000..a64b747
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
> +
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +
> +#include <asm/hw_irq.h>
> +#include <asm/io_apic.h>
> +#include <asm/irq_remapping.h>
> +#include <asm/hypervisor.h>
> +
> +#include "irq_remapping.h"
> +
> +/*
> + * According IO-APIC spec, IO APIC has a 24-entry Interrupt
> + * Redirection Table.
> + */
> +#define IOAPIC_REMAPPING_ENTRY 24
> +
> +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> +struct irq_domain *ioapic_ir_domain;
> +
> +static int hyperv_ir_set_affinity(struct irq_data *data,
> +		const struct cpumask *mask, bool force)
> +{
> +	struct irq_data *parent = data->parent_data;
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct IO_APIC_route_entry *entry;
> +	cpumask_t cpumask;
> +	int ret;
> +
> +	cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
> +
> +	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
> +	if (!cpumask_empty(&cpumask))
> +		return -EINVAL;
> +
> +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> +	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> +		return ret;
> +
> +	entry = data->chip_data;
> +	entry->dest = cfg->dest_apicid;
> +	entry->vector = cfg->vector;
> +	send_cleanup_vector(cfg);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip hyperv_ir_chip = {
> +	.name			= "HYPERV-IR",
> +	.irq_ack		= apic_ack_irq,
> +	.irq_set_affinity	= hyperv_ir_set_affinity,
> +};
> +
> +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	struct irq_alloc_info *info = arg;
> +	struct IO_APIC_route_entry *entry;
> +	struct irq_data *irq_data;
> +	struct irq_desc *desc;
> +	struct irq_cfg *cfg;
> +	int ret = 0;
> +
> +	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> +		return -EINVAL;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		goto fail;
> +
> +	irq_data = irq_domain_get_irq_data(domain, virq);
> +	cfg = irqd_cfg(irq_data);
> +	if (!irq_data || !cfg) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +
> +	irq_data->chip = &hyperv_ir_chip;
> +
> +	/*
> +	 * Save IOAPIC entry pointer here in order to set vector and
> +	 * and dest_apicid in the hyperv_irq_remappng_activate()
> +	 * and hyperv_ir_set_affinity(). IOAPIC driver ignores
> +	 * cfg->dest_apicid and cfg->vector when irq remapping
> +	 * mode is enabled. Detail see ioapic_configure_entry().
> +	 */
> +	irq_data->chip_data = entry = info->ioapic_entry;
> +
> +	/*
> +	 * Hypver-V IO APIC irq affinity should be in the scope of
> +	 * ioapic_max_cpumask because no irq remapping support.
> +	 */
> +	desc = irq_data_to_desc(irq_data);
> +	cpumask_and(desc->irq_common_data.affinity,
> +			desc->irq_common_data.affinity,
> +			&ioapic_max_cpumask);
> +
> + fail:
> +	return ret;
> +}
> +
> +static void hyperv_irq_remapping_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +}
> +
> +static int hyperv_irq_remappng_activate(struct irq_domain *domain,
> +			  struct irq_data *irq_data, bool reserve)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(irq_data);
> +	struct IO_APIC_route_entry *entry = irq_data->chip_data;
> +
> +	entry->dest = cfg->dest_apicid;
> +	entry->vector = cfg->vector;
> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops hyperv_ir_domain_ops = {
> +	.alloc = hyperv_irq_remapping_alloc,
> +	.free = hyperv_irq_remapping_free,
> +	.activate = hyperv_irq_remappng_activate,
> +};
> +
> +static int __init hyperv_prepare_irq_remapping(void)
> +{
> +	struct fwnode_handle *fn;
> +	u32 apic_id;
> +	int i;
> +
> +	if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
> +	    !x2apic_supported())
> +		return -ENODEV;
> +
> +	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (!fn)
> +		return -EFAULT;
> +
> +	ioapic_ir_domain =
> +		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> +				0, IOAPIC_REMAPPING_ENTRY, fn,
> +				&hyperv_ir_domain_ops, NULL);
> +
> +	irq_domain_free_fwnode(fn);
> +
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
> +	 * and set cpu into ioapic_max_cpumask if its APIC ID is less
> +	 * than 255.
> +	 */
> +	for (i = 0; i < 256; i++) {
> +		apic_id = cpu_physical_id(i);
> +		if (apic_id > 255)
> +			continue;
> +
> +		cpumask_set_cpu(i, &ioapic_max_cpumask);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init hyperv_enable_irq_remapping(void)
> +{
> +	return IRQ_REMAP_X2APIC_MODE;
> +}
> +
> +static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
> +{
> +	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
> +		return ioapic_ir_domain;
> +	else
> +		return NULL;
> +}
> +
> +struct irq_remap_ops hyperv_irq_remap_ops = {
> +	.prepare		= hyperv_prepare_irq_remapping,
> +	.enable			= hyperv_enable_irq_remapping,
> +	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
> +};
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index b94ebd4..81cf290 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
>   	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>   		 amd_iommu_irq_ops.prepare() == 0)
>   		remap_ops = &amd_iommu_irq_ops;
> +	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> +		 hyperv_irq_remap_ops.prepare() == 0)
> +		remap_ops = &hyperv_irq_remap_ops;
>   	else
>   		return -ENOSYS;
>   
> diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
> index 0afef6e..f8609e9 100644
> --- a/drivers/iommu/irq_remapping.h
> +++ b/drivers/iommu/irq_remapping.h
> @@ -64,6 +64,7 @@ struct irq_remap_ops {
>   
>   extern struct irq_remap_ops intel_irq_remap_ops;
>   extern struct irq_remap_ops amd_iommu_irq_ops;
> +extern struct irq_remap_ops hyperv_irq_remap_ops;
>   
>   #else  /* CONFIG_IRQ_REMAP */
>   
> 
