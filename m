Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeAaRlE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:41:04 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52693 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeAaRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:41:02 -0500
Date: Wed, 31 Jan 2018 18:40:59 +0100
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 01/16] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180131174058.f7gog7yahcu67sqr@qschulz>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-2-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cinr2hcuoq4lp4p4"
Content-Disposition: inline
In-Reply-To: <20180128232919.12639-2-embed3d@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cinr2hcuoq4lp4p4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:04AM +0100, Philipp Rossak wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>=20
> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> the bus clock and the reset was removed from the CCU. The THS in A83T
> has a clock that is directly connected and runs with 24 MHz.
>=20
> Update the binding document to cover H3 and A83T.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 50 ++++++++++++++++=
++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Docu=
mentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index 86dd8191b04c..22df0c5c23d4 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,35 @@ The Allwinner SoCs all have an ADC that can also act as=
 a thermal sensor
>  and sometimes as a touchscreen controller.
> =20
>  Required properties:
> -  - compatible: "allwinner,sun8i-a33-ths",
> +  - compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a33-ths"
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
>    - reg: mmio address range of the chip,
> -  - #thermal-sensor-cells: shall be 0,
> +  - #thermal-sensor-cells: shall be 0 or 1,

Well, thermal-sensor-cells is either 0 or 1 :)

Better to point to the documentation describing this
thermal-sensor-cells IMHO.

>    - #io-channel-cells: shall be 0,
> =20
> -Example:
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
> +  - interrupts: the sampling interrupt of the ADC,
> +
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "mod",
> +  - resets: the bus reset of the ADC,
> +
> +Optional properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem d=
evice.
> +		If unspecified default values shall be used. The size should
> +		be 0x2 * sensorcount.

"twice the number of sensors" ?

> +  - nvmem-cell-names: Should be "calibration".
> +
> +Details see: bindings/nvmem/nvmem.txt
> +
> +Example for A33:
>  	ths: ths@1c25000 {
>  		compatible =3D "allwinner,sun8i-a33-ths";
>  		reg =3D <0x01c25000 0x100>;
> @@ -17,6 +40,27 @@ Example:
>  		#io-channel-cells =3D <0>;
>  	};
> =20
> +Example for H3:
> +	ths: thermal-sensor@1c25000 {
> +		compatible =3D "allwinner,sun8i-h3-ths";
> +		reg =3D <0x01c25000 0x400>;
> +		clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +		clock-names =3D "bus", "mod";
> +		resets =3D <&ccu RST_BUS_THS>;
> +		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells =3D <0>;
> +		#io-channel-cells =3D <0>;
> +	};
> +
> +Example for A83T:
> +	ths: thermal-sensor@1f04000 {
> +		compatible =3D "allwinner,sun8i-a83t-ths";
> +		reg =3D <0x01f04000 0x100>;
> +		interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells =3D <1>;
> +		#io-channel-cells =3D <0>;
> +	};
> +

Aside from Maxime's comment on how we would like to refactor GPADC/THS,
I'm not sure we really want an example for each an every thermal sensor
supported.

Quentin

--cinr2hcuoq4lp4p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJacf+nAAoJEIS4mnU+4PGj74oQAIoUg6DY/r/AEbZmlPptIJ9b
aBi8OCOKDhpYI4roSMxtKNSmqsmQEooyEiisUNIVxJ178ZOaoT82X5gJNj6fLg2t
rW/H51Eile4ThT9jwyPU+ht+DGocH6mkoSykJypZHhzHHNOpaQPkClhrT8Yi0/25
9pgqBhMgBtzORBa1oZnTwR0j5lCmYzxY0izhuTnxsI92geqsjUWoOyJQIbUAymya
xG7TeBkFeKuR0tMgLb9Q9s3GXlzrMvESWsT1D3DRZYF8+rD/Z5ivO3ypK0+n3WzW
GKZHWtmSFXxF8kkqrvp3oxleSu+t7/F4My3lrfhsYhYUGELYH1IJKaSp/2i6AIMB
A9XswCfySEw3ef6g54BkcAbHfqT5eyMBLF+JRcQrteiRV7QtpT5HweHPYHX5pZIZ
9QZxsiMSIe9dEz4M1MMkSeUL0/SvU7uzGjMO2FA23RmRbhtOnq6Qdd2NycAY/8xf
jg9gRZaiC1/6LwVWmF4QFA+Au4IWU3WsD6Q04aQmufat5Gw1t9w8L5PVmxwEeqSK
U7wcZ7xkQgct83zfj8WL7cX1p3bZASxASB5WbhtLVaUf3WOXVhuMMH0d11/iEUVZ
5Wn2rRAJRt92dYdy1Noj8xUyfr7F5h3dNO6zGcsbgsSzOJ3xTqfJcC7cYrVenNXU
+QIMW79fbDxyp8LP9/z6
=Bn5q
-----END PGP SIGNATURE-----

--cinr2hcuoq4lp4p4--
