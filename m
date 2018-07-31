Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A83C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCAF208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="WbbtLq0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCAF208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeGaE7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:59:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46532 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeGaE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533008059; x=1564544059;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WDAQdHA83oU3Q0uoMkR54HPQsTmgxNl3agMqzfPLfzQ=;
  b=WbbtLq0aYX5tjwZsWLKUjDSGIc9NKJvkXGd091EY+duSoP/BFr4OVW+9
   U+I98LmWci066dUfGXVusRxn7z/QG3XSsdDIUJRG/r2HFbGDFcy0v0Sae
   ZfFyDHmji1BWRcPsaYewSxhihn7xQbW6wdH2nsxxbCOyixmyTuXFJfttq
   V3oHvSoRJ6GVK6ISDxZgMR2JQ9y/IZ3GG8eC5KqqYEh/P51OTeWDIxrqu
   /Qad+dW9r1c8jstfyHjET3QStyZtrBiy9L68MiisB9D2dk83THSZL9iBf
   GGO5EZaxHpoVngItHyIZzoShvLuX/0cyH+mg0puf+c1LF4c99IYDzyidV
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,425,1526313600"; 
   d="scan'208";a="182735243"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2018 11:34:03 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2018 20:09:26 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2018 20:21:33 -0700
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-8-hch@lst.de>
 <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <dc69d688-f765-74cc-3234-563fecff6002@wdc.com>
Date:   Mon, 30 Jul 2018 20:21:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 5:04 PM, Atish Patra wrote:
> On 7/26/18 7:38 AM, Christoph Hellwig wrote:
>> This patch adds a driver for the Platform Level Interrupt Controller (PLIC)
>> specified as part of the RISC-V supervisor level ISA manual, in the memory
>> layout implemented by SiFive and qemu.
>>
>> The PLIC connects global interrupt sources to the local interrupt controller
>> on each hart.
>>
>> This driver is based on the driver in the RISC-V tree from Palmer Dabbelt,
>> but has been almost entirely rewritten since.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I tried to boot HighFive Unleashed with the patch series after applying
> all the patches from riscv-all branch except timer & irq patches. It
> gets stuck pretty early.
> 
> Here is my github repo with all the changes:
> https://github.com/atishp04/riscv-linux/commits/master_chris_cleanup_hifive
> 
> I am still looking into it.
> 

I found the issue. As per PLIC documentation, a hart context is a given 
privilege mode on a given hart. Thus, cpu context ID & cpu numbers are 
not same. Here is the PLIC register Maps in U54 core:

Ref: https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf

Memory address for Interrupt enable
Address
0x0C00-2080   Hart 1 M-mode enables
0x0C00 2094   End of Hart 1 M-mode enables

0x0C00-2100   Hart 1 S-mode enables
0x0C00-2114   End of Hart 1 S-mode enables

Memory map Claim/Threshold
Address
0x0C20-1000 4B 	 M-mode priority threshold
0x0C20-1004 4B   M-mode claim/complete
0x0C20-2000 4B   S-mode priority threshold
0x0C20-2004 4B   S-mode claim/complete

The original PLIC patch was calculating based on handle->contextid which 
will assume numbers on a HighFive Unleashed board as 2 4 6 8.

In this patch, context id is assigned as cpu numbers which will be 1 2 3 
4. Thus it will lead to incorrect plic address access as shown below.

CPU1 enable register:
plic: plic_toggle: In for hwirq = [1] ctxid [1] reg = [0x2080]
plic: plic_toggle: In for hwirq = [32] ctxid [1] reg = [0x2084]


Palmer: Did I miss something?
> 
> FWIW, here is the boot log.
> --------- Boot log -------------------------------------------
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=5
> [    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
> [    0.000000] plic: mapped 53 interrupts to 4 (out of 9) handlers.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
> max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000000] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 2.00 BogoMIPS (lpj=10000)
> [    0.010000] pid_max: default: 32768 minimum: 301
> [    0.010000] Mount-cache hash table entries: 16384 (order: 5, 131072
> bytes)
> [    0.020000] Mountpoint-cache hash table entries: 16384 (order: 5,
> 131072 bytes)
> [    0.020000] Hierarchical SRCU implementation.
> [    0.030000] smp: Bringing up secondary CPUs ...
>> ---
>>    drivers/irqchip/Kconfig          |  13 ++
>>    drivers/irqchip/Makefile         |   1 +
>>    drivers/irqchip/irq-riscv-plic.c | 219 +++++++++++++++++++++++++++++++
>>    3 files changed, 233 insertions(+)
>>    create mode 100644 drivers/irqchip/irq-riscv-plic.c
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index e9233db16e03..5ac6dd922a0d 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -372,3 +372,16 @@ config QCOM_PDC
>>    	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>>    
>>    endmenu
>> +
>> +config RISCV_PLIC
>> +	bool "Platform-Level Interrupt Controller"
>> +	depends on RISCV
>> +	default y
>> +	help
>> +	   This enables support for the PLIC chip found in standard RISC-V
>> +	   systems.  The PLIC controls devices interrupts and connects them to
>> +	   each core's local interrupt controller.  Aside from timer and
>> +	   software interrupts, all other interrupt sources (MSI, GPIO, etc)
>> +	   are subordinate to the PLIC.
>> +
>> +	   If you don't know what to do here, say Y.
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 15f268f646bf..bf9238da8a31 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
>>    obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>>    obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>>    obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>> +obj-$(CONFIG_RISCV_PLIC)		+= irq-riscv-plic.o
>> diff --git a/drivers/irqchip/irq-riscv-plic.c b/drivers/irqchip/irq-riscv-plic.c
>> new file mode 100644
>> index 000000000000..274fe2cba544
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-riscv-plic.c
>> @@ -0,0 +1,219 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2017 SiFive
>> + * Copyright (C) 2018 Christoph Hellwig
>> + */
>> +#define pr_fmt(fmt) "plic: " fmt
>> +#include <linux/cpumask.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +/*
>> + * From the RISC-V Priviledged Spec v1.10:
>> + *
>> + * Global interrupt sources are assigned small unsigned integer identifiers,
>> + * beginning at the value 1.  An interrupt ID of 0 is reserved to mean "no
>> + * interrupt".  Interrupt identifiers are also used to break ties when two or
>> + * more interrupt sources have the same assigned priority. Smaller values of
>> + * interrupt ID take precedence over larger values of interrupt ID.
>> + *
>> + * While the RISC-V supervisor spec doesn't define the maximum number of
>> + * devices supported by the PLIC, the largest number supported by devices
>> + * marked as 'riscv,plic0' (which is the only device type this driver supports,
>> + * and is the only extant PLIC as of now) is 1024.  As mentioned above, device
>> + * 0 is defined to be non-existent so this device really only supports 1023
>> + * devices.
>> + */
>> +#define MAX_DEVICES			1024
>> +#define MAX_CONTEXTS			15872
>> +
> 
> Is there any way we can preserve some of the comments in the original
> patch about memory-mapped control registers or at least a reference
> where to find the register offset calculations?
> 
> IMHO, it is helpful for anybody who is not familiar with the details.
>> +/*
>> + * Each interrupt source has a priority register associated with it.
>> + * We always hardwire it to one in Linux.
>> + */
>> +#define PRIORITY_BASE			0
>> +#define	    PRIORITY_PER_ID		4
>> +
>> +/*
>> + * Each hart context has a vector of interupt enable bits associated with it.
>> + * There's one bit for each interrupt source.
>> + */
>> +#define ENABLE_BASE			0x2000
>> +#define     ENABLE_PER_HART		0x80
>> +
>> +/*
>> + * Each hart context has a set of control registers associated with it.  Right
>> + * now there's only two: a source priority threshold over which the hart will
>> + * take an interrupt, and a register to claim interrupts.
>> + */
>> +#define CONTEXT_BASE			0x200000
>> +#define     CONTEXT_PER_HART		0x1000
>> +#define     CONTEXT_THRESHOLD		0x00
>> +#define     CONTEXT_CLAIM		0x04
>> +
>> +static void __iomem *plic_regs;
>> +
>> +static inline void __iomem *plic_hart_offset(int ctxid)
>> +{
>> +	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
>> +}
>> +
>> +/*
>> + * Protect mask operations on the registers given that we can't assume that
>> + * atomic memory operations work on them.
>> + */
>> +static DEFINE_SPINLOCK(plic_toggle_lock);
>> +
>> +static inline void plic_toggle(int ctxid, int hwirq, int enable)
>> +{
>> +	u32 __iomem *reg = plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
> 
> shouldn't it be
> u32 __iomem *reg = plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART +
> (hwirq / 32) * 4;
> 
> Without that change, plic_handle_irq() gets called before irq mapping as
> plic was not disabled for that irq.
> 
> As per comment in the original patch,
> --------------------------------------------------------------
> * base + 0x002000: Enable bits for sources 0-31 on context 0
> * base + 0x002004: Enable bits for sources 32-63 on context 0
> --------------------------------------------------------------
> 
>> +	u32 hwirq_mask = 1 << (hwirq % 32);
>> +
>> +	spin_lock(&plic_toggle_lock);
>> +	if (enable)
>> +		writel(readl(reg) | hwirq_mask, reg);
>> +	else
>> +		writel(readl(reg) & ~hwirq_mask, reg);
>> +	spin_unlock(&plic_toggle_lock);
>> +}
>> +
>> +static inline void plic_irq_toggle(struct irq_data *d, int enable)
>> +{
>> +	int cpu;
>> +
>> +	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>> +	for_each_present_cpu(cpu)
>> +		plic_toggle(cpu, d->hwirq, enable);
>> +}
>> +
>> +static void plic_irq_enable(struct irq_data *d)
>> +{
>> +	plic_irq_toggle(d, 1);
>> +}
>> +
>> +static void plic_irq_disable(struct irq_data *d)
>> +{
>> +	plic_irq_toggle(d, 0);
>> +}
>> +
>> +static struct irq_chip plic_chip = {
>> +	.name		= "riscv,plic0",
>> +	/*
>> +	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>> +	 * by reading claim and "unmasked" when writing it back.
>> +	 */
>> +	.irq_enable	= plic_irq_enable,
>> +	.irq_disable	= plic_irq_disable,
>> +};
>> +
>> +static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>> +			      irq_hw_number_t hwirq)
>> +{
>> +	irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, NULL);
>> +	irq_set_noprobe(irq);
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops plic_irqdomain_ops = {
>> +	.map		= plic_irqdomain_map,
>> +	.xlate		= irq_domain_xlate_onecell,
>> +};
>> +
>> +static struct irq_domain *plic_irqdomain;
>> +
>> +/*
>> + * Handling an interrupt is a two-step process: first you claim the interrupt
>> + * by reading the claim register, then you complete the interrupt by writing
>> + * that source ID back to the same claim register.  This automatically enables
>> + * and disables the interrupt, so there's nothing else to do.
>> + */
>> +static void plic_handle_irq(struct pt_regs *regs)
>> +{
>> +	void __iomem *claim =
>> +		plic_hart_offset(smp_processor_id()) + CONTEXT_CLAIM;
>> +	irq_hw_number_t hwirq;
>> +
>> +	csr_clear(sie, SIE_STIE);
>> +	while ((hwirq = readl(claim))) {
>> +		int irq = irq_find_mapping(plic_irqdomain, hwirq);
>> +
>> +		if (unlikely(irq <= 0)) {
>> +			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
>> +					hwirq);
> 
> Ratlimiting the warning message here didn't help as ack_bad_irq() still
> print message still flooded the console without any useful info.
> 
> Regards,
> Atish
>> +			ack_bad_irq(irq);
>> +		} else {
>> +			generic_handle_irq(irq);
>> +		}
>> +		writel(hwirq, claim);
>> +	}
>> +	csr_set(sie, SIE_STIE);
>> +}
>> +
>> +static int __init plic_init(struct device_node *node,
>> +		struct device_node *parent)
>> +{
>> +	int error = 0, nr_mapped = 0, nr_handlers, cpu;
>> +	u32 nr_irqs;
>> +
>> +	if (plic_regs) {
>> +		pr_warning("PLIC already present.\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	plic_regs = of_iomap(node, 0);
>> +	if (WARN_ON(!plic_regs))
>> +		return -EIO;
>> +
>> +	error = -EINVAL;
>> +	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
>> +	if (WARN_ON(!nr_irqs))
>> +		goto out_iounmap;
>> +
>> +	nr_handlers = of_irq_count(node);
>> +	if (WARN_ON(!nr_handlers))
>> +		goto out_iounmap;
>> +	if (WARN_ON(nr_handlers < num_possible_cpus()))
>> +		goto out_iounmap;
>> +
>> +	error = -ENOMEM;
>> +	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
>> +			&plic_irqdomain_ops, NULL);
>> +	if (WARN_ON(!plic_irqdomain))
>> +		goto out_iounmap;
>> +
>> +	/*
>> +	 * We assume that each present hart is wire up to the PLIC.
>> +	 * If that isn't the case in the future this code will need to be
>> +	 * modified.
>> +	 */
>> +	for_each_present_cpu(cpu) {
>> +		irq_hw_number_t hwirq;
>> +
>> +		/* priority must be > threshold to trigger an interrupt */
>> +		writel(0, plic_hart_offset(cpu) + CONTEXT_THRESHOLD);
In correct context id as explained above.

>> +		for (hwirq = 1; hwirq <= nr_irqs; ++hwirq)
>> +			plic_toggle(cpu, hwirq, 0);

In correct context id as explained above.


Regards,
Atish
>> +		nr_mapped++;
>> +	}
>> +
>> +	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
>> +		nr_irqs, nr_mapped, nr_handlers);
>> +	set_handle_irq(plic_handle_irq);
>> +	return 0;
>> +
>> +out_iounmap:
>> +	iounmap(plic_regs);
>> +	return error;
>> +}
>> +
>> +IRQCHIP_DECLARE(plic0, "riscv,plic0", plic_init);
>>
> 
> 

