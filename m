Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2D20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E2D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeINPpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:45:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:45:15 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0lNf-0002CW-3q; Fri, 14 Sep 2018 12:31:19 +0200
Date:   Fri, 14 Sep 2018 12:31:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
In-Reply-To: <20180913155945.GA19903@ulmo>
Message-ID: <alpine.DEB.2.21.1809141211200.1473@nanos.tec.linutronix.de>
References: <20180913155945.GA19903@ulmo>
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

On Thu, 13 Sep 2018, Thierry Reding wrote:
> I've been trying to implement a feature on recent Tegra chips that's
> called "wake events". These wake events are implemented as part of the
> power management controller (PMC) and they control which events can be
> used to wake the system from suspend. Events include things like an
> alarm interrupt from an RTC, or the GPIO interrupt hooked up to a
> power button for example.
> 
> We already have a driver for a couple of other things that the PMC does,
> so I thought it'd be natural to implement this functionality as an IRQ
> chip in the PMC driver. The way that this would work is that for all the
> devices that are wakeup sources, we'd end up specifying the PMC as the
> interrupt parent and the PMC would then itself have the main GIC as its
> parent. That way, the hierarchical IRQ domain infrastructure would take
> care of pretty much everything.
> 
> Unfortunately I've run into some issues here. One problem that I'm
> facing is that PMC could have more than one parent. For example, the RTC
> alarm interrupt goes straight to the GIC, but the power button GPIO goes
> through the GPIO controller first and then to the GIC. This doesn't seem
> to be something that's currently possible.

So what you are saying is that the RTC is directly wired up to the GIC and
the GPIO interrupts are demultiplxed by a single GIC interrupt first, but
at the same time have the requirement to talk to the PMC.

Lets look at the current implementation without taking PMC into account.

- RTC gets its interrupt directly from the GIC domain

- GPIO gets its interrupt from the GPIO domain. The GPIO domain does not
  have a parent domain. It is stand alone because it sets up a demultiplex
  interrupt from the GIC domain.

  So there is absolutely no irqdomain relationship between a single GPIO
  and the GIC. The indirection through the demultiplex interrupt does not
  create one, really.

Now, you need the PMC for both, the GPIOs and the RTC. What you can do here
is to provide two irq domains in PMC. One which has GIC as its parent and
one which has no parent. Surely they need to share some resources, but
that should be a solvable problem.

Now you connect RTC to the GIC parented one and let the PMC irq chip just
hand through, except for the set_wake() functionality.

The GPIO domain is connected to the parentless PMC domain and the irq chip
merily provides the set_wake() stuff and everything else is a noop.

So GPIO ends up as a hierarchy which is still not connected to the GIC
directly.

Hmm?

Thanks,

	tglx


