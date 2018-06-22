Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8517C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACA624443
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACA624443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeFVO5w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:57:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56560 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933556AbeFVO5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:57:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8759820799; Fri, 22 Jun 2018 16:57:48 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0CD5120775;
        Fri, 22 Jun 2018 16:57:38 +0200 (CEST)
Date:   Fri, 22 Jun 2018 16:57:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20180622165738.6aa18de8@xps13>
In-Reply-To: <20180608164623.0175fc05@xps13>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-14-miquel.raynal@bootlin.com>
        <20180605205121.GA19249@rob-hp-laptop>
        <20180608164623.0175fc05@xps13>
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

On Fri, 8 Jun 2018 16:46:23 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> Hi Rob, Marc,
> 
> On Tue, 5 Jun 2018 14:51:21 -0600, Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, May 22, 2018 at 11:40:39AM +0200, Miquel Raynal wrote:  
> > > Describe the System Error Interrupt (SEI) controller. It aggregates two
> > > types of interrupts, wired and MSIs from respectively the AP and the
> > > CPs, into a single SPI interrupt.
> > > 
> > > Suggested-by: Haim Boot <hayim@marvell.com>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/interrupt-controller/marvell,sei.txt  | 50 ++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > > new file mode 100644
> > > index 000000000000..689981036c30
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> > > @@ -0,0 +1,50 @@
> > > +Marvell SEI (System Error Interrupt) Controller
> > > +-----------------------------------------------
> > > +
> > > +Marvell SEI (System Error Interrupt) controller is an interrupt
> > > +aggregator. It receives interrupts from several sources and aggregates
> > > +them to a single interrupt line (an SPI) on the parent interrupt
> > > +controller.
> > > +
> > > +This interrupt controller can handle up to 64 SEIs, a set comes from the
> > > +AP and is wired while a second set comes from the CPs by the mean of
> > > +MSIs. Each 'domain' is represented as a subnode.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: should be "marvell,armada-8k-sei".
> > > +- reg: SEI registers location and length.
> > > +- interrupts: identifies the parent IRQ that will be triggered.
> > > +
> > > +Child node 'sei-wired-controller' required properties:
> > > +
> > > +- marvell,sei-ranges: ranges of wired interrupts.
> > > +- #interrupt-cells: number of cells to define an SEI wired interrupt
> > > +                    coming from the AP, should be 1. The cell is the IRQ
> > > +                    number.
> > > +- interrupt-controller: identifies the node as an interrupt controller.
> > > +
> > > +Child node 'sei-msi-controller' required properties:
> > > +
> > > +- marvell,sei-ranges: ranges of non-wired interrupts triggered by way of
> > > +                      MSIs.
> > > +- msi-controller: identifies the node as an MSI controller.
> > > +
> > > +Example:
> > > +
> > > +        sei: sei@3f0200 {
> > > +               compatible = "marvell,armada-8k-sei";
> > > +               reg = <0x3f0200 0x40>;
> > > +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +               sei_wired_controller: sei-wired-controller@0 {
> > > +                       marvell,sei-ranges = <0 21>;
> > > +                       #interrupt-cells = <1>;
> > > +                       interrupt-controller;
> > > +               };
> > > +
> > > +               sei_msi_controller: sei-msi-controller@21 {
> > > +                       marvell,sei-ranges = <21 43>;
> > > +                       msi-controller;
> > > +               };    
> > 
> > I still think this should just be all one node. There's several examples 
> > in the tree of nodes which are both interrupt-controller and 
> > msi-controller. Marvell MPIC is one example.  
> 
> I checked Marvell MPIC example (armada 370 XP), it does not use
> hierarchy domains, so I totally understand your point but I'm not sure
> how I could get inspired by this driver (I'm looking for others).
> 
> Here I'm stuck. I know from a pure DT point of view the following is
> not a valid argument. But from Linux, there is no easy way to handle
> this situation without two different device nodes due to the internals
> of the irqchip subsystem. There is simply no easy solution and having
> only one node would require consequent changes in the core.
> 
> Maybe Marc will have an idea, but I think we already gave up on this
> topic :/

I double checked the MPIC driver and I still don't understand how we
can allocate both MSIs and wired interrupts with the current driver.

Anyway, I finally managed to merge 'sei_wired_controller' and
'sei_msi_controller' and have only one 'sei' node.

I had to do not use the fwnode of the 'sei' node in at least one IRQ
domain (I choose the wired one) and instead implement for that domain
the ->match() hook. I hope this is the right way to do it.

Please have a look at the v3 coming soon.

Thanks,
Miquèl
