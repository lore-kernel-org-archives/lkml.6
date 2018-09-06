Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0B5206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0B5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeIFTc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:32:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60003 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbeIFTc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:32:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39F1A207AD; Thu,  6 Sep 2018 16:56:33 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0059A20787;
        Thu,  6 Sep 2018 16:56:22 +0200 (CEST)
Date:   Thu, 6 Sep 2018 16:56:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 02/10] phy: Add configuration interface
Message-ID: <20180906145622.kwxvkcuerbeqsj6b@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxtewovccik3oxha"
Content-Disposition: inline
In-Reply-To: <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxtewovccik3oxha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Thu, Sep 06, 2018 at 02:57:58PM +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 05 September 2018 02:46 PM, Maxime Ripard wrote:
> > The phy framework is only allowing to configure the power state of the =
PHY
> > using the init and power_on hooks, and their power_off and exit
> > counterparts.
> >=20
> > While it works for most, simple, PHYs supported so far, some more advan=
ced
> > PHYs need some configuration depending on runtime parameters. These PHYs
> > have been supported by a number of means already, often by using ad-hoc
> > drivers in their consumer drivers.
> >=20
> > That doesn't work too well however, when a consumer device needs to deal
> > multiple PHYs, or when multiple consumers need to deal with the same PH=
Y (a
> > DSI driver and a CSI driver for example).
> >=20
> > So we'll add a new interface, through two funtions, phy_validate and
> > phy_configure. The first one will allow to check that a current
> > configuration, for a given mode, is applicable. It will also allow the =
PHY
> > driver to tune the settings given as parameters as it sees fit.
> >=20
> > phy_configure will actually apply that configuration in the phy itself.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/phy/phy-core.c  | 62 +++++++++++++++++++++++++++++++++++++++++=
+-
> >  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
> >  2 files changed, 104 insertions(+)
> >=20
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 35fd38c5a4a1..6eaf655e370f 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
> >  EXPORT_SYMBOL_GPL(phy_calibrate);
> > =20
> >  /**
> > + * phy_configure() - Changes the phy parameters
> > + * @phy: the phy returned by phy_get()
> > + * @mode: phy_mode the configuration is applicable to.
>=20
> mode should be used if the same PHY can be configured in multiple modes. =
But
> with phy_set_mode() and phy_calibrate() we could achieve the same.

So you would change the prototype to have a configuration applying
only to the current mode set previously through set_mode?

Can we have PHY that operate in multiple modes at the same time?

> > + * @opts: New configuration to apply
>=20
> Should these configuration come from the consumer driver?

Yes

> Can't the helper functions be directly invoked by the PHY driver for
> the configuration.

Not really. The helpers are here to introduce functions that give you
the defaults provided by the spec for a given configuration, and to
validate that a given configuration is within the spec boundaries. I
expect some consumers to need to change the defaults for some more
suited parameters that are still within the boundaries defined by the
spec.

And I'd really want to have that interface being quite generic, and
applicable to other phy modes as well. The allwinner USB PHY for
example require at the moment an extra function that could be moved to
this API:
https://elixir.bootlin.com/linux/latest/source/drivers/phy/allwinner/phy-su=
n4i-usb.c#L512

> > + *
> > + * Used to change the PHY parameters. phy_init() must have
> > + * been called on the phy.
> > + *
> > + * Returns: 0 if successful, an negative error code otherwise
> > + */
> > +int phy_configure(struct phy *phy, enum phy_mode mode,
> > +		  union phy_configure_opts *opts)
> > +{> +	int ret;
> > +
> > +	if (!phy)
> > +		return -EINVAL;
> > +
> > +	if (!phy->ops->configure)
> > +		return 0;
> > +
> > +	mutex_lock(&phy->mutex);
> > +	ret =3D phy->ops->configure(phy, mode, opts);
> > +	mutex_unlock(&phy->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * phy_validate() - Checks the phy parameters
> > + * @phy: the phy returned by phy_get()
> > + * @mode: phy_mode the configuration is applicable to.
> > + * @opts: Configuration to check
> > + *
> > + * Used to check that the current set of parameters can be handled by
> > + * the phy. Implementations are free to tune the parameters passed as
> > + * arguments if needed by some implementation detail or
> > + * constraints. It will not change any actual configuration of the
> > + * PHY, so calling it as many times as deemed fit will have no side
> > + * effect.
> > + *
> > + * Returns: 0 if successful, an negative error code otherwise
> > + */
> > +int phy_validate(struct phy *phy, enum phy_mode mode,
> > +		  union phy_configure_opts *opts)
>=20
> IIUC the consumer driver will pass configuration options (or PHY paramete=
rs)
> which will be validated by the PHY driver and in some cases the PHY drive=
r can
> modify the configuration options? And these modified configuration option=
s will
> again be given to phy_configure?
>=20
> Looks like it's a round about way of doing the same thing.

Not really. The validate callback allows to check whether a particular
configuration would work, and try to negotiate a set of configurations
that both the consumer and the PHY could work with.

For example, DRM requires this to filter out display modes (ie,
resolutions) that wouldn't be achievable by the PHY so that it's never
exposed to the user, and you don't end up in a situation where the
user select a mode that you knew had zero chance to work.

> > @@ -164,6 +202,10 @@ int phy_exit(struct phy *phy);
> >  int phy_power_on(struct phy *phy);
> >  int phy_power_off(struct phy *phy);
> >  int phy_set_mode(struct phy *phy, enum phy_mode mode);
> > +int phy_configure(struct phy *phy, enum phy_mode mode,
> > +		  union phy_configure_opts *opts);
> > +int phy_validate(struct phy *phy, enum phy_mode mode,
> > +		 union phy_configure_opts *opts);
>=20
> Stub function when CONFIG_GENERIC_PHY is not set is also required.

Ok. Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mxtewovccik3oxha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluRQBUACgkQ0rTAlCFN
r3Rzug//YE2qmMLMuHh1TgQNdB2HvUosiW1B8k1HtC0zACsMjXaWG/2c7cGGbFqX
XXoa2hVL2V820bz+phOLPkor44tUouB9AeKviozpwwfNCfp/B9haUN2eUBOWUm2q
09ZOgwge+zx9e5RfTMIuZUlGH1C/vkLysfKOAUc4shaXbiX2zDs8ARe21NN0lnkQ
YUvAU0yvfrYhxGAerhWuA1ubiLnsxP0i/Y8qqz3h1vlitu9A0JO19HnrUz2kolfX
wdWkTFOcYGebxCf+RPrG0KdyJ/Zzd4ILOEODJaUDdvRhPjVyYPhoqocI6MS7dYBw
U7zQrjPtDcdkIZqi3iT3pqb+hJSfZ24eFLMZegZ5D4zW//GoJoSd4cFfeIuw3eDQ
urBcUprEy41jaW8Ucb8UhKIC3WzyzoaJJkfKp8nKepPHL5WySF81NtegPljWGdAi
r90I+tdQqwoUzNevQgChhNX5p7KnRfB4PJRFN80Az+H6Q58/BrikNNmNoZle2Kys
22aaNwKkesiBX71Il9tYLlwKbbYpC84KB1emF10ZswhaXCrvUvhzaQ+qnX6dpjnp
J64ThzwyZIRLsBZpxsuzyuyFwdKU81ryF0BG+C0m8ZvMZSGD9m2lAIXeGVBS5BW8
HQBXACIPqGVwvcQ7ifXvtOtrya0HN2mcivT4jFj+NVK0TcydERk=
=m3Dq
-----END PGP SIGNATURE-----

--mxtewovccik3oxha--
