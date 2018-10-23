Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010020665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F010020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeJWRzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:55:16 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:41704 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbeJWRzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:55:15 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id BD606BFE63;
        Tue, 23 Oct 2018 11:32:39 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 18111C10A6; Tue, 23 Oct 2018 11:32:39 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id C44A7C1008;
        Tue, 23 Oct 2018 11:32:25 +0200 (CEST)
Message-ID: <224ec158bf627b4d2f577b1dadf10bd87891e2a7.camel@paulk.fr>
Subject: Re: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal
 with RGB interface
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Date:   Tue, 23 Oct 2018 11:33:10 +0200
In-Reply-To: <20181010145736.l6zpohvvd4b5qngr@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
         <20181010145736.l6zpohvvd4b5qngr@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gI9g6LVf0JgHXOGJa04j"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gI9g6LVf0JgHXOGJa04j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 10 octobre 2018 =C3=A0 16:57 +0200, Maxime Ripard a =C3=A9crit =
:
> On Wed, Oct 10, 2018 at 01:41:31PM +0200, Paul Kocialkowski wrote:
> > Some panels need an active-low data enable (DE) signal for the RGB
> > interface. This requires flipping a bit in the TCON0 polarity register
> > when setting up the mode for the RGB interface.
> >=20
> > Add a new helper function to match specific bus flags and use it to set
> > the polarity inversion bit for the DE signal when required.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i=
/sun4i_tcon.c
> > index 3fb084f802e2..d249a462ec09 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct d=
rm_encoder *encoder)
> >  	return -EINVAL;
> >  }
> > =20
> > +static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encod=
er,
> > +				       u32 bus_flags)
> > +{
> > +	struct drm_connector *connector;
> > +	struct drm_display_info *info;
> > +
> > +	connector =3D sun4i_tcon_get_connector(encoder);
> > +	if (!connector)
> > +		return false;
> > +
> > +	info =3D &connector->display_info;
> > +
> > +	if ((info->bus_flags & bus_flags) =3D=3D bus_flags)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int=
 channel,
> >  					  bool enabled)
> >  {
> > @@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_=
tcon *tcon,
> >  }
> > =20
> >  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > +				     const struct drm_encoder *encoder,
> >  				     const struct drm_display_mode *mode)
> >  {
> >  	unsigned int bp, hsync, vsync;
> > @@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_=
tcon *tcon,
> >  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >  		val |=3D SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> > =20
> > +	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
> > +		val |=3D SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> > +
>=20
> There's other flags in use in that function, you should also migrate
> them (ideally by splitting that new function into a separate patch).

Actually, these other flags are not DRM bus flags but DRM mode flags,
which can be accessed directly from the mode pointer passed as
argument. Thus, they don't require a helper.

If you'd like, I could still split this patch into one introducing the
helper and one using it for checking the DE_LOW flag.

What do you think?

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-gI9g6LVf0JgHXOGJa04j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvO6tYACgkQhP3B6o/u
lQyaww/+LEHGAI0eyS9mXFNnzLafS9wACmtlBIlb9tRWy3aRnIxZgvwChAWG+ljG
MaYnphmP6Yykfru2B2i8VgfpdFU0Eat6wBiacvjXKVhCGaAqCfeQC8YBeW8JwDyS
C39T27GBef3raNT5tD2MxTXwRdUQEXlqsSwy9ClRzzyp8p4Hc772gFhJv2iEEdoW
VQQs4Vb43JyrJaTdHucs+y6E7HeMg0UaB6e6fDpHjeN0vQzjvttwVT5rK6N0FWyX
ajSlFNECBZ++OpOjGXaFMCPAu3zLraev0hXb4fqLfqfu0AfbhxcOJ6QNtY6CkO43
MwS37sqmWuY1bCfB8bSJRzRD1Smii3D47BVk6J/ZH9Xt9jDKc5IV0ZVCeOjFTjmk
2OwT/C2FfDYOnoSDwD/f50UTMnwWx/+3Rv45TyAPAmuK549wD1HD1tA7u3jqLbhT
Kgubq2mqkA0xmuoULb+yvIj2VZgwRgWG2HLfifQu/1N57SqgVIDvZtWm9RWjdCZo
k7jtLN8kkpx5uw5PXao5RiwB8dJwqg9T3e6RqrXsTQr3DVCLHcmC4dC1kZD3bNTQ
nfpqRxh08gZR5x8k4GZ4H834srLFrfXsN3xSBnbvtavYcj4Cr9yNamDUJAj+FGnW
c600E2ireiaHQoXYrB0fcRQdqAJCNiW3KdeykzhE9QKp2yBnenU=
=QD2w
-----END PGP SIGNATURE-----

--=-gI9g6LVf0JgHXOGJa04j--

