Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E855C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E93720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rVIqTaLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E93720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeK3MrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:47:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36461 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3MrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543541987; x=1575077987;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nuBQjkoNBHnA8e5JkbiKnr8fvMi+LuXfed+OuvM9GEI=;
  b=rVIqTaLlgU3ZbDtnPVDdeJvD5kYBAjaxC60KsX04xmISdfM0DHBdA0lf
   /psBHMr5KylcP6N8+rM8U/6XleDz69F8fLxEpVGzLqwSP6CxRNSUvuKpt
   VZrvbKqyLqlamO9wUA9Z7dknkTagE1+AaVckcA9sW8/tIcpG3W8ghszEf
   2IzCQNNtWP+u+5BcjwNlXqloJzGt16NWWGDIyAtcHJC+BgdGLxXwI3GEO
   di3n5gsDW1RVDnMwYoQipayhxubAgVhbdfOcEEu0BDzf2Ar5DM7zXlALT
   Gr58pipwHTpIu1vVKVVjwLHO6BsMk6BH1WB5rp2as8z4iWTdfsgM7GFAc
   g==;
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="100288448"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 09:39:46 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Nov 2018 17:22:11 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 17:39:46 -0800
Subject: Re: [PATCH v2 2/4] irqchip: sifive-plic: More flexible
 plic_irq_toggle()
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181127100317.12809-1-anup@brainfault.org>
 <20181127100317.12809-3-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <25c2fafc-a479-911f-a7df-704108da5dc7@wdc.com>
Date:   Thu, 29 Nov 2018 17:39:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127100317.12809-3-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 2:03 AM, Anup Patel wrote:
> We make plic_irq_toggle() more generic so that we can enable/disable
> hwirq for given cpumask. This generic plic_irq_toggle() will be
> eventually used to implement set_affinity for PLIC driver.
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/irqchip/irq-sifive-plic.c | 79 +++++++++++++++----------------
>   1 file changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 56fce648a901..95b4b92ca9b8 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -55,19 +55,26 @@
>   #define     CONTEXT_THRESHOLD		0x00
>   #define     CONTEXT_CLAIM		0x04
>   
> -static void __iomem *plic_regs;
> -
>   struct plic_handler {
>   	bool			present;
> -	int			ctxid;
>   	void __iomem		*hart_base;
>   	raw_spinlock_t		enable_lock;
>   	void __iomem		*enable_base;
>   };
> +
>   static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>   
> -static inline void plic_toggle(struct plic_handler *handler,
> -				int hwirq, int enable)
> +struct plic_hw {
> +	u32			nr_irqs;
> +	u32			nr_handlers;
> +	u32			nr_mapped;

Why these three are moved inside a structure? I don't see them being 
used outside plic_init. Am I missing something ?

> +	void __iomem		*regs;
> +	struct irq_domain	*irqdomain;
> +};
> +
> +static struct plic_hw plic;
> +
> +static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
>   {
>   	u32 __iomem *reg = handler->enable_base + (hwirq / 32);
>   	u32 hwirq_mask = 1 << (hwirq % 32);
> @@ -80,27 +87,23 @@ static inline void plic_toggle(struct plic_handler *handler,
>   	raw_spin_unlock(&handler->enable_lock);
>   }
>   
> -static inline void plic_irq_toggle(struct irq_data *d, int enable)
> +static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
>   {
>   	int cpu;
>   
> -	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> -	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
> -		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> -
> -		if (handler->present)
> -			plic_toggle(handler, d->hwirq, enable);
> -	}
> +	writel(enable, plic.regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
> +	for_each_cpu(cpu, mask)
> +		plic_toggle(per_cpu_ptr(&plic_handlers, cpu), hwirq, enable);

Any specific reason to remove the handler->present check.

Moreover, only this part matches commit text. Most of the other changes 
looks like cosmetic cleanup because of variable is moved to a structure.
May be separate patch for those changes if they are are required at all.

>   }
>   
>   static void plic_irq_enable(struct irq_data *d)
>   {
> -	plic_irq_toggle(d, 1);
> +	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
>   }
>   
>   static void plic_irq_disable(struct irq_data *d)
>   {
> -	plic_irq_toggle(d, 0);
> +	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 0);
>   }
>   
>   static struct irq_chip plic_chip = {
> @@ -127,8 +130,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>   	.xlate		= irq_domain_xlate_onecell,
>   };
>   
> -static struct irq_domain *plic_irqdomain;
> -
>   /*
>    * Handling an interrupt is a two-step process: first you claim the interrupt
>    * by reading the claim register, then you complete the interrupt by writing
> @@ -145,7 +146,7 @@ static void plic_handle_irq(struct pt_regs *regs)
>   
>   	csr_clear(sie, SIE_SEIE);
>   	while ((hwirq = readl(claim))) {
> -		int irq = irq_find_mapping(plic_irqdomain, hwirq);
> +		int irq = irq_find_mapping(plic.irqdomain, hwirq);
>   
>   		if (unlikely(irq <= 0))
>   			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
> @@ -174,36 +175,34 @@ static int plic_find_hart_id(struct device_node *node)
>   static int __init plic_init(struct device_node *node,
>   		struct device_node *parent)
>   {
> -	int error = 0, nr_handlers, nr_mapped = 0, i;
> -	u32 nr_irqs;
> +	int error = 0, i;
>   
> -	if (plic_regs) {
> +	if (plic.regs) {
>   		pr_warn("PLIC already present.\n");
>   		return -ENXIO;
>   	}
>   
> -	plic_regs = of_iomap(node, 0);
> -	if (WARN_ON(!plic_regs))
> +	plic.regs = of_iomap(node, 0);
> +	if (WARN_ON(!plic.regs))
>   		return -EIO;
>   
>   	error = -EINVAL;
> -	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> -	if (WARN_ON(!nr_irqs))
> +	of_property_read_u32(node, "riscv,ndev", &plic.nr_irqs);
> +	if (WARN_ON(!plic.nr_irqs))
>   		goto out_iounmap;
>   
> -	nr_handlers = of_irq_count(node);
> -	if (WARN_ON(!nr_handlers))
> +	plic.nr_handlers = of_irq_count(node);
> +	if (WARN_ON(!plic.nr_handlers))
>   		goto out_iounmap;
> -	if (WARN_ON(nr_handlers < num_possible_cpus()))
> +	if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
>   		goto out_iounmap;
>   
> -	error = -ENOMEM;
> -	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> -			&plic_irqdomain_ops, NULL);
> -	if (WARN_ON(!plic_irqdomain))
> +	plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
> +						&plic_irqdomain_ops, NULL);
> +	if (WARN_ON(!plic.irqdomain))
>   		goto out_iounmap;
>   

Should we return EINVAL if irq_domain_add_linear fails ? Earlier, it was 
returning ENOMEM.

> -	for (i = 0; i < nr_handlers; i++) {
> +	for (i = 0; i < plic.nr_handlers; i++) {
>   		struct of_phandle_args parent;
>   		struct plic_handler *handler;
>   		irq_hw_number_t hwirq;
> @@ -227,27 +226,27 @@ static int __init plic_init(struct device_node *node,
>   		cpu = riscv_hartid_to_cpuid(hartid);
>   		handler = per_cpu_ptr(&plic_handlers, cpu);
>   		handler->present = true;
> -		handler->ctxid = i;


The previous patch removed all the usage of ctxid. So this line also can 
be included in that patch as well to make it more coherent.


Regards,
Atish
>   		handler->hart_base =
> -			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> +			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
>   		raw_spin_lock_init(&handler->enable_lock);
>   		handler->enable_base =
> -			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
> +			plic.regs + ENABLE_BASE + i * ENABLE_PER_HART;
>   
>   		/* priority must be > threshold to trigger an interrupt */
>   		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
> -		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> +		for (hwirq = 1; hwirq <= plic.nr_irqs; hwirq++)
>   			plic_toggle(handler, hwirq, 0);
> -		nr_mapped++;
> +
> +		plic.nr_mapped++;
>   	}
>   
>   	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
> -		nr_irqs, nr_mapped, nr_handlers);
> +		plic.nr_irqs, plic.nr_mapped, plic.nr_handlers);
>   	set_handle_irq(plic_handle_irq);
>   	return 0;
>   
>   out_iounmap:
> -	iounmap(plic_regs);
> +	iounmap(plic.regs);
>   	return error;
>   }
>   
> 

