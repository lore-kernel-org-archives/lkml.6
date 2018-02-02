Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeBBQlM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:41:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeBBQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:41:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 973DA601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 2 Feb 2018 16:41:02 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC v2 1/3] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180202164102.GB5319@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-2-ilina@codeaurora.org>
 <alpine.DEB.2.21.1802021551150.1472@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802021551150.1472@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All valid comments. Will fix them all in the next rev.

Thanks Thomas.

-- Lina

On Fri, Feb 02 2018 at 15:37 +0000, Thomas Gleixner wrote:
>On Fri, 2 Feb 2018, Lina Iyer wrote:
>> +static inline void pdc_enable_intr(struct irq_data *d, bool on)
>> +{
>> +	int pin_out = d->hwirq;
>> +	u32 index, mask;
>> +	u32 enable;
>> +	unsigned long flags;
>> +
>> +	index = pin_out / 32;
>> +	mask = pin_out % 32;
>> +
>> +	spin_lock_irqsave(&pdc_lock, flags);
>
>Please make this a raw spinlock. Aside of that the _irqsave() is pointless
>as the chip callbacks are already called with interrupts disabled.
>
>> +	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
>> +	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
>
>You really should cache the enable register content to avoid the read back
>
>> +	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
>> +	spin_unlock_irqrestore(&pdc_lock, flags);
>> +}
>> +
>> +static void qcom_pdc_gic_mask(struct irq_data *d)
>> +{
>> +	pdc_enable_intr(d, false);
>> +	irq_chip_mask_parent(d);
>> +}
>> +
>> +static void qcom_pdc_gic_unmask(struct irq_data *d)
>> +{
>> +	pdc_enable_intr(d, true);
>> +	irq_chip_unmask_parent(d);
>> +}
>> +
>> +/*
>> + * GIC does not handle falling edge or active low. To allow falling edge and
>> + * active low interrupts to be handled at GIC, PDC has an inverter that inverts
>> + * falling edge into a rising edge and active low into an active high.
>> + * For the inverter to work, the polarity bit in the IRQ_CONFIG register has to
>> + * set as per the table below.
>> + * (polarity, falling edge, rising edge ) POLARITY
>> + * 3'b0 00  Level sensitive active low    LOW
>> + * 3'b0 01  Rising edge sensitive         NOT USED
>> + * 3'b0 10  Falling edge sensitive        LOW
>> + * 3'b0 11  Dual Edge sensitive           NOT USED
>> + * 3'b1 00  Level senstive active High    HIGH
>> + * 3'b1 01  Falling Edge sensitive        NOT USED
>> + * 3'b1 10  Rising edge sensitive         HIGH
>> + * 3'b1 11  Dual Edge sensitive           HIGH
>> + */
>> +enum pdc_irq_config_bits {
>> +	PDC_POLARITY_LOW	= 0, // 0 00
>
>What's wrong with
>
>       PDC_POLARITY_LOW		= 000b,
>       PDC_FALLING_EDGE		= 010b,
>
>instead of decimal and these weird comments ?
>
>> +static irq_hw_number_t get_irq_for_pin(int pin, struct pdc_pin_data *pdc_data)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; pdc_data[i].pin >= 0; i++)
>> +		if (pdc_data[i].pin == pin)
>> +			return pdc_data[i].hwirq;
>
>Please let the for() loop have braces. See:
>
>       https://marc.info/?l=linux-kernel&m=148467980905537&w=2
>
>> +
>> +	return pin;
>> +}
>> +
>> +static int qcom_pdc_translate(struct irq_domain *d,
>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>
>Please align the arguments right of the opening brace:
>
>static int qcom_pdc_translate(struct irq_domain *d,
>			      struct irq_fwspec *fwspec, unsigned long *hwirq,
>			      unsigned int *type)
>
>
>> +{
>> +	if (is_of_node(fwspec->fwnode)) {
>> +		if (fwspec->param_count < 3)
>> +			return -EINVAL;
>> +
>> +		*hwirq = fwspec->param[1];
>> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int qcom_pdc_alloc(struct irq_domain *domain,
>> +			unsigned int virq, unsigned int nr_irqs, void *data)
>
>Ditto
>
>> +static int pdc_setup_pin_mapping(struct device_node *np,
>> +				struct pdc_pin_data **data)
>> +{
>> +	int ret;
>> +	int n, i, j, k, pins = 0;
>> +	int *val;
>
>I have no idea what's the rationale behind these 3 lines of int declarations.
>
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
>> +
>> +	for (i = 0; i < n; i += 3)
>> +		pins += val[i + 2];
>> +
>> +	if (pins > PDC_MAX_IRQS)
>> +		return -EFAULT;
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
>This all is really horrible to read. First of all the val[] array. That can
>be represented in a structure, right? Without looking at the DT patch the
>code lets me assume:
>
>   struct pdcrange {
>   	u32	pin;
>	u32	hwirq;
>	u32	numpins;
>	u32	unused;
>   };
>
>So the above becomes:
>
>	nelm = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
>	if (!nelm || nelm % 3)
>		return -EINVAL;
>
>	nranges = nelm / 4;
>	ranges = kcalloc(nranges, sizeof(*prng), GFP_KERNEL);
>	if (!ranges)
>		return -ENOMEM;
>
>which makes the pin counting readable:
>
>	for (i = 0; i < nranges; i++)
>		pins += ranges[i].numpins;
>
>And then allows to write the map initialization with:
>
>	*data = map;
>	for (i = 0; i < nranges; i++) {
>		for (j = 0; j < ranges[i].numpins; j++, map++) {
>			map->pin = ranges[i].pin + j;
>			map->hwirq = ranges[i].hwirq + j;
>		}
>	}
>	map->pin = -1;
>
>Hmm?
>
>> +int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	struct irq_domain *parent_domain, *pdc_domain;
>> +	struct pdc_pin_data *pdc_data = NULL;
>> +	int ret;
>> +
>> +	pdc_base = of_iomap(node, 0);
>> +	if (!pdc_base) {
>> +		pr_err("%s(): unable to map PDC registers\n", node->full_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		pr_err("unable to obtain PDC parent domain\n");
>> +		ret = -ENXIO;
>> +		goto failure;
>> +	}
>> +
>> +	ret = pdc_setup_pin_mapping(node, &pdc_data);
>
>You can let pdc_setup_pin_mapping() return a pointer to pdc_data or NULL
>and check the pointer for ERR or NULL instead of having that ret
>indirection.
>
>> +	if (ret) {
>> +		pr_err("failed to setup PDC pin mapping\n");
>> +		goto failure;
>> +	}
>> +
>> +	pdc_domain = irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
>> +					of_fwnode_handle(node), &qcom_pdc_ops,
>> +					pdc_data);
>
>See comment about argument alignement above. Hint: shortening the *_domain
>variable names helps.
>
>Thanks,
>
>	tglx
