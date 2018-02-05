Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeBEGHQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:07:16 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36960 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeBEGHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:07:07 -0500
X-Google-Smtp-Source: AH8x2245My9Icvui+be9Hy+7f6ZYxjTgRhDoj8g+Dpmp2Tx3o+cqDHJroIfvqQFGIkHp+aaYux/aaQ==
Date: Mon, 5 Feb 2018 00:07:05 -0600
From: Rob Herring <robh@kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Message-ID: <20180205060705.cg3qywtqs65w74ee@rob-hp-laptop>
References: <20180122092133.23177-1-rasmus.villemoes@prevas.dk>
 <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180125150230.7234-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125150230.7234-2-rasmus.villemoes@prevas.dk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 04:02:30PM +0100, Rasmus Villemoes wrote:
> This adds Device Tree binding documentation for the external interrupt
> lines with configurable polarity present on some Layerscape SOCs.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> Changes since v3: Add non-empty commit log.
> 
> .../interrupt-controller/fsl,ls-extirq.txt         | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> new file mode 100644
> index 000000000000..a71ce2c3eeae
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
> +- #interrupt-cells: Use the same format as specified by GIC in arm,gic.txt.
> +- interrupt-parent: phandle of GIC.
> +- offset: offset to the Interrupt Polarity Control Register (INTPCR)
> +  register in the SCFG.
> +- interrupts: Specifies the mapping to interrupt numbers in the parent
> +  interrupt controller. Interrupts are mapped one-to-one to parent
> +  interrupts.
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
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			offset = <0x1ac>;

Use reg here instead (with a length).

> +			interrupts = <163 164 165 167 168 169>;

These don't look like GIC interrupt cells. Building this with current 
dtc will have errors.

> +			fsl,bit-reverse;
> +		};
> +	};
> +
> +
> +	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&extirq GIC_SPI 1 IRQ_TYPE_LEVEL_LOW>;
> -- 
> 2.15.1
> 
