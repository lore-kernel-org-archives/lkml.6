Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l9B/BcyKGltOJgAAmS7hNA
	; Fri, 08 Jun 2018 14:01:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 13EE26089E; Fri,  8 Jun 2018 14:01:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 76CEC606FA;
	Fri,  8 Jun 2018 14:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76CEC606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeFHOBN convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 10:01:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41520 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeFHOBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:01:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5FAF720737; Fri,  8 Jun 2018 16:01:09 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id DA26F2069C;
        Fri,  8 Jun 2018 16:00:58 +0200 (CEST)
Date: Fri, 8 Jun 2018 16:00:58 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
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
Subject: Re: [PATCH v2 12/16] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
Message-ID: <20180608160058.04db4613@xps13>
In-Reply-To: <20180605202902.GA8875@rob-hp-laptop>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-13-miquel.raynal@bootlin.com>
        <20180605202902.GA8875@rob-hp-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviewing.

On Tue, 5 Jun 2018 14:29:02 -0600, Rob Herring <robh@kernel.org> wrote:

> On Tue, May 22, 2018 at 11:40:38AM +0200, Miquel Raynal wrote:
> > Change the documentation to reflect the new bindings used for Marvell
> > ICU. This involves describing each interrupt group as a subnode of the
> > ICU node. Each of them having their own compatible.  
> 
> Need to explain why you need to do this and why breaking backwards 
> compatibility is okay.

As explained by Thomas, backward compatibility is not broken as old
bindings are still documented and supported.

I will update the commit message to reflect that point.

> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/interrupt-controller/marvell,icu.txt  | 81 ++++++++++++++++++----
> >  1 file changed, 69 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > index 649b7ec9d9b1..6f7e4355b3d8 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> > @@ -5,6 +5,8 @@ The Marvell ICU (Interrupt Consolidation Unit) controller is
> >  responsible for collecting all wired-interrupt sources in the CP and
> >  communicating them to the GIC in the AP, the unit translates interrupt
> >  requests on input wires to MSG memory mapped transactions to the GIC.
> > +These messages will access a different GIC memory area depending on
> > +their type (NSR, SR, SEI, REI, etc).
> >  
> >  Required properties:
> >  
> > @@ -12,20 +14,19 @@ Required properties:
> >  
> >  - reg: Should contain ICU registers location and length.
> >  
> > +Subnodes: Each group of interrupt is declared as a subnode of the ICU,
> > +with their own compatible.
> > +
> > +Required properties for the icu_nsr/icu_sei subnodes:
> > +
> > +- compatible: Should be "marvell,cp110-icu-nsr" or "marvell,cp110-icu-sei".
> > +
> >  - #interrupt-cells: Specifies the number of cells needed to encode an
> > -  interrupt source. The value shall be 3.
> > +  interrupt source. The value shall be 2.
> >  
> > -  The 1st cell is the group type of the ICU interrupt. Possible group
> > -  types are:
> > +  The 1st cell is the index of the interrupt in the ICU unit.
> >  
> > -   ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
> > -   ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
> > -   ICU_GRP_SEI (0x4) : System error interrupt
> > -   ICU_GRP_REI (0x5) : RAM error interrupt  
> 
> What happens to SR and REI interrupts?

They were unused since the beginning.

These values are still detailed below (in the legacy section).

[...]

> 
> > -
> > -  The 2nd cell is the index of the interrupt in the ICU unit.
> > -
> > -  The 3rd cell is the type of the interrupt. See arm,gic.txt for
> > +  The 2nd cell is the type of the interrupt. See arm,gic.txt for
> >    details.
> >  
> >  - interrupt-controller: Identifies the node as an interrupt
> > @@ -35,17 +36,73 @@ Required properties:
> >    that allows to trigger interrupts using MSG memory mapped
> >    transactions.
> >  
> > +Note: each 'interrupts' property referring to any 'icu_xxx' node shall
> > +      have a different number within [0:206].
> > +
> >  Example:
> >  
> >  icu: interrupt-controller@1e0000 {
> >  	compatible = "marvell,cp110-icu";
> >  	reg = <0x1e0000 0x440>;
> > +
> > +	CP110_LABEL(icu_nsr): icu-nsr {  
> 
> 'interrupt-controller' is the proper node name. Is there no register 
> range associated sub nodes?

I will update the name.

A few are used only for NSR, a few only for SEI and others are used for
both. But ok, I will add register ranges.

> 
> > +		compatible = "marvell,cp110-icu-nsr";
> > +		#interrupt-cells = <2>;
> > +		interrupt-controller;
> > +		msi-parent = <&gicp>;
> > +	};
> > +
> > +        CP110_LABEL(icu_sei): icu-sei {
> > +                compatible = "marvell,cp110-icu-sei";
> > +                #interrupt-cells = <2>;
> > +                interrupt-controller;
> > +                msi-parent = <&sei>;
> > +        };  
> 
> Mixture of tabs and spaces.

Oops.

> 
> > +};
> > +

Thanks,
Miquèl
