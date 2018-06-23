Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC5C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2AC24B78
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2AC24B78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeFWI4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 04:56:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeFWI4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 04:56:41 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWeLQ-0003c7-R3; Sat, 23 Jun 2018 10:56:33 +0200
Date:   Sat, 23 Jun 2018 10:56:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, shorne@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Clark <mjc@sifive.com>
Subject: Re: [PATCH 3/3] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <20180622232006.12158-4-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1806231041110.8650@nanos.tec.linutronix.de>
References: <20180622232006.12158-1-palmer@sifive.com> <20180622232006.12158-4-palmer@sifive.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Palmer Dabbelt wrote:
> +struct riscv_irq_data {
> +	struct irq_chip		chip;
> +	struct irq_domain	*domain;
> +	int			hart;
> +	char			name[20];
> +};
> +DEFINE_PER_CPU(struct riscv_irq_data, riscv_irq_data);

static ?

> +static void riscv_intc_irq(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	struct irq_domain *domain;
> +	unsigned long cause = csr_read(scause);
> +
> +	/*
> +	 * The high order bit of the trap cause register is always set for
> +	 * interrupts, which allows us to differentiate them from exceptions
> +	 * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
> +	 * need to mask it off here.
> +	 */
> +	WARN_ON((cause & (1UL << (PTR_BITS - 1))) == 0);

So what's the point of continuing here? 


> +	cause = cause & ~(1UL << (PTR_BITS - 1));

Please define a proper CAUSE_MASK or such as this is really hard to read.

> +/*
> + * On RISC-V systems local interrupts are masked or unmasked by writing the SIE
> + * (Supervisor Interrupt Enable) CSR.  As CSRs can only be written on the local
> + * hart, these functions can only be called on the hart that corresponds to the
> + * IRQ chip.  They are only called internally to this module, so they BUG_ON if
> + * this condition is violated rather than attempting to handle the error by
> + * forwarding to the target hart, as that's already expected to have been done.
> + */
> +static void riscv_irq_mask(struct irq_data *d)
> +{
> +	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
> +
> +	BUG_ON(smp_processor_id() != data->hart);
> +	csr_clear(sie, 1 << (long)d->hwirq);

What's the point of this type cast? Whether you shift by unsigned long or by
long does not really matter, right? I'd rather expected to see 1U << d->hwirq

> +static int __init riscv_intc_init(struct device_node *node, struct device_node *parent)
> +{
> +	int hart;
> +	struct riscv_irq_data *data;

Nit. Reverse fir tree ordering please

	struct riscv_irq_data *data;
	int hart;

Simpler to parse.

> +
> +	if (parent)
> +		return 0;

Hmm, that wants a comment because it's not clear why this is done for the
casual reader.

> +
> +	hart = riscv_of_processor_hart(node->parent);
> +	if (hart < 0)
> +		return -EIO;
> +
> +	data = &per_cpu(riscv_irq_data, hart);
> +	snprintf(data->name, sizeof(data->name), "riscv,cpu_intc,%d", hart);
> +	data->hart = hart;
> +	data->chip.name = data->name;
> +	data->chip.irq_mask = riscv_irq_mask;
> +	data->chip.irq_unmask = riscv_irq_unmask;
> +	data->chip.irq_enable = riscv_irq_enable;
> +	data->chip.irq_disable = riscv_irq_disable;
> +	data->domain = irq_domain_add_linear(node, PTR_BITS,
> +					     &riscv_irqdomain_ops, data);
> +	if (!data->domain)
> +		goto error_add_linear;
> +
> +	set_handle_irq(&riscv_intc_irq);
> +
> +	pr_info("%s: %lu local interrupts mapped\n", data->name, PTR_BITS);
> +	return 0;
> +
> +error_add_linear:
> +	pr_warning("%s: unable to add IRQ domain\n",
> +		   data->name);

One line please.

> +	return -ENXIO;

Thanks,

	tglx
