Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F8205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gcB7z3Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJHWdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:33:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53038 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJHWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:33:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98FKbmw092624;
        Mon, 8 Oct 2018 10:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539012037;
        bh=65tpNVw5Le7Aht/sv1ZlT5+e0ZBTeMT8kPXxNbH4NZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gcB7z3Eot60mWvZZO1U/ufyXsbiDEHDaWH0ycKU9PCZU+1j09wMxPJE612kiw2p+Y
         rn/rE5yU9sOb7Bka32SxK+g+INlCWycnCeKtVBeP5oVQGCMiJrfwET1K9za+XG8stC
         msMgjjysjw0pY2PQw1/rch/ObErd7O2KkVyThHaE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FKbtU008513;
        Mon, 8 Oct 2018 10:20:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 10:20:37 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 10:20:37 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FKW40002285;
        Mon, 8 Oct 2018 10:20:33 -0500
Subject: Re: [PATCH 2/2] irqchip: ti-sci-intr: Add support for Interrupt
 Router driver
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-3-lokeshvutla@ti.com>
 <86va6ftn5q.wl-marc.zyngier@arm.com>
 <5d43154a-81c0-2ff3-660d-fa46b33ac090@ti.com>
 <927a0b85-d989-2508-fa9d-6479bba3629c@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <93031647-aa9d-2bb8-3324-66578890a0dd@ti.com>
Date:   Mon, 8 Oct 2018 20:50:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <927a0b85-d989-2508-fa9d-6479bba3629c@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 08 October 2018 06:30 PM, Marc Zyngier wrote:
> Hi Lokesh,
> 
> On 08/10/18 10:48, Lokesh Vutla wrote:
>> Hi Marc,
>>
>> On 10/6/2018 3:25 PM, Marc Zyngier wrote:
>>> Hi Lokesh,
>>>
>>> On Sat, 06 Oct 2018 08:28:12 +0100,
>>> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>>
>>>> Texas Instruments' K3 generation SoCs has an IP Interrupt Router
>>>> that does allows for multiplexing of input interrupts to host
>>>> interrupt controller. Interrupt Router inputs are either from a
>>>> peripheral or from an Interrupt Aggregator which is another
>>>> interrupt controller.
>>>>
>>>> Configuration of the interrupt router registers can only be done by
>>>> a system co-processor and the driver needs to send a message to this
>>>> co processor over TISCI protocol.
>>>
>>> I assume that this co-processor only deals with the routing itself,
>>> and doesn't need to be talked to during interrupt processing, right?
>>
>> Yes, that's right.
>>
>>>
>>>>
>>>> Add support for Interrupt Router driver over TISCI protocol.
>>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>    MAINTAINERS                       |   1 +
>>>>    drivers/irqchip/Kconfig           |  11 +
>>>>    drivers/irqchip/Makefile          |   1 +
>>>>    drivers/irqchip/irq-ti-sci-intr.c | 325 ++++++++++++++++++++++++++++++
>>>>    4 files changed, 338 insertions(+)
>>>>    create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index a23778b68d74..cf3c834f8cee 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -14626,6 +14626,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>>>    F:	drivers/clk/keystone/sci-clk.c
>>>>    F:	drivers/reset/reset-ti-sci.c
>>>>    F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>> +F:	drivers/irqchip/irq-ti-sci-intr.c
>>>>    
>>>>    THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>>>>    M:	Hans Verkuil <hverkuil@xs4all.nl>
>>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>>> index 96451b581452..9a965fe22043 100644
>>>> --- a/drivers/irqchip/Kconfig
>>>> +++ b/drivers/irqchip/Kconfig
>>>> @@ -374,6 +374,17 @@ config QCOM_PDC
>>>>    	  Power Domain Controller driver to manage and configure wakeup
>>>>    	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>>>>    
>>>> +config TI_SCI_INTR_IRQCHIP
>>>> +	tristate "TISCI based Interrupt Router irqchip driver"
>>>> +	depends on TI_SCI_PROTOCOL && ARCH_K3
>>>> +	select IRQ_DOMAIN
>>>> +	select IRQ_DOMAIN_HIERARCHY
>>>> +	help
>>>> +	  This enables the irqchip driver support for K3 Interrupt router
>>>> +	  over TI System Control Interface available on some new TI's SoCs.
>>>> +	  If you wish to use interrupt router irq resources managed by the
>>>> +	  TI System Controller, say Y here. Otherwise, say N.
>>>
>>> I don't really see the point of making this user-selectable. If you're
>>> compiling support for a given platform, this platform configuration
>>> fragment should itself select the necessary dependencies for the
>>> system to work as expected. Here, you are leaving the choice to the
>>> user, with a 50% chance of getting a system that doesn't boot...
>>
>> There are 2 reasons why I made it tristate:
>> - Not all interrupts go through this irqchip(At least in the AM6 SoC
>> using this). Most of the legacy peripherals still are directly connected
>> to GIC
>> - TI_SCI_PROTOCOL is defined as tristate.
> 
> But as you said, these are "legacy" interrupts, and most of the
> interesting stuff is routed through the system controller. We also try
> not to have core interrupt controllers as modules. As for having the
> firmware interface as a module, I wonder what the use-case is.
> 
>> If you still feel I should not make it user-selectable, I can drop it.
> 
> I really wonder what the added value is for the user.

okay, will not make it use configurable in v2.

> 
>>
>>>
>>>> +
>>>>    endmenu
>>>>    
>>>>    config SIFIVE_PLIC
>>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>>> index b822199445ff..44bf65606d60 100644
>>>> --- a/drivers/irqchip/Makefile
>>>> +++ b/drivers/irqchip/Makefile
>>>> @@ -89,3 +89,4 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>>>>    obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>>>>    obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>>>>    obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>>>> +obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
>>>> new file mode 100644
>>>> index 000000000000..f04fe6da1b09
>>>> --- /dev/null
>>>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>>>> @@ -0,0 +1,325 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Texas Instruments' K3 Interrupt Router irqchip driver
>>>> + *
>>>> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>>>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/irqchip.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/of_irq.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/moduleparam.h>
>>>> +#include <linux/irqdomain.h>
>>>> +#include <linux/soc/ti/ti_sci_protocol.h>
>>>> +
>>>> +#define TI_SCI_DEV_ID_MASK	0xffff
>>>> +#define TI_SCI_DEV_ID_SHIFT	16
>>>> +#define TI_SCI_IRQ_ID_MASK	0xffff
>>>> +#define TI_SCI_IRQ_ID_SHIFT	0
>>>> +#define TI_SCI_IS_EVENT_IRQ	BIT(31)
>>>> +
>>>> +#define HWIRQ_TO_DEVID(HWIRQ)	(((HWIRQ) >> (TI_SCI_DEV_ID_SHIFT)) & \
>>>> +				 (TI_SCI_DEV_ID_MASK))
>>>> +#define HWIRQ_TO_IRQID(HWIRQ)	((HWIRQ) & (TI_SCI_IRQ_ID_MASK))
>>>
>>> nit: s/(HWIRQ)/(hwirq)/g
>>
>> okay.
>>
>>>
>>>> +
>>>> +/**
>>>> + * struct ti_sci_intr_irq_domain - Structure representing a TISCI based
>>>> + *				   Interrupt Router IRQ domain.
>>>> + * @sci:	Pointer to TISCI handle
>>>> + * @dst_irq:	TISCI resource pointer representing destination irq controller.
>>>> + * @dst_id:	TISCI device ID of the destination irq controller.
>>>> + */
>>>> +struct ti_sci_intr_irq_domain {
>>>> +	const struct ti_sci_handle *sci;
>>>> +	struct ti_sci_resource *dst_irq;
>>>> +	u16 dst_id;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct ti_sci_intr_irq_desc - Description of an Interrupt Router IRQ
>>>> + * @src_id:		TISCI device ID of the IRQ source
>>>> + * @src_index:		IRQ source index within the device.
>>>> + * @dst_irq:		Destination host IRQ.
>>>> + */
>>>> +struct ti_sci_intr_irq_desc {
>>>> +	u16 src_id;
>>>> +	u16 src_index;
>>>> +	u16 dst_irq;
>>>> +};
>>>
>>> Oh great. So this is reinventing the GICv3 ITS, only for SPIs. :-(
>>>
>>> Now, this structure seems completely useless, see below.
>>>
>>>> +
>>>> +static struct irq_chip ti_sci_intr_irq_chip = {
>>>> +	.name			= "INTR",
>>>> +	.irq_eoi		= irq_chip_eoi_parent,
>>>> +	.irq_mask		= irq_chip_mask_parent,
>>>> +	.irq_unmask		= irq_chip_unmask_parent,
>>>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>>> +	.irq_set_type		= irq_chip_set_type_parent,
>>>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>>> +};
>>>> +
>>>> +/**
>>>> + * ti_sci_intr_irq_domain_translate() - Retrieve hwirq and type from
>>>> + *					IRQ firmware specific handler.
>>>> + * @domain:	Pointer to IRQ domain
>>>> + * @fwspec:	Pointer to IRQ specific firmware structure
>>>> + * @hwirq:	IRQ number identified by hardware
>>>> + * @type:	IRQ type
>>>> + *
>>>> + * Return 0 if all went ok else appropriate error.
>>>> + */
>>>> +static int ti_sci_intr_irq_domain_translate(struct irq_domain *domain,
>>>> +					    struct irq_fwspec *fwspec,
>>>> +					    unsigned long *hwirq,
>>>> +					    unsigned int *type)
>>>> +{
>>>> +	if (is_of_node(fwspec->fwnode)) {
>>>> +		if (fwspec->param_count != 3)
>>>> +			return -EINVAL;
>>>> +
>>>> +		*hwirq = ((fwspec->param[0] & TI_SCI_DEV_ID_MASK) <<
>>>> +			  TI_SCI_DEV_ID_SHIFT) |
>>>> +			 (fwspec->param[1] & TI_SCI_IRQ_ID_MASK);
>>>
>>> Maybe it would make sense to have a macro that hides this:
>>
>> okay.
>>
>>>
>>>         	       *hwirq = FWSPEC_TO_HWIRQ(fwspec);
>>>
>>>> +		*type = fwspec->param[2];
>>>> +
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +static inline void ti_sci_intr_delete_desc(struct ti_sci_intr_irq_domain *intr,
>>>> +					   struct ti_sci_intr_irq_desc *desc)
>>>> +{
>>>> +	intr->sci->ops.rm_irq_ops.free_direct_irq(intr->sci, desc->src_id,
>>>> +						  desc->src_index,
>>>> +						  intr->dst_id, desc->dst_irq);
>>>
>>> This looks horrible. Why doesn't your firmware interface have a helper
>>> functions that hides this? Something like:
>>>
>>> 	ti_sci_free_direct_irq(intr, src_id, src_index, dst_irq);
>>>
>>> and you could even add some error checking.
>>
>> All existing TISCI users follow the same convention, so I did not bother adding
>> any such wrapper. Will update TISCI with these wrappers and see what firmware
>> maintainer says.
> 
> Frankly, exposing all kind of data structures to the world is a pretty
> poor form of abstraction, which is what the firmware is supposed to
> provide.
> 
> I'd strongly suggest that include/linux/soc/ti/ti_sci_protocol.h gets
> cleaned up, and that the whole ti_sci_ops disappears from the that file.
> Nobody outside of the firmware *implementation* needs to know about its,
> and it would be much better served by a set of helpers.
> 
> Finally, please make the TISCI interrupt management part of this series,
> so that I can review it as part of the code that uses it.

Sure, my next version will include TISCI interrupt management as well.

Thanks and regards,
Lokesh
