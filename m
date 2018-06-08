Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E3L4F3KWGlt9EgAAmS7hNA
	; Fri, 08 Jun 2018 14:46:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 283AE6089E; Fri,  8 Jun 2018 14:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94C7E601D2;
	Fri,  8 Jun 2018 14:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94C7E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeFHOq1 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:46:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42570 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbeFHOqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:46:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B9B9207C0; Fri,  8 Jun 2018 16:46:23 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B05320702;
        Fri,  8 Jun 2018 16:46:23 +0200 (CEST)
Date: Fri, 8 Jun 2018 16:46:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Haim Boot <hayim@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/16] dt-bindings/interrupt-controller: add
 documentation for Marvell SEI controller
Message-ID: <20180608164623.0175fc05@xps13>
In-Reply-To: <20180605205121.GA19249@rob-hp-laptop>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-14-miquel.raynal@bootlin.com>
        <20180605205121.GA19249@rob-hp-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Marc,

On Tue, 5 Jun 2018 14:51:21 -0600, Rob Herring <robh@kernel.org> wrote:

> On Tue, May 22, 2018 at 11:40:39AM +0200, Miquel Raynal wrote:
> > Describe the System Error Interrupt (SEI) controller. It aggregates two
> > types of interrupts, wired and MSIs from respectively the AP and the
> > CPs, into a single SPI interrupt.
> > 
> > Suggested-by: Haim Boot <hayim@marvell.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/interrupt-controller/marvell,sei.txt  | 50 ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > new file mode 100644
> > index 000000000000..689981036c30
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > @@ -0,0 +1,50 @@
> > +Marvell SEI (System Error Interrupt) Controller
> > +-----------------------------------------------
> > +
> > +Marvell SEI (System Error Interrupt) controller is an interrupt
> > +aggregator. It receives interrupts from several sources and aggregates
> > +them to a single interrupt line (an SPI) on the parent interrupt
> > +controller.
> > +
> > +This interrupt controller can handle up to 64 SEIs, a set comes from the
> > +AP and is wired while a second set comes from the CPs by the mean of
> > +MSIs. Each 'domain' is represented as a subnode.
> > +
> > +Required properties:
> > +
> > +- compatible: should be "marvell,armada-8k-sei".
> > +- reg: SEI registers location and length.
> > +- interrupts: identifies the parent IRQ that will be triggered.
> > +
> > +Child node 'sei-wired-controller' required properties:
> > +
> > +- marvell,sei-ranges: ranges of wired interrupts.
> > +- #interrupt-cells: number of cells to define an SEI wired interrupt
> > +                    coming from the AP, should be 1. The cell is the IRQ
> > +                    number.
> > +- interrupt-controller: identifies the node as an interrupt controller.
> > +
> > +Child node 'sei-msi-controller' required properties:
> > +
> > +- marvell,sei-ranges: ranges of non-wired interrupts triggered by way of
> > +                      MSIs.
> > +- msi-controller: identifies the node as an MSI controller.
> > +
> > +Example:
> > +
> > +        sei: sei@3f0200 {
> > +               compatible = "marvell,armada-8k-sei";
> > +               reg = <0x3f0200 0x40>;
> > +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +               sei_wired_controller: sei-wired-controller@0 {
> > +                       marvell,sei-ranges = <0 21>;
> > +                       #interrupt-cells = <1>;
> > +                       interrupt-controller;
> > +               };
> > +
> > +               sei_msi_controller: sei-msi-controller@21 {
> > +                       marvell,sei-ranges = <21 43>;
> > +                       msi-controller;
> > +               };  
> 
> I still think this should just be all one node. There's several examples 
> in the tree of nodes which are both interrupt-controller and 
> msi-controller. Marvell MPIC is one example.

I checked Marvell MPIC example (armada 370 XP), it does not use
hierarchy domains, so I totally understand your point but I'm not sure
how I could get inspired by this driver (I'm looking for others).

Here I'm stuck. I know from a pure DT point of view the following is
not a valid argument. But from Linux, there is no easy way to handle
this situation without two different device nodes due to the internals
of the irqchip subsystem. There is simply no easy solution and having
only one node would require consequent changes in the core.

Maybe Marc will have an idea, but I think we already gave up on this
topic :/

Regards,
Miquèl
