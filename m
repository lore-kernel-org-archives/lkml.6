Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47781ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C222084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C222084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeGRH6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:58:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38266 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRH6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:58:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9C5C920741; Wed, 18 Jul 2018 09:21:54 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 01185208FF;
        Wed, 18 Jul 2018 09:21:17 +0200 (CEST)
Message-ID: <cdd9c0632d495aedb6cc709033c983ce19f59e48.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk
 for lowest plane alpha support
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        thomas.petazzoni@bootlin.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Date:   Wed, 18 Jul 2018 09:21:17 +0200
In-Reply-To: <CAGRGNgX27bbJz2qe3FOb4eP5WKgDYFUNxoz7SkUbN_QDF25pAg@mail.gmail.com>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
         <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
         <CAGRGNgX27bbJz2qe3FOb4eP5WKgDYFUNxoz7SkUbN_QDF25pAg@mail.gmail.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jKeEluu2eYf8U2KMKTrE"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jKeEluu2eYf8U2KMKTrE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2018-07-17 at 22:41 +1000, Julian Calaby wrote:
> Hi Paul,
>=20
> On Tue, Jul 17, 2018 at 6:53 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >=20
> > Not all sunxi platforms with the first version of the Display Engine
> > support an alpha component on the plane with the lowest z position
> > (as in: lowest z-pos), that gets blended with the background color.
> >=20
> > In particular, the A13 is known to have this limitation. However, it wa=
s
> > recently discovered that the A20 and A33 are capable of having alpha on
> > their lowest plane.
> >=20
> > Thus, this introduces a specific quirk to indicate such support,
> > per-platform. Since this was not tested on sun4i and sun6i platforms, a
> > conservative approach is kept and this feature is not supported.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/su=
n4i/sun4i_backend.c
> > index a3cc398d4d80..cdc4a8a91ea2 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_=
engine *engine,
> >         }
> >=20
> >         /* We can't have an alpha plane at the lowest position */
> > -       if (plane_states[0]->fb->format->has_alpha ||
> > -           (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE))
> > +       if ((plane_states[0]->fb->format->has_alpha ||
> > +           (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)) &&
> > +           !backend->quirks->supports_lowest_plane_alpha)
>=20
> From a readability perspective, it'd be fractionally nicer if the
> quirk check was before the alpha checks.

Agreed, I will do that in v2.

Thanks!

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-jKeEluu2eYf8U2KMKTrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAltO6m0ACgkQ3cLmz3+f
v9GSSgf/SsA1FXEXN0DNZ59qY3tI2bsZNB8COFdbGAi2c5JichteR1bgfLjRwMG5
EhDTEb9VxXxaq0v72BK2cKYSZ4VBKEiRO1T2hmK0a/UG4lpJRIdpZFEWyyUH5HNL
dDtKr5XNecDesXYaYjH6XrVLhiq7g9G1KqYx6ZVTd06K8tLB47Nixo+5WEZ2gdmd
4s2RtCtAtl6dDGf24gvyLzMSS+w2YLuoMSXn7qi4ajAx45Q5Zov1wmNV/MCovZoR
W1zmRlXHy89+TFxNLRV9/T3kHgr4d85lXZ/G2bl4f0v9dY34qAk8E/xKb9hDzUNB
arc4JJSsZZqxDsBe/lKU6VwwbTWitA==
=CvsW
-----END PGP SIGNATURE-----

--=-jKeEluu2eYf8U2KMKTrE--

