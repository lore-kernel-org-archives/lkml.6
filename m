Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09702C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35E52146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbeLQNwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:52:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:52:25 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gYtJk-0002Lb-PU; Mon, 17 Dec 2018 14:52:20 +0100
Message-ID: <1545054740.5874.6.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] irqchip: add driver for imx-irqsteer controller
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 17 Dec 2018 14:52:20 +0100
In-Reply-To: <98217822-208a-9a92-e80b-b0b73111e527@arm.com>
References: <20181214102244.21509-1-l.stach@pengutronix.de>
         <20181214102244.21509-3-l.stach@pengutronix.de>
         <86r2ejaztt.wl-marc.zyngier@arm.com>
         <1545041393.5874.1.camel@pengutronix.de>
         <98217822-208a-9a92-e80b-b0b73111e527@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 17.12.2018, 10:32 +0000 schrieb Marc Zyngier:
[...]
> > > > > > +	/* steer all IRQs into configured channel */
> > > > +	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
> > > 
> > > Could you explain what this channel is exactly?
> > 
> > I've tired in the cover letter, but seems I still failed, so let me try
> > again. ;)
> > 
> > Each irqsteer instance can be connected to multiple upstream IRQ lines,
> > but only one of them can be used at runtime. This register controls
> > which output IRQ line will be used by this controller instance. With
> > multiple controller instances in the system it's a way to offload the
> > decision of the IRQ routing from the hardware to the software guys.
> > 
> > Let's try to add an example: Suppose there are 2 instances of the
> > irqsteer controller. Both are connected to upstream GIC IRQs 20 and 21.
> > The channel controls which of those IRQs are used by each instance, so
> > there are 2 valid DT configurations in this scenario:
> > 
> > This is valid:
> > 
> > irqsteer@0 {
> > 	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
> > 	fsl,channel = <0>;
> > };
> > 
> > irqsteer@1 {
> > 	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
> > 	fsl,channel = <1>;
> > };
> > 
> > As well as this:
> > 
> > irqsteer@0 {
> > 	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
> > 	fsl,channel = <1>;
> > };
> > 
> > irqsteer@1 {
> > 	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
> > 	fsl,channel = <0>;
> > };
> 
> OK, this is now making sense, thanks for that. I'm wondering if it'd
> make sense to expose both IRQs in the DT for each irqsteer, and use
> fsl,channel as the selector? It doesn't change much in the driver, but
> seems to describe the HW in a more complete way.
> 
> I don't care much either way, and I'll leave it for you and the DT folks
> to decide.

At least according to the preliminary documentation available about the
i.MX8QM not all of the channels are routed to an upstream IRQ which is
visible to the Linux system. Some of them may also go to the Cortex-M
subsystem, so for your suggestion to work I would need a scheme to
describe the output interrupts with holes in between them.

I guess that complicates things a bit too much for little gain, as I
don't see us switching the controller between different channels at
runtime (which is the only thing I could imagine which would benefit
from this more complete HW description). The current binding can deal
with having some channels which route to something invisible to the
Linux system just fine, so I'm leaning toward keeping things as they
are now.

Regards,
Lucas
