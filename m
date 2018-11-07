Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D1BC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCC020892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNOqtyQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCC020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeKHEco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725727AbeKHEcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:32:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208B420862;
        Wed,  7 Nov 2018 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541617263;
        bh=HY3iJm3Ccw0G4LKGVA8FPkjVKVLj2rK3qzm7WAZOftI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=sNOqtyQjfit9uionxGXkE5iuD+Lo2caTTT5WM+Slfl6MNlOph7ZYVKZMAbyZlm43B
         HiqDnQDoqVMIqNF51+KOT15dgkfiP6V13z9NlurkA78VS8Nwn7d+ziRNDdJscmCCo8
         rITaL9fKdrC0R12jQqhjBv6IDvQ6PNNaXx7ndmds=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
Message-ID: <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 07 Nov 2018 11:01:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-11-07 03:54:45)
> On Wed, Oct 17, 2018 at 12:55:52PM -0700, Stephen Boyd wrote:
> > Quoting Abel Vesa (2018-09-24 03:39:55)
> > > +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> > > +                                        unsigned long parent_rate)
> > > +{
> > > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > > +       u32 val, ref, divr1, divf1, divr2, divf2;
> > > +       u64 temp64;
> > > +
> > > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > > +       switch (FIELD_GET(PLL_REF_MASK, val)) {
> > > +       case 0:
> > > +               ref =3D OSC_25M;
> > > +               break;
> > > +       case 1:
> > > +               ref =3D OSC_27M;
> > > +               break;
> > > +       default:
> > > +               ref =3D OSC_25M;
> > =

> > Does this information not come through 'parent_rate'?
> > =

> =

> No. So basically both pll1 and pll2 and the divider after it form togethe=
r this SCCG:
> =

> https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834
> =

> See: Figure 5-8. SSCG PLL Block Diagram

Thanks for the link!

> =

> We're basically reading the input of the pll 1 in order to compute the ou=
tput of the entire SCCG.
> =

> I know it's a mess. I'm working on cleaning it up, but for now we need th=
is in in order to boot up.

What's the plan to clean it up?

> =

> > > +               break;
> > > +       }
> > > +
> > > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > > +       divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
> > > +       divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
> > > +       divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
> > > +       divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
> > > +
> > > +       temp64 =3D ref * 2;
> > > +       temp64 *=3D (divf1 + 1) * (divf2 + 1);
> > > +
> > > +       do_div(temp64, (divr1 + 1) * (divr2 + 1));
> > =

> > Nitpicks: A comment with the equation may be helpful to newcomers.
> =

> Since the SCCG is contructed by multiple different types of clocks here, =
the equation doesn't help
> since it is spread in all constructing blocks.

Ok.

