Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C37520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeGYMce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:32:34 -0400
Received: from verein.lst.de ([213.95.11.211]:59098 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbeGYMce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:32:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F7EB68D64; Wed, 25 Jul 2018 13:24:57 +0200 (CEST)
Date:   Wed, 25 Jul 2018 13:24:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        palmer@sifive.com, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180725112457.GA24502@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de> <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
> This feels odd. It means that you cannot have the following sequence:
> 
> 	local_irq_disable();
> 	enable_irq(x); // where x is owned by a remote hart
> 
> as smp_call_function_single() requires interrupts to be enabled.
> 
> More fundamentally, why are you trying to make these interrupts look
> global while they aren't? arm/arm64 have similar restrictions with GICv2
> and earlier, and treats these interrupts as per-cpu.
> 
> Given that the drivers that deal with drivers connected to the per-hart
> irqchip are themselves likely to be aware of the per-cpu aspect, it
> would make sense to align things (we've been through that same
> discussion about the clocksource driver a few weeks back).

Right now the only direct consumers are said clocksource, the PLIC
driver later in this series and the RISC-V arch IPI code.  None of them
is going to do a manual enable_irq, so I guess the remote case of the
code is simply dead code.  I'll take a look at converting them to
per-cpu.  I guess the GICv2 driver is the best template?
