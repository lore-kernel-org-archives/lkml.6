Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F30ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AAA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AAA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYBw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:52:56 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:42336 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYBw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:52:56 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 87B4EBFE87;
        Wed, 24 Oct 2018 19:24:01 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 141F6C1045; Wed, 24 Oct 2018 19:24:01 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id E553FC1036;
        Wed, 24 Oct 2018 19:23:48 +0200 (CEST)
Message-ID: <265be8b3daab5b9fedcf7646c68c4319a2564b3c.camel@paulk.fr>
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
Date:   Wed, 24 Oct 2018 19:24:32 +0200
In-Reply-To: <20181024164758.iqnlie4witckzauy@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
         <20181010145736.l6zpohvvd4b5qngr@flea>
         <224ec158bf627b4d2f577b1dadf10bd87891e2a7.camel@paulk.fr>
         <20181024164758.iqnlie4witckzauy@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UUpNS/Nn+Z07HaKyvBLU"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UUpNS/Nn+Z07HaKyvBLU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 24 octobre 2018 =C3=A0 17:47 +0100, Maxime Ripard a =C3=A9crit =
:
> On Tue, Oct 23, 2018 at 11:33:10AM +0200, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > Le mercredi 10 octobre 2018 =C3=A0 16:57 +0200, Maxime Ripard a =C3=A9c=
rit :
> > > On Wed, Oct 10, 2018 at 01:41:31PM +0200, Paul Kocialkowski wrote:
> > > > Some panels need an active-low data enable (DE) signal for the RGB
> > > > interface. This requires flipping a bit in the TCON0 polarity regis=
ter
> > > > when setting up the mode for the RGB interface.
> > > >=20
> > > > Add a new helper function to match specific bus flags and use it to=
 set
> > > > the polarity inversion bit for the DE signal when required.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++=
--
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
> > > >  2 files changed, 27 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/s=
un4i/sun4i_tcon.c
> > > > index 3fb084f802e2..d249a462ec09 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > @@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const stru=
ct drm_encoder *encoder)
> > > >  	return -EINVAL;
> > > >  }
> > > > =20
> > > > +static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *e=
ncoder,
> > > > +				       u32 bus_flags)
> > > > +{
> > > > +	struct drm_connector *connector;
> > > > +	struct drm_display_info *info;
> > > > +
> > > > +	connector =3D sun4i_tcon_get_connector(encoder);
> > > > +	if (!connector)
> > > > +		return false;
> > > > +
> > > > +	info =3D &connector->display_info;
> > > > +
> > > > +	if ((info->bus_flags & bus_flags) =3D=3D bus_flags)
> > > > +		return true;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > >  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon,=
 int channel,
> > > >  					  bool enabled)
> > > >  {
> > > > @@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct su=
n4i_tcon *tcon,
> > > >  }
> > > > =20
> > > >  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > > > +				     const struct drm_encoder *encoder,
> > > >  				     const struct drm_display_mode *mode)
> > > >  {
> > > >  	unsigned int bp, hsync, vsync;
> > > > @@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct su=
n4i_tcon *tcon,
> > > >  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > > >  		val |=3D SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> > > > =20
> > > > +	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
> > > > +		val |=3D SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> > > > +
> > >=20
> > > There's other flags in use in that function, you should also migrate
> > > them (ideally by splitting that new function into a separate patch).
> >=20
> > Actually, these other flags are not DRM bus flags but DRM mode flags,
> > which can be accessed directly from the mode pointer passed as
> > argument. Thus, they don't require a helper.
>=20
> I was talking about DRM_BUS_FLAG_PIXDATA_POSEDGE and
> DRM_BUS_FLAG_PIXDATA_NEGEDGE, which are in the current tree.

Thanks, I guess I need to rebase these patches atop the current tree!

Looking at how these flags are used in the current tree, I see that the
connector's display_info structure (that contains the bus flags) is
retreived from tcon->panel.

Would it make sense to change this and retreive it from the encoder,
passed as argument to that function (as I've done in this patch)
instead? This way, this wouldn't only apply to panels, but also to
external bridges. It would also somewhat streamline the logic.

What do you think?

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-UUpNS/Nn+Z07HaKyvBLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvQqtEACgkQhP3B6o/u
lQwhmA//VybPN90FQy3dg7NmZK+rutPm92xdUetC8FkAswdWPC0vFfOmLC+2LicY
cQIL/dzBUUtP0iYEVF0SlVMYBZdlUu0LYr0Udgc5a9Vytb80r5d3vVbSU2KiIEZS
Nei5eq2QFEVhkb/YJ8ShGv2agO9vIxIbrRwk/Hvk/jdrod+ZGAf/GuorjDmHhntD
JPPObbuCWPH3PpFHirBe95quJFuS9nj6FSdEf9D5/nvIX3zgGI4H14/EPt07XUvd
84i+CIQPQfqQGoJrrJdn/p5c4SvxrjNF5it0aVMXpeViQhQEEwgB8/xOsdCxNTlU
0xKDJ3CPOOLhrVt9XN7oZDtCHI5uRRl2nCcrzJeJjIzTE9EeKQ4HZ62REfMDmruE
NPTaiKJJQS1mZUiYTh9KxMW6ncwWfS04XtYhJLczjF+0BNCm1rhaYbV6/iLGgaLT
JcufC6nxk3o4v1Q0T7Oj6zV84Si9YNYMKGKzXO5IKka5qu9C3Vu7RMhZPgzrcJh4
wy60vgKRYM50oU4qmSnUTH/mWWySzozPYUlbegy1cGoSXvnHY0EEyAl0VrLM9O+Z
5PF7UbbkSyRDNmZ9o0k7njRyWxWWjq0lvScz7nrE3/N14WFW+odMZbD5sFj738Vg
2Ax4zDyj+mBoKQO6NdqlaLXlxGB6ThR5gDCpGunFNocxEoxNojY=
=l9yV
-----END PGP SIGNATURE-----

--=-UUpNS/Nn+Z07HaKyvBLU--

