Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeAaQqr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:46:47 -0500
Received: from foss.arm.com ([217.140.101.70]:40146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753664AbeAaQqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:46:43 -0500
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
 <619608bb-a9c5-27a1-2383-5f6b2f455499@arm.com>
 <20180131162432.GA13231@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <83cfda67-511f-aa83-8eff-214c08de25e4@arm.com>
Date: Wed, 31 Jan 2018 16:46:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131162432.GA13231@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/18 16:24, Lina Iyer wrote:
> On Tue, Jan 30 2018 at 18:11 +0000, Marc Zyngier wrote:
>> On 30/01/18 17:56, Lina Iyer wrote:
>>> Hi Mark,
>>>
>>> On Wed, Jan 24 2018 at 14:20 +0000, Marc Zyngier wrote:
>>>> Hi Lina, Archana,
>>>>
>>>> On 23/01/18 17:56, Lina Iyer wrote:
>>>>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>>>>
>>>>> The Power Domain Controller (PDC) hardware block on Qualcomm SoCs houses
>>>>> an interrupt controller along with other domain control functions to
>>>>> handle interrupt related functions like handle falling edge or active
>>>>> low which are not detected at the GIC and handle wakeup interrupts.
>>>>>
>>>>> The interrupt controller is on an always-on domain for the purpose of
>>>>> waking up the processor, but only a subset of the processor's interrupts
>>>>> are routed through the PDC to the GIC. The PDC powers on the processor's
>>>>> domain, bringing the domain out of low power mode and replays the
>>>>> pending interrupts so the GIC may wake up the processor.
>>>>>
>>>>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>>>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>>> [Lina: Split out DT bindings target data and initialization changes]
>>>>> ---
>>>
>>> [...]
>>>
>>>>> +
>>>>> +static int qcom_pdc_translate(struct irq_domain *d,
>>>>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>>>>> +{
>>>>> +	return d->parent->ops->translate(d->parent, fwspec, hwirq, type);
>>>>
>>>> No way. The translate operation is local to your domain. You don't go
>>>> and fish in another domain's private stuff. Please implement your own.
>>>> The reason you're getting away with it is because you're in the DT by
>>>> providing the GIC SPI instead of the pin into the PDC.
>>>>
>>> I am looking into this approach. Was hoping to get some clarifications
>>> from you.
>>>
>>> The PDC sits between the device and the the GIC. Platform drivers
>>> receive their interrupts from GIC. They are not aware of the fact that
>>> the GIC may lose power and hand over its job to PDC. The platform
>>
>> I disagree here. If the PDC is between the device and the GIC, then the
>> device interrupt line is routed to the PDC, and nothing else. The PDC
>> itself is tied to the GIC, but that's none of the device's business.
>>
>> In general, the device shouldn't care about what interrupt controller it
>> is connected to. So please just describe the HW. There is about 10
>> similar configurations in the tree at the moment for the exact same
>> thing. They are simpler because their PDC equivalent has been designed
>> to exactly align with the GIC pins, but that's absolutely not a requirement.
>>
> This is exactly the case. The PDC is not aligned with GIC for all
> interrupts. To be a bit more clear than what I seem to conveyed, some
> interrupts are routed to the GIC and to the PDC and some are not.

And? That's not a problem. A single device can have some interrupts
routed to an interrupt controller, and some to another. See the OMAP
stuff and the use of interrupts-extended.

> Interrupts like USB that need to be detected for a falling edge or level
> low (i.e., not detected at the GIC) are routed through the PDC as well.
> The PDC detects these and re-triggers the GIC interrupts with the
> correct polarity so the GIC may sense it.
> 
> In another case, when the GIC is powered off, the PDC will continue to
> montior the interrupts routed through the PDC interrupt controller and
> if any of the enabled ones trigger, the PDC will wake up the GIC and
> replay the interrupts at the GIC.
> 
> To the device the presence of PDC is transparent, nor it is aware if the
> GIC was powered off while the interrupt was enabled.

The device never cares about the controller it's on, and none of that
affects the way it works. It is connected to a pin that has certain
properties, and that's about it.

> 
>>> drivers may configure an interrupt as a wakeup interrupt, in which case,
>>> we would wake up the CPU even if we are in system sleep or suspend mode.
>>> Platform driver don't know about the PDC pin or its configuration
>>> information. It makes it easier to keep that information contained
>>> within the PDC driver. Instead of getting the pin-hwirq map from the
>>> table as in patch #4, I can get that information cleanly from DT.
>>
>> That part is fine.
>>
>>>
>>>> Don't do that. Expose the pin in the DT, use the alloc method to map the
>>>> PDC pin into the GIC pin.
>>>>
>>> I would like to understand how you mean by this. I am thinking something
>>> like this in the dts -
>>>
>>> / {
>>> 	interrupt-controller = <&pdc>;
>>> 	soc {
>>> 		intc: interrupt-controller@176000 {
>>> 			[...]
>>> 			interrupt-controller;
>>> 			interrupt-parent = <&intc>;
>>> 		};
>>>
>>> 		pdc: interrupt-controller@210000 {
>>> 			[...]
>>> 			interrupt-controller;
>>> 			interrupt-parent = <&intc>;
>>> 			qcm,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
>>> 		};
>>>
>>> 		foo-device {
>>> 			interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
>>
>> Drop the GIC_SPI (you should only use it in the PDC driver itself when
>> requesting the GIC version of the interrupt), make sure 481 is a PDC pin
>> number (it looks like a GIC SPI to me), and *never* encode IRQ_TYPE_NONE
>> in DT (put the actual trigger type).
>>
> Sure, I just picked it up as an example.Yes, this is a GIC SPI and not a
> PDC port. This is what the platform drivers desire. They have an
> interrupt number assigned for their device and it would be preferrable
> for them to use this interrupt vector at the GIC in DT. They dont't want
> to know the PDC pin (even though the interrupt controller for the SoC
> may be the PDC in DT). This is because the devices that do not have their
> interrupt routed through the PDC, would anyways have only the GIC
> interrupt vector to provide. They have no PDC port available for them.
> The foo-device above is an example of one such device that does not have
> it's interrupt routed through the PDC (it doesn't fall in the
> pdc-ranges).
> 
> The PDC behaves more like arch extn to the GIC than a stacked interrupt
> controller in the hierarchy.

You're misguided here. Your PDC is not special, and it fits in the
existing framework just fine, just like all the other GPC, wakeupgen,
ictlr, and the rest.

> 
>>> 		};
>>> 	};
>>>  };
>>>
>>> Where the qcom,pdc-ranges is defined as -
>>> 	<pdc-pin-start interrupt-vector size-of-sequence>.
>>>
>>> For this example, the PDC map is established for pin0-pin93 using 94
>>> interrupts in sequence starting from 512 and so on. This allows for
>>> holes in the map per the hardware interrupt topology.
>>>
>>> I am not sure if you were asking to specify the pin in the 'interrupts'
>>> property in each device. I would like to avoid that as this may be an
>>> information that the device author may care less about. Would you agree?
>>
>> The way we represent these stacked interrupt controllers is by tying the
>> device to the closest interrupt controller. Look at
>>
> Did you miss a reference here?

Probably. I got tired.

> We looked at tegra's implementation and it appears similar, thought they
> don't seemt to have the same complexity.

Exactly. They are pretty similar. Hence my suggestion to adopt the same
approach, which you don't seem to agree with.

	M.
-- 
Jazz is not dead. It just smells funny...
