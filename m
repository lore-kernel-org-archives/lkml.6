Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232C420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232C420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbeHAUm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:42:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34721 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbeHAUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:42:26 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkwH5-0000Rm-Ha; Wed, 01 Aug 2018 20:55:07 +0200
Date:   Wed, 1 Aug 2018 20:55:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Marc Zyngier <marc.zyngier@arm.com>, palmer@sifive.com,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <20180725112457.GA24502@lst.de>
Message-ID: <alpine.DEB.2.21.1808012049170.1835@nanos.tec.linutronix.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de> <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com> <20180725112457.GA24502@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jul 2018, Christoph Hellwig wrote:

> On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
> > This feels odd. It means that you cannot have the following sequence:
> > 
> > 	local_irq_disable();
> > 	enable_irq(x); // where x is owned by a remote hart
> > 
> > as smp_call_function_single() requires interrupts to be enabled.
> > 
> > More fundamentally, why are you trying to make these interrupts look
> > global while they aren't? arm/arm64 have similar restrictions with GICv2
> > and earlier, and treats these interrupts as per-cpu.
> > 
> > Given that the drivers that deal with drivers connected to the per-hart
> > irqchip are themselves likely to be aware of the per-cpu aspect, it
> > would make sense to align things (we've been through that same
> > discussion about the clocksource driver a few weeks back).
> 
> Right now the only direct consumers are said clocksource, the PLIC
> driver later in this series and the RISC-V arch IPI code.  None of them
> is going to do a manual enable_irq, so I guess the remote case of the
> code is simply dead code.  I'll take a look at converting them to
> per-cpu.  I guess the GICv2 driver is the best template?

Confused. The timer and the IPI are separate causes and have nothing to do
with the per cpu irq domain. That's what the low level interrupt handling
code tells me.

If I understand correctly then the per cpu irq domain is for device
interrupts, right? If so, then this simply cannot work and there is no way
to make it work with per cpu interrupts either.

Is there some high level documentation about the design (or the lack of) or
can someone give a concise explanation how this stuff is supposed to work?

Thanks,

	tglx
