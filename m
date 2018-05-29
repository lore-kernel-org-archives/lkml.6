Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934840AbeE2N7i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:59:38 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41859 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeE2N7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:59:33 -0400
X-Auth-Info: 6qxnZUqFc7vzyY2PXBhDK5lBsFAcdz3EQUCMnGf9htE=
Date: Tue, 29 May 2018 15:58:12 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
Message-ID: <20180529155736.275e27b1@jawa>
In-Reply-To: <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
        <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
        <20180519140202.3449e3c1@jawa>
        <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eE_sO=x0ezrHDGFeX9ISkBP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eE_sO=x0ezrHDGFeX9ISkBP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Sat, May 19, 2018 at 9:02 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do
> > see following errors in the dmesg (v4.17-rc5):
> >
> > imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
> > imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map
> > table =20
>=20
> Could you please investigate this error?

Sorry for "small" delay on this.

Ok, so I've investigated the issue:

1. The code, which you pasted:
http://code.bulix.org/ik01yu-339697

works correctly as imx53-qsb-common.dtsi directly includes "imx53.dtsi"
in which iomuxc label is defined.

In my case though,

2. I do include imx53-tqma53.dtsi [1], in which the iomuxc" label
is extended:

&iomuxc {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&pinctrl_hog>;

	imx53-tqma53 {
		pinctrl_hog: hoggrp {

.......

};

The imx53-tqma53.dtsi then includes imx53.dtsi.

Moreover, my file -> imx53-kp.dtsi as it includes [1], it extends
further the &iomuxc label:

&iomuxc {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&pinctrl_kp_common>;
=09
	imx53-kp-common {
		pinctrl_buzzer: buzzergrp {
.......
};

So, when I remove imx53-kp-common I will have mismatch with [1] iomuxc
structure.

The code works as expected when I do remove imx53-tqma53 in [1].

However, I would prefer to not touch this imx53-tqma53.dtsi file.
It is also included in: imx53-mba53.dts, which extends iomux in
following way:

&iomuxc {
        lvds1 {
                pinctrl_lvds1_1: lvds1-grp1 {


Here I would need to remove lvds1, disp1 and tve to make it working.
However, it will not break during build, but at run time.

Considering the above, I would prefer to leave the code in [1] as is
and use imx53-kp-common as well (as in v2 of this patch).

Fabio, what do you think?

[I'm using linux 4.17-rc7 (with included dtc 1.4.6)]

>=20
> I have just tried the following change on a imx53-qsb:
> http://code.bulix.org/ik01yu-339697
>=20
> and it works as expected:
> # dmesg  | grep iomux
> [    0.100046] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl
> driver




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/eE_sO=x0ezrHDGFeX9ISkBP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsNXHQACgkQAR8vZIA0
zr1Xagf6A3b+9PA0KSZ2BsJ18w4YxVwGET/A5GpNEpudylN1TU8nerWrb4qjtZE7
EoqYghY6mqYY/bTkYzI8XpzOBwOjHGRMbdu7oKkfjqSJMzyLpKY/wBM4Pn4iap+I
QFGc4epFNUi9pRozExltD7GH+E13tcyX5azmbdQLoHzkZHrgT3jHbramNK7UJuAa
aIE77I4edg/eZasJ/oac8Lvo9iINGxog8DN8jqK630b+fmYEpkO+UyFIdwSkR6hY
lg1jxTfH0nSJplL+f5bU+wLthl2DEY0+hsajsLKsSBl1/JKzZDlaSXAC96jmzVg6
8VR2A4sxmeVu17oCdJoH4mNnHABCcA==
=Uirw
-----END PGP SIGNATURE-----

--Sig_/eE_sO=x0ezrHDGFeX9ISkBP--
