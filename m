Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754366AbeDJPCJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:02:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52207 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754349AbeDJPCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:02:07 -0400
Date: Tue, 10 Apr 2018 17:01:55 +0200
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
Message-ID: <20180410170155.6e07113d@windsurf>
In-Reply-To: <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
        <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc, Hello Stephen,

On Tue, 21 Mar 2017 09:43:24 +0000, Marc Zyngier wrote:

> The whole idea behind this GICD_SETSPI_NSR is to offer a way to signal
> SPIs using memory transaction, even allowing level interrupts (in
> combinaison with the GICD_CLRSPI_NSR at offset 0x48). This is *not* a
> GICv2m at all - only the offset is the same.
> 
> The reasoning is that firmware would program the various devices with
> the GICD_{CLR,SET}SPI_NSR addresses and the payload, and simply describe
> this as an SPI in the device tree. Another reason for doing so is that
> while we can always twist the DT to express anything, this cannot be
> described in ACPI at all.
> 
> Also, as you noticed, there is no provision in the architecture to
> describe the range of message-based SPIs, because any SPI can be
> signalled through that mechanism. It makes it impossible to distinguish
> SPIs that are statically allocated (because it is a real wire) from
> those that can be dynamically allocated (because it is just a number).
> 
> You end-up having to describe the range of SPIs that can be generated
> through messages at least on a per SoC basis, and maybe on a per board
> basis. Not to mention that you're still only describing half of the
> capability of the HW (what about level interrupts?).
> 
> If we really want to support this kind of thing, I'd like to see level
> interrupts supported as a first class citizen in our generic MSI
> infrastructure, and then the GICv3 message-based SPIs as an client of
> that infrastructure.

We are trying to support a platform that has a GICv3, and that also
uses level-triggered interrupts through GICD_SETSPI_NSR and
GICD_CLRSPI_NSR. Therefore, I'm also interested in seeing this
functionality of the GICv3 exposed as an MSI controller.

In the current Marvell Armada 7K/8K, we have a unit called the ICU
that turns wired level interrupts on one side of the chip into MSIs,
signaled to the GIC through a special unit called GICP, which allowed
to trigger SPIs in the GIC-400 by doing memory writes. See
irq-mvebu-icu.c and irq-mvebu-gicp.c for the two sides of the story
(MSI consumer and MSI provider). We have one hack between those two
drivers: because those interrupts are level-triggered, we need the
addresses of two registers, while 'struct msi_msg' only allows to pass
one address, assuming MSIs are edge-triggered.

In the upcoming Armada 8KP, we have a GICv3, which has built-in support
for memory-triggered SPIs, thanks to the GICD_SETSPI_NSR and
GICD_CLRSPI_NSR, and the ICU will directly use this GICv3
functionality. We would therefore very much like to have this GICv3
feature provided as a MSI controller, which as Marc said would require
supporting level-triggered MSIs.

Marc, let me know how we can collaborate on this topic. I'm able to
either test some preliminary patches, or work on such patches if
necessary (preferably with some initial directions).

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
