Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeDJPXF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:23:05 -0400
Received: from foss.arm.com ([217.140.101.70]:39854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753097AbeDJPXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:23:04 -0400
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hanna Hawa <hannah@marvell.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Date: Tue, 10 Apr 2018 16:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410170155.6e07113d@windsurf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/04/18 16:01, Thomas Petazzoni wrote:
> Hello Marc, Hello Stephen,
> 
> On Tue, 21 Mar 2017 09:43:24 +0000, Marc Zyngier wrote:
> 
>> The whole idea behind this GICD_SETSPI_NSR is to offer a way to signal
>> SPIs using memory transaction, even allowing level interrupts (in
>> combinaison with the GICD_CLRSPI_NSR at offset 0x48). This is *not* a
>> GICv2m at all - only the offset is the same.
>>
>> The reasoning is that firmware would program the various devices with
>> the GICD_{CLR,SET}SPI_NSR addresses and the payload, and simply describe
>> this as an SPI in the device tree. Another reason for doing so is that
>> while we can always twist the DT to express anything, this cannot be
>> described in ACPI at all.
>>
>> Also, as you noticed, there is no provision in the architecture to
>> describe the range of message-based SPIs, because any SPI can be
>> signalled through that mechanism. It makes it impossible to distinguish
>> SPIs that are statically allocated (because it is a real wire) from
>> those that can be dynamically allocated (because it is just a number).
>>
>> You end-up having to describe the range of SPIs that can be generated
>> through messages at least on a per SoC basis, and maybe on a per board
>> basis. Not to mention that you're still only describing half of the
>> capability of the HW (what about level interrupts?).
>>
>> If we really want to support this kind of thing, I'd like to see level
>> interrupts supported as a first class citizen in our generic MSI
>> infrastructure, and then the GICv3 message-based SPIs as an client of
>> that infrastructure.
> 
> We are trying to support a platform that has a GICv3, and that also
> uses level-triggered interrupts through GICD_SETSPI_NSR and
> GICD_CLRSPI_NSR. Therefore, I'm also interested in seeing this
> functionality of the GICv3 exposed as an MSI controller.
> 
> In the current Marvell Armada 7K/8K, we have a unit called the ICU
> that turns wired level interrupts on one side of the chip into MSIs,
> signaled to the GIC through a special unit called GICP, which allowed
> to trigger SPIs in the GIC-400 by doing memory writes. See
> irq-mvebu-icu.c and irq-mvebu-gicp.c for the two sides of the story
> (MSI consumer and MSI provider). We have one hack between those two
> drivers: because those interrupts are level-triggered, we need the
> addresses of two registers, while 'struct msi_msg' only allows to pass
> one address, assuming MSIs are edge-triggered.

So effectively, the GICP/GIC400 combination is a poor-man GICv3 MBI
(Message Based Interrupt -- we love overloaded acronyms) implementation.

> In the upcoming Armada 8KP, we have a GICv3, which has built-in support
> for memory-triggered SPIs, thanks to the GICD_SETSPI_NSR and
> GICD_CLRSPI_NSR, and the ICU will directly use this GICv3
> functionality. We would therefore very much like to have this GICv3
> feature provided as a MSI controller, which as Marc said would require
> supporting level-triggered MSIs.
> 
> Marc, let me know how we can collaborate on this topic. I'm able to
> either test some preliminary patches, or work on such patches if
> necessary (preferably with some initial directions).

I have a vague idea how to support this. Given that level-triggered MSIs
have to be platform MSIs (because it is just madness otherwise), we can
probably store an extra message in the struct platform_msi_desc for the
"lower the line" write. On activation, you'd get two callbacks, probably
with a flag of some sort to indicate whether this is for the rising or
falling edge. The thing I'm unclear about so far is how to let the
generic MSI layer know that we're dealing with such an interrupt without
make a total mess of everything. It is probably done by marking the
interrupt level triggered, but there are some corner cases.

And if that works, the PCI stuff will come for free (it is just a matter
of implementing a new irqdomain on top of the base GICv3 one).

I'll try to spend some time on it in the coming couple of weeks, but
will have to rely on you for the testing (as I don't have much in the
way of HW).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
