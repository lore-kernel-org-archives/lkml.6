Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756725AbeDZUxV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:53:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeDZUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:53:20 -0400
Date: Thu, 26 Apr 2018 22:53:15 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Jason Cooper <jason@lakedaemon.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] irqchip/gic-v3: Add support for Message Based
 Interrupts as an MSI controller
In-Reply-To: <20180423103440.26592-6-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1804262230560.1596@nanos.tec.linutronix.de>
References: <20180423103440.26592-1-marc.zyngier@arm.com> <20180423103440.26592-6-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Marc Zyngier wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v3-mbi.c
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright (C) 2018 ARM Limited, All Rights Reserved.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>

Can you please:

1) Add the proper SPDX-License-Identifier

// SPDX-License-Identifier: GPL-2.0

at the first line of the file and

2) Remove the boiler plate? Please talk to Jilayne.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

> +struct mbi_range {
> +	u32			spi_start;
> +	u32			nr_spis;
> +	unsigned long		*bm;
> +};
> +
> +static spinlock_t		mbi_lock;

DEFINE_SPINLOCK() please

> +static phys_addr_t		mbi_phys_base;
> +static struct mbi_range		*mbi_ranges;
> +static unsigned int		mbi_range_nr;
> +
> +static struct irq_chip mbi_irq_chip = {
> +	.name			= "MBI",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
> +static int mbi_irq_gic_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq,
> +				       irq_hw_number_t hwirq)
> +{
> +	struct irq_fwspec fwspec;
> +	struct irq_data *d;
> +	int err;
> +
> +	/*
> +	 * Using ACPI? There is no MBI support in the spec, you
> +	 * shouldn't even be here.
> +	 */
> +	if (!is_of_node(domain->parent->fwnode))
> +		return -EINVAL;
> +
> +	/*
> +	 * Let's default to edge. This is consistent with traditional
> +	 * MSIs, and systems requiring level signaling will just
> +	 * enforce the trigger on their own.
> +	 */
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 3;
> +	fwspec.param[0] = 0;
> +	fwspec.param[1] = hwirq - 32;
> +	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +
> +	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (err)
> +		return err;
> +
> +	d = irq_domain_get_irq_data(domain->parent, virq);
> +	d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);

  	irq_chip_set_type_parent(d, ....) ?

> +
> +	return 0;
> +}
> +
> +static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
> +			 int nr_irqs)
> +{
> +	spin_lock(&mbi_lock);
> +	bitmap_release_region(mbi->bm, hwirq - mbi->spi_start,
> +			      get_count_order(nr_irqs));
> +	spin_unlock(&mbi_lock);
> +}
> +
> +static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	struct mbi_range *mbi = NULL;
> +	int hwirq, offset, i, err = 0;
> +
> +	spin_lock(&mbi_lock);

There is no real reason that this must be a spinlock, right? Make it a
mutex please.

> +	for (i = 0; i < mbi_range_nr; i++) {
> +		offset = bitmap_find_free_region(mbi_ranges[i].bm,
> +						 mbi_ranges[i].nr_spis,
> +						 get_count_order(nr_irqs));
> +		if (offset >= 0) {
> +			mbi = &mbi_ranges[i];
> +			break;
> +		}
> +	}
> +	spin_unlock(&mbi_lock);

> +/* Platform-MSI specific irqchip */
> +static struct irq_chip mbi_pmsi_irq_chip = {
> +	.name			= "pMSI",
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_compose_msi_msg	= mbi_compose_mbi_msg,

Fun. I did not expect this to work w/o any of the other callbacks. Magic!

Other than the above nits, this looks pretty good.

Thanks,

	tglx
