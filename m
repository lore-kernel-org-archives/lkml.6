Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBADC222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbfBMPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:32:21 -0500
Received: from muru.com ([72.249.23.125]:38512 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfBMPcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:32:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A361080AE;
        Wed, 13 Feb 2019 15:32:28 +0000 (UTC)
Date:   Wed, 13 Feb 2019 07:32:15 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     marc.zyngier@arm.com, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190213153215.GT5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212163018.GL5720@atomide.com>
 <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [190213 04:23]:
> Hi Tony,
> 
> On 12/02/19 10:00 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> >> +The Interrupt Router (INTR) module provides a mechanism to route M
> >> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
> >> +to be driven per N output. There is one register per output (MUXCNTL_N) that
> >> +controls the selection.
> >> +
> >> +
> >> +                                 Interrupt Router
> >> +                             +----------------------+
> >> +                             |  Inputs     Outputs  |
> >> +        +-------+            | +------+             |
> >> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
> >> +        +-------+            | +------+             |      controller
> >> +                             |    .        +-----+  |      +-------+
> >> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
> >> +        | INTA  |----------->|    .        +-----+  |      +-------+
> >> +        +-------+            |    .          .      |
> >> +                             | +------+      .      |
> >> +                             | | irqM |    +-----+  |
> >> +                             | +------+    |  N  |  |
> >> +                             |             +-----+  |
> >> +                             +----------------------+
> > 
> > Is this always one-to-one mapping or can the same interrupt be routed to
> > multiple targets like to the SoC and some coprocessor?
> 
> Yes, it is always one-to-one. Output of INTR can only be attached to one of the
> processor.

OK

> >> +Configuration of these MUXCNTL_N registers is done by a system controller
> >> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
> >> +controller will keep track of the used and unused registers within the Router.
> >> +Driver should request the system controller to get the range of GIC IRQs
> >> +assigned to the requesting hosts. It is the drivers responsibility to keep
> >> +track of Host IRQs.
> >> +
> >> +Communication between the host processor running an OS and the system
> >> +controller happens through a protocol called TI System Control Interface
> >> +(TISCI protocol). For more details refer:
> >> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> > 
> > Care to describe a bit why the interrupts need to be routed by a system
> > controller?
> 
> K3 architecture defines a heterogeneous system where multiple heterogeneous
> cores are serving its own usecases. Given that there are multiple ways in which
> a device IRQ can be routed using INTR, like either it can be routed to HLOS
> core(A53 int this case) or it can be routed to any other coprocessor available
> in the system(like R5). If every sw running in each co-processor is allowed to
> program this INTR then there is a high probability that one sw executing on one
> core can damage other heterogeneous core.  Mainly to avoid this damage the
> configuration of all the INTRs and INTAs are done in a centralized place(sysfw).
> Any user for programming its IRQ route should send a message to sysfw with the
> parameters. These parameters are policed by sysfw and does the configuration.

OK so maybe update the description along those lines saying it's
a shared piece of hardware between various independent SoC
clusters which may or may not be running Linux.

Regards,

Tony
