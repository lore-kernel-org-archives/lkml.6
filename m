Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211EE20838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfBRPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:13:12 -0500
Received: from foss.arm.com ([217.140.101.70]:33138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfBRPNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:13:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6971650;
        Mon, 18 Feb 2019 07:13:12 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7323F740;
        Mon, 18 Feb 2019 07:12:48 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:12:19 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI
 Interrupt router bindings
Message-ID: <20190218150738.527a0507@why.wild-wind.fr.eu.org>
In-Reply-To: <20190212074237.2875-6-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
        <20190212074237.2875-6-lokeshvutla@ti.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 13:12:32 +0530
Lokesh Vutla <lokeshvutla@ti.com> wrote:

> Add the DT binding documentation for Interrupt router driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v4:
> - None
> 
>  .../interrupt-controller/ti,sci-intr.txt      | 85 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> new file mode 100644
> index 000000000000..4b0ca797fda1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> @@ -0,0 +1,85 @@
> +Texas Instruments K3 Interrupt Router
> +=====================================
> +
> +The Interrupt Router (INTR) module provides a mechanism to route M
> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
> +to be driven per N output. There is one register per output (MUXCNTL_N) that
> +controls the selection.
> +
> +
> +                                 Interrupt Router
> +                             +----------------------+
> +                             |  Inputs     Outputs  |
> +        +-------+            | +------+             |
> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
> +        +-------+            | +------+             |      controller
> +                             |    .        +-----+  |      +-------+
> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
> +        | INTA  |----------->|    .        +-----+  |      +-------+
> +        +-------+            |    .          .      |
> +                             | +------+      .      |
> +                             | | irqM |    +-----+  |
> +                             | +------+    |  N  |  |
> +                             |             +-----+  |
> +                             +----------------------+
> +
> +Configuration of these MUXCNTL_N registers is done by a system controller
> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
> +controller will keep track of the used and unused registers within the Router.
> +Driver should request the system controller to get the range of GIC IRQs
> +assigned to the requesting hosts. It is the drivers responsibility to keep
> +track of Host IRQs.
> +
> +Communication between the host processor running an OS and the system
> +controller happens through a protocol called TI System Control Interface
> +(TISCI protocol). For more details refer:
> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +TISCI Interrupt Router Node:
> +----------------------------
> +- compatible:		Must be "ti,sci-intr".
> +- interrupt-controller:	Identifies the node as an interrupt controller
> +- #interrupt-cells:	Specifies the number of cells needed to encode an
> +			interrupt source. The value should be 4.
> +			First cell should contain the TISCI device ID of source
> +			Second cell should contain the interrupt source offset
> +			within the device
> +			Third cell specifies the trigger type as defined
> +			in interrupts.txt in this directory.
> +			Fourth cell should be 1 if the irq is coming from
> +			interrupt aggregator else 0.

This is odd. Doesn't the aggregator have a device ID too, which could
be used to discriminate between the two?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
