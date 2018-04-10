Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDJQS7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:18:59 -0400
Received: from foss.arm.com ([217.140.101.70]:40568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeDJQS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:18:57 -0400
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
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
 <20180410174118.0aa1d137@windsurf>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <0611f696-e542-b4a0-415f-657bb3ac9230@arm.com>
Date: Tue, 10 Apr 2018 17:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410174118.0aa1d137@windsurf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 16:41, Thomas Petazzoni wrote:
> Hello,
> 
> Thanks for your feedback!
> 
> On Tue, 10 Apr 2018 16:23:00 +0100, Marc Zyngier wrote:
> 
>>> In the current Marvell Armada 7K/8K, we have a unit called the ICU
>>> that turns wired level interrupts on one side of the chip into MSIs,
>>> signaled to the GIC through a special unit called GICP, which allowed
>>> to trigger SPIs in the GIC-400 by doing memory writes. See
>>> irq-mvebu-icu.c and irq-mvebu-gicp.c for the two sides of the story
>>> (MSI consumer and MSI provider). We have one hack between those two
>>> drivers: because those interrupts are level-triggered, we need the
>>> addresses of two registers, while 'struct msi_msg' only allows to pass
>>> one address, assuming MSIs are edge-triggered.  
>>
>> So effectively, the GICP/GIC400 combination is a poor-man GICv3 MBI
>> (Message Based Interrupt -- we love overloaded acronyms) implementation.
> 
> Yes, that's what it is. I thought it was already clear for you, since
> you already spent a great deal of time working with me on ICU/GICP back
> when it was submitted and merged (and thank you for that!).

I was just trying to give some context here for those who don't really
follow the nightmarish state that we deal with... ;-)

> 
>>> Marc, let me know how we can collaborate on this topic. I'm able to
>>> either test some preliminary patches, or work on such patches if
>>> necessary (preferably with some initial directions).  
>>
>> I have a vague idea how to support this. Given that level-triggered MSIs
>> have to be platform MSIs (because it is just madness otherwise), we can
>> probably store an extra message in the struct platform_msi_desc for the
>> "lower the line" write.
> 
> Is there a problem with extending the msi_msg structure with an
> additional address ? It could be transparent for existing users of
> msi_msg, who would continue to use just address_lo/address_hi/data,
> while users needing level-triggered MSIs would use the new fields in
> addition to the existing ones. But perhaps I'm missing something.

At least two reasons:

- I don't want to put an extra overhead on everyone else, as about 99.9%
of the msi_msg users are sane (read: PCI), and I'm quite happy to put
the overhead on the [expletive] crazy designs.

- The fact that GICv3 requires a different address and the same data is
an implementation detail. Let's say that I invent a new interrupt
controller that requires bit 31 of the data to indicate whether this is
a set or a clear, and uses the same address. Now your scheme doesn't work.

So I really want a different message altogether.

> 
>> On activation, you'd get two callbacks, probably with a flag of some
>> sort to indicate whether this is for the rising or falling edge.
> 
> What you call "activation" is when ->write_msg() gets called on the MSI
> consumer side, to configure its HW so that it knows how to trigger its
> MSIs ?

The write_msi is indeed part of the activation, together with
compose_msg. That's the phase where we actually commit the HW resources,
and plumb everything together.

> 
>> The thing I'm unclear about so far is how to let the generic MSI layer
>> know that we're dealing with such an interrupt without make a total
>> mess of everything. It is probably done by marking the interrupt
>> level triggered, but there are some corner cases.
> 
> Certainly me not fully understand the generic MSI layer, but why does
> it need to be aware of the interrupt being level vs. edge ?

See the above reasoning about the two messages. If you notice that the
MSI is level, you know that you'll need a second message for the clear.

> 
>> And if that works, the PCI stuff will come for free (it is just a
>> matter of implementing a new irqdomain on top of the base GICv3 one).
> 
> I've lost you here :)

Same as usual. GICv3 already implements a domain for all the interrupts
it services, and we just need to bolt an MBI-specific domain on top (the
equivalent of your GICP). At that stage, we can create the usual
platform and PCI MSI domains that are used by the drivers.

> 
>> I'll try to spend some time on it in the coming couple of weeks, but
>> will have to rely on you for the testing (as I don't have much in the
>> way of HW).
> 
> I can definitely make some tests, I have actual HW to test this.

Cool, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
