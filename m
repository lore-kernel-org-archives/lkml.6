Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEDIHH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:07:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50701 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeEDIHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:07:04 -0400
Date: Fri, 4 May 2018 10:06:52 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
Message-ID: <20180504080652.dniwaqqhbeuknp7y@flea>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
 <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rttcqilsjxraxvtj"
Content-Disposition: inline
In-Reply-To: <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rttcqilsjxraxvtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2018 at 06:41:34PM +0200, Giulio Benetti wrote:
> > > You don't have to handcode the fragments anymore with the new syntax,
> > > and U-Boot makes it really trivial to use if you use the FIT image
> > > format to have multiple overlays bundled in the same image. You can
> > > choose to apply them dynamically, for example based on an EEPROM or
> > > some other metric to see which combination you have.
> >=20
> > Ah, this is interesting. I'm going to experiment with that.
> >=20
>=20
> I'm struggling against this, I don't really know how to proceed,
> except keeping monolithic dts files including other dtsi files.
>=20
> About dt-overlays I've tried to look around lot of time,
> but the only thing I've found is this:
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git=
/tree/arch/arm/boot/dts?h=3Dtopic/renesas-overlays
>=20
> where they use .dtso tagging them as "/plugin/;"
> and compile all .dtso found in dts folder.
> Then they obtain .dtbo files that should be the dt-overlays we have spoken
> about right?

Yes. You don't have to do that though, you can just rely on dtc to
compile them, outside of the linux build system.

> What I can't understand is if there's a real standard at this time to
> follow, because on renesas-driver they use their way to handle all .dtso
> files, but on mainline there seems to be nothing about that.

I'm not sure what you mean here. It's just fragments of device tree,
that have to be compiled using dtc, that's it. You can use the Linux
build system infrastructure to do that, or you can build your own
simpler one. That's really up to you. See for example
https://github.com/NextThingCo/CHIP-dt-overlays/blob/master/Makefile

(even though the overlays themselves use the legacy syntax and
shouldn't really be used an examples)

> So at the moment I'm trying to compile dts tagged as /plugin/;
> but dtc gives me a lot of warnings.
>=20
> dts:
> "
> /dts-v1/;
> /plugin/;
>=20
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/interrupt-controller/irq.h>
>=20
> &i2c2 {
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&i2c2_pins_a>;
> 	status =3D "okay";
>=20
> 	ft5x {
> 		compatible =3D "edt,edt-ft5306";
> 		reg =3D <0x38>;
> 		interrupt-parent =3D <&pio>;
> 		interrupts =3D <7 2 IRQ_TYPE_EDGE_FALLING>; /* PH2 */
> 		reset-gpios =3D <&pio 7 3 GPIO_ACTIVE_LOW>; /* PH3 */
> 		touchscreen-size-x =3D <480>;
> 		touchscreen-size-y =3D <272>;
> 	};
> };
> "
>=20
> Build output issuing make ARCH=3Darm CROSS_COMPILE=3Darm-linux- aaa.dtb (=
I use
> aaa.dts as source):
> "
> arch/arm/boot/dts/aaa.dtb: Warning (reg_format):
> /fragment@0/__overlay__/ft5x:reg: property has invalid length (4 bytes)
> (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/boot/dts/aaa.dtb: Warning (pci_device_bus_num): Failed prerequis=
ite
> 'reg_format'
> arch/arm/boot/dts/aaa.dtb: Warning (simple_bus_reg): Failed prerequisite
> 'reg_format'
> arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size):
> /fragment@0/__overlay__/ft5x: Relying on default #address-cells value
> arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size):
> /fragment@0/__overlay__/ft5x: Relying on default #size-cells value
> "

Yeah, your i2c node doesn't have the right address-cells and
size-cells properties value, like dtc is telling you.

> Then in uboot I'm trying to do as follows:
> # fdt addr 0x43000000 (where dtb is)
> # fdt resize 8192
> # fdt apply 0x430c0000 (where dtbo is)
> But it gives me "libfdt fdt_check_header(): FDT_ERR_BADMAGIC"
> (I was expecting some error)

It looks like your overlay hasn't been properly loaded.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rttcqilsjxraxvtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsFJsACgkQ0rTAlCFN
r3TVBw/9F7pOTRJNK4/JtxdlsA7UcgdtzJy9YXm9DySLRCZltkonNjqJOI9Niwt7
D7hWMZrP0HSrN0ecl3+2LLiVd/JPJ40EX++3iCnLmyNmJv7WVDyhYFiRGd+ktaZ4
xH9PMJsBu75wDucsZc6GJo2Md6zXb6VEpQ7tsbXQTqIZXq43iOpeCSZxqiQwbWkn
V6BaD/aIZoQxnaFBxIwj5ennlL9E+0QpsgOePNvGUD5Uz1o0lM04T5ldUi6B8QA0
5znF2fAq1MDBqwbYPqLBGScfcEVoURpPP9Upt8JesYAJXUTmCLeL1hRVutNidFJH
m/6D7fYJ6Qg5lAqOiNKu/ddOKsBCQzvt+Ua3bdwvhqlCVTpHxqNCd2x3q/XNXoyF
57QXkqWLUrHp+6D0JZlIAOYZY2Nl3gR3yATW2bnx+ppF4ACFnECaYZlcpCUTuaKJ
d4tPL+urjiimjvqxTK/j8tRjQkAu3MR8bj1kDNwe/7aqVkMICpje5fz12T8hhnAu
GJkL6W3nZpuDQrStcZAym6ASw4W9EV/AqpTINHLaTE0AOxC5ulSIETNcGLAtRqeD
z6ypjIvI/NRB44RNqaEyvm1FgENnqvZ5A94PEPQEEfjzee4kzPhWU3v92/T5/LQ4
rsZcKZFiTQm0jq0nlQquOy9zkkZogAfe1DmW62ZY+uFFEVYrU9M=
=jt3Q
-----END PGP SIGNATURE-----

--rttcqilsjxraxvtj--
