Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeBFWnw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:43:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeBFWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:43:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA8E660790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 6 Feb 2018 22:43:48 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        asathyak@codeaurora.org
Subject: Re: [PATCH v3 1/2] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180206224348.GA16504@codeaurora.org>
References: <20180206180905.29047-1-ilina@codeaurora.org>
 <20180206180905.29047-2-ilina@codeaurora.org>
 <86shadamdj.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86shadamdj.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2018 at 20:34 +0000, Marc Zyngier wrote:
>On Tue, 06 Feb 2018 18:09:04 +0000,
>Lina Iyer wrote:
>> +#define PDC_MAX_IRQS		126
>
>From v2: "Is that an absolute, architectural maximum? Or should it
>come from the DT (being the sum of all ranges that are provided by
>this PDC)?"
>
Architectural maximum. Sorry I forgot to respond earlier.

>> +static inline void pdc_reg_write(int reg, u32 i, u32 val)
>> +{
>> +	writel_relaxed(val, pdc_base + reg + i * sizeof(u32));
>> +}
>> +
>> +static inline u32 pdc_reg_read(int reg, u32 i)
>> +{
>> +	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
>> +}
>> +
>> +static inline void pdc_enable_intr(struct irq_data *d, bool on)
>
>You can loose the "inline" on these 3 function, I believe the compiler
>will do a pretty good job specialising them.
>
Ok.

>> + * 3'b0 00  Level sensitive active low    LOW
>> + * 3'b0 01  Rising edge sensitive         NOT USED
>> + * 3'b0 10  Falling edge sensitive        LOW
>> + * 3'b0 11  Dual Edge sensitive           NOT USED
>> + * 3'b1 00  Level senstive active High    HIGH
>
>sensitive
>
Ok

>> +
>> +static struct irq_chip qcom_pdc_gic_chip = {
>
>const?
>
>> +	.name			= "pdc-gic",
>
>Just call it "PDC".
>
OK to both.

>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_mask		= qcom_pdc_gic_mask,
>> +	.irq_unmask		= qcom_pdc_gic_unmask,
>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>> +	.irq_set_type		= qcom_pdc_gic_set_type,
>> +	.flags			= IRQCHIP_MASK_ON_SUSPEND |
>> +				  IRQCHIP_SET_TYPE_MASKED |
>> +				  IRQCHIP_SKIP_SET_WAKE,
>> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
>> +#ifdef CONFIG_SMP
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +#endif
>
>Is this supposed to work on any architecture other than arm64? If not,
>then you can loose the CONFIG_SMP, as there is no !SMP config on arm64.
>
Only ARM64 afaict. But who knows ? :)

>> +};
>> +
>> +static irq_hw_number_t get_parent_hwirq(int pin)
>> +{
>> +	int i;
>> +	struct pdc_pin_region *region;
>> +
>> +	for (i = 0; i < pdc_region_cnt; i++) {
>> +		region = &pdc_region[i];
>> +		if (pin >= region->pin_base &&
>> +		   pin < region->pin_base + region->cnt)
>> +			return (region->parent_base + pin - region->pin_base);
>> +	}
>> +
>> +	WARN_ON(1);
>> +	return pin;
>
>Do not return a valid value in case of error. Please return an error
>value that you will check in the caller. Otherwise you're feeding the
>GIC with a SPI number that is actually a PDC pin number. That is not
>going to have any positive effect.
>
How about the max of irq_hw_number_t ?

>> +static int qcom_pdc_alloc(struct irq_domain *domain,
>> +			unsigned int virq, unsigned int nr_irqs, void *data)
>> +{
>> +	struct irq_fwspec *fwspec = data;
>> +	struct irq_fwspec parent_fwspec;
>> +	irq_hw_number_t hwirq, parent_hwirq;
>> +	unsigned int type;
>> +	int ret;
>> +
>> +	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	parent_hwirq = get_parent_hwirq(hwirq);
>> +	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +					    &qcom_pdc_gic_chip,
>> +					    (void *)parent_hwirq);
>
>Nothing else in this driver should be concerned with the parent hwirq,
>so NULL should be an appropriate value for chip_data.
>
Yes, I forgot to remove it. I don't need this anymore.

>> +	region = kcalloc(n, sizeof(*region), GFP_KERNEL);
>> +	if (!region)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(np, "qcom,pdc-ranges", region, n);
>> +	if (ret) {
>> +		kfree(region);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pdc_region = (struct pdc_pin_region *)region;
>
>Oh please... Don't resort to that kind of hack. Next thing you know,
>someone will add a u8 field to that structure and you'll spend the
>following 2 hours trying to understand why it all went so wrong.
>Allocate a bounce buffer if you want, copy fields one by one, I don't
>care. Just don't do that. :-(
>
:) ok.

>> +	pdc_region_cnt = n / 3;
>> +
>> +	return 0;
>> +}
>> +
>> +int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>
>static.
>
OK.

>> +{
>> +	struct irq_domain *parent_domain, *pdc_domain;
>> +	int ret;
>> +
>> +	pdc_base = of_iomap(node, 0);
>> +	if (!pdc_base) {
>> +		pr_err("%s: unable to map PDC registers\n", node->full_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		pr_err("%s: unable to obtain PDC parent domain\n",
>> +		      node->full_name);
>
>Use %pOF instead of %s and node->full_name in all occurrences in this
>function  (see commit ce4fecf1fe15).
>
Sure.

>
>Thanks,
Once again thanks Marc.

-- Lina
