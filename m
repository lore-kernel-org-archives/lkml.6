Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeB1Hg5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:36:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51937 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeB1Hez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:34:55 -0500
Date: Wed, 28 Feb 2018 08:34:40 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 01/16] clk: sunxi-ng: Add check for minimal rate to NM
 PLLs
Message-ID: <20180228073440.6ejo3wjdqag6h4nl@flea>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jbftow7kteudva7c"
Content-Disposition: inline
In-Reply-To: <20180227222701.9716-2-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbftow7kteudva7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2018 at 11:26:46PM +0100, Jernej Skrabec wrote:
> Some NM PLLs doesn't work well when their output clock rate is set below
> certain rate.
>=20
> Add support for that constrain.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_nm.c | 11 +++++++----
>  drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index a16de092bf94..7fc743c78c1b 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -20,7 +20,7 @@ struct _ccu_nm {
>  };
> =20
>  static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
> -			     struct _ccu_nm *nm)
> +			     unsigned long min_rate, struct _ccu_nm *nm)
>  {
>  	unsigned long best_rate =3D 0;
>  	unsigned long best_n =3D 0, best_m =3D 0;
> @@ -30,7 +30,7 @@ static void ccu_nm_find_best(unsigned long parent, unsi=
gned long rate,
>  		for (_m =3D nm->min_m; _m <=3D nm->max_m; _m++) {
>  			unsigned long tmp_rate =3D parent * _n  / _m;
> =20
> -			if (tmp_rate > rate)
> +			if (tmp_rate > rate || tmp_rate < min_rate)
>  				continue;
> =20
>  			if ((rate - tmp_rate) < (rate - best_rate)) {
> @@ -117,6 +117,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsi=
gned long rate,
>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *=3D nm->fixed_post_div;
> =20
> +	if (rate < nm->min_rate)
> +		rate =3D nm->min_rate;
> +

I guess you can just return there. There's no point in trying to find
the factors at this point, since the minimum should be a value that
can be reached.

>  	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
>  		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  			rate /=3D nm->fixed_post_div;
> @@ -134,7 +137,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsi=
gned long rate,
>  	_nm.min_m =3D 1;
>  	_nm.max_m =3D nm->m.max ?: 1 << nm->m.width;
> =20
> -	ccu_nm_find_best(*parent_rate, rate, &_nm);
> +	ccu_nm_find_best(*parent_rate, rate, nm->min_rate, &_nm);

Therefore, you don't need to change the prototype there either.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jbftow7kteudva7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWW4wACgkQ0rTAlCFN
r3TU/BAAmxBKw7Wvwd44uNICrnv1n/tKtG72EEdkJvG4B8OqXY69KckH7941DM9h
YfujkHMsFqghmXCdMzxunXNHegSy6lM3aNMHQBXfOOj4drBW37WQMyZCc9jBUoAI
DlmEraJZJDoA1sSSL/BIHSDxlM2EGzmhtB3RZrlcOdNGSPldAqgnEC28NwYbuZxP
RMAsvwnyL39RVLZy3kSrJ6SNMdcFVvNNbueQhUrFrJAd/bpGbfBNJzj2uUPVODVV
cwVGbqOe5z0Zno6O7Tp3Zd0+wKC1YwqQ6+K/MYzbXn5p5LIZLu+CcJvk9C2LEj3y
/tY/XKU++1PSbHdbYIN7ZgNLVrTf9/3lyazgJcm/Wt9D5IplHKyDGZDwTFpW36fX
R41WQS6YW1i3LJMd4qUBVlZuLtlVLceX6XDl9wxkQAwkSG3dyKPMBzEjVj2w+XUc
OvNwIxwqmCdAcn12ZpRc3EAisKFzfcDJlMuXCIhKNwvddtGLsbLzXxvLTZUuJtmo
nsBefriY+5d28sPucEVHtaYlz3276yF3dCi+j4JHrujdROhhuXud/WDPlBT2BecL
btXOaCKZlbxrXAj2/ZXPz0iKTR2bx9CSGqfBIkkVZ+wfume+72fKpK3cXe3hekPM
2s8bQ75DlSaEbcTQXNhgzJ8at+fFm9LDQi6MsW57x6hQBnbbzoI=
=WPSn
-----END PGP SIGNATURE-----

--jbftow7kteudva7c--
