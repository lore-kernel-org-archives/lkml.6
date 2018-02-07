Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeBGJSU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:18:20 -0500
Received: from foss.arm.com ([217.140.101.70]:47370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeBGJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:18:15 -0500
Subject: Re: [PATCH v5 2/4] irqchip/gic-v3-its: add ability to save/restore
 ITS state
To: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-3-dbasehore@chromium.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8cad6e62-3577-5229-1147-5949599cae5a@arm.com>
Date: Wed, 7 Feb 2018 09:18:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207014117.62611-3-dbasehore@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 01:41, Derek Basehore wrote:
> Some platforms power off GIC logic in suspend, so we need to
> save/restore state. The distributor and redistributor registers need
> to be handled in platform code due to access permissions on those
> registers, but the ITS registers can be restored in the kernel.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 99 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06f025fd5726..5e63635e2a7b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -33,6 +33,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
> +#include <linux/syscore_ops.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> @@ -46,6 +47,7 @@
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> +#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
>  
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
> @@ -101,6 +103,8 @@ struct its_node {
>  	struct its_collection	*collections;
>  	struct fwnode_handle	*fwnode_handle;
>  	u64			(*get_msi_base)(struct its_device *its_dev);
> +	u64			cbaser_save;
> +	u32			ctlr_save;
>  	struct list_head	its_device_list;
>  	u64			flags;
>  	unsigned long		list_nr;
> @@ -3042,6 +3046,96 @@ static void its_enable_quirks(struct its_node *its)
>  	gic_enable_quirks(iidr, its_quirks, its);
>  }
>  
> +static int its_save_disable(void)
> +{
> +	struct its_node *its;
> +	int err = 0;
> +
> +	spin_lock(&its_lock);
> +	list_for_each_entry(its, &its_nodes, entry) {
> +		void __iomem *base;
> +
> +		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> +			continue;
> +
> +		base = its->base;
> +		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
> +		err = its_force_quiescent(base);
> +		if (err) {
> +			pr_err("ITS failed to quiesce\n");
> +			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
> +			goto err;
> +		}
> +
> +		its->cbaser_save = gits_read_cbaser(base + GITS_CBASER);
> +	}
> +
> +err:
> +	if (err) {
> +		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
> +			void __iomem *base;
> +
> +			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> +				continue;
> +
> +			base = its->base;
> +			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
> +		}
> +	}
> +	spin_unlock(&its_lock);
> +
> +	return err;
> +}
> +
> +static void its_restore_enable(void)
> +{
> +	struct its_node *its;
> +
> +	spin_lock(&its_lock);
> +	list_for_each_entry(its, &its_nodes, entry) {
> +		void __iomem *base;
> +		int i;
> +
> +		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> +			continue;
> +
> +		base = its->base;
> +
> +		/*
> +		 * Make sure that the ITS is disabled. There's not much we can
> +		 * do if this fails.
> +		 */
> +		if (its_force_quiescent(base))
> +			pr_err("ITS failed to quiesce on resume\n");

One thing we can do though is to abort the resume of this ITS, because
"When GITS_CTLR.Enabled == 1 or GITS_CTLR.Quiescent == 0, writing this
register is UNPREDICTABLE." (where "this register" is any of the
GITS_BASER<n>).

Printing the physical base address of the failing ITS can also help
people to debug their HW (my toy platform has 8 of them...).

> +
> +		gits_write_cbaser(its->cbaser_save, base + GITS_CBASER);
> +
> +		/*
> +		 * Writing CBASER resets CREADR to 0, so make CWRITER and
> +		 * cmd_write line up with it.
> +		 */
> +		its->cmd_write = its->cmd_base;
> +		gits_write_cwriter(0, base + GITS_CWRITER);
> +
> +		/* Restore GITS_BASER from the value cache. */
> +		for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> +			struct its_baser *baser = &its->tables[i];
> +
> +			if (!(baser->val & GITS_BASER_VALID))
> +				continue;
> +
> +			its_write_baser(its, baser, baser->val);
> +		}
> +		writel_relaxed(its->ctlr_save, base + GITS_CTLR);
> +	}
> +	spin_unlock(&its_lock);
> +}
> +
> +static struct syscore_ops its_syscore_ops = {
> +	.suspend = its_save_disable,
> +	.resume = its_restore_enable,
> +};
> +
>  static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  {
>  	struct irq_domain *inner_domain;
> @@ -3261,6 +3355,9 @@ static int __init its_probe_one(struct resource *res,
>  		ctlr |= GITS_CTLR_ImDe;
>  	writel_relaxed(ctlr, its->base + GITS_CTLR);
>  
> +	if (fwnode_property_present(handle, "reset-on-suspend"))
> +		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
> +
>  	err = its_init_domain(handle, its);
>  	if (err)
>  		goto out_free_tables;
> @@ -3515,5 +3612,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  		}
>  	}
>  
> +	register_syscore_ops(&its_syscore_ops);
> +
>  	return 0;
>  }
> 

Otherwise starting to look OK.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
