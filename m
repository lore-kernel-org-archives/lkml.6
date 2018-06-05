Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFEUvZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:51:25 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36154 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFEUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:51:23 -0400
X-Google-Smtp-Source: ADUXVKLrpWwph8B89ltr6PU0ofSUQH3CB9Gsuf6NcuEptYnVr9RHe/HxbUbwczQL0oktdGsaZ0ynOQ==
Date: Tue, 5 Jun 2018 14:51:21 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/16] dt-bindings/interrupt-controller: add
 documentation for Marvell SEI controller
Message-ID: <20180605205121.GA19249@rob-hp-laptop>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
 <20180522094042.24770-14-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522094042.24770-14-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:40:39AM +0200, Miquel Raynal wrote:
> Describe the System Error Interrupt (SEI) controller. It aggregates two
> types of interrupts, wired and MSIs from respectively the AP and the
> CPs, into a single SPI interrupt.
> 
> Suggested-by: Haim Boot <hayim@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/interrupt-controller/marvell,sei.txt  | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> new file mode 100644
> index 000000000000..689981036c30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> @@ -0,0 +1,50 @@
> +Marvell SEI (System Error Interrupt) Controller
> +-----------------------------------------------
> +
> +Marvell SEI (System Error Interrupt) controller is an interrupt
> +aggregator. It receives interrupts from several sources and aggregates
> +them to a single interrupt line (an SPI) on the parent interrupt
> +controller.
> +
> +This interrupt controller can handle up to 64 SEIs, a set comes from the
> +AP and is wired while a second set comes from the CPs by the mean of
> +MSIs. Each 'domain' is represented as a subnode.
> +
> +Required properties:
> +
> +- compatible: should be "marvell,armada-8k-sei".
> +- reg: SEI registers location and length.
> +- interrupts: identifies the parent IRQ that will be triggered.
> +
> +Child node 'sei-wired-controller' required properties:
> +
> +- marvell,sei-ranges: ranges of wired interrupts.
> +- #interrupt-cells: number of cells to define an SEI wired interrupt
> +                    coming from the AP, should be 1. The cell is the IRQ
> +                    number.
> +- interrupt-controller: identifies the node as an interrupt controller.
> +
> +Child node 'sei-msi-controller' required properties:
> +
> +- marvell,sei-ranges: ranges of non-wired interrupts triggered by way of
> +                      MSIs.
> +- msi-controller: identifies the node as an MSI controller.
> +
> +Example:
> +
> +        sei: sei@3f0200 {
> +               compatible = "marvell,armada-8k-sei";
> +               reg = <0x3f0200 0x40>;
> +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               sei_wired_controller: sei-wired-controller@0 {
> +                       marvell,sei-ranges = <0 21>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +               };
> +
> +               sei_msi_controller: sei-msi-controller@21 {
> +                       marvell,sei-ranges = <21 43>;
> +                       msi-controller;
> +               };

I still think this should just be all one node. There's several examples 
in the tree of nodes which are both interrupt-controller and 
msi-controller. Marvell MPIC is one example.

Rob
