Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC10C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E64216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E64216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHGWsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:48:00 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:40638 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHGWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:47:59 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 5B645C013D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 22:31:49 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 15229C0F36; Tue,  7 Aug 2018 22:31:48 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id D05CDC0F18;
        Tue,  7 Aug 2018 22:31:31 +0200 (CEST)
Message-ID: <230112e8b2ad4b4e53b54fe1446e7f71aa09e514.camel@paulk.fr>
Subject: Re: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com
Date:   Tue, 07 Aug 2018 22:31:30 +0200
In-Reply-To: <20180807201801.GF3008@phenom.ffwll.local>
References: <20180807193919.4800-1-contact@paulk.fr>
         <20180807201801.GF3008@phenom.ffwll.local>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+/fzeC/q/EtTWxQj+UFa"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+/fzeC/q/EtTWxQj+UFa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 07 ao=C3=BBt 2018 =C3=A0 22:18 +0200, Daniel Vetter a =C3=A9crit :
> On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> > Initializing and registering fbdev requires at least one DRM connector
> > and will fail otherwise. In order to support headless setups (for
> > instance for GPU rendering with the GBM backend, where a DRI card node
> > is required to provide GEM memory reservation), add a check on the
> > number of registered connectors before initializing fbdev.
>=20
> sun4i is a pure kms driver, why exactly do you need it for gbm backed
> rendering? What exactly is rendering here, and why does it insist on a
> display card node, even if that display card node is 100% defunct?

The non-free Mali blobs provide GPU support with a GBM interface that
takes a DRM fd in order to reserve the memory it needs for its rendering
targets. This uses the GEM interface available through the DRI card node
(and there is no render node with the non-free Mali driver). Allwinner
has a minimalistic out-of-tree driver pretty much only for this purpose.

I crafted this patch when someone on IRC tried to get the out-of-tree
Mali GPU driver going with the mainline kernel in order to do rendering
in a GBM buffer, since it's apparently the only option for headless
rendering with the blob.

In my opinion, supporting the pipeline of an out-of-tree GPU driver that
only works with a non-free userspace blob is not a valid reason to do
anything. Still, it felt like adding support for the headless use-case
wouldn't hurt, whatever the underlying use case for it may be. I found
that other drivers also implement the same mechanism (perhaps for
different reasons).

Cheers,

Paul

> -Daniel
>=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/dr=
m/sun4i/sun4i_framebuffer.c
> > index 5f29850ef8ac..19a265e4a93a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> > @@ -49,6 +49,8 @@ static struct drm_mode_config_helper_funcs sun4i_de_m=
ode_config_helpers =3D {
> > =20
> >  int sun4i_framebuffer_init(struct drm_device *drm)
> >  {
> > +	int ret;
> > +
> >  	drm_mode_config_reset(drm);
> > =20
> >  	drm->mode_config.max_width =3D 8192;
> > @@ -57,7 +59,13 @@ int sun4i_framebuffer_init(struct drm_device *drm)
> >  	drm->mode_config.funcs =3D &sun4i_de_mode_config_funcs;
> >  	drm->mode_config.helper_private =3D &sun4i_de_mode_config_helpers;
> > =20
> > -	return drm_fb_cma_fbdev_init(drm, 32, 0);
> > +	if (drm->mode_config.num_connector > 0) {
> > +		ret =3D drm_fb_cma_fbdev_init(drm, 32, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> >  }
> > =20
> >  void sun4i_framebuffer_free(struct drm_device *drm)
> > --=20
> > 2.18.0
> >=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20
--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-+/fzeC/q/EtTWxQj+UFa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAltqAaIACgkQhP3B6o/u
lQw0fg//Z2sVRijSWYVQZ2XOWioiO8hs07/ggbznUjO6UyQ87mTDZEXTiEr/9PEk
7ZerPTRjWUvynQILZZESY4E1ojwQis6e9d53yOZr24kvaIR4ysk3LUgfHO10EiFB
YAbvjOWHnwcdnJ7dPQ3i9rIXrnMJVFpc1WyFGPqvv2fOktOk7bEEptI5JcOryVgm
erC36pnTnqEXjSYw/ZGPde4FHfIsBv/lYQVl/S5DwSfW26qO2yPhCjzOen8O26gi
wY6hVDQLZKM+I2tjUfv8QG5mr8kCMQMDPvwUE6lyaVQ85l93qjjG37pI4LrYzDHe
lIvuqQCNnHhP+rPExEkmrdaj3W92pM/p+TZE4lINFuBRe0nFp2lFC7krdHOrvc8+
k1uK8iVEy9k4wJPMqCq7WYjZLXwyt+B4IpbJBy9Vys1BQUfKSn5MZTCpFUuN/coQ
aqtw4EIlQZAi1AuzL/Qz6iArxiDan1CqK8Lti+Ln3Qy2it3eYTn11kwJOkOuQ0qR
J/6arYnCI5j3YbcVzj42TpsXKYrqI3HwuXx3RbIV2MYdLmTQRvIIchAiaHQD48Us
WWL0f3DdrR4vxyLn0MECoq6jjt/gNNBhMugtuctyNc4rILcpR2PQNwMZQ54Xwp9D
uz/PsBImSQBKXSfhU/fkd37h04gZsNpKLT3np1Tr3MFJWBtMoqA=
=LSkm
-----END PGP SIGNATURE-----

--=-+/fzeC/q/EtTWxQj+UFa--

