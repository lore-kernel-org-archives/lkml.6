Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D06C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF92133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEF92133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeKHVBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:01:08 -0500
Received: from foss.arm.com ([217.140.101.70]:38690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeKHVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:01:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149A080D;
        Thu,  8 Nov 2018 03:26:06 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4BC3F5CF;
        Thu,  8 Nov 2018 03:26:03 -0800 (PST)
Subject: Re: [PATCH 08/10] irqchip/gic-v3-its: Decouple its initialization
 from gic
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
 <20181107220254.6116-9-rrichter@cavium.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <21a0183b-bf4b-1895-d10b-8287dbff930a@arm.com>
Date:   Thu, 8 Nov 2018 11:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181107220254.6116-9-rrichter@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/18 22:03, Robert Richter wrote:
> This patch separates its initialization from the gic. Probing and
> initialization of its nodes is separate now. There is an own cpu
> notifier for its now.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 58 +++++++++++++++++++++++++-------------
>   drivers/irqchip/irq-gic-v3.c       | 14 ++++-----
>   include/linux/cpuhotplug.h         |  1 +
>   include/linux/irqchip/arm-gic-v3.h |  2 +-
>   4 files changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index c28f4158ff70..fd8561fcfdf3 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -167,6 +167,7 @@ static struct {
>   } vpe_proxy;
>   
>   static LIST_HEAD(its_nodes);
> +static LIST_HEAD(its_probed);
>   static DEFINE_RAW_SPINLOCK(its_lock);
>   static struct rdists *gic_rdists;
>   static struct irq_domain *its_parent;
> @@ -3482,20 +3483,13 @@ static int __init its_compute_its_list_map(struct its_node *its)
>   
>   static void its_free(struct its_node *its)
>   {
> -	raw_spin_lock(&its_lock);
> -	list_del(&its->entry);
> -	raw_spin_unlock(&its_lock);
> -
>   	kfree(its);
>   }
>   
> -static int __init its_init_one(struct its_node *its);
> -
>   static int __init its_probe_one(struct resource *res,
>   				struct fwnode_handle *handle, int numa_node)
>   {
>   	struct its_node *its;
> -	int err;
>   
>   	its = kzalloc(sizeof(*its), GFP_KERNEL);
>   	if (!its)
> @@ -3510,16 +3504,12 @@ static int __init its_probe_one(struct resource *res,
>   	its->numa_node = numa_node;
>   
>   	raw_spin_lock(&its_lock);
> -	list_add_tail(&its->entry, &its_nodes);
> +	list_add_tail(&its->entry, &its_probed);
>   	raw_spin_unlock(&its_lock);
>   
>   	pr_info("ITS %pR\n", res);
>   
> -	err = its_init_one(its);
> -	if (err)
> -		its_free(its);
> -
> -	return err;
> +	return 0;
>   }
>   
>   static int __init its_init_one(struct its_node *its)
> @@ -3717,7 +3707,7 @@ static int redist_disable_lpis(void)
>   	return 0;
>   }
>   
> -int its_cpu_init(void)
> +static int its_cpu_init(unsigned int cpu)
>   {
>   	if (!list_empty(&its_nodes)) {
>   		int ret;
> @@ -3913,8 +3903,6 @@ static void __init its_acpi_probe(void)
>   static void __init its_acpi_probe(void) { }
>   #endif
>   
> -static int __init its_init(void);
> -
>   int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
>   		     struct irq_domain *parent_domain)
>   {
> @@ -3929,23 +3917,51 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
>   
>   	gic_rdists = rdists;
>   
> -	return its_init();
> +	return 0;
>   }
>   
> -static int __init its_init(void)
> +int __init its_init(void)
>   {
>   	struct its_node *its;
>   	bool has_v4 = false;
>   	int err;
>   
> +	if (list_empty(&its_probed))
> +		return 0;
> +
> +	raw_spin_lock(&its_lock);
> +redo:
> +	list_for_each_entry(its, &its_probed, entry) {
> +		list_del_init(&its->entry);
> +
> +		raw_spin_unlock(&its_lock);
> +
> +		/* Needs to be called in non-atomic context */
> +		err = its_init_one(its);
> +		if (err)
> +			its_free(its);
> +
> +		raw_spin_lock(&its_lock);
> +
> +		if (!err)
> +			list_add_tail(&its->entry, &its_nodes);
> +
> +		goto redo;

Again, you're starting a loop only to work on the first element and then 
restarting the loop.

Just do a while (!list_empty()), and without gotos...

> +	}
> +
> +	raw_spin_unlock(&its_lock);
> +
>   	if (list_empty(&its_nodes)) {
>   		pr_warn("ITS: No ITS available, not enabling LPIs\n");
>   		return -ENXIO;
>   	}
>   
>   	err = allocate_lpi_tables();
> -	if (err)
> +	if (err) {
> +		pr_warn("ITS: Failed to initialize (%d), not enabling LPIs\n",
> +			err);
>   		return err;
> +	}
>   
>   	list_for_each_entry(its, &its_nodes, entry)
>   		has_v4 |= its->is_v4;
> @@ -3960,5 +3976,9 @@ static int __init its_init(void)
>   
>   	register_syscore_ops(&its_syscore_ops);
>   
> +	cpuhp_setup_state(CPUHP_AP_IRQ_GIC_ITS_STARTING,
> +			"irqchip/arm/gicv3-its:starting",
> +			its_cpu_init, NULL);
> +
>   	return 0;
>   }
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index e04108b7c6b7..d2942efdb6d5 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -685,9 +685,6 @@ static int gic_starting_cpu(unsigned int cpu)
>   {
>   	gic_cpu_init();
>   
> -	if (gic_dist_supports_lpis())
> -		its_cpu_init();
> -
>   	return 0;
>   }
>   
> @@ -815,7 +812,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>   #else
>   #define gic_set_affinity	NULL
>   #define gic_smp_init()		do { } while(0)
> -#endif
> +#endif	/* CONFIG_SMP */
>   
>   #ifdef CONFIG_CPU_PM
>   /* Check whether it's single security state view */
> @@ -1131,10 +1128,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   	gic_cpu_init();
>   	gic_cpu_pm_init();
>   
> -	if (gic_dist_supports_lpis()) {
> +	if (gic_dist_supports_lpis())
>   		its_probe(handle, &gic_data.rdists, gic_data.domain);
> -		its_cpu_init();
> -	}
>   
>   	return 0;
>   
> @@ -1327,6 +1322,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
>   
>   	if (static_branch_likely(&supports_deactivate_key))
>   		gic_of_setup_kvm_info(node);
> +
> +	its_init();
> +
>   	return 0;
>   
>   out_unmap_rdist:
> @@ -1630,6 +1628,8 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
>   	if (static_branch_likely(&supports_deactivate_key))
>   		gic_acpi_setup_kvm_info();
>   
> +	its_init();
> +
>   	return 0;
>   
>   out_fwhandle_free:
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e0cd2baa8380..584f73585142 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -96,6 +96,7 @@ enum cpuhp_state {
>   	CPUHP_AP_SCHED_STARTING,
>   	CPUHP_AP_RCUTREE_DYING,
>   	CPUHP_AP_IRQ_GIC_STARTING,
> +	CPUHP_AP_IRQ_GIC_ITS_STARTING,
>   	CPUHP_AP_IRQ_HIP04_STARTING,
>   	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>   	CPUHP_AP_IRQ_BCM2836_STARTING,
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index a6fdb2910f73..f4348fa4260a 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -602,9 +602,9 @@ struct rdists {
>   
>   struct irq_domain;
>   struct fwnode_handle;
> -int its_cpu_init(void);
>   int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
>   	      struct irq_domain *domain);
> +int its_init(void);
>   int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
>   
>   static inline bool gic_enable_sre(void)
> 

-- 
Julien Thierry
