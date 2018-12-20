Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248FC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179121903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545340162;
	bh=Ge1/tEjB2RmN0rIIzRGmX3o8YdSsD9kdZGbjH8HZELI=;
	h=To:References:Cc:From:In-Reply-To:Subject:Date:List-ID:From;
	b=TG3Dm07g7J6b07/WSsiHjW6dK/lnVM2mjRNEHALli3qbGaHRk4xWNfFqJQpMbv6Vw
	 21B21HUohgDanfw8jCF3xeweyNYOsUZlt77SwbDvKifyZQPYFrvGNfe9Sm24Pe16NC
	 tBUcJuOZSwVbHMe/0k9u+3Q3EqD5UjhA2NBjloJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbeLTVJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbeLTVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:09:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF981218FE;
        Thu, 20 Dec 2018 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545340160;
        bh=Ge1/tEjB2RmN0rIIzRGmX3o8YdSsD9kdZGbjH8HZELI=;
        h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
        b=llX4WFK0DS9Jd8LXQWAU6kE8TbhIDKBD5I6oV6Ep+XOzx13ZtNNRlPN94Mjm/o/UZ
         tHq4SH5c6+qzbEKQbH/BgnJcvsk8qtyw67OS7T/z51iwQ8isZbPkrMpKKAk4e0lQdo
         Q37jRlqe+KF1LgquvUNCqAkQvHNBnnktK2shItCQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Miquel Raynal <miquel.raynal@bootlin.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com> <20181204192440.12125-2-miquel.raynal@bootlin.com> <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com> <20181219090331.4c8c4852@xps13>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181219090331.4c8c4852@xps13>
Message-ID: <154534015908.79149.14109221006631310404@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
Date:   Thu, 20 Dec 2018 13:09:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-12-19 00:03:31)
> Hi Stephen,
>=20
> Stephen Boyd <sboyd@kernel.org> wrote on Tue, 18 Dec 2018 16:03:29
> -0800:
>=20
> > Quoting Miquel Raynal (2018-12-04 11:24:37)
> > > Currently, the core->dev entry is populated only if runtime PM is
> > > enabled. Doing so prevents accessing the device structure in any
> > > case.
> > >=20
> > > Keep the same logic but instead of using the presence of core->dev as
> > > the only condition, also check the status of
> > > pm_runtime_enabled(). Then, we can set the core->dev pointer at any
> > > time as long as a device structure is available.
> > >=20
> > > This change will help supporting device links in the clock subsystem.
> > >=20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/clk/clk.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index af011974d4ec..b799347c5fd6 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
> > >  {
> > >         int ret =3D 0;
> > > =20
> > > -       if (!core->dev)
> > > +       if (!core->dev || !pm_runtime_enabled(core->dev)) =20
> >=20
> > This looks potentially dangerous. What if runtime PM is disabled for the
> > clk when this function is called? Shouldn't we just stash a bool away in
> > the clk_core structure when it's registered? And then we can replace the
> > check for !core->dev with a check for 'core->rpm_enabled' instead. That
> > would be a more exact transformation.
>=20
> Sure, I'll do that if you think there is a danger.

I've made the change and pushed it out to the clk tree. I'm working on
some patches to change how we do parent lookups and reworking clk_get()
in the process. Take a look so we don't duplicate efforts. The code
isn't complete, but I hope to finish soon. Your device links patches can
build upon this.

 git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-parent-rew=
rite

