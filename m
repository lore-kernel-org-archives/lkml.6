Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3331C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEAA21104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEAA21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeKHVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:00:30 -0500
Received: from foss.arm.com ([217.140.101.70]:38650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeKHVAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:00:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18AAC80D;
        Thu,  8 Nov 2018 03:25:28 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6D63F5CF;
        Thu,  8 Nov 2018 03:25:25 -0800 (PST)
Subject: Re: [PATCH 07/10] irqchip/gic-v3-its: Split probing from its node
 initialization
To:     Robert Richter <rrichter@cavium.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-8-rrichter@cavium.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <3ab57b7c-43e4-f6b8-fa4e-433fd087fc01@arm.com>
Date:   Thu, 8 Nov 2018 11:25:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181107220254.6116-8-rrichter@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/18 22:03, Robert Richter wrote:
> To initialize the its nodes at a later point during boot, we need to
> split probing from initialization. Collect all information required
> for initialization in struct its_node. We can then use the its node
> list for initialization.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 135 +++++++++++++++++++++++--------------
>   drivers/irqchip/irq-gic-v3.c       |   2 +-
>   include/linux/irqchip/arm-gic-v3.h |   4 +-
>   3 files changed, 87 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 4033f71f5181..c28f4158ff70 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -103,6 +103,7 @@ struct its_node {
>   	struct list_head	entry;
>   	void __iomem		*base;
>   	phys_addr_t		phys_base;
> +	phys_addr_t		phys_size;
>   	struct its_cmd_block	*cmd_base;
>   	struct its_cmd_block	*cmd_write;
>   	struct its_baser	tables[GITS_BASER_NR_REGS];
> @@ -3375,7 +3376,7 @@ static struct syscore_ops its_syscore_ops = {
>   	.resume = its_restore_enable,
>   };
>   
> -static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
> +static int its_init_domain(struct its_node *its)
>   {
>   	struct irq_domain *inner_domain;
>   	struct msi_domain_info *info;
> @@ -3384,7 +3385,8 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>   	if (!info)
>   		return -ENOMEM;
>   
> -	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
> +	inner_domain = irq_domain_create_tree(its->fwnode_handle,
> +					&its_domain_ops, its);

Separate change?

>   	if (!inner_domain) {
>   		kfree(info);
>   		return -ENOMEM;
> @@ -3441,8 +3443,7 @@ static int its_init_vpe_domain(void)
>   	return 0;
>   }
>   
> -static int __init its_compute_its_list_map(struct resource *res,
> -					   void __iomem *its_base)
> +static int __init its_compute_its_list_map(struct its_node *its)
>   {
>   	int its_number;
>   	u32 ctlr;
> @@ -3456,15 +3457,15 @@ static int __init its_compute_its_list_map(struct resource *res,
>   	its_number = find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
>   	if (its_number >= GICv4_ITS_LIST_MAX) {
>   		pr_err("ITS@%pa: No ITSList entry available!\n",
> -		       &res->start);
> +		       &its->phys_base);
>   		return -EINVAL;
>   	}
>   
> -	ctlr = readl_relaxed(its_base + GITS_CTLR);
> +	ctlr = readl_relaxed(its->base + GITS_CTLR);
>   	ctlr &= ~GITS_CTLR_ITS_NUMBER;
>   	ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
> -	writel_relaxed(ctlr, its_base + GITS_CTLR);
> -	ctlr = readl_relaxed(its_base + GITS_CTLR);
> +	writel_relaxed(ctlr, its->base + GITS_CTLR);
> +	ctlr = readl_relaxed(its->base + GITS_CTLR);

This (removal of its_base parameter) also feel like a separate change.

Also, I would define a local variable its_base to avoid dereferencing 
its every time in order to get the base address.

>   	if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
>   		its_number = ctlr & GITS_CTLR_ITS_NUMBER;
>   		its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
> @@ -3472,83 +3473,110 @@ static int __init its_compute_its_list_map(struct resource *res,
>   
>   	if (test_and_set_bit(its_number, &its_list_map)) {
>   		pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
> -		       &res->start, its_number);
> +		       &its->phys_base, its_number);
>   		return -EINVAL;
>   	}
>   
>   	return its_number;
>   }
>   
> +static void its_free(struct its_node *its)
> +{
> +	raw_spin_lock(&its_lock);
> +	list_del(&its->entry);
> +	raw_spin_unlock(&its_lock);
> +
> +	kfree(its);
> +}
> +
> +static int __init its_init_one(struct its_node *its);

You might as well define its_init_one here, no?

> +
>   static int __init its_probe_one(struct resource *res,
>   				struct fwnode_handle *handle, int numa_node)
>   {
>   	struct its_node *its;
> +	int err;
> +
> +	its = kzalloc(sizeof(*its), GFP_KERNEL);
> +	if (!its)
> +		return -ENOMEM;
> +
> +	raw_spin_lock_init(&its->lock);
> +	INIT_LIST_HEAD(&its->entry);
> +	INIT_LIST_HEAD(&its->its_device_list);
> +	its->fwnode_handle = handle;
> +	its->phys_base = res->start;
> +	its->phys_size = resource_size(res);
> +	its->numa_node = numa_node;
> +
> +	raw_spin_lock(&its_lock);
> +	list_add_tail(&its->entry, &its_nodes);
> +	raw_spin_unlock(&its_lock);
> +
> +	pr_info("ITS %pR\n", res);
> +
> +	err = its_init_one(its);
> +	if (err)
> +		its_free(its);
> +
> +	return err;
> +}
> +
> +static int __init its_init_one(struct its_node *its)
> +{
>   	void __iomem *its_base;
>   	u32 val, ctlr;
>   	u64 baser, tmp, typer;
>   	int err;
>   
> -	its_base = ioremap(res->start, resource_size(res));
> +	its_base = ioremap(its->phys_base, its->phys_size);
>   	if (!its_base) {
> -		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
> -		return -ENOMEM;
> +		pr_warn("ITS@%pa: Unable to map ITS registers\n", &its->phys_base);
> +		err = -ENOMEM;
> +		goto fail;
>   	}
>   
>   	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
>   	if (val != 0x30 && val != 0x40) {
> -		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
> +		pr_warn("ITS@%pa: No ITS detected, giving up\n", &its->phys_base);
>   		err = -ENODEV;
>   		goto out_unmap;
>   	}
>   
>   	err = its_force_quiescent(its_base);
>   	if (err) {
> -		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
> +		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &its->phys_base);
>   		goto out_unmap;
>   	}
>   
> -	pr_info("ITS %pR\n", res);
> -
> -	its = kzalloc(sizeof(*its), GFP_KERNEL);
> -	if (!its) {
> -		err = -ENOMEM;
> -		goto out_unmap;
> -	}
> -
> -	raw_spin_lock_init(&its->lock);
> -	INIT_LIST_HEAD(&its->entry);
> -	INIT_LIST_HEAD(&its->its_device_list);
>   	typer = gic_read_typer(its_base + GITS_TYPER);
>   	its->base = its_base;
> -	its->phys_base = res->start;
>   	its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
>   	its->device_ids = GITS_TYPER_DEVBITS(typer);
>   	its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
>   	if (its->is_v4) {
>   		if (!(typer & GITS_TYPER_VMOVP)) {
> -			err = its_compute_its_list_map(res, its_base);
> +			err = its_compute_its_list_map(its);
>   			if (err < 0)
> -				goto out_free_its;
> +				goto out_unmap;
>   
>   			its->list_nr = err;
>   
>   			pr_info("ITS@%pa: Using ITS number %d\n",
> -				&res->start, err);
> +				&its->phys_base, err);
>   		} else {
> -			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
> +			pr_info("ITS@%pa: Single VMOVP capable\n",
> +				&its->phys_base);
>   		}
>   	}
>   
> -	its->numa_node = numa_node;
> -
>   	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>   						get_order(ITS_CMD_QUEUE_SZ));
>   	if (!its->cmd_base) {
>   		err = -ENOMEM;
> -		goto out_free_its;
> +		goto out_unmap;
>   	}
>   	its->cmd_write = its->cmd_base;
> -	its->fwnode_handle = handle;
>   	its->get_msi_base = its_irq_get_msi_base;
>   	its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
>   
> @@ -3597,13 +3625,11 @@ static int __init its_probe_one(struct resource *res,
>   	if (GITS_TYPER_HCC(typer))
>   		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>   
> -	err = its_init_domain(handle, its);
> +	err = its_init_domain(its);

I'm not sure what is the logic for "this goes in probe, this goes in init?".

>   	if (err)
>   		goto out_free_tables;
>   
> -	raw_spin_lock(&its_lock);
> -	list_add_tail(&its->entry, &its_nodes);
> -	raw_spin_unlock(&its_lock);
> +	pr_info("ITS@%pa: ITS node added\n", &its->phys_base);
>   
>   	return 0;
>   
> @@ -3611,11 +3637,10 @@ static int __init its_probe_one(struct resource *res,
>   	its_free_tables(its);
>   out_free_cmd:
>   	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
> -out_free_its:
> -	kfree(its);
>   out_unmap:
>   	iounmap(its_base);
> -	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
> +fail:
> +	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
>   	return err;
>   }
>   
> @@ -3888,13 +3913,12 @@ static void __init its_acpi_probe(void)
>   static void __init its_acpi_probe(void) { }
>   #endif
>   
> -int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
> -		    struct irq_domain *parent_domain)
> +static int __init its_init(void);
> +
> +int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
> +		     struct irq_domain *parent_domain)
>   {
>   	struct device_node *of_node;
> -	struct its_node *its;
> -	bool has_v4 = false;
> -	int err;
>   
>   	its_parent = parent_domain;
>   	of_node = to_of_node(handle);
> @@ -3903,13 +3927,22 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	else
>   		its_acpi_probe();
>   
> +	gic_rdists = rdists;
> +
> +	return its_init();
> +}
> +
> +static int __init its_init(void)
> +{
> +	struct its_node *its;
> +	bool has_v4 = false;
> +	int err;
> +
>   	if (list_empty(&its_nodes)) {
>   		pr_warn("ITS: No ITS available, not enabling LPIs\n");
>   		return -ENXIO;
>   	}
>   
> -	gic_rdists = rdists;
> -
>   	err = allocate_lpi_tables();
>   	if (err)
>   		return err;
> @@ -3917,10 +3950,10 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	list_for_each_entry(its, &its_nodes, entry)
>   		has_v4 |= its->is_v4;
>   
> -	if (has_v4 & rdists->has_vlpis) {
> +	if (has_v4 & gic_rdists->has_vlpis) {
>   		if (its_init_vpe_domain() ||
> -		    its_init_v4(parent_domain, &its_vpe_domain_ops)) {
> -			rdists->has_vlpis = false;
> +		    its_init_v4(its_parent, &its_vpe_domain_ops)) {
> +			gic_rdists->has_vlpis = false;
>   			pr_err("ITS: Disabling GICv4 support\n");
>   		}
>   	}
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 8f87f40c9460..e04108b7c6b7 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1132,7 +1132,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   	gic_cpu_pm_init();
>   
>   	if (gic_dist_supports_lpis()) {
> -		its_init(handle, &gic_data.rdists, gic_data.domain);
> +		its_probe(handle, &gic_data.rdists, gic_data.domain);
>   		its_cpu_init();
>   	}
>   
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 071b4cbdf010..a6fdb2910f73 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -603,8 +603,8 @@ struct rdists {
>   struct irq_domain;
>   struct fwnode_handle;
>   int its_cpu_init(void);
> -int its_init(struct fwnode_handle *handle, struct rdists *rdists,
> -	     struct irq_domain *domain);
> +int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
> +	      struct irq_domain *domain);
>   int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
>   
>   static inline bool gic_enable_sre(void)
> 

-- 
Julien Thierry
