Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C33C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608DF25D8C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608DF25D8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeFYP6W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:58:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60298 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbeFYP6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:58:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F1CE206D8; Mon, 25 Jun 2018 17:58:16 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03923203D9;
        Mon, 25 Jun 2018 17:58:05 +0200 (CEST)
Date:   Mon, 25 Jun 2018 17:58:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 3/7] bus: add bus driver for accessing Allwinner A64
 DE2
Message-ID: <20180625155805.kds7bl3cburblwv6@flea>
References: <20180622124540.56203-1-icenowy@aosc.io>
 <20180622124540.56203-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gl5ozc65ejgjb7yn"
Content-Disposition: inline
In-Reply-To: <20180622124540.56203-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gl5ozc65ejgjb7yn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 08:45:36PM +0800, Icenowy Zheng wrote:
> The "Display Engine 2.0" (usually called DE2) on the Allwinner A64 SoC
> is different from the ones on other Allwinner SoCs. It requires a SRAM
> region to be claimed, otherwise all DE2 subblocks won't be accessible.
>=20
> Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
> region when probing.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> No changes since v1.
>=20
>  drivers/bus/Kconfig      | 10 ++++++++
>  drivers/bus/Makefile     |  1 +
>  drivers/bus/sun50i-de2.c | 49 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/bus/sun50i-de2.c
>=20
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index d1c0b60e9326..1851112ccc29 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -103,6 +103,16 @@ config SIMPLE_PM_BUS
>  	  Controller (BSC, sometimes called "LBSC within Bus Bridge", or
>  	  "External Bus Interface") as found on several Renesas ARM SoCs.
> =20
> +config SUN50I_DE2_BUS
> +	bool "Allwinner A64 DE2 Bus Driver"
> +	  default ARM64
> +	  depends on ARCH_SUNXI
> +	  select SUNXI_SRAM
> +	  help

The alignment here should be one tab.

> +static int sun50i_de2_bus_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int ret;
> +
> +	ret =3D sunxi_sram_claim(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
> +		return ret;
> +	}
> +
> +	if (np)
> +		of_platform_populate(np, NULL, NULL, &pdev->dev);

Why do you need to test np here?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gl5ozc65ejgjb7yn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxEQ0ACgkQ0rTAlCFN
r3Q7ghAAgafjNShKtVy1wF7ybhUEKPoF25teOrUO8ObOsgKgTaA+HeA0Iewg1w9c
slPeaTq/WKnRrN3RKADWLA6oUnIOPctPVWraFxPgOeEVnETlMBSm7igtFUodoMk6
W2qetFnSmWj7GgBVBCvX1G87qPyCHRHeyYgwWzvuAvApHedOjDZX1TFHoMuL9K+q
grLOVyj6U+L9Yl38S0/wScGQ0qeiUYWYW+dUyE5tuFgso1tftQNHDj01U9m/Zavg
+3cW6gbxQYBSzptkm0jaWxUJmCXGKZJYP2eNmnwkaT8HgmZMpq8AcxqKo6ES8jlq
fhVKOTBOVl+kYaoGMpIxq5TI1GGlblo5LkKXsEnq+bE1BKYqSb3EY3npuzfbs8Px
+JhITGKLpgYEytIj2rNf+5lyF4sueMizdVNIIpZuFlxI9BWW/gQ4OeOC5vdqI6ng
fRocfixsnCsZoFsxCT3T/V0IUygTBiBDQRyOWx08sdaHTNg6fkfpwZI9TjH7urzm
8PeNl+EA7STRUxEQchXwJZIwtt1ZA2EiY+U/eQVzbpXvcGKwwB0m3CxbGaUA8q82
hVMBazQt9DMVak17XYFlU+dd/v5/+tibMb/z+qER4NiG0C3x/XEeqrB46gkyRloi
HV7iUbhrb3D/jQAbVw81dwh01j2n1IYDpb/KAnJxyKxyAl87wug=
=BUDh
-----END PGP SIGNATURE-----

--gl5ozc65ejgjb7yn--
