Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfARKWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:22:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33397 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:22:42 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gkRIO-0001vk-GG; Fri, 18 Jan 2019 11:22:40 +0100
Message-ID: <1547806960.2626.9.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri, 18 Jan 2019 11:22:40 +0100
In-Reply-To: <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
         <1547801609.2626.5.camel@pengutronix.de>
         <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
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

Am Freitag, den 18.01.2019, 09:54 +0000 schrieb Aisheng Dong:
> > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Friday, January 18, 2019 4:53 PM
> > Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > > One irqsteer channel can support up to 8 output interrupts.
> > 
> > This has been discussed when upstreaming the driver. The controller may
> > support multiple output IRQs, but only one them is actually used depending on
> > the CHANCTRL config. There is no use in hooking up all the output IRQs in DT, if
> > only one of them is actually used. Some of the outputs may not even be visible
> > to the Linux system, but may belong to a Cortex M4 subsystem. All of those
> > configurations can be described in DT by changing the upstream interrupt and
> > "fsl,channel" in a coherent way.
> > 
> > Please correct me if my understanding is totally wrong.
> 
> I'm afraid your understanding of CHAN seems wrong.
> (Binding doc of that property needs change as well).
> 
> On QXP DC SS, the IRQSTEER supports 512 interrupts with 8 interrupt output
> Conntected to GIC.
> The current driver does not support it as it assumes only one interrupt output used.

Okay, so let's take a step back. The description in the QXP RM is
actually better than what I've seen until now. Still it's totally
confusing that the "channel" terminology used with different meanings
in docs. Let's try to avoid this as much as possible.

So to get things straight: Each irqsteer controller has a number of IRQ
groups. All the input IRQs of one group are ORed together to form on
output IRQ. Depending on the SoC integration, a group can contain 32 or
64 IRQs, where DCSS irqsteer on MX8M and the big 512 input controllers
on QXP and QM both use 64 IRQs per group. You are claiming that the
smaller controllers on both QXP am QM have only 32 IRQs per group,
right?

So the only change that is needed is that the driver needs to know the
number of input IRQs per group, with a default of 64 to not break DT
compatibility.

Also if the connection between IRQ group and output IRQ is fixed, the
driver should be more clever about handling the chained IRQ. If you
know which of the upstream IRQs fired you only need to look at the 32
or 64 IRQ status registers of that specific group, not all of them.

Can you please clarify what the CHANCTRL setting changes in this setup?

Regards,
Lucas
