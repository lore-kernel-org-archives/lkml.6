Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ECE2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hUdDgCml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ECE2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbeHFWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:38:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59771 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbeHFWin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533587278; x=1565123278;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c6MIWcuq8ptwrNB+FEzYHhtW/vno8T8ADFDBISrt74U=;
  b=hUdDgCmlBWQl/Aq4OVm8RGj+5Ylb01lrz8YNx0h3pEVWOIPWAZUY6nLS
   PC8rTaGhjG/34bzQBgq6HKIPr04QwEgEOzlLe9Az37AJqhWizWwhesC+z
   G6Q5+XN6JZQN+citpb1+rHzkfG3MiAICUvgJoyUltaSpJ0w6hc9mxGsMD
   GX2GWQ4+C846jcvbVLJWuNU7qcTqozA4HcGvbScVeZWIyIhyGTaNe8Y7D
   Yvmr3Yx56TbYRMwCjx/TqDfRjBmhAKqnGZ1sYIx50JAQP1g/oa99EbXM5
   GQa8n7Hrk3EL+8LtrUZOnubaeEzUB+O/ixrBbYsTx6sXT9kOINmqbX+b4
   w==;
X-IronPort-AV: E=Sophos;i="5.51,452,1526313600"; 
   d="scan'208";a="190655614"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2018 04:27:58 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Aug 2018 13:15:39 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2018 13:27:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 7/8] irqchip: add a SiFive PLIC driver
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180804082319.5711-1-hch@lst.de>
 <20180804082319.5711-8-hch@lst.de>
Message-ID: <c190946c-eadb-8e35-91f1-26c7d7a4d2fc@wdc.com>
Date:   Mon, 6 Aug 2018 13:27:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804082319.5711-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/18 1:23 AM, Christoph Hellwig wrote:
> Adds a driver for the SiFive implementation of the RISC-V Platform Level
> Interrupt Controller (PLIC).  The PLIC connects global interrupt sources
> to the local interrupt controller on each hart.
> 
> This driver is based on the driver in the RISC-V tree from Palmer Dabbelt,
> but has been almost entirely rewritten since, and includes many fixes
> from Atish Patra.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/riscv/configs/defconfig      |   1 +
>   drivers/irqchip/Kconfig           |  12 ++
>   drivers/irqchip/Makefile          |   1 +
>   drivers/irqchip/irq-sifive-plic.c | 259 ++++++++++++++++++++++++++++++
>   4 files changed, 273 insertions(+)
>   create mode 100644 drivers/irqchip/irq-sifive-plic.c
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 07326466871b..36473d7dbaac 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -76,3 +76,4 @@ CONFIG_ROOT_NFS=y
>   CONFIG_CRYPTO_USER_API_HASH=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
> +CONFIG_SIFIVE_PLIC=y
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index e9233db16e03..df345b878ac2 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -372,3 +372,15 @@ config QCOM_PDC
>   	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>   
>   endmenu
> +
> +config SIFIVE_PLIC
> +	bool "SiFive Platform-Level Interrupt Controller"
> +	depends on RISCV
> +	help
> +	   This enables support for the PLIC chip found in SiFive (and
> +	   potentially other) RISC-V systems.  The PLIC controls devices
> +	   interrupts and connects them to each core's local interrupt
> +	   controller.  Aside from timer and software interrupts, all other
> +	   interrupt sources are subordinate to the PLIC.
> +
> +	   If you don't know what to do here, say Y.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15f268f646bf..fbd1ec8070ef 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
>   obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>   obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>   obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
> +obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> new file mode 100644
> index 000000000000..faacf428e250
> --- /dev/null
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2018 Christoph Hellwig
> + */
> +#define pr_fmt(fmt) "plic: " fmt
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +/*
> + * This driver implements a version of the RISC-V PLIC with the actual layout
> + * specified in chapter 8 of the SiFive U5 Coreplex Series Manual:
> + *
> + *     https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
> + *
> + * The largest number supported by devices marked as 'riscv,plic0', is 1024, of
> + * which device 0 is defined as non-existent by the RISC-V Privileged Spec.
> + */
> +
> +#define MAX_DEVICES			1024
> +#define MAX_CONTEXTS			15872
> +
> +/*
> + * Each interrupt source has a priority register associated with it.
> + * We always hardwire it to one in Linux.
> + */
> +#define PRIORITY_BASE			0
> +#define     PRIORITY_PER_ID		4
> +
> +/*
> + * Each hart context has a vector of interrupt enable bits associated with it.
> + * There's one bit for each interrupt source.
> + */
> +#define ENABLE_BASE			0x2000
> +#define     ENABLE_PER_HART		0x80
> +
> +/*
> + * Each hart context has a set of control registers associated with it.  Right
> + * now there's only two: a source priority threshold over which the hart will
> + * take an interrupt, and a register to claim interrupts.
> + */
> +#define CONTEXT_BASE			0x200000
> +#define     CONTEXT_PER_HART		0x1000
> +#define     CONTEXT_THRESHOLD		0x00
> +#define     CONTEXT_CLAIM		0x04
> +
> +static void __iomem *plic_regs;
> +
> +struct plic_handler {
> +	bool			present;
> +	int			ctxid;
> +};
> +static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> +
> +static inline void __iomem *plic_hart_offset(int ctxid)
> +{
> +	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
> +}
> +
> +static inline u32 __iomem *plic_enable_base(int ctxid)
> +{
> +	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
> +}
> +
> +/*
> + * Protect mask operations on the registers given that we can't assume that
> + * atomic memory operations work on them.
> + */
> +static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
> +
> +static inline void plic_toggle(int ctxid, int hwirq, int enable)
> +{
> +	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
> +	u32 hwirq_mask = 1 << (hwirq % 32);
> +
> +	raw_spin_lock(&plic_toggle_lock);
> +	if (enable)
> +		writel(readl(reg) | hwirq_mask, reg);
> +	else
> +		writel(readl(reg) & ~hwirq_mask, reg);
> +	raw_spin_unlock(&plic_toggle_lock);
> +}
> +
> +static inline void plic_irq_toggle(struct irq_data *d, int enable)
> +{
> +	int cpu;
> +
> +	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> +	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
> +		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +		if (handler->present)
> +			plic_toggle(handler->ctxid, d->hwirq, enable);
> +	}
> +}
> +
> +static void plic_irq_enable(struct irq_data *d)
> +{
> +	plic_irq_toggle(d, 1);
> +}
> +
> +static void plic_irq_disable(struct irq_data *d)
> +{
> +	plic_irq_toggle(d, 0);
> +}
> +
> +static struct irq_chip plic_chip = {
> +	.name		= "SiFive PLIC",
> +	/*
> +	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> +	 * by reading claim and "unmasked" when writing it back.
> +	 */
> +	.irq_enable	= plic_irq_enable,
> +	.irq_disable	= plic_irq_disable,
> +};
> +
> +static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, NULL);
> +	irq_set_noprobe(irq);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops plic_irqdomain_ops = {
> +	.map		= plic_irqdomain_map,
> +	.xlate		= irq_domain_xlate_onecell,
> +};
> +
> +static struct irq_domain *plic_irqdomain;
> +
> +/*
> + * Handling an interrupt is a two-step process: first you claim the interrupt
> + * by reading the claim register, then you complete the interrupt by writing
> + * that source ID back to the same claim register.  This automatically enables
> + * and disables the interrupt, so there's nothing else to do.
> + */
> +static void plic_handle_irq(struct pt_regs *regs)
> +{
> +	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
> +	irq_hw_number_t hwirq;
> +
> +	WARN_ON_ONCE(!handler->present);
> +
> +	csr_clear(sie, SIE_SEIE);
> +	while ((hwirq = readl(claim))) {
> +		int irq = irq_find_mapping(plic_irqdomain, hwirq);
> +
> +		if (unlikely(irq <= 0))
> +			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
> +					hwirq);
> +		else
> +			generic_handle_irq(irq);
> +		writel(hwirq, claim);
> +	}
> +	csr_set(sie, SIE_SEIE);
> +}
> +
> +/*
> + * Walk up the DT tree until we find a active RISC-V core (HART) node and
/s/a/an

> + * extract the cpuid from it.
> + */
> +static int plic_find_hart_id(struct device_node *node)
> +{
> +	for (; node; node = node->parent) {
> +		if (of_device_is_compatible(node, "riscv"))
> +			return riscv_of_processor_hart(node);
> +	}
> +
> +	return -1;
> +}
> +
> +static int __init plic_init(struct device_node *node,
> +		struct device_node *parent)
> +{
> +	int error = 0, nr_handlers, nr_mapped = 0, i;
> +	u32 nr_irqs;
> +
> +	if (plic_regs) {
> +		pr_warn("PLIC already present.\n");
> +		return -ENXIO;
> +	}
> +
> +	plic_regs = of_iomap(node, 0);
> +	if (WARN_ON(!plic_regs))
> +		return -EIO;
> +
> +	error = -EINVAL;
> +	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> +	if (WARN_ON(!nr_irqs))
> +		goto out_iounmap;
> +
> +	nr_handlers = of_irq_count(node);
> +	if (WARN_ON(!nr_handlers))
> +		goto out_iounmap;
> +	if (WARN_ON(nr_handlers < num_possible_cpus()))
> +		goto out_iounmap;
> +
> +	error = -ENOMEM;
> +	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> +			&plic_irqdomain_ops, NULL);
> +	if (WARN_ON(!plic_irqdomain))
> +		goto out_iounmap;
> +
> +	for (i = 0; i < nr_handlers; i++) {
> +		struct of_phandle_args parent;
> +		struct plic_handler *handler;
> +		irq_hw_number_t hwirq;
> +		int cpu;
> +
> +		if (of_irq_parse_one(node, i, &parent)) {
> +			pr_err("failed to parse parent for context %d.\n", i);
> +			continue;
> +		}
> +
> +		/* skip context holes */
> +		if (parent.args[0] == -1)
> +			continue;
> +
> +		cpu = plic_find_hart_id(parent.np);
> +		if (cpu < 0) {
> +			pr_warn("failed to parse hart ID for context %d.\n", i);
> +			continue;
> +		}
> +
> +		handler = per_cpu_ptr(&plic_handlers, cpu);
> +		handler->present = true;
> +		handler->ctxid = i;
> +
> +		/* priority must be > threshold to trigger an interrupt */
> +		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
> +		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> +			plic_toggle(i, hwirq, 0);
> +		nr_mapped++;
> +	}
> +
> +	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
> +		nr_irqs, nr_mapped, nr_handlers);
> +	set_handle_irq(plic_handle_irq);
> +	return 0;
> +
> +out_iounmap:
> +	iounmap(plic_regs);
> +	return error;
> +}
> +
> +IRQCHIP_DECLARE(sifive_plic0, "sifive,u5-plic", plic_init);
Should it be sifive,u54-plic ?

> +IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> 

Otherwise, Looks good to me. FWIW..
Reviewed-by: Atish Patra <atish.patra@wdc.com>

Regards,
Atish
