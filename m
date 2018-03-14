Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeCNRmL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:42:11 -0400
Received: from foss.arm.com ([217.140.101.70]:57418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbeCNRmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:42:09 -0400
Subject: Re: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and workarounds
To: Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
 <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com>
 <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com>
 <20180314165708.daoui66waxvicciq@lakrids.cambridge.arm.com>
 <alpine.DEB.2.21.1803141808350.2481@nanos.tec.linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8e20eae8-aa9f-28a4-3e7d-3d8ec71b2953@arm.com>
Date: Wed, 14 Mar 2018 17:42:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803141808350.2481@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/18 17:11, Thomas Gleixner wrote:
> On Wed, 14 Mar 2018, Mark Rutland wrote:
>> On Tue, Mar 13, 2018 at 06:35:07PM +0000, Marc Zyngier wrote:
>>> On 13/03/18 17:51, Mark Rutland wrote:
>>>> On Tue, Mar 13, 2018 at 05:21:00PM +0000, Marc Zyngier wrote:
>>>>> As kexec and kdump are getting used a bit more intensively, I've been
>>>>> made aware of a number of shortcomings.
>>>>>
>>>>> The main gripe is from folks trying to launch a kdump kernel from
>>>>> within an interrupt handler. If using EOImode==1, things work as
>>>>> expected. If using EOImode==0 (such as in a guest), the secondary
>>>>> kernel hangs as the previous interrupt hasn't been EOI'd, and the
>>>>> active priority is still set. The first two patches are addressing
>>>>> this situation for both GICv2 and GICv3 by reseting the APRs to their
>>>>> default value.
>>>>
>>>> As a more general thing, if irqchip drivers have state that needs to be
>>>> reset in their init code, can we live all this irqchip reset to the
>>>> crashdump kernel, and kill machine_kexec_mask_interrupts() entirely?
>>>
>>> We could, once we know for sure that all the potential irqchips have
>>> been fixed. Or we could just remove it immediately, and see what breaks.
>>
>> I would be very tempted to do the latter.
> 
> Makes sense. Do we have any indicator that tells us that a particular irq
> chip is missing something in the init code or do we have to rely on crash
> reports?
A way to work out what is potentially missing would be to make sure that
whatever we're removing from machine_kexec_mask_interrupts, we can find
it in the irqchip init code. Not an easy task, and certainly not perfect
(patches 1 and 2 in this series have no equivalent in the kexec code).

There is still another category of "reset" stuff that belongs to the
teardown path, and that's for things that may have an impact on the
secondary kernel.

The case I have in mind is that of the GIC LPI pending tables. These are
allocated to the GIC, which can write pending bits at any time. Think of
it as a DMA engine. At the moment we enter the secondary kernel, we must
make sure the GIC has already been shut down, as the table memory will
be reallocated.

For that particular case, I've started looking at some "reset" API that
an irqchip to register with, and get called back on kexec/kdump. Not
completely dissimilar to the shutdown method that some IOMMU drivers use
to gracefully stop in the same circumstances.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
