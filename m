Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5B21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLROCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:02:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLROCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:02:32 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gZFx6-0002gJ-RI; Tue, 18 Dec 2018 15:02:28 +0100
Message-ID: <1545141748.5874.27.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Dec 2018 15:02:28 +0100
In-Reply-To: <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
         <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
         ,<1545129634.5874.20.camel@pengutronix.de>
         <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
        ,<1545140504.5874.25.camel@pengutronix.de>
         <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
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

Am Dienstag, den 18.12.2018, 13:53 +0000 schrieb Anson Huang:
[...]
> > 
> > > Regarding about the over head, yes, the change in common composite
> > > clock register has too many over head for other clocks, what if I
> > > ONLY have dram core clock to pass the CLK_GET_RATE_NOCACHE flag to
> > > register the composite clock?
> > 
> > IMHO marking clocks under TF-A control explicitly as nocache would be
> > much more acceptable than doing it for every composite clock. This
> > seems okay for a short term solution.
> > 
> > Still I think that whatever is causing the bus frequency scale to
> > change should have a way to explicitly invalidate the clock cache for
> > the affected clocks eventually.
> 
> It is because the DDR PLL/clocks can only be changed with strict DDR
> freq change flow, and it is done in TF-A, Linux kernel can NOT touch
> it in runtime, so we have to mark the child clock of DDR PLL to be
> uncached, in V2 patch, I will just add the flag for the DDR PLL child
> clocks to be a shorten solution, should be only very few ones, hope
> it is acceptable, thanks.

I fully understand why you are doing the frequency change in TF-A and I
agree with the reasoning to do so. I also think that using uncached for
the few clocks under TF-A control is fine for now.

But if/when the bus frequency scaling is actually implemented for
upstream I think the flow should look something like that:

1. Bus freq scaling driver determines that a change is necessary
2. Scaling driver calls into TF-A to do the change
3. TF-A reconfigures clock rates
4. Scaling driver calls into clock driver to signal that a clock change
might have happened
5. Clock driver invalidates and recalculates cached values for the
affected clocks

Regards,
Lucas
