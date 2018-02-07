Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeBGPSa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:18:30 -0500
Received: from foss.arm.com ([217.140.101.70]:52188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754509AbeBGPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:18:28 -0500
Date: Wed, 7 Feb 2018 15:18:26 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] irqchip/gic-v2m: Add PCI Multi-MSI support
Message-ID: <20180207151826.GA9111@e110455-lin.cambridge.arm.com>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
 <20180207143255.17003-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180207143255.17003-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:32:54PM +0000, Marc Zyngier wrote:
> We'd never implemented Multi-MSI support with GICv2m, because
> it is weird and clunky, and you'd think people would rather use
> MSI-X.
> 
> Turns out there is still plenty of devices out there that rely
> on Multi-MSI. Oh well, let's teach that trick to the v2m widget,
> it is not a big deal anyway.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Looks good to me. Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/irqchip/irq-gic-v2m.c | 46 +++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index 993a8426a453..1ff38aff9f29 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -94,7 +94,7 @@ static struct irq_chip gicv2m_msi_irq_chip = {
>  
>  static struct msi_domain_info gicv2m_msi_domain_info = {
>  	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_PCI_MSIX),
> +		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>  	.chip	= &gicv2m_msi_irq_chip,
>  };
>  
> @@ -155,18 +155,12 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
>  	return 0;
>  }
>  
> -static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq)
> +static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
> +			       int nr_irqs)
>  {
> -	int pos;
> -
> -	pos = hwirq - v2m->spi_start;
> -	if (pos < 0 || pos >= v2m->nr_spis) {
> -		pr_err("Failed to teardown msi. Invalid hwirq %d\n", hwirq);
> -		return;
> -	}
> -
>  	spin_lock(&v2m_lock);
> -	__clear_bit(pos, v2m->bm);
> +	bitmap_release_region(v2m->bm, hwirq - v2m->spi_start,
> +			      get_count_order(nr_irqs));
>  	spin_unlock(&v2m_lock);
>  }
>  
> @@ -174,13 +168,13 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  				   unsigned int nr_irqs, void *args)
>  {
>  	struct v2m_data *v2m = NULL, *tmp;
> -	int hwirq, offset, err = 0;
> +	int hwirq, offset, i, err = 0;
>  
>  	spin_lock(&v2m_lock);
>  	list_for_each_entry(tmp, &v2m_nodes, entry) {
> -		offset = find_first_zero_bit(tmp->bm, tmp->nr_spis);
> -		if (offset < tmp->nr_spis) {
> -			__set_bit(offset, tmp->bm);
> +		offset = bitmap_find_free_region(tmp->bm, tmp->nr_spis,
> +						 get_count_order(nr_irqs));
> +		if (offset >= 0) {
>  			v2m = tmp;
>  			break;
>  		}
> @@ -192,16 +186,21 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	hwirq = v2m->spi_start + offset;
>  
> -	err = gicv2m_irq_gic_domain_alloc(domain, virq, hwirq);
> -	if (err) {
> -		gicv2m_unalloc_msi(v2m, hwirq);
> -		return err;
> -	}
> +	for (i = 0; i < nr_irqs; i++) {
> +		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
> +		if (err)
> +			goto fail;
>  
> -	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> -				      &gicv2m_irq_chip, v2m);
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &gicv2m_irq_chip, v2m);
> +	}
>  
>  	return 0;
> +
> +fail:
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +	gicv2m_unalloc_msi(v2m, hwirq, get_count_order(nr_irqs));
> +	return err;
>  }
>  
>  static void gicv2m_irq_domain_free(struct irq_domain *domain,
> @@ -210,8 +209,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *domain,
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>  	struct v2m_data *v2m = irq_data_get_irq_chip_data(d);
>  
> -	BUG_ON(nr_irqs != 1);
> -	gicv2m_unalloc_msi(v2m, d->hwirq);
> +	gicv2m_unalloc_msi(v2m, d->hwirq, nr_irqs);
>  	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>  
> -- 
> 2.14.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
