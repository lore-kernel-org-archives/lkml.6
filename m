Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03387C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90E921473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548796548;
	bh=OzERr/HuAbo9/0J3smto0XPrPizi57aChpdG0oRQ000=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=gAlB8C1EMb971oAxHx/p6fTBtOIPE5HzXDzU9aHIwwNfG1lL0dY3jYTCfPwjA/ExE
	 4vKKFRwjj6KzzOfXs408bSYISlAcziBiE3A8LBiSLg/1JaUCtmfdtum3tpTH291CMD
	 nEFgfiXyfpPAiRf8xrkiI8EN/KtFx53W6Zj+ZhF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfA2VPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:15:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2VPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:15:46 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC0120881;
        Tue, 29 Jan 2019 21:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548796545;
        bh=OzERr/HuAbo9/0J3smto0XPrPizi57aChpdG0oRQ000=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=f1PhKEbNu7ZiZ4ckO9XeQ+5UUxpd5P9UtzvXvrsOeFophlPtBMFG2cur24LVMrkku
         boieqnci0NGBWlG/G/fRF/WnK2AkN/ZxnvMhYndPyDZYgOHft6FBqVFuEGz9mpX085
         SXTuOOW+PkIwLfnLNaNXLF8giRszDY3sB7nGIMpc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-3-sboyd@kernel.org> <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com>
Message-ID: <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 29 Jan 2019 13:15:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-29 01:34:38)
> On Mon, 2019-01-28 at 22:10 -0800, Stephen Boyd wrote:
> > ---
> >  drivers/clk/clk.c            | 117 ++++++++++++++++++++++++++---------
> >  include/linux/clk-provider.h |   9 +++
> >  2 files changed, 96 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 01b36f0851bd..5d82cf25bb29 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2242,14 +2242,84 @@ struct clk *clk_get_parent(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(clk_get_parent);
> > =20
> > -static struct clk_core *__clk_init_parent(struct clk_core *core)
> > +static struct clk_core *
> > +__clk_init_parent(struct clk_core *core, bool update_orphan)
> >  {
> >       u8 index =3D 0;
> > +     struct clk_hw *parent_hw =3D NULL;
> > =20
> > -     if (core->num_parents > 1 && core->ops->get_parent)
> > -             index =3D core->ops->get_parent(core->hw);
> > +     if (core->ops->get_parent_hw) {
> > +             parent_hw =3D core->ops->get_parent_hw(core->hw);
> > +             /*
> > +              * The provider driver doesn't know what the parent is,
> > +              * but it's at least something valid, so it's not an
> > +              * orphan, just a clk with some unknown parent.
> > +              */
>=20
> I suppose this is the answer the discussion we had last year. I'm not sur=
e it
> answer the problem. In the case I presented, we have no idea wether the
> setting is valid or not.
>=20
> We can't assume it is `at least something valid`, the value in the mux is=
 just
> something we can't map.

So if you can't map the value in the mux how is that valid? I would
think the mux knows what indexes it has strings for, and if the index
isn't in there it's invalid. Is that not the case here?

>=20
> Aslo, could you provide an example of what such callback would be, with c=
lk-
> mux maybe ?

Sounds fair. I can convert the clk-mux API to this op. It may be that we
need to make clk_hw_get_parent_by_index() return an error pointer
instead of NULL if it can't find the clk so that we can move the error
codes through this new API.

>=20
> I don't get how a clock driver will keep track of the clk_hw pointers it =
is
> connected to. Is there an API for this ? clk-mux must access to clk_core =
to
> explore his own parent ... which already does not scale well, expect if we
> plan to expose clk_core at some point ?


No we don't want to expose clk_core to provider drivers. It is only for
the use of the clk framework and it's not exposed even as an opaque
pointer. We have that core member of clk_hw but that's just to traverse
from clk_hw to clk_core, and not for anything else.

>=20
> > +             if (!parent_hw && update_orphan)
> > +                     core->orphan =3D false;
> > +     } else {
> > +             if (core->num_parents > 1 && core->ops->get_parent)
>=20
> I still get why, when num_parents =3D=3D 1, it is OK to call get_parent_h=
w() and
> no get_parent(). It does not seems coherent.

I'd rather not change behavior of existing code in this patch, so I took
the route of adding another callback with semantics that we can define
now because there aren't any users. The difference between the two is
made intentionally.

>=20
> > +                     index =3D core->ops->get_parent(core->hw);
> > +
> > +             parent_hw =3D clk_hw_get_parent_by_index(core->hw, index);
> > +     }
> > +
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 60c51871b04b..8b84dee942bf 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -155,6 +155,14 @@ struct clk_duty {
> >   *           multiple parents.  It is optional (and unnecessary) for c=
locks
> >   *           with 0 or 1 parents.
> >   *
> > + * @get_parent_hw: Queries the hardware to determine the parent of a
> > clock.  The
> > + *           return value is a clk_hw pointer corresponding to
> > + *           the parent clock. In short, this function translates the
> > parent
> > + *           value read from hardware into a pointer to the clk_hw for=
 that
> > clk.
> > + *           Currently only called when the clock is initialized by
> > + *           __clk_init.  This callback is mandatory for clocks with
> > + *           multiple parents.  It is optional for clocks with 0 or 1
> > parents.
> > + *
>=20
> The comments above could imply that get_parent() and get_parent_hw() are =
both
> mandatory if num_parent > 1. (I don't think so but) Is this your intent ?

It is not the intent. I'll update the docs. Thanks.

