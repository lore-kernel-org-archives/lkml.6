Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBBQkU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:40:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBBQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:40:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2297C6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 2 Feb 2018 16:40:07 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC v2 1/3] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180202164007.GA5319@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-2-ilina@codeaurora.org>
 <e1322b9a-4765-3c71-84b8-cb725fe457dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e1322b9a-4765-3c71-84b8-cb725fe457dd@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02 2018 at 16:21 +0000, Marc Zyngier wrote:
>Hi Lina,
>
>On 02/02/18 14:21, Lina Iyer wrote:
>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>
>> The Power Domain Controller (PDC) on QTI SoCs like SDM845 houses an
>> interrupt controller along with other domain control functions to handle
>> interrupt related functions like handle falling edge or active low which
>> are not detected at the GIC and handle wakeup interrupts.
>>
>> The interrupt controller is on an always-on domain for the purpose of
>> waking up the processor. Only a subset of the processor's interrupts are
>> routed through the PDC to the GIC. The PDC powers on the processors'
>> domain, when in low power mode and replays pending interrupts so the GIC
>> may wake up the processor.
>>
>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> +struct pdc_pin_data {
>> +	int pin;
>> +	int hwirq;
>> +};
>
>I seriously doubt you need this structure, see below.
>
>> +
>> +static DEFINE_SPINLOCK(pdc_lock);
>> +static void __iomem *pdc_base;
>
>You only have one of those per SoC?
>
There is only one that Linux can control.

>> +static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +	int pin_out = d->hwirq;
>> +	enum pdc_irq_config_bits pdc_type;
>> +
>> +	switch (type) {
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		pdc_type = PDC_RISING_EDGE;
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		pdc_type = PDC_FALLING_EDGE;
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +		break;
>> +	case IRQ_TYPE_EDGE_BOTH:
>> +		pdc_type = PDC_DUAL_EDGE;
>> +		break;
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +		pdc_type = PDC_POLARITY_HIGH;
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>> +		break;
>> +	case IRQ_TYPE_LEVEL_LOW:
>> +		pdc_type = PDC_POLARITY_LOW;
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>> +		break;
>> +	default:
>> +		pdc_type = PDC_POLARITY_HIGH;
>> +		break;
>
>If this default clause triggers, something is pretty wrong. You may want
>to warn and bail out instead.
>
The hardware defaults to this. I can bail out as well.

>> +	}
>> +
>> +	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
>> +
>> +	return irq_chip_set_type_parent(d, type);
>> +}
>> +
>> +static struct irq_chip qcom_pdc_gic_chip = {
>> +	.name			= "pdc-gic",
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
>> +};
>> +
>> +static irq_hw_number_t get_irq_for_pin(int pin, struct pdc_pin_data *pdc_data)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; pdc_data[i].pin >= 0; i++)
>> +		if (pdc_data[i].pin == pin)
>> +			return pdc_data[i].hwirq;
>> +
>> +	return pin;
>> +}
>
>This is the function that irks me. The DT already gives you a nice set
>of ranges with all the information you need. And yet, you expand the
>whole thing into at most 127 structures, wasting memory and making the
>search time a function of the number of interrupts instead of being that
>of the number of regions. Not very nice. How about something like this
>(untested):
>
Duh! Why didn't I think of this.. Thanks.

>struct pin_region {
>	u32 pin_base;
>	u32 parent_base;
>	u32 cnt;
>};
>
>struct pin_region *pin_regions;
>int pin_region_count;
>
>static int pdc_pin_to_parent_hwirq(int pin)
>{
>	int i;
>
>	for (i = 0; i < pin_region_count; i++) {
>		if (pin >= pin_regions[i].pin_base &&
>		    pin < (pin_regions[i].pin_base + pin_regions[i].cnt)
>			return (pin_regions[i].parent_base + pin -
>				pin_regions[i].pin_base);
>	}
>
>	WARN();
>	return -1;
>}
>
>Less memory, less comparisons.
>
Agreed.

>> +
>> +static int qcom_pdc_translate(struct irq_domain *d,
>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>> +{
>> +	if (is_of_node(fwspec->fwnode)) {
>> +		if (fwspec->param_count < 3)
>> +			return -EINVAL;
>
>Why 3? Reading the DT binding, this is indeed set to 3 without any
>reason. I'd suggest this becomes 2, encoding the pin number and the
>trigger information, as the leading 0 is quite useless. Yes, I know
>other examples in the kernel are using this 0, and that was a
>consequence of retrofitting the omitted interrupt controllers (back in
>the days of the stupid gic_arch_extn...). Don't do that.
>
>> +
>> +		*hwirq = fwspec->param[1];
>> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>
>... and fix this accordingly.
>
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
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
>> +	parent_hwirq = get_irq_for_pin(hwirq, domain->host_data);
>> +	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +			&qcom_pdc_gic_chip, (void *)parent_hwirq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (type & IRQ_TYPE_EDGE_BOTH)
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +
>> +	if (type & IRQ_TYPE_LEVEL_MASK)
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>> +
>> +	parent_fwspec = *fwspec;
>> +	parent_fwspec.param[1] = parent_hwirq;
>> +	parent_fwspec.param[2] &= ~IRQ_TYPE_SENSE_MASK;
>> +	parent_fwspec.param[2] |= type;
>> +	parent_fwspec.fwnode = domain->parent->fwnode;
>
>This becomes:
>
>	parent_fwspec.fwnode = domain->parent->fwnode;
>	parent_fwspec.param_count = 3; // That's what the GIC wants
>	parent_fwspec.param[0] = 0; //GIC_SPI
>	parent_fwspec.param[1] = parent_hwirq;
>	parent_fwspec.param[2] = type;
>
Sure.

>> +
>> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>> +						&parent_fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops qcom_pdc_ops = {
>> +	.translate	= qcom_pdc_translate,
>> +	.alloc		= qcom_pdc_alloc,
>> +	.free		= irq_domain_free_irqs_common,
>> +};
>> +
>> +static int pdc_setup_pin_mapping(struct device_node *np,
>> +				struct pdc_pin_data **data)
>> +{
>> +	int ret;
>> +	int n, i, j, k, pins = 0;
>> +	int *val;
>> +	struct pdc_pin_data *map;
>> +
>> +	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
>> +	if (!n || n % 3)
>> +		return -EINVAL;
>> +
>> +	val = kcalloc(n, sizeof(u32), GFP_KERNEL);
>> +	if (!val)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(np, "qcom,pdc-ranges", val, n);
>> +	if (ret)
>> +		return ret;
>
>Memory leak.
>
Ok.

>> +
>> +	for (i = 0; i < n; i += 3)
>> +		pins += val[i + 2];
>> +
>> +	if (pins > PDC_MAX_IRQS)
>> +		return -EFAULT;
>
>EFAULT is for an actual page fault. If you get one here, you have
>bigger problems. EINVAL is better. is You're also leaking memory.
>
Ok.
>> +
>> +	map = kcalloc(pins + 1, sizeof(*map), GFP_KERNEL);
>> +	if (!map) {
>> +		ret = -ENOMEM;
>> +		goto fail;
>> +	}
>> +
>> +	for (i = 0, k = 0; i < n; i += 3) {
>> +		for (j = 0; j < val[i + 2]; j++, k++) {
>> +			map[k].pin = val[i] + j;
>> +			map[k].hwirq = val[i + 1] + j;
>> +		}
>> +	}
>
>That's the thing that needs to go. Just store the ranges as exposed by
>the DT, maybe with some checking that there is no overlap in the
>ranges (not that it matters much...).
>
Makes sense.

Thanks,
Lina
