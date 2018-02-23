Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeBWNhY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:37:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeBWNhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:37:22 -0500
Subject: Re: [PATCH RFC v2 1/3] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Lina Iyer <ilina@codeaurora.org>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-2-ilina@codeaurora.org>
 <e1322b9a-4765-3c71-84b8-cb725fe457dd@arm.com>
 <02e2a5f9-8ecc-76b1-a3cc-c95b215e8fe1@prevas.dk>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8a482f9c-9d2c-cea9-137e-2ce367c0f903@arm.com>
Date: Fri, 23 Feb 2018 13:37:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <02e2a5f9-8ecc-76b1-a3cc-c95b215e8fe1@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On 23/02/18 12:16, Rasmus Villemoes wrote:
> On 2018-02-02 15:58, Marc Zyngier wrote:
>> Hi Lina,
>>
>> On 02/02/18 14:21, Lina Iyer wrote:
>>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>>
>>> +
>>> +static int qcom_pdc_translate(struct irq_domain *d,
>>> +	struct irq_fwspec *fwspec, unsigned long *hwirq, unsigned int *type)
>>> +{
>>> +	if (is_of_node(fwspec->fwnode)) {
>>> +		if (fwspec->param_count < 3)
>>> +			return -EINVAL;
>>
>> Why 3? Reading the DT binding, this is indeed set to 3 without any
>> reason. I'd suggest this becomes 2, encoding the pin number and the
>> trigger information, as the leading 0 is quite useless. Yes, I know
>> other examples in the kernel are using this 0, and that was a
>> consequence of retrofitting the omitted interrupt controllers (back in
>> the days of the stupid gic_arch_extn...). Don't do that.
>>
> 
> Hi Marc
> 
> I'm about to send out a new revision of the ls-extirq patchset, and
> thanks to you pointing me to these patches, I've read the comments on
> the various revisions of this series and tried to take those into
> account. But the above confused me, because in response to my first RFC
> (https://patchwork.kernel.org/patch/10102643/) we have
> 
> On 2017-12-08 17:09, Marc Zyngier wrote:
>> On 08/12/17 15:11, Alexander Stein wrote:
>>> Hi Rasmus,
>>>
>>>> +
>>>> +Required properties:
>>>> +- compatible: should be "fsl,ls1021a-extirq"
>>>> +- interrupt-controller: Identifies the node as an interrupt controller
>>>> +- #interrupt-cells: Use the same format as specified by GIC in
> arm,gic.txt.
>>>
>>> Do you really need 3 interrupt-cells here? As you've written below
> you don't
>>> support PPI anyway the 1st flag might be dropped then. So support
> just 2 cells:
>>> * IRQ number (IRQ0 - IRQ5)
>>> * IRQ flags
>>
>> The convention for irqchip stacked on top of a GIC is to keep the
>> interrupt specifier the same. It makes the maintenance if the DT much
>> easier, and doesn't hurt at all.
> 
> Personally, I'd actually prefer the simpler interrupt specifiers without
> a redundant 0. Maybe I'm just missing some difference between this case
> and the ls-extirq one?
The difference is that you're adding a new irqchip to an existing DT,
and you get some possible breakage. Maybe you'd be happy with the
breakage, that's your call (and the maintainer's). In the QC case, it is
old brand new, so no harm in doing the right thing from day one.

It is in the end an implementation decision, and you could go either way.

Hope this helps,

	M.
-- 
Jazz is not dead. It just smells funny...
