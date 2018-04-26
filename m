Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756433AbeDZOj3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:39:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755511AbeDZOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:39:26 -0400
Date: Thu, 26 Apr 2018 16:39:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 1/3] dt-bindings: misc: achc: Make ezport
 distinguishable
Message-ID: <20180426143922.ri6jn5y4ulgxh3zn@earth.universe>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
 <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
 <20180409185727.j4unhx5ig3fgm6ex@rob-hp-laptop>
 <20180409211337.goavadt6f22wtkbw@earth.universe>
 <CAL_JsqJfj_tvojYnGQhK1Pj88tUFMGX6cB1t0=U5-34XKaA+bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4rzgxzturmav4pm"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfj_tvojYnGQhK1Pj88tUFMGX6cB1t0=U5-34XKaA+bw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l4rzgxzturmav4pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 13, 2018 at 10:33:05AM -0500, Rob Herring wrote:
> On Mon, Apr 9, 2018 at 4:13 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > Hi,
> >
> > On Mon, Apr 09, 2018 at 01:57:27PM -0500, Rob Herring wrote:
> >> On Tue, Mar 27, 2018 at 03:52:57PM +0200, Sebastian Reichel wrote:
> >> > This updates the GE ACHC binding, so that different compatible
> >> > strings are used for the programming interface, which is the
> >> > ezport interface from NXP MK20FN1M0VMD12 and the microcontroller's
> >> > normal SPI interface.
> >> >
> >> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >> > ---
> >> >  Documentation/devicetree/bindings/misc/ge-achc.txt | 19 +++++++++++=
+++++---
> >> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Do=
cumentation/devicetree/bindings/misc/ge-achc.txt
> >> > index 77df94d7a32f..6c6bd6568504 100644
> >> > --- a/Documentation/devicetree/bindings/misc/ge-achc.txt
> >> > +++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
> >> > @@ -7,7 +7,13 @@ Note: This device does not expose the peripherals a=
s USB devices.
> >> >
> >> >  Required properties:
> >> >
> >> > -- compatible : Should be "ge,achc"
> >> > +- compatible : Should be
> >> > +  "ge,achc" (normal interface)
> >> > +  "ge,achc-ezport" (flashing interface)
> >> > +
> >> > +Required properties (flashing interface only):
> >> > +
> >> > +- reset-gpios: GPIO Specifier for the reset GPIO
> >>
> >> Does the reset only affect the flashing interface and are the data pins
> >> shared? If not for both, then I think the correct thing to do here is
> >> just extend reg to support multiple values to represent multiple chip
> >> selects.
> >
> > reset affects the whole chip and the same spi data/clock pins are
> > being used, so extending reg should work. The flashing cannot happen
> > with the same speed, though. I'm currently encoding this by using
> > different "spi-max-frequency" properties. I suppose I could limit
> > it in the driver instead. I tried to come up with an example for
> > your suggestion. Is this what you had in mind?
>=20
> If the max frequency is the device max, then that should be in the
> driver. spi-max-frequency should really only be needed if the
> frequency is less than the max of either the host or device.

Right.

> > &spi_controller {
> >     achc@multiple {
>=20
> @0
>=20
> unit addresses are the 1st address.

Ok.

> >         /* 0 =3D flashing interface, 1 =3D normal interface */
> >         reg =3D <0>, <1>;
>=20
> You may want to put the normal interface first as that is the primary
> interface and would still work assuming the OS ignored extra entries.
>=20
> >         compatible =3D "ge,achc";
> >         reset-gpios =3D <&gpio42 23 ACTIVE_LOW>;
> >         spi-max-frequency =3D <42>; /* max speed for normal operation */
>=20
> 42 Hz?

This was just a random number as example.

I had a look at implementing this and the Linux SPI core does not
expect any devices with multiple chip selects. I can try to
implement it, but I think it makes sense to gather some feedback
=66rom Mark first (added to Cc).

@Mark
Patch Series: https://lwn.net/Articles/750177/
Binding Discussion: https://patchwork.kernel.org/patch/10310109/

-- Sebastian

--l4rzgxzturmav4pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrh5JcACgkQ2O7X88g7
+poBoQ//UU2nGexBiZ0ZgR4KRn1t8zFnluqeeeYRCQ3Sd2SoOfBNeQRSOtPntXVn
EKM3eqlLjb4RzUL9/msMt/tzNPBRB7A/5v6Yo6A/Ck8aIUZBuCOirax4GGPuiJ7T
jMfI5vt7uVJGezeCjFLxWtUdt54Fk+3riZLvetcCTv2yfpbXGXkSb2kqsf4ltpcn
d2LAoomp9Tl/DsIr6pes383Og5AoRNsNR2nyqEwX8q3JlubrDwcYxXT5fvNIcQ2B
Q50/TjDsxesnkmMc0Qsr6Hx6TPTSZGb0RldmsHwpe6L7aslkVxNrBbJHYuS175jD
ySbZ9WhCzr+1hvx/VKQrVEPkD333rD3vriGZMnxnDOcFfeG9K9s5a2PZlCRz/2UF
GQlBoceAH4cd7Q5ll1q3mxTAGRn5s4GgXOObAr+GuHQ2+nJSKNO8D+QzjUEMMSxs
i/Livc/DSCZHlQayfRcZ+cXqFwMwKuQosEitSDMCiWYVg1Wq6clwIlUsMn3qBaf8
MOOHj5mb/ldtPTFtIVj9WAhfr0Vp+HJP+EcdALpQK1d+SdO15Z1WF61W1erboTGf
Pdt6kfe83FMT5ulJ/l8qrmlIrN2CTCfR6vs0ydsZe8+08JGzxh1Mb2VGj+CgWENl
R/hBTDnkIyboAVqGrvB+TSyJg6xZWJf1tp+EmlCOEn6fqSniDZk=
=pFVz
-----END PGP SIGNATURE-----

--l4rzgxzturmav4pm--
