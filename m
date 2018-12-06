Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD302C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42EE2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42EE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLFU7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:59:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:59:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 89527263ACA
Received: by earth.universe (Postfix, from userid 1000)
        id DE8043C08D6; Thu,  6 Dec 2018 21:59:36 +0100 (CET)
Date:   Thu, 6 Dec 2018 21:59:36 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181206205936.jqcirosf2s34gcje@earth.universe>
References: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75fgkhawihvwaveb"
Content-Disposition: inline
In-Reply-To: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75fgkhawihvwaveb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2018 at 05:29:46PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Move SHDWC realted data to only one structure to have them grouped.
> Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
> mpddrc_base part of struct shdwc").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Changes in v2:
> - avoid allocate at91_shdwc and keep it static instead
> - avoid registering at91_shdwc as platform data and use static variable
>   instead
>=20
>  drivers/power/reset/at91-poweroff.c | 48 +++++++++++++++++++------------=
------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index d3d87af24e55..9e74e131c675 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -51,14 +51,16 @@ static const char *shdwc_wakeup_modes[] =3D {
>  	[AT91_SHDW_WKMODE0_ANYLEVEL]	=3D "any",
>  };
> =20
> -static void __iomem *at91_shdwc_base;
> -static struct clk *sclk;
> -static void __iomem *mpddrc_base;
> +static struct shdwc {
> +	struct clk *sclk;
> +	void __iomem *shdwc_base;
> +	void __iomem *mpddrc_base;
> +} at91_shdwc;
> =20
>  static void __init at91_wakeup_status(struct platform_device *pdev)
>  {
>  	const char *reason;
> -	u32 reg =3D readl(at91_shdwc_base + AT91_SHDW_SR);
> +	u32 reg =3D readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
> =20
>  	/* Simple power-on, just bail out */
>  	if (!reg)
> @@ -92,9 +94,9 @@ static void at91_poweroff(void)
> =20
>  		"	b	.\n\t"
>  		:
> -		: "r" (mpddrc_base),
> +		: "r" (at91_shdwc.mpddrc_base),
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
> -		  "r" (at91_shdwc_base),
> +		  "r" (at91_shdwc.shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
>  		: "r6");
>  }
> @@ -144,7 +146,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct p=
latform_device *pdev)
>  	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
>  			mode |=3D AT91_SHDW_RTTWKEN;
> =20
> -	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
> +	writel(wakeup_mode | mode, at91_shdwc.shdwc_base + AT91_SHDW_MR);
>  }
> =20
>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> @@ -155,15 +157,15 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
>  	int ret;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	at91_shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(at91_shdwc_base))
> -		return PTR_ERR(at91_shdwc_base);
> +	at91_shdwc.shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(at91_shdwc.shdwc_base))
> +		return PTR_ERR(at91_shdwc.shdwc_base);
> =20
> -	sclk =3D devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(sclk))
> -		return PTR_ERR(sclk);
> +	at91_shdwc.sclk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(at91_shdwc.sclk))
> +		return PTR_ERR(at91_shdwc.sclk);
> =20
> -	ret =3D clk_prepare_enable(sclk);
> +	ret =3D clk_prepare_enable(at91_shdwc.sclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not enable slow clock\n");
>  		return ret;
> @@ -176,20 +178,20 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
> =20
>  	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
>  	if (np) {
> -		mpddrc_base =3D of_iomap(np, 0);
> +		at91_shdwc.mpddrc_base =3D of_iomap(np, 0);
>  		of_node_put(np);
> =20
> -		if (!mpddrc_base) {
> +		if (!at91_shdwc.mpddrc_base) {
>  			ret =3D -ENOMEM;
>  			goto clk_disable;
>  		}
> =20
> -		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
> +		ddr_type =3D readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
>  				 AT91_DDRSDRC_MD;
>  		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
>  		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
> -			iounmap(mpddrc_base);
> -			mpddrc_base =3D NULL;
> +			iounmap(at91_shdwc.mpddrc_base);
> +			at91_shdwc.mpddrc_base =3D NULL;
>  		}
>  	}
> =20
> @@ -198,7 +200,7 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
>  	return 0;
> =20
>  clk_disable:
> -	clk_disable_unprepare(sclk);
> +	clk_disable_unprepare(at91_shdwc.sclk);
>  	return ret;
>  }
> =20
> @@ -207,10 +209,10 @@ static int __exit at91_poweroff_remove(struct platf=
orm_device *pdev)
>  	if (pm_power_off =3D=3D at91_poweroff)
>  		pm_power_off =3D NULL;
> =20
> -	if (mpddrc_base)
> -		iounmap(mpddrc_base);
> +	if (at91_shdwc.mpddrc_base)
> +		iounmap(at91_shdwc.mpddrc_base);
> =20
> -	clk_disable_unprepare(sclk);
> +	clk_disable_unprepare(at91_shdwc.sclk);
> =20
>  	return 0;
>  }
> --=20
> 2.7.4
>=20

--75fgkhawihvwaveb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwJjbgACgkQ2O7X88g7
+poYkxAAhnjIBKgbhI5/qt1oyGBlJqjq9vYY9ZN0boo3Xy+Hmyve/vFUIsCFVa8K
pP7FpFXkLF9599Nobjte8i2ioGe51I1wKhby/K7dYd+0l4dPfLYnoO0JvZwl4HLZ
BVVjKl+wcnyw54/54NzF+WST1PzI11pv/OuI3Y/q7G2fj+SPS6c2s8Lz1zNfyVrY
p8Evmela9PI0mApoB2jjNw3ZoEGjFoRs9eo85aBK/p/QNs0hj9ZBdHRLX1Z1idQ9
g5G0L9t6xmncPp6OK0W9tsjVy1ZyjBLmdhDlDuQgDdLTittLdVUGN4a0L/e4xBhq
rWQhtQv2LDW1XNuueC8r8w8Y0tJIfN7Hc0PMsvWRgCQ6WgibOuIWd5QO03NmV+VL
o0IBFwFzEOPcFbe0OBECAZDTX8l9w4i3LkFwcLGh0VPV2AxUzruAkaENkqVGqkum
Y864FYyMuU9vA5fzB4zmPDhxzVEiOcitBnpWThZX9XqnY4nC5oIqXakS3n5rLcgB
F1C9RymDqZLDku+sO13O0YO0OOPCitHA25OaD7ZlIIjiS+Gb8sIWw3MEdhsQR9pl
UOX/+Tkp3iFkN4+x/3ROE5cxr/ZtbMDm8PcoIue8WopasedpERoYE5oqAUK2xJhY
teWJOKZO+J1RY6wYBSeEdlt9ctThNHS2YpJxhn2MyvbrN/cnNfY=
=DTwq
-----END PGP SIGNATURE-----

--75fgkhawihvwaveb--
