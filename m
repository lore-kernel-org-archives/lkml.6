Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeCBTtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:49:39 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33744 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbeCBTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:49:37 -0500
X-Google-Smtp-Source: AG47ELvtUYTV8rOQnZencTU32gAHBK3858bD30iGrP7tUcQu0wfak2rDld3oEl3cP669zKJAbp8mSQ==
Date: Fri, 2 Mar 2018 13:49:35 -0600
From: Rob Herring <robh@kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Message-ID: <20180302194935.yq3xw4nxyrxuonz5@rob-hp-laptop>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-3-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223210901.23480-3-rasmus.villemoes@prevas.dk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 10:09:00PM +0100, Rasmus Villemoes wrote:
> This adds Device Tree binding documentation for the external interrupt
> lines with configurable polarity present on some Layerscape SOCs.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  .../interrupt-controller/fsl,ls-extirq.txt         | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> new file mode 100644
> index 000000000000..e510c715e8f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> @@ -0,0 +1,44 @@
> +* Freescale Layerscape external IRQs
> +
> +Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
> +the polarity of certain external interrupt lines.
> +
> +The device node must be a child of the node representing the
> +Supplemental Configuration Unit (SCFG).
> +
> +Required properties:
> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
> +- interrupt-controller: Identifies the node as an interrupt controller
> +- #interrupt-cells: Must be 2. The first element is the index of the
> +  external interrupt line. The second element is the trigger type.
> +- interrupt-parent: phandle of GIC.
> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
> +  interrupt controller. Interrupts are mapped one-to-one to parent
> +  interrupts.

Use the interrupt-map property for this.

> +
> +Optional properties:
> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
> +  if the SCFGREVCR register has been set to all-ones (which is usually
> +  the case), meaning that all reads and writes of SCFG registers are
> +  implicitly bit-reversed. Other compatible platforms do not have such
> +  a register.
> +
> +Example:
> +	scfg: scfg@1570000 {
> +		compatible = "fsl,ls1021a-scfg", "syscon";
> +		...
> +		extirq: interrupt-controller {
> +			compatible = "fsl,ls1021a-extirq";
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			reg = <0x1ac>;

This needs the length too. What is buys us is following the standard in 
which mmio has a #size-cells >= 1. BTW, you need a #size-cells and 
#address-cells properties in the parent. (I think dtc will complain if 
not).

> +			fsl,extirq-map = <163 164 165 167 168 169>;
> +			fsl,bit-reverse;
> +		};
> +	};
> +
> +
> +	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
