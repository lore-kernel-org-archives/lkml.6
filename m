Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030356AbeCAMQz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:16:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030253AbeCAMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:16:54 -0500
Date: Thu, 1 Mar 2018 13:16:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
cc: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] irqchip: add support for Layerscape external
 interrupt lines
In-Reply-To: <20180223210901.23480-2-rasmus.villemoes@prevas.dk>
Message-ID: <alpine.DEB.2.21.1803011308440.1396@nanos.tec.linutronix.de>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk> <20180223210901.23480-1-rasmus.villemoes@prevas.dk> <20180223210901.23480-2-rasmus.villemoes@prevas.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018, Rasmus Villemoes wrote:
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>

of.h is already included from of_irq.h and of_address.h

> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +static int
> +ls_extirq_set_type(struct irq_data *data, unsigned int type)
> +{
> +	irq_hw_number_t hwirq = data->hwirq;
> +	struct extirq_chip_data *chip_data = data->chip_data;
> +	u32 value, mask;

Please order local variables in reverse fir tree fashion whenever
possible. That's way simpler to read:

	struct extirq_chip_data *chip_data = data->chip_data;
	irq_hw_number_t hwirq = data->hwirq;
	u32 value, mask;

> +
> +	if (chip_data->bit_reverse)
> +		mask = 1U << (31 - hwirq);
> +	else
> +		mask = 1U << hwirq;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_LOW:
> +		type = IRQ_TYPE_LEVEL_HIGH;
> +		value = mask;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		type = IRQ_TYPE_EDGE_RISING;
> +		value = mask;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +	case IRQ_TYPE_EDGE_RISING:
> +		value = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(chip_data->syscon, chip_data->intpcr, mask, value);
> +
> +	data = data->parent_data;
> +	return data->chip->irq_set_type(data, type);

  	irq_chip_set_type_parent() 

Thanks,

	tglx
