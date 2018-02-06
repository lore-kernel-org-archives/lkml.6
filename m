Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBFJHZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:07:25 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:45970 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeBFJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:07:08 -0500
Date: Tue, 6 Feb 2018 10:06:56 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 05/10] ARM: sun8i: h3: add operating-points-v2 table
 for CPU
Message-ID: <20180206090656.r52hs7sk7w5iynrk@flea>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lm7thvhrmh5kkjhy"
Content-Disposition: inline
In-Reply-To: <20180206044905.30508-6-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lm7thvhrmh5kkjhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 12:49:00PM +0800, Icenowy Zheng wrote:
> The CPU on Allwinner H3 can do dynamic frequency scaling.
>=20
> Add a DVFS table based on the one shipped with Allwinner's H3 SDK. The
> voltage-frequency relationship seems to be conservative, and Armbian has
> another DVFS table which uses lower voltage at a certain frequency.
> However, the official one is chosen for safety.
>=20
> Frequencies higher than 1008MHz are temporarily dropped in the table, as
> they may lead to over voltage on boards without proper regulator
> settings or over temperature on boards with proper regulator settings.
> They will be added back once regulator settings are ready and thermal
> sensor driver is merged.
>=20
> In order to satisfy all different regulators (SY8106A which is 50mV per
> level, SY8113B which have two states: 1.1V and 1.3V, and some board with
> non-tweakable regulators), all the OPPs are defined with a range which has
> the target value as the minimum allowed value, and 1.3V (the highest
> VDD-CPUX voltage suggested by the datasheet) as the maximum allowed value.
> It's proven to work well with a board with SY8113B.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Switch to BSP OPP table, which is more conservative.
>=20
>  arch/arm/boot/dts/sun8i-h3.dtsi | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index 8495deecedad..36608c03f02b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -43,32 +43,62 @@
>  #include "sunxi-h3-h5.dtsi"
> =20
>  / {
> +	cpu0_opp_table: opp_table0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp@648000000 {
> +			opp-hz =3D /bits/ 64 <648000000>;
> +			opp-microvolt =3D <1040000 1040000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <1100000 1100000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <1200000 1200000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible =3D "arm,cortex-a7";
>  			device_type =3D "cpu";
>  			reg =3D <0>;
> +			clocks =3D <&ccu CLK_CPUX>;
> +			clock-names =3D "cpu";
> +			operating-points-v2 =3D <&cpu0_opp_table>;
> +			#cooling-cells =3D <0x2>;

So, that would be 2?

There's this pattern on pretty much all the other patches following
this one as well, you should address them too.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--lm7thvhrmh5kkjhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp5cC8ACgkQ0rTAlCFN
r3TOGw/9GnFM1ShIioIb0M8acn9gVHSUJYIbN4sEJ3+TTpkm4BNLPg8GVBLMUw5n
S6EjRhDXf9rO/jP7G0o1YGk8V8qzzwIqgqnLhJca12/82c8Cs9M/tnJFBJkFgAat
7evGuMbqdL97WF/vTOKB4rqNIVyLqWfvW2dbS/fqfA2uaNhdvnCuoA0LrsQZuXxl
sEJo0FUQFw2LYg6FMZ9t+BrerDbxsp+xu/C7uBsmFqM7WzHr5MJOQbm7KUF1ANaR
+VQP403FpJCzQftAe74uzcTKbPYw/BT3Lh7qSo/3EqRUyBKIOykv1MLzMa3mIlOD
U3ofGV1xhrk/QsFqgQs8QDFcf7EVfRAUp3VTYtHmYAICl2QzOGwqWQT61qV0jK5a
BkASNUjuIY9GTpD98E9xgngPtkUKycYNdh1WlaYwvjPw9/5iag1cWS2pH5n7TgBu
cotIzw/YQT21Cfw8bA9HWamkWbJp+ivOdA/GkdvIzVcjvSk83RZLsp4IeC8Rrd32
xS451eXDUyuGVOHwbEktmDs2eovKcTPMx9jvxe09ZDAdPclwNW/gs1YhPm/reAfh
uNhHDDV3ynqB4LyYjwZ+7v13ekoax718+Jr0zxkMFG9PUs5jali+Hrn+NMDLIEPI
9vhBs1s+msO7tXtwmex236TqaltAhy7aq6n0j6Kybq9Jabpr22Q=
=mDjU
-----END PGP SIGNATURE-----

--lm7thvhrmh5kkjhy--
