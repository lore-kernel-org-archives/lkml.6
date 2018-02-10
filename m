Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeBJMnh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 07:43:37 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38046 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 07:43:34 -0500
X-Google-Smtp-Source: AH8x224fDQj1m0Cf8Bs1GntN5zyRDakkQAhjESsjC6WkKTEw64X6pObakDXVeZlWMb0UBFbPOWH9pQ==
Date: Sat, 10 Feb 2018 13:43:28 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
Message-ID: <20180210124328.GB744@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-5-marcus.folkesson@gmail.com>
 <1518261002.9025.36.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <1518261002.9025.36.camel@mtkswgap22>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
>=20
> Hi, Marcus
>=20
> The changes you made for dt-bindings and driver should be put into
> separate patches.

I actually thought about it but chose to have it in the same patch because I
did not see any direct advantage to separating them.

But I can do that.
I will come up with a v3 with this change if no one thinks differently.

>=20
> And the property timeout-sec seems to be generic enough to all devices,
> so why not add a common document to describe it and allow those devices
> to refer to, like other dt-bindings for other kinds of devices usually
> did.

It should be, but it requires that the driver is using
watchdog_init_timeout() to set timeout, most of the drivers does not.
Most drivers does not even use the watchdog API but register itself as
misc devices.

When we have all wdt drivers using the watchdog API, we should probably
move the dt-binding to a common document.

>=20
> 	Sean
>=20

Thanks,

Best regards
Marcus Folkesson

> On Sat, 2018-02-10 at 10:19 +0100, Marcus Folkesson wrote:
> > watchdog_init_timeout() will allways pick timeout_param since it
> > defaults to a valid timeout.
> >=20
> > By following best practice described in
> > Documentation/watchdog/watchdog-kernel-api.txt, it also
> > let us to set timout-sec property in devicetree.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
> >  drivers/watchdog/mtk_wdt.c                             | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/D=
ocumentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > index 5b38a30e608c..859dee167b91 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > @@ -11,9 +11,13 @@ Required properties:
> > =20
> >  - reg : Specifies base physical address and size of the registers.
> > =20
> > +Optional properties:
> > +- timeout-sec: contains the watchdog timeout in seconds.
> > +
> >  Example:
> > =20
> >  wdt: watchdog@10000000 {
> >  	compatible =3D "mediatek,mt6589-wdt";
> >  	reg =3D <0x10000000 0x18>;
> > +	timeout-sec =3D <10>;
> >  };
> > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > index 7ed417a765c7..fcdc10ec28a3 100644
> > --- a/drivers/watchdog/mtk_wdt.c
> > +++ b/drivers/watchdog/mtk_wdt.c
> > @@ -57,7 +57,7 @@
> >  #define DRV_VERSION		"1.0"
> > =20
> >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > -static unsigned int timeout =3D WDT_MAX_TIMEOUT;
> > +static unsigned int timeout;
> > =20
> >  struct mtk_wdt_dev {
> >  	struct watchdog_device wdt_dev;
>=20
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp+6OoACgkQiIBOb1ld
UjLSJRAAxUO1qMHNhPF/4u4zm7H9yVubohdg5d8jCJWRSsijTea8V7Tmrz8VrCl2
3zLKSC1q66PaKG8nx7GwPe0cCPgzy1auk58D5qy1MO/R1cW5o9RhbgXfEAjDc1bh
AWlRnMyxr4K44jxMFdQUW0JLCXrAzSPOYTmDcKV9zaFD14OY1Pb9/3n8LDno2gwp
Mx31b1KqQ909VBwpY97n+MfI8heCAtlF9wFjsPYlDG3sWuKyCEJSWoYKfhu/10wi
RkELCP/bwUo9kxn1YRTxz8bjxW5oBa7LacqQtCAQe8xDltozPFkiODNZw/PIMsiu
VHknwjz8QVMBUe/r0T1qzjv8vmslgYd+4M8K1TxTL+JFrlNVjzBEmh1Bnkm4pB2u
kdfgV+YRZ6Wmdvg5JLvv4544bLNwCzdCKGAQ+qOOIjF8hFiLrqzZbbuw7h/2Utdh
wcLGnjKV55pB/Gwk8X2yAMyH6M1pYufLlzmAxVF0AdpfMqaOkUQJx6Iz4D0CBwvc
f1j6jOdoZl5ccASGT9oZ1k067vQfeCoFxqJEsD0UkTigUKuQx1M/jtk/tbtgf0VJ
WwJIWPskUBOqeVaUPQQGDISe4hl1GCP7vmH/v2xlcaadP3cjrWl5mROnisd9X1y+
S4PjMa/Ljyg9+CMkRokgoa5DKPPHy7gCUKCg7ywdGzEXb1D1o/I=
=kIOQ
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
