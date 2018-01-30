Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeA3R46 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:56:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeA3R44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:56:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1391F601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 30 Jan 2018 17:56:54 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC 1/4] drivers: irqchip: pdc: add support for PDC
 interrupt controller
Message-ID: <20180130175654.GC20815@codeaurora.org>
References: <20180123175656.11942-1-ilina@codeaurora.org>
 <20180123175656.11942-2-ilina@codeaurora.org>
 <9dd8307c-4906-4707-d4d7-2ef0fc8307b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9dd8307c-4906-4707-d4d7-2ef0fc8307b6@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jan 24 2018 at 14:20 +0000, Marc Zyngier wrote:
>Hi Lina, Archana,
>
>On 23/01/18 17:56, Lina Iyer wrote:
>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>
>> The Power Domain Controller (PDC) hardware block on Qualcomm SoCs houses
>> an interrupt controller along with other domain control functions to
>> handle interrupt related functions like handle falling edge or active
>> low which are not detected at the GIC and handle wakeup interrupts.
>>
>> The interrupt controller is on an always-on domain for the purpose of
>> waking up the processor, but only a subset of the processor's interrupts
>> are routed through the PDC to the GIC. The PDC powers on the processor's
>> domain, bringing the domain out of low power mode and replays the
>> pending interrupts so the GIC may wake up the processor.
>>
>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> [Lina: Split out DT bindings target data and initialization changes]
>> ---

[...]

>> +
>> +static int qcom_pdc_translate(struct irq_domain *d,
>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>> +{
>> +	return d->parent->ops->translate(d->parent, fwspec, hwirq, type);
>
>No way. The translate operation is local to your domain. You don't go
>and fish in another domain's private stuff. Please implement your own.
>The reason you're getting away with it is because you're in the DT by
>providing the GIC SPI instead of the pin into the PDC.
>
I am looking into this approach. Was hoping to get some clarifications
from you.

The PDC sits between the device and the the GIC. Platform drivers
receive their interrupts from GIC. They are not aware of the fact that
the GIC may lose power and hand over its job to PDC. The platform
drivers may configure an interrupt as a wakeup interrupt, in which case,
we would wake up the CPU even if we are in system sleep or suspend mode.
Platform driver don't know about the PDC pin or its configuration
information. It makes it easier to keep that information contained
within the PDC driver. Instead of getting the pin-hwirq map from the
table as in patch #4, I can get that information cleanly from DT.

>Don't do that. Expose the pin in the DT, use the alloc method to map the
>PDC pin into the GIC pin.
>
I would like to understand how you mean by this. I am thinking something
like this in the dts -

/ {
	interrupt-controller = <&pdc>;
	soc {
		intc: interrupt-controller@176000 {
			[...]
			interrupt-controller;
			interrupt-parent = <&intc>;
		};

		pdc: interrupt-controller@210000 {
			[...]
			interrupt-controller;
			interrupt-parent = <&intc>;
			qcm,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
		};

		foo-device {
			interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
		};
	};
 };

Where the qcom,pdc-ranges is defined as -
	<pdc-pin-start interrupt-vector size-of-sequence>.

For this example, the PDC map is established for pin0-pin93 using 94
interrupts in sequence starting from 512 and so on. This allows for
holes in the map per the hardware interrupt topology.

I am not sure if you were asking to specify the pin in the 'interrupts'
property in each device. I would like to avoid that as this may be an
information that the device author may care less about. Would you agree?

If I completely missed your point, would you please care to elaborate?

Thanks,
Lina
