Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8408121772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8408121772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHHRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:19:22 -0400
Received: from verein.lst.de ([213.95.11.211]:38293 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHRTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:19:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9123868D69; Wed,  8 Aug 2018 17:04:48 +0200 (CEST)
Date:   Wed, 8 Aug 2018 17:04:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/8] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180808150448.GA31785@lst.de>
References: <20180804082319.5711-1-hch@lst.de> <20180804082319.5711-7-hch@lst.de> <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:29:50AM -0600, Rob Herring wrote:
> Version numbers on the individual patches would be nice...

We've never done these in the subsystems I'm involved with.  Too
much clutter in the subject lines for information that is easily
deductable.

> > +Example:
> > +
> > +       plic: interrupt-controller@c000000 {
> > +               #address-cells = <0>;
> > +               #interrupt-cells = <1>;
> > +               compatible = "riscv,plic0";
> > +               interrupt-controller;
> > +               interrupts-extended = <
> > +                       &cpu0-intc 11
> > +                       &cpu1-intc 11 &cpu1-intc 9
> > +                       &cpu2-intc 11 &cpu2-intc 9
> > +                       &cpu3-intc 11 &cpu3-intc 9
> > +                       &cpu4-intc 11 &cpu4-intc 9>;
> 
> I'm confused why this is still here if you are dropping the cpu intc binding?

We need some parent that identifies the core (hart in RISC-V terminology).
The way the code now works is that it just walks up the parent chain
until it finds a CPU node, so it either accepts the legacy intc node
inbetween, or it accepts the cpu node directly as the intc node is pointless.

I guess for the documentation we should instead just point to the
"riscv" cpu nodes instead?

> I also noticed the cpu binding refers to "riscv,cpu-intc" as well.
> That needs to be fixed too if there's a change.

Only in the examples.  I'd be fine with dropping them, but let's keep
that separate from the interrupt support.
