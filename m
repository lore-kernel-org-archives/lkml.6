Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbeA3SLt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:11:49 -0500
Received: from foss.arm.com ([217.140.101.70]:56804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753467AbeA3SLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:11:45 -0500
Subject: Re: [PATCH RFC 1/4] drivers: irqchip: pdc: add support for PDC
 interrupt controller
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
References: <20180123175656.11942-1-ilina@codeaurora.org>
 <20180123175656.11942-2-ilina@codeaurora.org>
 <9dd8307c-4906-4707-d4d7-2ef0fc8307b6@arm.com>
 <20180130175654.GC20815@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <619608bb-a9c5-27a1-2383-5f6b2f455499@arm.com>
Date: Tue, 30 Jan 2018 18:11:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130175654.GC20815@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/18 17:56, Lina Iyer wrote:
> Hi Mark,
> 
> On Wed, Jan 24 2018 at 14:20 +0000, Marc Zyngier wrote:
>> Hi Lina, Archana,
>>
>> On 23/01/18 17:56, Lina Iyer wrote:
>>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>>
>>> The Power Domain Controller (PDC) hardware block on Qualcomm SoCs houses
>>> an interrupt controller along with other domain control functions to
>>> handle interrupt related functions like handle falling edge or active
>>> low which are not detected at the GIC and handle wakeup interrupts.
>>>
>>> The interrupt controller is on an always-on domain for the purpose of
>>> waking up the processor, but only a subset of the processor's interrupts
>>> are routed through the PDC to the GIC. The PDC powers on the processor's
>>> domain, bringing the domain out of low power mode and replays the
>>> pending interrupts so the GIC may wake up the processor.
>>>
>>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>> [Lina: Split out DT bindings target data and initialization changes]
>>> ---
> 
> [...]
> 
>>> +
>>> +static int qcom_pdc_translate(struct irq_domain *d,
>>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>>> +{
>>> +	return d->parent->ops->translate(d->parent, fwspec, hwirq, type);
>>
>> No way. The translate operation is local to your domain. You don't go
>> and fish in another domain's private stuff. Please implement your own.
>> The reason you're getting away with it is because you're in the DT by
>> providing the GIC SPI instead of the pin into the PDC.
>>
> I am looking into this approach. Was hoping to get some clarifications
> from you.
> 
> The PDC sits between the device and the the GIC. Platform drivers
> receive their interrupts from GIC. They are not aware of the fact that
> the GIC may lose power and hand over its job to PDC. The platform

I disagree here. If the PDC is between the device and the GIC, then the
device interrupt line is routed to the PDC, and nothing else. The PDC
itself is tied to the GIC, but that's none of the device's business.

In general, the device shouldn't care about what interrupt controller it
is connected to. So please just describe the HW. There is about 10
similar configurations in the tree at the moment for the exact same
thing. They are simpler because their PDC equivalent has been designed
to exactly align with the GIC pins, but that's absolutely not a requirement.

> drivers may configure an interrupt as a wakeup interrupt, in which case,
> we would wake up the CPU even if we are in system sleep or suspend mode.
> Platform driver don't know about the PDC pin or its configuration
> information. It makes it easier to keep that information contained
> within the PDC driver. Instead of getting the pin-hwirq map from the
> table as in patch #4, I can get that information cleanly from DT.

That part is fine.

> 
>> Don't do that. Expose the pin in the DT, use the alloc method to map the
>> PDC pin into the GIC pin.
>>
> I would like to understand how you mean by this. I am thinking something
> like this in the dts -
> 
> / {
> 	interrupt-controller = <&pdc>;
> 	soc {
> 		intc: interrupt-controller@176000 {
> 			[...]
> 			interrupt-controller;
> 			interrupt-parent = <&intc>;
> 		};
> 
> 		pdc: interrupt-controller@210000 {
> 			[...]
> 			interrupt-controller;
> 			interrupt-parent = <&intc>;
> 			qcm,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
> 		};
> 
> 		foo-device {
> 			interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;

Drop the GIC_SPI (you should only use it in the PDC driver itself when
requesting the GIC version of the interrupt), make sure 481 is a PDC pin
number (it looks like a GIC SPI to me), and *never* encode IRQ_TYPE_NONE
in DT (put the actual trigger type).

> 		};
> 	};
>  };
> 
> Where the qcom,pdc-ranges is defined as -
> 	<pdc-pin-start interrupt-vector size-of-sequence>.
> 
> For this example, the PDC map is established for pin0-pin93 using 94
> interrupts in sequence starting from 512 and so on. This allows for
> holes in the map per the hardware interrupt topology.
> 
> I am not sure if you were asking to specify the pin in the 'interrupts'
> property in each device. I would like to avoid that as this may be an
> information that the device author may care less about. Would you agree?

The way we represent these stacked interrupt controllers is by tying the
device to the closest interrupt controller. Look at

> 
> If I completely missed your point, would you please care to elaborate?

Hope the above helps,

	M.
-- 
Jazz is not dead. It just smells funny...
