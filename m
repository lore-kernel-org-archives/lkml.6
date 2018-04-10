Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDJPlY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:41:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53565 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbeDJPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:41:20 -0400
Date: Tue, 10 Apr 2018 17:41:18 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hanna Hawa <hannah@marvell.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards
 compatibility mode
Message-ID: <20180410174118.0aa1d137@windsurf>
In-Reply-To: <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
        <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
        <20180410170155.6e07113d@windsurf>
        <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your feedback!

On Tue, 10 Apr 2018 16:23:00 +0100, Marc Zyngier wrote:

> > In the current Marvell Armada 7K/8K, we have a unit called the ICU
> > that turns wired level interrupts on one side of the chip into MSIs,
> > signaled to the GIC through a special unit called GICP, which allowed
> > to trigger SPIs in the GIC-400 by doing memory writes. See
> > irq-mvebu-icu.c and irq-mvebu-gicp.c for the two sides of the story
> > (MSI consumer and MSI provider). We have one hack between those two
> > drivers: because those interrupts are level-triggered, we need the
> > addresses of two registers, while 'struct msi_msg' only allows to pass
> > one address, assuming MSIs are edge-triggered.  
> 
> So effectively, the GICP/GIC400 combination is a poor-man GICv3 MBI
> (Message Based Interrupt -- we love overloaded acronyms) implementation.

Yes, that's what it is. I thought it was already clear for you, since
you already spent a great deal of time working with me on ICU/GICP back
when it was submitted and merged (and thank you for that!).

> > Marc, let me know how we can collaborate on this topic. I'm able to
> > either test some preliminary patches, or work on such patches if
> > necessary (preferably with some initial directions).  
> 
> I have a vague idea how to support this. Given that level-triggered MSIs
> have to be platform MSIs (because it is just madness otherwise), we can
> probably store an extra message in the struct platform_msi_desc for the
> "lower the line" write.

Is there a problem with extending the msi_msg structure with an
additional address ? It could be transparent for existing users of
msi_msg, who would continue to use just address_lo/address_hi/data,
while users needing level-triggered MSIs would use the new fields in
addition to the existing ones. But perhaps I'm missing something.

> On activation, you'd get two callbacks, probably with a flag of some
> sort to indicate whether this is for the rising or falling edge.

What you call "activation" is when ->write_msg() gets called on the MSI
consumer side, to configure its HW so that it knows how to trigger its
MSIs ?

> The thing I'm unclear about so far is how to let the generic MSI layer
> know that we're dealing with such an interrupt without make a total
> mess of everything. It is probably done by marking the interrupt
> level triggered, but there are some corner cases.

Certainly me not fully understand the generic MSI layer, but why does
it need to be aware of the interrupt being level vs. edge ?

> And if that works, the PCI stuff will come for free (it is just a
> matter of implementing a new irqdomain on top of the base GICv3 one).

I've lost you here :)

> I'll try to spend some time on it in the coming couple of weeks, but
> will have to rely on you for the testing (as I don't have much in the
> way of HW).

I can definitely make some tests, I have actual HW to test this.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
