Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A72C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E48220883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E48220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeGZJjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:39:08 -0400
Received: from verein.lst.de ([213.95.11.211]:35298 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbeGZJjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:39:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CF36E68D64; Thu, 26 Jul 2018 10:27:06 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:27:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, palmer@sifive.com,
        jason@lakedaemon.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180726082706.GA22868@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de> <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com> <20180725112457.GA24502@lst.de> <CAAhSdy31=D3jOgvrc+Td-TeKQMazPA-suFjOy9XwEuima1WdeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy31=D3jOgvrc+Td-TeKQMazPA-suFjOy9XwEuima1WdeA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 09:08:00AM +0530, Anup Patel wrote:
> Actually, RISCV HLIC and PLIC are very similar to RPi2 and RPi3 SOCs.
> 
> On RPi2 and RPi3, we have per-CPU BCM2836 local intc and the global
> interrupts are managed using BCM2835 intc. You should certainly have
> a look a this drivers because these very simple compared to GICv2 and
> GICv3 drivers.

Yes, using that model makes writing the per-cpu irq controller driver
trivial.  But retrofitting it into the device tree, where the existing
bootloader (bbl) assumes the old DT layout is a giant pain in the neck.

At the same time I'm still not conveninced RISC-V really needs a full
irqchip driver for the per-cpu interrupt 'controller' really is nothing
but 1 and a half architectural control registers:

  - the scause register that contains the reason for an exception
    (any exception including syscalls and page faults) for the entry
    into supervisor mode.  This includes a bit to indicate interrupts,
    and then logical interrupt reason, out of which only three are
    interesting for supervisor mode (timer, software, external)
  - the sie register that allows to to enable/disable each of the above
    causes individually

So after burning out on DT hacking (never mind retrofitting that into
actual shipping SOCs vs just qemu) I'm going to try a version that
doesn't add an irqchip for this but just handles it hardcoded in
RISC-V do_IRQ.  I'll still keep the irqchip for the PLIC, which while
specificed in the RISC-V spec isn't architectural but an actual
periphal.
