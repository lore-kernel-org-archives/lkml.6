Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA79C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91332184C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeLSIDp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:03:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52210 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbeLSIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:03:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA08120A82; Wed, 19 Dec 2018 09:03:41 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9AACF207B8;
        Wed, 19 Dec 2018 09:03:31 +0100 (CET)
Date:   Wed, 19 Dec 2018 09:03:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
Message-ID: <20181219090331.4c8c4852@xps13>
In-Reply-To: <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
        <20181204192440.12125-2-miquel.raynal@bootlin.com>
        <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Tue, 18 Dec 2018 16:03:29
-0800:

> Quoting Miquel Raynal (2018-12-04 11:24:37)
> > Currently, the core->dev entry is populated only if runtime PM is
> > enabled. Doing so prevents accessing the device structure in any
> > case.
> > 
> > Keep the same logic but instead of using the presence of core->dev as
> > the only condition, also check the status of
> > pm_runtime_enabled(). Then, we can set the core->dev pointer at any
> > time as long as a device structure is available.
> > 
> > This change will help supporting device links in the clock subsystem.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/clk/clk.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index af011974d4ec..b799347c5fd6 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
> >  {
> >         int ret = 0;
> >  
> > -       if (!core->dev)
> > +       if (!core->dev || !pm_runtime_enabled(core->dev))  
> 
> This looks potentially dangerous. What if runtime PM is disabled for the
> clk when this function is called? Shouldn't we just stash a bool away in
> the clk_core structure when it's registered? And then we can replace the
> check for !core->dev with a check for 'core->rpm_enabled' instead. That
> would be a more exact transformation.

Sure, I'll do that if you think there is a danger.


Thanks,
Miquèl
