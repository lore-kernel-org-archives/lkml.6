Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CAD2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CAD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJHVHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:07:14 -0400
Received: from foss.arm.com ([217.140.101.70]:50668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHVHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:07:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F4FF80D;
        Mon,  8 Oct 2018 06:55:23 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934A23F5BC;
        Mon,  8 Oct 2018 06:55:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        tglx@linutronix.de, jason@lakedaemon.net,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <86tvlztmt1.wl-marc.zyngier@arm.com>
 <8a05f735-01bd-5c2d-fcfa-dcc00adffd0b@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <7e7e7778-c67d-5fc1-6b4a-52a7089a9691@arm.com>
Date:   Mon, 8 Oct 2018 14:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a05f735-01bd-5c2d-fcfa-dcc00adffd0b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 10:46, Lokesh Vutla wrote:
> Hi Marc,
> 
> On Saturday 06 October 2018 03:32 PM, Marc Zyngier wrote:
>> On Sat, 06 Oct 2018 08:28:11 +0100,
>> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>
>>> Add the DT binding documentation for Interrupt router driver.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> ---
>>>    .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
>>>    MAINTAINERS                                   |  1 +
>>>    2 files changed, 84 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>> new file mode 100644
>>> index 000000000000..681ca53cc5fb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>> @@ -0,0 +1,83 @@
>>> +Texas Instruments K3 Interrupt Router
>>> +=====================================
>>> +
>>> +The Interrupt Router (INTR) module provides a mechanism to mux M
>>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>>> +controls the selection.
>>> +
>>> +
>>> +                                 Interrupt Router
>>> +                             +----------------------+
>>> +                             |  Inputs     Outputs  |
>>> +        +-------+            | +------+             |
>>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>>> +        +-------+            | +------+             |      controller
>>> +                             |    .        +-----+  |      +-------+
>>> +        +-------+            |    .        |  0  |  |----->|  GIC  |
>>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>>> +        +-------+            |    .          .      |
>>> +                             | +------+      .      |
>>> +                             | | irqM |    +-----+  |
>>> +                             | +------+    |  N  |  |
>>> +                             |             +-----+  |
>>> +                             +----------------------+
>>> +
>>> +Configuration of these MUXCNTL_N registers is done by a system controller
>>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>>> +controller will keep track of the used and unused registers within the Router.
>>> +Driver should request the system controller to get the range of GIC IRQs
>>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>>> +track of GIC IRQs.
>>
>> I would drop the GIC here, and replace it by "parent interrupt
>> controller", as nothing here is GIC specific
>>
>>> +
>>> +Communication between the host processor running an OS and the system
>>> +controller happens through a protocol called TI System Control Interface
>>> +(TISCI protocol). For more details refer:
>>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>> +
>>> +TISCI Interrupt Router Node:
>>> +----------------------------
>>> +- compatible:		Must be "ti,sci-intr".
>>> +- interrupt-controller:	Identifies the node as an interrupt controller
>>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>>> +			interrupt source. The value should be 3.
>>> +			First cell should contain the TISCI device ID of source
>>> +			Second cell should contain the interrupt source offset
>>> +			within the device
>>> +			Third cell specifies the trigger type as defined
>>> +			in interrupts.txt in this directory.
>>
>> Are all trigger types supported?
> 
> Nope, only level interrupts are supported. Will fix it in v2.
> 
>>
>>> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
>>> +			use the same interrupt-cells format as GIC.
>>
>> Why that constraint? From what I can see, the two are fairly
>> independent, and the constraint looks more of a Linux driver issue
>> than a DT constraint.
> 
> Driver when calling irq_domain_alloc_irqs_parent(), the fwspec node that gets
> passed assumes that parent is gic. parameters are filled in with such
> assumption. Do you suggest anything to make it more generic?

As I said, that's a Linux driver issue, not a DT specification at all. 
It is not worth it trying to generalize it in the driver implementation, 
but the DT spec it self should be generic enough.

> 
>>
>>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>>> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
>>> +			defines the dst host irq ranges assigned to this
>>> +			interrupt router from this host context.
>>> +			Tuple should be of format <type subtype>.
>>> +
> 
> Thanks a lot for the review. Also, I need a suggestion regarding one more
> interrupt controller(Interrupt Aggregator) on the same SoC controlled by
> TISCI_PROTOCOL.
> 
> The Interrupt Aggregator (INTA) provides a centralized machine
> which handles the termination of system events to that they can
> be coherently processed by the host(s) in the system. Integration looks
> something similar https://pastebin.ubuntu.com/p/T32vbrwsch/ .
> 
> Configuration of the Intmap registers that maps global events to vint is done
> by a system controller (like the Device Memory and Security Controller on K3
> AM654 SoC). Driver should request the system controller to get the range
> of global events and vints assigned to the requesting host. Management
> of these requested resources should be handled by driver and requests
> system controller to map specific global event to vint, bit pair.

I'm sorry, but I really have no idea what the global events and the 
vints are. Maybe you should describe what this is all about, and maybe 
provide a pointer to some documentation...

> 
> There can be cases such that IRQ routes can involve both INTR and INTA like below:
> 	IP ---> INTA ---> INTR ----> GIC.
> 
> In these cases TISCI involves only one message with parametes(source id, source
> offset, inta_id, dst id) for configuring IRQ route till the destination. Co
> processor will detect there is INTR in the IRQ path and configure that as well.
> 
> Right now I kind of differentiated this scenario in INTA driver by passing a
> flag(TI_SCI_EVENT) to INTR driver. If such flag comes, INTR driver should avoid
> calling ti_sci api for configuring. Do you think this is the right direction or
> do you suggest a better solution.

Frankly, it mostly indicates that the firmware does too much, and should 
be more flexible.

> If I am not clear in the above description, I can post an RFC for INTA driver
> for continuing this discussion.

That'd be preferable, IMO. Please provide definitions for all the above 
jargon, as well as pointers to publicly available documentation, if any.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
