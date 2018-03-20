Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbeCTOD5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:03:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbeCTODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:03:18 -0400
Date: Tue, 20 Mar 2018 15:03:14 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip: Add a driver for the Microsemi Ocelot
 controller
In-Reply-To: <20180320135215.4921-2-alexandre.belloni@bootlin.com>
Message-ID: <alpine.DEB.2.21.1803201456380.1567@nanos.tec.linutronix.de>
References: <20180320135215.4921-1-alexandre.belloni@bootlin.com> <20180320135215.4921-2-alexandre.belloni@bootlin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Alexandre Belloni wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-mscc-ocelot.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi Ocelot IRQ controller driver
> + *
> + * License: Dual MIT/GPL

The whole point of SPDX identifiers is to get rid of this kind of sloppy
and inexact license references. The SPDX identifier above is clear and
precise: The code is dual licensed under GPL V2 only or MIT.

Now looking again at your extra line:

> + * License: Dual MIT/GPL

It does not tell which version of GPL.

Please get rid of that.

> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/bitops.h>
> +#include <linux/irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/interrupt.h>
> +
> +#define ICPU_CFG_INTR_INTR_STICKY	0x10
> +#define ICPU_CFG_INTR_INTR_ENA		0x18
> +#define ICPU_CFG_INTR_INTR_ENA_CLR	0x1c
> +#define ICPU_CFG_INTR_INTR_ENA_SET	0x20
> +#define ICPU_CFG_INTR_DST_INTR_IDENT(x)	(0x38 + 0x4 * (x))
> +#define ICPU_CFG_INTR_INTR_TRIGGER(x)	(0x5c + 0x4 * (x))
> +
> +#define OCELOT_NR_IRQ 24
> +
> +static void ocelot_irq_unmask(struct irq_data *data)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	struct irq_chip_type *ct = irq_data_get_chip_type(data);
> +	unsigned int mask = data->mask;
> +	u32 val;
> +
> +	irq_gc_lock(gc);
> +	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
> +	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
> +	if ((val & mask) == 0)

Usual kernel style is:

	if (!(val & mask))

> +		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
> +
> +	*ct->mask_cache &= ~mask;
> +	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
> +	irq_gc_unlock(gc);
> +}

> +
> +	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA); /* Mask all */
> +	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY); /* Ack pending */

Please do not use tail comments. They are annoying as they disturb the
visual parsing.

       /* Mask and ack all interrupts */
	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA);
	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY);

is way better to read.

Other than those nitpicks. Nice work!

Thanks,

	tglx
