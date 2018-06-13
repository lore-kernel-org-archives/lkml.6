Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B05AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17695208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17695208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936070AbeFMXH5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:07:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:34667 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935381AbeFMXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:07:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5DN7jil010846;
        Wed, 13 Jun 2018 18:07:46 -0500
Message-ID: <a52cd1fc35cc76ac2482a6b8f6f3f6591053235c.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jun 2018 09:07:45 +1000
In-Reply-To: <CAL_JsqJtL0HMPxv5vMv2+LOyvyVtYusu3Ja-NikCy2RQSo7f0Q@mail.gmail.com>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
         <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com>
         <f5e71bac1bc23f96b7dae64bbdad8e2154c339aa.camel@kernel.crashing.org>
         <CAL_JsqJtL0HMPxv5vMv2+LOyvyVtYusu3Ja-NikCy2RQSo7f0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 09:00 -0600, Rob Herring wrote:
> 
> > My thinking was to then replace most of_iomap users with this.
> > 
> > As for the specific case of the driver I'm cooking, it's a case where
> > the SoC contains a little coprocessor (a ColdFire even !) alongside the
> 
> Wow. Must be the 1 licensee.

Haha probably :-) It was fun to play with for sure, lots of old
memories of m68k asm coming back to the surface ;-)

> > main ARM core. I have a driver that offloads the bitbanging of some
> > GPIOs to it (to implement the FSI bus). I use devm_of_iomap() to map
> > the registers of the interrupt controller of the coprocessor, it's not
> > really part of the interrupt tree, it doesn't distribute interrupts to
> > the ARM or to Linux, it's just a device-node pointed to by a handle.
> 
> Accessing another processor's interrupt controller. What could go
> wrong with that.

We poke at one of the registers to trigger an IPI to the corproessor :-
) Sadly the HW doesn't cleanly separate the registers for the
"consumer" side (the coprocessor) from those used to poke at it by from
ARM into different banks (though at least the "clear IPI" is a separate
register so the coprocessor and the ARM don't race, ie, it actually
works fine :-).

> I guess this is fine. There's another problem though. This doesn't
> work on Sparc because address.c is not built. I'd suggest moving to
> of/device.c or a new file.

Ah sure. lib/devres.c maybe, where devm_ioremap is already.

> > BTW. Another thing that I find a bit annoying is "allocated" reserved-
> > memory, there's no API to get to it other than via the DMA APIs or a
> > CMA, which is overkill in a few circumstances (such as the one here
> > where I just want to dedicate a bit of memory to the coprocessor).
> > Right now I'm using a fixed reservation (with a reg property) and go to
> > it "manually" but that somewhat sucks.
> 
> But that's not really a DT problem.

Correct. At the moment I just use a fixed DT reserved entry and go
directly for it's "reg" property (well, via of_address_to_resource) but
that's not very nice. It would be better if I could have linux
"allocate" the space for me but then just give me an API to find it
without going via a CMA or some DMA ops.

>  It's a kernel problem if you can't
> reserve a contiguous range of unmapped pages. But why not just get
> coherent allocation and ignore that it is mapped. That seems better to
> me than working around it in DT.

The kernel won't get me a 1M (or 2M on the AST2400) aligned allocation
successfully at runtime. So a reserve entry is the way to go here
(though being mapped or not is not a big deal, I can just flush the
cache after loading the ucode into it).

Basically, I want one of the "allocated" reserved-memory entry but I
don't want to bother with a CMA or a shared DMA pool for it, which are
both completely overkill for what I need. (Also the code is hard to
follow :-)

Cheers,
Ben.

