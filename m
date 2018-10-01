Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795292084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795292084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeJAQja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:39:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51984 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbeJAQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:39:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 212FE20A90; Mon,  1 Oct 2018 12:02:27 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3DE920A95;
        Mon,  1 Oct 2018 12:02:16 +0200 (CEST)
Date:   Mon, 1 Oct 2018 12:02:16 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 10/11] phy: add driver for Microsemi Ocelot
 SerDes muxing
Message-ID: <20181001100216.fm3ojqx4zwnmyy5a@qschulz>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <cde4ccafdbd948db7ccbb263dd5b1a803e63a83e.1536912834.git-series.quentin.schulz@bootlin.com>
 <1dc66b5d-e60e-dad2-eed9-e283de260dc3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ha3eirq52wwwupq7"
Content-Disposition: inline
In-Reply-To: <1dc66b5d-e60e-dad2-eed9-e283de260dc3@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ha3eirq52wwwupq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Sat, Sep 15, 2018 at 02:20:25PM -0700, Florian Fainelli wrote:
>=20
>=20
> On 09/14/18 01:16, Quentin Schulz wrote:
> > The Microsemi Ocelot can mux SerDes lanes (aka macros) to different
> > switch ports or even make it act as a PCIe interface.
> >=20
> > This adds support for the muxing of the SerDes.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
>=20
> [snip]
>=20
> > +
> > +struct serdes_macro {
> > +	u8			idx;
> > +	/* Not used when in QSGMII or PCIe mode */
> > +	int			port;
>=20
> u8 port to be consistent with the mux table?
>=20

Not wanted in the current implementation.

In serdes_phy_create, I put the port to -1. In serdes_simple_xlate, I
make sure that once port is set to anything else than -1, it cannot be
set again (cannot have 2+ PHYs sharing the same SerDes (except for
SERDES6G_0 which is used for QSGMII)).

I cannot use u8 for this simple reason. However, I'm all ears for a
nicer solution :)

> [snip]
>=20
> > +#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {	\
> > +	.idx =3D _idx,						\
> > +	.port =3D _port,						\
> > +	.mode =3D _mode,						\
> > +	.mask =3D _mask,						\
> > +	.mux =3D _mux,						\
> > +}
> > +
> > +static const struct serdes_mux ocelot_serdes_muxes[] =3D {
> > +	SERDES_MUX(SERDES1G_0, 0, PHY_MODE_SGMII, 0, 0),
> > +	SERDES_MUX(SERDES1G_1, 1, PHY_MODE_SGMII, HSIO_HW_CFG_DEV1G_5_MODE, 0=
),
> > +	SERDES_MUX(SERDES1G_1, 5, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> > +		   HSIO_HW_CFG_DEV1G_5_MODE, HSIO_HW_CFG_DEV1G_5_MODE),
>=20
> Why not go one step further and define a SERDES_MUX_SGMII() macro which
> automatically resolves the correct bit definitions to use?
>=20
> The current macro does not make this particularly easy to read :/
>=20

I agree on the readability. But SERDES_MUX_SGMII would basically just
abstract the third argument (mode) and that's it, right? That's still
one argument less but do you see something even more intuitive and more
readable?

[...]

> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
> > +		if (macro->idx !=3D ocelot_serdes_muxes[i].idx ||
> > +		    mode !=3D ocelot_serdes_muxes[i].mode)
> > +			continue;
> > +
> > +		if (mode !=3D PHY_MODE_QSGMII &&
> > +		    macro->port !=3D ocelot_serdes_muxes[i].port)
> > +			continue;
> > +
> > +		ret =3D regmap_update_bits(macro->ctrl->regs, HSIO_HW_CFG,
> > +					 ocelot_serdes_muxes[i].mask,
> > +					 ocelot_serdes_muxes[i].mux);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (macro->idx < SERDES1G_MAX)
> > +			return serdes_init_s1g(macro->ctrl->regs, macro->idx);
> > +
> > +		/* SERDES6G and PCIe not supported yet */
> > +		return 0;
>=20
> Would not returning -EOPNOTSUPP be more helpful rather than leaving the
> PHY unconfigured (or did the bootloader somehow configure it before for u=
s)?
>=20

Yup, you're right, if the SerDes needs to be configured by the kernel,
the user of the SerDes mux is "broken" anyway so it makes sense to
return -EOPNOTSUPP.

[...]

> > +
> > +	ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> > +	if (!ctrl)
> > +		return -ENOMEM;
> > +
> > +	ctrl->dev =3D &pdev->dev;
> > +	ctrl->regs =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> > +	if (!ctrl->regs)
> > +		return -ENODEV;
> > +
> > +	for (i =3D 0; i <=3D SERDES_MAX; i++) {
>=20
> Every other loop you have is using <, is this one off-by-one?

That is an error.

Thanks,
Quentin

--ha3eirq52wwwupq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux8KgACgkQhLiadT7g
8aM7nBAAkQBdAHrGxa7Cg/8n+FhDPSAp9KXppLEraJru1T6XXu2BpYjEQ4GabimS
9D9Dj5PUjBMJ9CiOLm/O58gLbXaC0famPGtzbZbiKW2jEtxt6PGmUAhnOXC3p0vo
VwXnfKDiW0GEcN4qnK++7Y1iPQknKHWENQqcv5AKZPsfUKmp4iLoEel5XcHshYUF
x5vX7y34V1pfGz0omcxwPLnPKV3AjPbk5TffntPGRhBlFVq5oH0jtyDiKE1UjxUd
c47IT5A/hOEc6wNsyJ0kMrzFtkCghcUJtPCscIGTSSAYeswfN63JWXO1SNOYlpRf
dctN2nQ6KY2m5ajbwujiLvrXVf7mI2GO1YClDMZRxBrktUxRoUWKY/lleuiQBxKO
pHV8AQVogCyTwjWXzRByNvQqj5zZGhoGPiHpOWctWsKMiShPstIDjOiC3CPHxn8Z
azn98xmDky8CuK2HGziEnAUtfep9mnh4ZlGGHtXUQsz8wIxM5gG4pnocAvRKelX2
5+JU+1TiuvRT+k/UtGSvoYrq43M+2vAOfG00a6+YnkVXiC4Wfwc0UP1RuIXD2rgy
XO599eXbvMTwQhS+yNCLrV6PTq6CQvHF9sRCOwzQdRKyM6ZbVfNNSW0DxESQ9JeQ
cFPZDl5qTTgqCe0CPY1b0hhRWn1RwalTqHxlNFj3J269OErCcOc=
=YAEa
-----END PGP SIGNATURE-----

--ha3eirq52wwwupq7--
