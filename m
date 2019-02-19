Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4F21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBSPfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:35:43 -0500
Received: from muru.com ([72.249.23.125]:39602 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfBSPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:35:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE1F780B6;
        Tue, 19 Feb 2019 15:35:50 +0000 (UTC)
Date:   Tue, 19 Feb 2019 07:35:37 -0800
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
Message-ID: <20190219153537.GJ15711@atomide.com>
References: <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [190219 08:51]:
> Hi Tony,
> 
> On 18/02/19 8:02 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
> >> On 2/15/2019 9:46 PM, Tony Lindgren wrote:
> >>> The dts node for the interrupt controller should describe a
> >>> proper Linux device, that is with reg entries and so on.
> >>
> >> You are asking to just keep the compatible property :)
> > 
> > Right, and then I realized this node is missing the standard
> > reg entry too. And you're saying the registers are not even
> > accissible from Linux.
> > 
> > So based on that IMO you should not even have a device tree
> > node for it at all. You should just have the interrupt
> 
> Practically lets look at what all I am adding in the DT node. Below is one such
> example:
> 
> main_intr: interrupt-controller0 {
> 	compatible = "ti,sci-intr";
> 	interrupt-controller;
> 	interrupt-parent = <&gic500>;
> 	#interrupt-cells = <4>;
> 	ti,sci = <&dmsc>;
> 	ti,sci-dst-id = <56>;
> 	ti,sci-rm-range-girq = <0x1>;
> };
> 
> The following 4 properties are required at least for probing, to represent the
> hierarchy and for  interrupt definition:
> 	compatible = "ti,sci-intr";
> 	interrupt-controller;
> 	interrupt-parent = <&gic500>;
> 	#interrupt-cells = <4>;
> 
> The remaining 3 properties represents the TISCI interface. Let's go step by step:
> * ti,sci = <&dmsc> :This is the phandle to the firmware protocol driver using
> which the messages are sent
> * ti,sci-dst-id = <56> : This is the TISCI device ID for the parent controller
> for which your irqs needs to be connected. As I said this cannot be queried from
> sysfw and this is the input to the messages that are send to sysfw.

Let's not add anything that does not describe hardware to the device
tree. This is ID is an invented number used by the firmware.

> *  ti,sci-rm-range-girq = <0x1>: This define the ids using which the parent-irq
> ranges that are allocated to this interrupt router instance can be queried from
> sysfw.
> If the above 2 properties are to be added as driver phandle then for every
> instance of interrupt router in the SoC, a new compatible needs to be created. I
> don't think this is a desirable solution.

To me it seems that the interrupt router _must_ have proper IO
configuration registers available to the Linux running SoC.

Are you sure the interrupt route does not have proper IO
configuration registers available for the Linux running SoC?

If the there are not, I'd be surprised how the SoC is designed :)

So assuming it does, you should just use the standard device tree
reg property to differentiate between the various interrupt router
instances. And then you can have the driver talk to the firmware
in a way where the driver instances are separate even if no IO
access to these shared registers is done by the Linux running SoC.

But see also the mux comment below.

> With this can you tell me how can we not have a device-tree and still support
> irq allocation?

Using standard dts reg property to differentiate the interrupt
router instances. And if the interrupt router is a mux, you should
treat it as a mux rather than a chained interrupt controller.

We do have drivers/mux nowadays, not sure if it helps in this case
as at least timer interrupts need to be configured very early.

> Also, this is not the first time a driver based on a firmware is being added.
> K2g clock, power and reset drivers are based on this where device ids are being
> passed from consumers. Similarly arm scpi based drivers are also available.

Having drivers communicate with firmware is quite standard.

However, stuffing firmware specific data to the device tree
does not describe the hardware and must not be done.

Regards,

Tony
