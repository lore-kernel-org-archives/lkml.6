Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42BE214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42BE214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIQRzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:55:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeIQRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:55:17 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1sdK-0003xX-N0; Mon, 17 Sep 2018 14:28:06 +0200
Date:   Mon, 17 Sep 2018 14:28:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
In-Reply-To: <20180917095222.GA27927@ulmo>
Message-ID: <alpine.DEB.2.21.1809171358070.16580@nanos.tec.linutronix.de>
References: <20180913155945.GA19903@ulmo> <alpine.DEB.2.21.1809141211200.1473@nanos.tec.linutronix.de> <20180917095222.GA27927@ulmo>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018, Thierry Reding wrote:
> On Fri, Sep 14, 2018 at 12:31:18PM +0200, Thomas Gleixner wrote:
> > Now, you need the PMC for both, the GPIOs and the RTC. What you can do here
> > is to provide two irq domains in PMC. One which has GIC as its parent and
> > one which has no parent. Surely they need to share some resources, but
> > that should be a solvable problem.
> 
> I think I have this working to some degree, finally. GPIO is still
> proving difficult, but RTC seems to be working fine. I've currently
> solved this by making the PMC an interrupt controller and then have
> an interrupt-map property in its device tree node that lists those
> wake events that we're interested in. It looks something like this:
> 
> 	pmc: pmc@c360000 {
> 		compatible = "nvidia,tegra194-pmc";
> 		reg = <0x0c360000 0x10000>,
> 		      <0x0c370000 0x10000>,
> 		      <0x0c380000 0x10000>,
> 		      <0x0c390000 0x10000>,
> 		      <0x0c3a0000 0x10000>;
> 		reg-names = "pmc", "wake", "aotag", "scratch", "misc";
> 
> 		#interrupt-cells = <1>;
> 		interrupt-controller;
> 
> 		interrupt-map = /*<29 &gpio_aon TEGRA194_AON_GPIO(EE, 4)
> 					      IRQ_TYPE_LEVEL_HIGH>,*/
> 				<73 &gic GIC_SPI 10
> 					 IRQ_TYPE_LEVEL_HIGH>;
> 	};
> 
> Note that I've commented out the GPIO wake event (this is for the power
> button) because that currently crashes in the GPIO driver, probably
> because I misunderstood how to properly implement this.

I'm not a DT wizerd, but the GPIO cannot be linked there I think.

    RTC ---------------------------> [ PMC domain 1] -----> GIC

    Button --> [GPIO domain] ------> [ PMC domain 2]

The RTC is connected to PMC domain 1 and that allocates the GIC irq.

The button is conntected to the GPIO which connect to the PMC domain
2. That PMC domain has no connection to anything. It ends there.

> When I use the above code on the PMC/GPIO domain, then I see crashes
> because the GPIO controller doesn't implement things like the ->alloc()
> callback for its IRQ domain. But perhaps this is what I misunderstand.
> Are you saying that for the case of GPIO I can just *not* pass through
> all other operations and just let them be NULL? So that the only
> callback will be ->irq_set_wake()? What I don't quite understand is how
> the IRQ code would know how to properly set up the GPIO interrupt in
> that case.

Let's look at the PMC level first:

  The PMC has a fixed number of interrupts which are avail

  domain 1:

       That domain is used for interrupts which have a dedicated GIC
       interrupt line, e.g. the RTC

       The interrupt domain needs at least:

       alloc		= pmc_domain1_alloc

       The interrupt chip has:

       irq_mask		= irq_chip_mask_parent
       irq_unmask	= irq_chip_unmask_parent
       irq_eoi		= irq_chip_eoi_parent
       irq_set_affinity	= irq_chip_set_affinity_parent
       irq_set_type	= irq_chip_set_type_parent
       irq_set_wake	= pmc_set_wake

  domain 2:

       That domain is used for interrupts which are not related to the GIC
       directly, e.g. GPIO

       The interrupt domain needs at least:

       alloc		= pmc_domain2_alloc
       
       The interrupt chip has:

       irq_set_wake	= pmc_set_wake


Now the GPIO domain builds on top of PMC domain2

    	i.e. the parent of the GPIO domain is PMC domain2, which means that
    	it's part of a hierarchy and therefore needs an alloc function in
    	the domain ops.

	The GPIO irq chip gains one extra callback:

       	irq_set_wake	= irq_chip_set_wake_parent,


So, I don't know how GPIOs are mapped into the PMC when they are a wakeup
source. It might be all of them have the ability so there is some 1:1
relation ship or if the whole GPIO -> PMC connection can be built at run
time, but that's just an implementation detail.

Thanks,

	tglx

