Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F5C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFC27B71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFFC27B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeF2HR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:17:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40205 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeF2HR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:17:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D186A20DB4; Fri, 29 Jun 2018 09:17:55 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 974C8208B3;
        Fri, 29 Jun 2018 09:17:45 +0200 (CEST)
Date:   Fri, 29 Jun 2018 09:17:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
Message-ID: <20180629071746.ohdhg6mgj6knyijp@flea>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
 <20180627182500.eanqagmcfmsgzos2@flea>
 <8012754.crdjCMeE0H@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrbyc5izmmi6gw7g"
Content-Disposition: inline
In-Reply-To: <8012754.crdjCMeE0H@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrbyc5izmmi6gw7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 10:58:28PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> > Hi!
> >=20
> > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > Initial implementation of DE2 planes only supported fixed zpos.
> > >=20
> > > Expand implementation with configurable zpos property.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >=20
> > Thanks for that work. I guess you should expand a bit on the exact
> > setup you're doing here.
>=20
> OK.
>=20
> >=20
> > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > pipe blending applies before the alpha blending, and therefore you
> > need to make sure that there's not two planes with alpha going to the
> > same pipe?
>=20
> I'm not familiar with DE1 and I'm not sure what the problem is.

The alpha blending is happening after the pipe blending. So you
basically have a two-stage blending, the first one between the planes
assigned to a pipe, only taking the plane priority into account, and
using the highest priority plane's pixel in overlapping area. And
then, you have alpha blending between the two pipes.

But that means that if you have two planes with alpha assigned to the
same pipe, it's not going to work since the value and alpha of the
lowest priority plane is going to be dropped in favor of the highest
priority, instead of having transparency.

> However, there is an issue in DE2 when alpha blending multiple planes if=
=20
> bottom-most plane doesn't cover all screen. In this case alpha blending=
=20
> produce weird result on screen. Fortunately, there is elegant solution. B=
lack=20
> opaque fill color is enabled for pipe 0 (always at the bottom), which cov=
ers=20
> any "undefined region" and that makes alpha blending happy again.
>=20
> Alternatively, blending modes between planes could be tweaked or
> disabled, but I found aforementioned solution is much simpler and
> you set it only once.

Yeah, we had a similar behaviour as well, if the lowest plane has a
some alpha (!=3D 0xff), the pixel value is completely dropped. We worked
around this by preventing any plane with alpha at the lowest position,
but it might be a good idea to check if the background color set to
black fixes it. I remember that we were indeed seeing the background
color, but I don't think I tried setting it to black and seeing what
happens.

> > Also, you seem to use the pipe and channels indifferently now, why is
> > that?
>=20
> Why do you think so?

Your driver used to use the channel id, and is now replaced by the
zpos assigned (for example in SUN8I_MIXER_BLEND_PIPE_CTL_EN)

> Channel always represents HW unit, for example, on H3, mixer0, channel 0=
=20
> always represents VI plane, channel 1, represents first UI, plane, channe=
l 2,=20
> second UI plane, etc.
>=20
> Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe=
 0,=20
> etc. Initial, fixed zpos implementation really had 1:1 mapping, but now i=
t can=20
> be different.
>=20
> Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
> Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents =
pipe=20
> 1, etc.
>=20
> Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are enab=
led=20
> and pipe 1 and 2 are disabled.

IIRC, you have 4 layers per channel, and then a combination of VI and
UI channels to form the DE2. Where is the pipe located exactly,
between the layers and the channel output, or between the channel
output?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lrbyc5izmmi6gw7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls13RkACgkQ0rTAlCFN
r3QsBA//ah6iE3x8xfBi5Sgiyz1qAIsryeybvEvscNJWPMDaI+7CY/5hIPTgApCg
Iu+JYrO/iqiULVpi59NnFiHLT5qTHGdbNtrm/HKvscCZTcaCpXxKp+49HVH19m4e
McDJ02XJAP8g/b7kCN009PUywRbva1ijINEfdfKt9Zp0veXfaYNqFAzobpLHrdSl
w0rP/fk/3lDtgjTUdBpcdm9FnjiPY+KwKXz5s0S9yMscHw/ZGDzgY9IgEZzjmXRD
i0wvR69hMnwzsOGR1p62dVJEvEBbB203K5Kyp38f3N/KHT9r82Zh4G65Bu4iGrwC
kk3Hwp8GnKmhPHcMLHcXIDk3Ay8C1HVxoscJkmroWu+W5gd2PDOLrHS4thEnQZNS
0a+x3RqOnjZjWugRSSLRwzxpm45l6dnyGS5VdWJ4eCF643QohyN4pzHfhfjcjD4k
eQTsGmV5Wojlc32KBG4LmUvoMzx6nukxfejd1JP0S8wMAtj3EJzywqV1idZplTrn
Knj6QR/D3AZ6k0dewFyujdcfwRMgTjSpZTyuFQVjZbz2/M2qeLdQIzfTHTARr9Un
cpJJcBWcusoHNDCFwqnYjj7gav5C/mHs+zwpEvPU/PyAxFji0dHIMCAOyrUSb+YQ
t8o5Vcu2ZFSXcLdtK6RyqBc+4PUhQqJmfqS9TU9C70yBxuIjB6c=
=wZaK
-----END PGP SIGNATURE-----

--lrbyc5izmmi6gw7g--
