Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C04C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173AA21479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yW1+ntjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173AA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeK3S2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeK3S2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:28:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1017920863;
        Fri, 30 Nov 2018 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543562426;
        bh=zCx1F6DpxVdxqoEAAx/yhOmiFnT1HaaFu1+jcTsaRvw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=yW1+ntjmOGmi+CZ8hHpJycVTUXjpXsJ/BFL7ux4+7I8GdqPWuGeTPT6Ytc3Hkltd6
         mP07Oc+WHLQGNvm2oBaRbZr+ohtGMTGta06JeCr/RHrsdavAHjG9vs8nHNQ1vHzBY7
         zGTL/bdLn8Us7oMO+a7QHa72077+BUpZ8aw06rIk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andreas Kemnade <andreas@kemnade.info>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130071534.0a6cd455@kemnade.info>
Cc:     bcousson@baylibre.com, letux-kernel@openphoenux.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        paul@pwsan.com, t-kristo@ti.com, tony@atomide.com
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
Message-ID: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Thu, 29 Nov 2018 23:20:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2018-11-29 22:15:34)
> Hi Stephen,
> =

> On Thu, 29 Nov 2018 16:25:05 -0800
> Stephen Boyd <sboyd@kernel.org> wrote:
> =

> > Quoting Andreas Kemnade (2018-11-10 12:31:14)
> > > Code might use autoidle api with clocks not being omap2 clocks,
> > > so check if clock type is not basic
> > > =

> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > New in v2
> > > ---
> > >  drivers/clk/ti/autoidle.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > > index 161f67850393..5bdae5552d38 100644
> > > --- a/drivers/clk/ti/autoidle.c
> > > +++ b/drivers/clk/ti/autoidle.c
> > > @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> > >  int omap2_clk_deny_idle(struct clk *clk)
> > >  {
> > >         struct clk_hw_omap *c;
> > > +       struct clk_hw *hw =3D __clk_get_hw(clk);
> > >  =

> > > -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > > +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)  =

> > =

> > Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> > Maybe add some flag in clk_hw_omap() instead?
> > =

> hmm, Tero suggested that.
> But to check flags in clk_hw_omap I first need to know that there is a
> clk_hw_omap behind clk_hw. And for that I either need to check flags in
> clk_hw or do more changes in the omap_hwmod code.

Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
other users are marking clks with this but there is no reason to do so.
I'll go make another pass over the tree and nuke those ones from orbit.

