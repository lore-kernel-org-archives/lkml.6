Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FA6C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CF021852
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549411316;
	bh=d4s9m47ttib8AaQP/NtDKNrQif884QXSKDeRZNtqkEs=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=yBAV4rYsS5UWY79QCc3pXLYWvU/p9vhtS7i5yzTWSb5CtRe3sxMarUEsd0/inHK+u
	 LyDt9WLB4wAJr5hFirHzjhkpglklMjDW77FVWr/QilVttPsiuYiCIxWCGkCcDcv/+O
	 WWDYzKPrZoYw5mS/vGkAG/Vb3DwgAX5qf+AwuFlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBFABz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfBFABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:01:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81E5217F9;
        Wed,  6 Feb 2019 00:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549411312;
        bh=d4s9m47ttib8AaQP/NtDKNrQif884QXSKDeRZNtqkEs=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=2EM4b5xW/uzLtgFAswfNgugrvgOAwdNZU6NjJ9M+5tBnVzffbEG5TDog8hQ0fT+Nv
         R9tmdjBQ+VfkbHIoU5uWPTLein4dZIMRk6lbJ+tVYf5SeadUSZobJSGxm5L8njGqFl
         Vwkx4RTK0lK8p29/wZsGinMhblE0gE41t7mmX7Zw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154941131193.169292.7500057932043013834@swboyd.mtv.corp.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-3-sboyd@kernel.org> <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com> <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com> <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com> <154888381385.169292.12776041058756822056@swboyd.mtv.corp.google.com> <97c2375f41fe7dabc4d71f66c9808912eb0ce611.camel@baylibre.com>
User-Agent: alot/0.8
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <97c2375f41fe7dabc4d71f66c9808912eb0ce611.camel@baylibre.com>
Date:   Tue, 05 Feb 2019 16:01:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-31 10:40:07)
> On Wed, 2019-01-30 at 13:30 -0800, Stephen Boyd wrote:
> > > With this quirk, CCF is making an assumption that might be wrong.
> > >=20
> > > The quirk is very easy put in the get_parent() callback of the said
> > > driver, or
> > > even better, don't provide the callback if it should not be called.
> > >=20
> > > I understand the need for a cautious approach. It seems I'm only one =
with
> > > that
> > > issue right now and since I have a work around, there is no rush. But=
 we
> > > must
> > > have plan to make it right.
> > >=20
> > > To be clear, I'm not against your new API but I don't think it should=
 be a
> > > reason to keep a broken behavior the framework.
> > >=20
> >=20
> > So do you think you can use this new clk_op and ignore the problems with
> > the .get_parent clk op? Putting effort into fixing the .get_parent
> > design isn't very useful from my perspective. There's more than just the
> > problem that we don't call it when .num_parents is 1. There's the
> > inability to return errors without doing weird things to return an index
> > out of range and there isn't any way for us to really know if the clk is
> > an orphan or not. If we can migrate all drivers to use the new clk op
> > then we can fix these problems too, and deprecate and eventually remove
> > the broken by design .get_parent clk op API.
>=20
> Stephen, I have nothing against your new API, I'm sure it will solve many
> issues
>=20
> I'm also quite sure that, like round_rate() and determine_rate(), migrati=
ng to
> the new API won't happen overnight. We are likely to still see get_parent=
()
> for a while. I don't understand why we would keep something wrong when it=
 is
> that easy to fix.
>=20
> I have spent quite sometime debugging this weird behavior of CCF, I'd pre=
fer
> if it can avoided for others.
>=20
> Yes, fixing the case I reported does not solves all the problem you have
> mentionned. Keeping this bug does not help either, AFAICT.
>=20
> The fact is that get_parent() already return out of bound values on some
> occasion, and we already have to deal with this when converting the index=
 to
> parent clk_hw pointer. Doing it in the same way when num_parent =3D=3D 1 =
does not
> change anything.
>=20
> I really don't understand why you insist on keeping this special case for
> num_parent =3D=3D 1, when we know it is not coherent.
>=20
> Considering, that I already proposed the fix, what is the effort here ?
> If it is fixing the driver that rely this weird thing, I'd be happy to do=
 it.
>=20
>=20

Ok. I'm happy to merge your patch to always call the .get_parent clk op
when num_parents > 0, but please fix all the drivers and analyze all the
implementations of .get_parent to make sure that they aren't broken by
the change in behavior. Furthermore, please add a debug/warning message
into the code when .get_parent returns a number outside of the range of
[0, num_parents) so that they can be converted to use .get_parent_hw
instead. Ideally there wouldn't be anything returning a parent index
outside the range of possible parents from .get_parent because this
analysis of drivers would find those implementations and migrate them to
.get_parent_hw instead.

In parallel, I'd like to convert all drivers to use .get_parent_hw
instead of .get_parent and then remove the .get_parent clk op right
away. I'll start a sweep of the users of clk_hw_get_parent_by_index() (I
see 50 calls in the tree right now) and see if I can convert them to
handle errors returned from that API, probably by just continuing and
ignoring errors. I'll start doing the same conversion for .round_rate
and .determine_rate so that we can get rid of that duplicate clk op as
well. Hopefully that's a mostly mechanical conversion.

For now I'll move this patch to the end of this series so that it
doesn't hold things up otherwise.
