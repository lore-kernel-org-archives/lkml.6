Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeBWPS0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:18:26 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53716 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeBWPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:18:24 -0500
Date: Fri, 23 Feb 2018 16:18:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 2/7] pinctrl: sunxi: support pin controllers with
 holes among IRQ banks
Message-ID: <20180223151821.gqn66roldejpowzu@flea.lan>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hzki2yhvhouadvwv"
Content-Disposition: inline
In-Reply-To: <20180223122552.58049-3-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hzki2yhvhouadvwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 08:25:47PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. This
> situation cannot be processed with the current pinctrl IRQ code, as it
> only expects a offset to all IRQ banks.
>=20
> Update the code to use a logical IRQ bank to hardware IRQ bank map, so
> the new situation in H6 main pin controller can be processed. The old
> special situation which uses a constant offset (on A33 and V3s, both
> with a offset of 1) can be also processed with the new code.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - change for the refactor in the new PATCH 1.
>=20
> No changes in v2.
>=20
>  drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c |  4 +++-
>  drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c |  4 +++-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h     | 29 +++++++++++++++++--------=
----
>  3 files changed, 23 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/=
sunxi/pinctrl-sun8i-a33.c
> index da387211a75e..f043afa1aac5 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> @@ -481,11 +481,13 @@ static const struct sunxi_desc_pin sun8i_a33_pins[]=
 =3D {
>  		  SUNXI_FUNCTION(0x3, "uart3")),	/* CTS */
>  };
> =20
> +static const unsigned int sun8i_a33_pinctrl_irq_bank_map[] =3D { 1, 2 };
> +
>  static const struct sunxi_pinctrl_desc sun8i_a33_pinctrl_data =3D {
>  	.pins =3D sun8i_a33_pins,
>  	.npins =3D ARRAY_SIZE(sun8i_a33_pins),
>  	.irq_banks =3D 2,
> -	.irq_bank_base =3D 1,
> +	.irq_bank_map =3D sun8i_a33_pinctrl_irq_bank_map,
>  	.disable_strict_mode =3D true,
>  };
> =20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c b/drivers/pinctrl/=
sunxi/pinctrl-sun8i-v3s.c
> index 496ba34e1f5f..6704ce8e5e3d 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
> @@ -293,11 +293,13 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[]=
 =3D {
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PG_EINT5 */
>  };
> =20
> +static const unsigned int sun8i_v3s_pinctrl_irq_bank_map[] =3D { 1, 2 };
> +
>  static const struct sunxi_pinctrl_desc sun8i_v3s_pinctrl_data =3D {
>  	.pins =3D sun8i_v3s_pins,
>  	.npins =3D ARRAY_SIZE(sun8i_v3s_pins),
>  	.irq_banks =3D 2,
> -	.irq_bank_base =3D 1,
> +	.irq_bank_map =3D sun8i_v3s_pinctrl_irq_bank_map,
>  	.irq_read_needs_mux =3D true
>  };
> =20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.h
> index 909ca1504b61..36502cbef6c2 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> @@ -110,7 +110,7 @@ struct sunxi_pinctrl_desc {
>  	int				npins;
>  	unsigned			pin_base;
>  	unsigned			irq_banks;
> -	unsigned			irq_bank_base;
> +	const unsigned int		*irq_bank_map;
>  	bool				irq_read_needs_mux;
>  	bool				disable_strict_mode;
>  };
> @@ -263,14 +263,23 @@ static inline u32 sunxi_pull_offset(u16 pin)
>  	return pin_num * PULL_PINS_BITS;
>  }
> =20
> +static inline u32 sunxi_irq_hw_bank_num(u8 bank,
> +					const struct sunxi_pinctrl_desc *desc)
> +{
> +	if (!desc->irq_bank_map)
> +		return bank;
> +	else
> +		return desc->irq_bank_map[bank];
> +}
> +

Same remark about the order of the argument, and I would have split
this patch in two, one to introduce the new function (but still using
the irq_bank_base), and then a second patch to introduce the
irq_bank_map.

Looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hzki2yhvhouadvwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQML0ACgkQ0rTAlCFN
r3TOoA/+IJr26dnmK1zjBiaE2I3eHpmYqrmmV7BmcTV3zEUAp0U/bCenYecTaG6C
L6ck25pgYSYk1MJQf2JsOxK7YIUp+5dytqBmHq2JgUsgGam1OrESDMuPkJJXjiha
I/6Fqunaa9Sa5gWjRAI426SL/9xe0gGz2Bf0d46MjycxgZlgrsxhLxDKEKASju7q
ViGnN5uZNle6Y88+84FRIYH/wMl1CFAWjGoVQbiss1UVPQapatqBhcnxSgUIVRd2
fbbc4As+/KgrN8CXZYY1vOmDF+PsGzDSngdZ4Sz+wKy5KMvZBTCplBCwl3+YkFJF
9h96wlLWIbK7JnL1NxRRir+e7kWRHgEstXF4Qz5LDTwnAEkprTaFdd9nmHhJzgIf
2Y44TpMIzhzCFA+rJG7hIJEWRCd4ZU726xLiJluqsKgTLz3S2DWFpn9ZAjVwRtXj
kTON+NtvCiB+sdoRVeQlq2V6VExk0HJsntSo8CKlX0IynFCyDyRxZgx21zkj/bDN
Oh5n24gGnqhZmArvCibeEKUOgzOEIkSLyrQbx28eOzgKGf28dH+xmUUpMFZqhzC8
hkv8ylzeYayFqQWgbCnuWGuvQqLyiOEJIQu2DIBA4LUTvL0gs3mFtqaFE4IASGd8
ZI2TMjJacm8bH0hMlzTANBDdvg67cr04wPDQYPjoiRrevTU4K58=
=GXP9
-----END PGP SIGNATURE-----

--hzki2yhvhouadvwv--
