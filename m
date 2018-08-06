Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736DF2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736DF2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHFKX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:23:28 -0400
Received: from foss.arm.com ([217.140.101.70]:34182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeHFKX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:23:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E196A18A;
        Mon,  6 Aug 2018 01:15:34 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 228653F5D0;
        Mon,  6 Aug 2018 01:15:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Move ITS' ->pend_page allocation
 into an early CPU up callback
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180718154205.13704-1-bigeasy@linutronix.de>
 <20180718154205.13704-3-bigeasy@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com>
Date:   Mon, 6 Aug 2018 09:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718154205.13704-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 18/07/18 16:42, Sebastian Andrzej Siewior wrote:
> The AP-GIC-starting callback allocates memory for the ->pend_page while
> the CPU is started during boot-up. This callback is invoked on the
> target CPU with disabled interrupts.
> This does not work on -RT because memory allocations are not possible
> with disabled interrupts.
> Move the memory allocation to an earlier hotplug step which is invoked
> with enabled interrupts on the boot CPU.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 60 ++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index a616043d25ee..acc3d44c356d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -171,6 +171,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
>  static DEFINE_IDA(its_vpeid_ida);
>  
>  #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
> +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>  #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>  
> @@ -1853,15 +1854,17 @@ static int its_alloc_collections(struct its_node *its)
>  	return 0;
>  }
>  
> -static struct page *its_allocate_pending_table(gfp_t gfp_flags)
> +static struct page *its_allocate_pending_table(unsigned int cpu)
>  {
>  	struct page *pend_page;
> +	unsigned int order;
>  	/*
>  	 * The pending pages have to be at least 64kB aligned,
>  	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
>  	 */
> -	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
> -				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
> +	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
> +	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
> +				     order);
>  	if (!pend_page)
>  		return NULL;
>  
> @@ -1877,6 +1880,28 @@ static void its_free_pending_table(struct page *pt)
>  		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
>  }
>  
> +static int its_alloc_pend_page(unsigned int cpu)
> +{
> +	struct page *pend_page;
> +	phys_addr_t paddr;
> +
> +	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
> +	if (pend_page)
> +		return 0;
> +
> +	pend_page = its_allocate_pending_table(cpu);
> +	if (!pend_page) {
> +		pr_err("Failed to allocate PENDBASE for CPU%d\n",
> +		       smp_processor_id());
> +		return -ENOMEM;
> +	}
> +
> +	paddr = page_to_phys(pend_page);
> +	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
> +	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
> +	return 0;
> +}
> +
>  static void its_cpu_init_lpis(void)
>  {
>  	void __iomem *rbase = gic_data_rdist_rd_base();
> @@ -1885,21 +1910,8 @@ static void its_cpu_init_lpis(void)
>  
>  	/* If we didn't allocate the pending table yet, do it now */
>  	pend_page = gic_data_rdist()->pend_page;
> -	if (!pend_page) {
> -		phys_addr_t paddr;
> -
> -		pend_page = its_allocate_pending_table(GFP_NOWAIT);
> -		if (!pend_page) {
> -			pr_err("Failed to allocate PENDBASE for CPU%d\n",
> -			       smp_processor_id());
> -			return;
> -		}
> -
> -		paddr = page_to_phys(pend_page);
> -		pr_info("CPU%d: using LPI pending table @%pa\n",
> -			smp_processor_id(), &paddr);
> -		gic_data_rdist()->pend_page = pend_page;
> -	}
> +	if (WARN_ON(!pend_page))
> +		return;
>  
>  	/* set PROPBASE */
>  	val = (page_to_phys(gic_rdists->prop_page) |
> @@ -2732,7 +2744,7 @@ static int its_vpe_init(struct its_vpe *vpe)
>  		return vpe_id;
>  
>  	/* Allocate VPT */
> -	vpt_page = its_allocate_pending_table(GFP_KERNEL);
> +	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
>  	if (!vpt_page) {
>  		its_vpe_id_free(vpe_id);
>  		return -ENOMEM;
> @@ -3706,6 +3718,16 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  	if (err)
>  		return err;
>  
> +	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
> +				its_alloc_pend_page, NULL);
> +	if (err < 0) {
> +		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
> +		return err;
> +	}
> +	err = its_alloc_pend_page(smp_processor_id());
> +	if (err < 0)
> +		return err;
> +
>  	list_for_each_entry(its, &its_nodes, entry)
>  		has_v4 |= its->is_v4;
>  
> 

I must say I'm not overly keen on the extra hotplug notifier, and I'd
rather allocate all the memory upfront on the boot CPU.

I've implemented this as part of a series that is required for
kexec/kdump support[1] (and specifically this[2] patch). Could you
please have a look and let me know if that works for you? I otherwise
plan to post it for review once the 4.19 merge window has closed.

Thanks,

	M.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gicv3-kdump&id=effe377d415900af10e206173d60dc6cc3f0662c
-- 
Jazz is not dead. It just smells funny...
