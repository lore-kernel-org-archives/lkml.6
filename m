Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8058222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256435;
	bh=gC+EeGymE0az1ng07H/vLR7IfB3r3tQ8zEotPd3Gjbo=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=m8PgxKhG3J0vWPfQBsIm4gqy9tInx/+9HVp6gM29j3F35U23ZDqIRXeO/ozQSjZeQ
	 PtO0axErLUXsaGS7RyOVh9U9BKO5zaQnJpwQ/4GqSagRqQFMYfR0T/5DNXtKjTZQyh
	 rw7TiWzC0iTucT0q5ltcCKAMYEu37ZCoVdylWSqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfBOSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfBOSrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:47:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEF221929;
        Fri, 15 Feb 2019 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550256432;
        bh=gC+EeGymE0az1ng07H/vLR7IfB3r3tQ8zEotPd3Gjbo=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=IUeITKXWTH4E6j+4mrNzKLHZ+jHOYAEk52HVhGTB406byGGfycEavDkQB9xAX3vUu
         OI48l75TvDqylfJJb0Lt6C1QsLIMzQlwwPuVAAuLY4570up1/ugPqRw82jhGWFobSR
         weMpMX9N80FmwtiQ8gJ/zeR9TMEOxh1TkrCQZnLg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <41f8f325-2738-3995-1fc8-354a9412041e@codeaurora.org>
User-Agent: alot/0.8
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
Message-ID: <155025643198.115909.9355230466710329335@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-3-sboyd@kernel.org> <41f8f325-2738-3995-1fc8-354a9412041e@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 10:47:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-02-11 08:09:00)
> On 1/28/2019 11:10 PM, Stephen Boyd wrote:
>=20
> > +static int clk_init_parent(struct clk_core *core)
> > +{
> > +     core->parent =3D __clk_init_parent(core, true);
> > +     if (IS_ERR(core->parent))
> > +             return PTR_ERR(core->parent);
> > +
> > +     /*
> > +      * Populate core->parent if parent has already been clk_core_init=
'd. If
> > +      * parent has not yet been clk_core_init'd then place clk in the =
orphan
> > +      * list.  If clk doesn't have any parents then place it in the ro=
ot
> > +      * clk list.
> > +      *
> > +      * Every time a new clk is clk_init'd then we walk the list of or=
phan
> > +      * clocks and re-parent any that are children of the clock curren=
tly
> > +      * being clk_init'd.
> > +      */
> > +     if (core->parent) {
> > +             hlist_add_head(&core->child_node,
> > +                             &core->parent->children);
> > +             core->orphan =3D core->parent->orphan;
> > +     } else if (!core->num_parents) {
> > +             hlist_add_head(&core->child_node, &clk_root_list);
> > +             core->orphan =3D false;
> > +     } else {
> > +             hlist_add_head(&core->child_node, &clk_orphan_list);
>=20
> Missing "core->orphan =3D true;"?
> The snippet below had that line.  Its not clear why it appears to be=20
> dropped here.
>=20

Hmm. Weird. I think I may have been getting ahead of myself and moving
the orphan updating code into __clk_init_parent(). I can't remember why
though, so I guess I'll go all the way and move it all into
__clk_init_parent() now. Thanks for pointing it out.

