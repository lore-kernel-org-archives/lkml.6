Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935658AbeBLNkN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:40:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933300AbeBLNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:40:10 -0500
Date: Mon, 12 Feb 2018 14:40:14 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lina Iyer <ilina@codeaurora.org>
cc: jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH v6 1/2] drivers: irqchip: pdc: Add PDC interrupt controller
 for QCOM SoCs
In-Reply-To: <20180209165735.19151-2-ilina@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de>
References: <20180209165735.19151-1-ilina@codeaurora.org> <20180209165735.19151-2-ilina@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018, Lina Iyer wrote:
> +/*
> + * GIC does not handle falling edge or active low. To allow falling edge and
> + * active low interrupts to be handled at GIC, PDC has an inverter that inverts
> + * falling edge into a rising edge and active low into an active high.
> + * For the inverter to work, the polarity bit in the IRQ_CONFIG register has to
> + * set as per the table below.
> + * (polarity, falling edge, rising edge ) POLARITY
> + * 3'b0 00  Level sensitive active low    LOW
> + * 3'b0 01  Rising edge sensitive         NOT USED
> + * 3'b0 10  Falling edge sensitive        LOW
> + * 3'b0 11  Dual Edge sensitive           NOT USED
> + * 3'b1 00  Level sensitive active High   HIGH
> + * 3'b1 01  Falling Edge sensitive        NOT USED
> + * 3'b1 10  Rising edge sensitive         HIGH
> + * 3'b1 11  Dual Edge sensitive           HIGH
> + */
> +enum pdc_irq_config_bits {
> +	PDC_POLARITY_LOW	= 0,
> +	PDC_FALLING_EDGE	= 2,
> +	PDC_POLARITY_HIGH	= 4,
> +	PDC_RISING_EDGE		= 6,
> +	PDC_DUAL_EDGE		= 7,

My previous comment about using binary constants still stands. Please
either address review comments or reply at least. Ignoring reviews is not
an option.

Aside of that I really have to ask about the naming of these constants. Are
these names hardware register nomenclature? If yes, they are disgusting. If
no, they are still disgusting, but should be changed to sensible ones,
which just match the IRQ_TYPE naming convention.

    PDC_LEVEL_LOW	= 000b,
    PDC_EDGE_FALLING	= 010b,
    ....


> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		pdc_type = PDC_RISING_EDGE;
> +		type = IRQ_TYPE_EDGE_RISING;

Whats the point of assigning the same value again?

> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		pdc_type = PDC_FALLING_EDGE;
> +		type = IRQ_TYPE_EDGE_RISING;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		pdc_type = PDC_DUAL_EDGE;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		pdc_type = PDC_POLARITY_HIGH;
> +		type = IRQ_TYPE_LEVEL_HIGH;

Ditto

Thanks,

	tglx
