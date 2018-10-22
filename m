Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A750C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6990320663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0IPMjMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6990320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeJVW4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:56:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45214 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeJVW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:56:11 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9MEZssS103698;
        Mon, 22 Oct 2018 09:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540218954;
        bh=GpTBx1kmd3jMdgASdakvix9wQw+7trRevLzvAL8sYhM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M0IPMjMk7kYmEsoyMcoHqdidgz6iKcY5rpLxAo9myqZyxc4L+uVfCr2sHgtULueWq
         hkekGCWTf9Ti10kfTef0y0gi/xbeWJ1sqMdPia6mYVKrfo5zAcxBf3edfiYkLqyV4z
         uSwlLBZCWOtuPXFHT9+t55RQ3xg6r6kWxjTiYtdE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9MEZswm016446;
        Mon, 22 Oct 2018 09:35:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 22
 Oct 2018 09:35:53 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 22 Oct 2018 09:35:53 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9MEZnQt009958;
        Mon, 22 Oct 2018 09:35:50 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
Date:   Mon, 22 Oct 2018 20:05:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b20127dc-be43-3b00-9960-663738df0069@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Friday 19 October 2018 08:52 PM, Marc Zyngier wrote:
> Hi Lokesh,
> 
> On 18/10/18 16:40, Lokesh Vutla wrote:
>> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
>> which is an interrupt controller that does the following:
>> - Converts events to interrupts that can be understood by
>>    an interrupt router.
>> - Allows for multiplexing of events to interrupts.
>> - Allows for grouping of multiple events to a single interrupt.
> 
> Aren't the last two points the same thing? Also, can you please define
> what an "event" is? What is its semantic? If they look like interrupts,
> can we just name them as such?

Event is actually a message sent by a master via an Event transport lane. Based 
on the id within the message, each message is directed to corresponding 
Interrupt Aggregator(IA). In turn IA raises a corresponding interrupt as 
configured for this event.

> 
>>
>> Configuration of the interrupt aggregator registers can only be done by
>> a system co-processor and the driver needs to send a message to this
>> co processor over TISCI protocol.
>>
>> Add support for Interrupt Aggregator driver over TISCI protocol.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Changes since v1:
>> - New patch
>>
>>   MAINTAINERS                             |   1 +
>>   drivers/irqchip/Kconfig                 |  11 +
>>   drivers/irqchip/Makefile                |   1 +
>>   drivers/irqchip/irq-ti-sci-inta.c       | 613 ++++++++++++++++++++++++
>>   include/linux/irqchip/irq-ti-sci-inta.h |  35 ++
>>   5 files changed, 661 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
>>   create mode 100644 include/linux/irqchip/irq-ti-sci-inta.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8cf1a6b73e6c..35c790ab0ae7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14689,6 +14689,7 @@ F:	drivers/reset/reset-ti-sci.c
>>   F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>   F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>>   F:	drivers/irqchip/irq-ti-sci-intr.c
>> +F:	drivers/irqchip/irq-ti-sci-inta.c
>>   
>>   THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>>   M:	Hans Verkuil <hverkuil@xs4all.nl>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index f6620a6bb872..895f6b47dc5b 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -385,6 +385,17 @@ config TI_SCI_INTR_IRQCHIP
>>   	  If you wish to use interrupt router irq resources managed by the
>>   	  TI System Controller, say Y here. Otherwise, say N.
>>   
>> +config TI_SCI_INTA_IRQCHIP
>> +	bool
>> +	depends on TI_SCI_PROTOCOL && ARCH_K3
>> +	select IRQ_DOMAIN
>> +	select IRQ_DOMAIN_HIERARCHY
>> +	help
>> +	  This enables the irqchip driver support for K3 Interrupt aggregator
>> +	  over TI System Control Interface available on some new TI's SoCs.
>> +	  If you wish to use interrupt aggregator irq resources managed by the
>> +	  TI System Controller, say Y here. Otherwise, say N.
>> +
>>   endmenu
>>   
>>   config SIFIVE_PLIC
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 44bf65606d60..aede4c1cc4a6 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -90,3 +90,4 @@ obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>>   obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>>   obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>> +obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
>> new file mode 100644
>> index 000000000000..ef0a2e8b782c
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -0,0 +1,613 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Texas Instruments' K3 Interrupt Aggregator irqchip driver
>> + *
>> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +
>> +#define MAX_EVENTS_PER_VINT	64
>> +#define TI_SCI_EVENT_IRQ	BIT(31)
>> +
>> +#define VINT_ENABLE_CLR_OFFSET	0x18
>> +
>> +/**
>> + * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
>> + *				   Interrupt Aggregator IRQ domain.
>> + * @sci:	Pointer to TISCI handle
>> + * @vint:	TISCI resource pointer representing IA inerrupts.
>> + * @global_event:TISCI resource pointer representing global events.
>> + * @base:	Base address of the memory mapped IO registers
>> + * @ia_id:	TISCI device ID of this Interrupt Aggregator.
>> + * @dst_id:	TISCI device ID of the destination irq controller.
>> + */
>> +struct ti_sci_inta_irq_domain {
>> +	const struct ti_sci_handle *sci;
>> +	struct ti_sci_resource *vint;
>> +	struct ti_sci_resource *global_event;
>> +	void __iomem *base;
>> +	u16 ia_id;
>> +	u16 dst_id;
>> +};
>> +
>> +/**
>> + * struct ti_sci_inta_event_desc - Description of an event coming to
>> + *				   Interrupt Aggregator.
>> + * @global_event:	Global event number corresponding to this event
>> + * @src_id:		TISCI device ID of the event source
>> + * @src_index:		Event source index within the device.
>> + */
>> +struct ti_sci_inta_event_desc {
>> +	u16 global_event;
>> +	u16 src_id;
>> +	u16 src_index;
>> +};
>> +
>> +/**
>> + * struct ti_sci_inta_vint_desc - Description of a virtual interrupt coming out
>> + *				  of Interrupt Aggregator.
>> + * @lock:		lock to guard the event map
>> + * @event_map:		Bitmap to manage the allocation of events to vint.
>> + * @events:		Array of event descriptors assigned to this vint.
>> + * @ack_needed:		Event needs to be acked via INTA. This is used when
>> + *			HW generating events cannot clear the events by itself.
>> + *			Assuming that only events from the same hw block are
>> + *			grouped. So all the events attached to vint needs
>> + *			an ack or none needs an ack.
>> + */
>> +struct ti_sci_inta_vint_desc {
>> +	raw_spinlock_t lock;
>> +	unsigned long *event_map;
>> +	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
>> +	bool ack_needed;
>> +};
>> +
>> +static void ti_sci_inta_irq_eoi(struct irq_data *data)
>> +{
>> +	struct ti_sci_inta_irq_domain *inta = data->domain->host_data;
>> +	struct ti_sci_inta_vint_desc *vint_desc;
>> +	u64 val;
>> +	int bit;
>> +
>> +	vint_desc = irq_data_get_irq_chip_data(data);
>> +	if (!vint_desc->ack_needed)
>> +		goto out;
>> +
>> +	for_each_set_bit(bit, vint_desc->event_map, MAX_EVENTS_PER_VINT) {
>> +		val = 1 << bit;
>> +		__raw_writeq(val, inta->base + data->hwirq * 0x1000 +
>> +			     VINT_ENABLE_CLR_OFFSET);
>> +	}
> 
> If you need an ack callback, why is this part of the eoi? We have
> interrupt flows that allow you to combine both, so why don't you use that?

Actually I started with ack_irq. But I did not see this callback being triggered 
when interrupt is raised. Then I was suggested to use irq_roi. Will see why 
ack_irq is not being triggered and  update it in next version.

> 
> Also, the __raw_writeq call is probably wrong, as it assumes that both
> the CPU and the INTA have the same endianness.

hmm.. May I know what is the right call to use here?

> 
>> +
>> +out:
>> +	irq_chip_eoi_parent(data);
>> +}
>> +
>> +static struct irq_chip ti_sci_inta_irq_chip = {
>> +	.name			= "INTA",
>> +	.irq_eoi		= ti_sci_inta_irq_eoi,
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>> +	.irq_set_type		= irq_chip_set_type_parent,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +};
>> +
>> +/**
>> + * ti_sci_inta_irq_domain_translate() - Retrieve hwirq and type from
>> + *					IRQ firmware specific handler.
>> + * @domain:	Pointer to IRQ domain
>> + * @fwspec:	Pointer to IRQ specific firmware structure
>> + * @hwirq:	IRQ number identified by hardware
>> + * @type:	IRQ type
>> + *
>> + * Return 0 if all went ok else appropriate error.
>> + */
>> +static int ti_sci_inta_irq_domain_translate(struct irq_domain *domain,
>> +					    struct irq_fwspec *fwspec,
>> +					    unsigned long *hwirq,
>> +					    unsigned int *type)
>> +{
>> +	if (is_of_node(fwspec->fwnode)) {
>> +		if (fwspec->param_count != 4)
>> +			return -EINVAL;
>> +
>> +		*hwirq = fwspec->param[2];
>> +		*type = fwspec->param[3] & IRQ_TYPE_SENSE_MASK;
>> +
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +/**
>> + * ti_sci_free_event_irq() - Free an event from vint
>> + * @inta:	Pointer to Interrupt Aggregator IRQ domain
>> + * @vint_desc:	Virtual interrupt descriptor containing the event.
>> + * @event_index:Event Index within the vint.
>> + * @dst_irq:	Destination host irq
>> + * @vint:	Interrupt number within interrupt aggregator.
>> + */
>> +static void ti_sci_free_event_irq(struct ti_sci_inta_irq_domain *inta,
>> +				  struct ti_sci_inta_vint_desc *vint_desc,
>> +				  u32 event_index, u16 dst_irq, u16 vint)
>> +{
>> +	struct ti_sci_inta_event_desc *event;
>> +	unsigned long flags;
>> +
>> +	if (event_index >= MAX_EVENTS_PER_VINT)
>> +		return;
> 
> How can this happen?
> 
>> +
>> +	event = &vint_desc->events[event_index];
>> +	inta->sci->ops.rm_irq_ops.free_event_irq(inta->sci,
>> +						 event->src_id,
>> +						 event->src_index,
>> +						 inta->dst_id,
>> +						 dst_irq,
>> +						 inta->ia_id, vint,
>> +						 event->global_event,
>> +						 event_index);
>> +
>> +	raw_spin_lock_irqsave(&vint_desc->lock, flags);
>> +	clear_bit(event_index, vint_desc->event_map);
>> +	raw_spin_unlock_irqrestore(&vint_desc->lock, flags);
> 
> clear_bit is atomic. Why do you need a spinlock?

will drop the spinlock guard here.

> 
>> +
>> +	ti_sci_release_resource(inta->global_event, event->global_event);
>> +}
>> +
>> +/**
>> + * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
>> + * @domain:	Domain to which the irqs belong
>> + * @virq:	base linux virtual IRQ to be freed.
>> + * @nr_irqs:	Number of continuous irqs to be freed
>> + */
>> +static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
>> +					unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
>> +	struct ti_sci_inta_vint_desc *vint_desc;
>> +	struct irq_data *data, *gic_data;
>> +	int event_index;
>> +
>> +	data = irq_domain_get_irq_data(domain, virq);
>> +	gic_data = irq_domain_get_irq_data(domain->parent->parent, virq);
> 
> That's absolutely horrid...

I agree. But I need to get GIC irq for sending TISCI message. Can you suggest a 
better way of doing it?

> 
>> +
>> +	vint_desc = irq_data_get_irq_chip_data(data);
>> +
>> +	/* This is the last event in the vint */
>> +	event_index = find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT);
> 
> What guarantees that you only have a single "event" left here?

As per the current implementation, ti_sci_inta_irq_domain_free() gets called 
only by irq_dispose_mapping. irq_dispose_mapping() will be called from 
ti_sci_inta_unregister_event() only if it is the last event attached to vint.

> 
>> +	ti_sci_free_event_irq(inta, vint_desc, event_index,
>> +			      gic_data->hwirq, data->hwirq);
>> +	irq_domain_free_irqs_parent(domain, virq, 1);
>> +	irq_domain_reset_irq_data(data);
>> +	ti_sci_release_resource(inta->vint, data->hwirq);
>> +	kfree(vint_desc->event_map);
>> +	kfree(vint_desc);
>> +}
>> +
>> +/**
>> + * ti_sci_allocate_event_irq() - Allocate an event to a IA vint.
>> + * @inta:	Pointer to Interrupt Aggregator IRQ domain
>> + * @vint_desc:	Virtual interrupt descriptor to which the event gets attached.
>> + * @src_id:	TISCI device id of the event source
>> + * @src_index:	Event index with in the device.
>> + * @dst_irq:	Destination host irq
>> + * @vint:	Interrupt number within interrupt aggregator.
>> + *
>> + * Return 0 if all went ok else appropriate error value.
>> + */
>> +static int ti_sci_allocate_event_irq(struct ti_sci_inta_irq_domain *inta,
>> +				     struct ti_sci_inta_vint_desc *vint_desc,
>> +				     u16 src_id, u16 src_index, u16 dst_irq,
>> +				     u16 vint)
>> +{
>> +	struct ti_sci_inta_event_desc *event;
>> +	unsigned long flags;
>> +	u32 free_bit;
>> +	int err;
>> +
>> +	raw_spin_lock_irqsave(&vint_desc->lock, flags);
>> +	free_bit = find_first_zero_bit(vint_desc->event_map,
>> +				       MAX_EVENTS_PER_VINT);
>> +	if (free_bit != MAX_EVENTS_PER_VINT)
>> +		set_bit(free_bit, vint_desc->event_map);
>> +	raw_spin_unlock_irqrestore(&vint_desc->lock, flags);
> 
> Why disabling the interrupts? Do you expect to take this lock
> concurrently with an interrupt? Why isn't it enough to just have a mutex
> instead?

I have thought about this while coding. We are attaching multiple events to the 
same interrupt. Technically the events from different IPs can be attached to the 
same interrupt or events from the same IP can be registered at different times. 
So I thought it is possible that when an event is being allocated to an 
interrupt, an event can be raised that belongs to the same interrupt.

> 
>> +
>> +	if (free_bit >= MAX_EVENTS_PER_VINT)
>> +		return -ENODEV;
>> +
>> +	event = &vint_desc->events[free_bit];
>> +
>> +	event->src_id = src_id;
>> +	event->src_index = src_index;
>> +	event->global_event = ti_sci_get_free_resource(inta->global_event);
> 
> Reading patch #5, shouldn't you at least test for the validity of what
> this function returns?

the below call will anyway fail and report the invlaid global_event. But you are 
right, will check for validity of global_event in my next version.

> 
>> +
>> +	err = inta->sci->ops.rm_irq_ops.set_event_irq(inta->sci,
>> +						      src_id, src_index,
>> +						      inta->dst_id,
>> +						      dst_irq,
>> +						      inta->ia_id,
>> +						      vint,
>> +						      event->global_event,
>> +						      free_bit);
>> +	if (err) {
>> +		pr_err("%s: Event allocation failed from src = %d, index = %d, to dst = %d,irq = %d,via ia_id = %d, vint = %d,global event = %d, status_bit = %d\n",
>> +		       __func__, src_id, src_index, inta->dst_id, dst_irq,
>> +		       inta->ia_id, vint, event->global_event, free_bit);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
>> + * @domain:	IRQ domain corresponding to Interrupt Aggregator
>> + * @virq:	Linux virtual IRQ number
>> + * @src_id:	TISCI device id of the event source
>> + * @src_index:	Event index with in the device.
>> + * @vint:	Virtual interrupt number within IA
>> + * @flags:	Corresponding IRQ flags
>> + *
>> + * Return pointer to vint descriptor if all went well else corresponding
>> + * error pointer.
>> + */
>> +static struct ti_sci_inta_vint_desc *alloc_parent_irq(struct irq_domain *domain,
> 
> Please rename this function to something less ambiguous (you've prefixed
> all functions so far, why not this one?).

Will fix it in my next version.

> 
>> +						      unsigned int virq,
>> +						      u32 src_id, u32 src_index,
>> +						      u32 vint, u32 flags)
>> +{
>> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
>> +	struct ti_sci_inta_vint_desc *vint_desc;
>> +	struct irq_data *gic_data;
>> +	struct irq_fwspec fwspec;
>> +	int err;
>> +
>> +	if (!irq_domain_get_of_node(domain->parent))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
>> +	if (!vint_desc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	vint_desc->event_map = kcalloc(BITS_TO_LONGS(MAX_EVENTS_PER_VINT),
>> +				       sizeof(*vint_desc->event_map),
>> +				       GFP_KERNEL);
>> +	if (!vint_desc->event_map) {
>> +		kfree(vint_desc);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	fwspec.fwnode = domain->parent->fwnode;
>> +	fwspec.param_count = 3;
>> +	/* Interrupt parent is Interrupt Router */
>> +	fwspec.param[0] = inta->ia_id;
>> +	fwspec.param[1] = vint;
>> +	fwspec.param[2] = flags | TI_SCI_EVENT_IRQ;
> 
> Why isn't that flag an additional parameter instead of mixing stuff
> coming from DT and things that are purely internal?

Since this is a single bit I tried to optimize the number of fields passing to 
the parent IRQ. Will update the INTR driver to take 4 fields in next version.

> 
>> +
>> +	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>> +	if (err)
>> +		goto err_irqs;
>> +
>> +	gic_data = irq_domain_get_irq_data(domain->parent->parent, virq);
>> +
>> +	raw_spin_lock_init(&vint_desc->lock);
>> +
>> +	err = ti_sci_allocate_event_irq(inta, vint_desc, src_id, src_index,
>> +					gic_data->hwirq, vint);
>> +	if (err)
>> +		goto err_events;
>> +
>> +	return vint_desc;
>> +
>> +err_events:
>> +	irq_domain_free_irqs_parent(domain, virq, 1);
>> +err_irqs:
>> +	ti_sci_release_resource(inta->vint, vint);
>> +	kfree(vint_desc);
>> +	return ERR_PTR(err);
>> +}
>> +
>> +/**
>> + * ti_sci_inta_irq_domain_alloc() - Allocate Interrupt aggregator IRQs
>> + * @domain:	Point to the interrupt aggregator IRQ domain
>> + * @virq:	Corresponding Linux virtual IRQ number
>> + * @nr_irqs:	Continuous irqs to be allocated
>> + * @data:	Pointer to firmware specifier
>> + *
>> + * Return 0 if all went well else appropriate error value.
>> + */
>> +static int ti_sci_inta_irq_domain_alloc(struct irq_domain *domain,
>> +					unsigned int virq, unsigned int nr_irqs,
>> +					void *data)
>> +{
>> +	struct ti_sci_inta_vint_desc *vint_desc;
>> +	struct irq_fwspec *fwspec = data;
>> +	int err;
>> +
>> +	vint_desc = alloc_parent_irq(domain, virq, fwspec->param[0],
>> +				     fwspec->param[1], fwspec->param[2],
>> +				     fwspec->param[3]);
> 
> Frankly, what is the point of doing that? Why don't you simply pass the
> fwspec?

okay, will fix in next version.

> 
>> +	if (IS_ERR(vint_desc))
>> +		return PTR_ERR(vint_desc);
>> +
>> +	err = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[2],
>> +					    &ti_sci_inta_irq_chip, vint_desc);
>> +
>> +	return err;
>> +}
>> +
>> +static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
>> +	.alloc		= ti_sci_inta_irq_domain_alloc,
>> +	.free		= ti_sci_inta_irq_domain_free,
>> +	.translate	= ti_sci_inta_irq_domain_translate,
>> +};
>> +
>> +static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
>> +{
>> +	struct irq_domain *parent_domain, *domain;
>> +	struct ti_sci_inta_irq_domain *inta;
>> +	struct device_node *parent_node;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	parent_node = of_irq_find_parent(dev_of_node(dev));
>> +	if (!parent_node) {
>> +		dev_err(dev, "Failed to get IRQ parent node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	parent_domain = irq_find_host(parent_node);
>> +	if (!parent_domain)
>> +		return -EPROBE_DEFER;
>> +
>> +	inta = devm_kzalloc(dev, sizeof(*inta), GFP_KERNEL);
>> +	if (!inta)
>> +		return -ENOMEM;
>> +
>> +	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
>> +	if (IS_ERR(inta->sci)) {
>> +		ret = PTR_ERR(inta->sci);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "ti,sci read fail %d\n", ret);
>> +		inta->sci = NULL;
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id",
>> +				   (u32 *)&inta->ia_id);
>> +	if (ret) {
>> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev,
>> +						 inta->ia_id,
>> +						 "ti,sci-rm-range-vint");
>> +	if (IS_ERR(inta->vint)) {
>> +		dev_err(dev, "VINT resource allocation failed\n");
>> +		return PTR_ERR(inta->vint);
>> +	}
>> +
>> +	inta->global_event =
>> +		devm_ti_sci_get_of_resource(inta->sci, dev,
>> +					    inta->ia_id,
>> +					    "ti,sci-rm-range-global-event");
>> +	if (IS_ERR(inta->global_event)) {
>> +		dev_err(dev, "Global event resource allocation failed\n");
>> +		return PTR_ERR(inta->global_event);
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	inta->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(inta->base))
>> +		return -ENODEV;
>> +
>> +	ret = of_property_read_u32(parent_node, "ti,sci-dst-id",
>> +				   (u32 *)&inta->dst_id);
>> +
>> +	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
>> +					  &ti_sci_inta_irq_domain_ops, inta);
>> +	if (!domain) {
>> +		dev_err(dev, "Failed to allocate IRQ domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>> + * @dev:	Device pointer to source generating the event
>> + * @src_id:	TISCI device ID of the event source
>> + * @src_index:	Event source index within the device.
>> + * @virq:	Linux Virtual IRQ number
>> + * @flags:	Corresponding IRQ flags
>> + * @ack_needed:	If explicit clearing of event is required.
>> + *
>> + * Creates a new irq and attaches to IA domain if virq is not specified
>> + * else attaches the event to vint corresponding to virq.
>> + * When using TISCI within the client drivers, source indexes are always
>> + * generated dynamically and cannot be represented in DT. So client
>> + * drivers should call this API instead of platform_get_irq().
> 
> NAK. Either this fits in the standard model, or we adapt the standard
> model to catter for your particular use case. But we don't define a new,
> TI specific API.
> 
> I have a hunch that if the IDs are generated dynamically, then the model
> we use for MSIs would fit this thing. I also want to understand what

hmm..I haven't thought about using MSI. Will try to explore it. But the "struct 
msi_msg" is not applicable in this case as device does not write to a specific 
location.

> this event is, and how drivers get notified that such an event has fired.

As said above, Event is a message being sent by a device using a hardware 
protocol. This message is sent over an Event Transport Lane(ETL) that 
understands this protocol. Based on the message ETL re directs the message to a 
specificed target(In our case it is interrupt Aggregator).

 From a client drivers(that generates this event) prespective, the following 
needs to be done:
- Get an index that is free and allocate it to a particular task.
- Request INTA driver to assign an irq for this index.
- do a request_irq baseed on the return value from the above step.

In case of grouping events, the client drivers has its own mechanism to identify 
the index that caused an interrupt(at least that is the case for the existing user).

More details can be found in TRM section 10.2.7 Interrupt Aggregator (INTR_AGGR) 
chapter[1]

[1] http://www.ti.com/lit/pdf/spruid7


> 
> So please explain what this is all about, and we'll work out something.
> In the meantime, I'll stop here for that particular patch.
> 

Thanks a lot for the detailed review.

Regards,
Lokesh

> Thanks,
> 
> 	M.
> 
