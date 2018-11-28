Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAA8208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAA8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeK1U54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:57:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45631 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1U54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:57:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B35C220701; Wed, 28 Nov 2018 10:56:49 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 79E0C2039F;
        Wed, 28 Nov 2018 10:56:39 +0100 (CET)
Date:   Wed, 28 Nov 2018 10:56:39 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Message-ID: <20181128095639.t4ogsk6ovyu2yaxu@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
 <20181127093852.2iavgo4xipjnu25l@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2lymjsckr36agz46"
Content-Disposition: inline
In-Reply-To: <20181127093852.2iavgo4xipjnu25l@flea>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2lymjsckr36agz46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 10:38:52AM +0100, Maxime Ripard wrote:
> On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:
> > From: Olliver Schinagl <oliver@schinagl.nl>
> >=20
> > With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
> > Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
> > LDO3 this may be less arbitrary, but for LDO4 this is just wrong.
> >=20
> > In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> > which has no other purpose then a CSI/TS interface, however the case
> > may still be, that the connected IO may be just as well be 3.3 volts.
> > The big misnomer is however, that the schematic names GPIO-2 pin4
> > LDO3_2.8V, rather then VDD-CSI0 or similar.
> >=20
> > This is much worse for LDO4 however, which is not referenced on any
> > pin, is now set to 2.8 volts, but port bank G can also support various
> > other peripherals such as UARTS etc.
> >=20
> > By having 2.8 volts however for LDO4, we thus now have peripherals that
> > no longer function properly all of the time.
> >=20
> > Ideally, we want to set a supply voltage for each port bank, but the
> > monolithic nature of the sunxi pinctroller currently prevents this and
> > as such, the board should at least configure the LDO4 with the proper
> > ranges.
> >=20
> > Until we can set the consumer at the port bank level, a child
> > device-tree has to do something like:
> >=20
> > &reg_ldo4 {
> >     regulator-min-microvolt =3D <3300000>;
> >     regulator-max-microvolt =3D <3300000>;
> > };
> >=20
> > While doing this the same way results in the same solution currently,
> > we force the hack into the final devicetree rather then having it wrong
> > at the board level.
> >=20
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm=
/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > index ffafe97..1b9867f 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > @@ -250,9 +250,10 @@
> >  };
> > =20
> >  &reg_ldo4 {
> > -	regulator-min-microvolt =3D <2800000>;
> > -	regulator-max-microvolt =3D <2800000>;
> > -	regulator-name =3D "vddio-csi1";
> > +	regulator-always-on;
> > +	regulator-min-microvolt =3D <1250000>;
> > +	regulator-max-microvolt =3D <3300000>;
> > +	regulator-name =3D "vdd-io-pg";
>=20
> As we discussed on the U-Boot ML already, this shouldn't be made
> always-on but tied to the consumer device (the pinctrl one) instead.

Can you test that patch (not tested):
http://code.bulix.org/h02vha-514284?raw

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2lymjsckr36agz46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5mVwAKCRDj7w1vZxhR
xVFQAQC+r68rQ7ExhxasRM817Bj/h9jucmxZwlh2jfs6MPvaCAD/RTi/ro68kT5N
o+HYB8oNcmvZ0LlofxDy6ZXY8yxEMw4=
=MtaY
-----END PGP SIGNATURE-----

--2lymjsckr36agz46--
