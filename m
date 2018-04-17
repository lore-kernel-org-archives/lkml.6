Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDQLxC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:53:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55694 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752510AbeDQLxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:53:00 -0400
Date: Tue, 17 Apr 2018 13:52:43 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow
 getting syscon regmap from device
Message-ID: <20180417115243.x42s7ygdpdbhtys2@flea>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-4-icenowy@aosc.io>
 <20180412145628.iaaeue2imiijwx5d@flea>
 <A027702A-F3F7-4896-B2B8-E024DA521661@aosc.io>
 <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
 <20180416143130.tls6xtcq3hsv7u7f@flea>
 <CAGb2v65VLYc1X2bN5v0_1xokZCEkKFYNLzecnE3WeP8goc2KmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ipq2z77j2redhq6"
Content-Disposition: inline
In-Reply-To: <CAGb2v65VLYc1X2bN5v0_1xokZCEkKFYNLzecnE3WeP8goc2KmQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ipq2z77j2redhq6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 10:51:55PM +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 16, 2018 at 10:31 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Thu, Apr 12, 2018 at 11:23:30PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Apr 12, 2018 at 11:11 PM, Icenowy Zheng <icenowy@aosc.io> wrot=
e:
> >> > =E4=BA=8E 2018=E5=B9=B44=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=8810:56:28, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=
=B0:
> >> >>On Wed, Apr 11, 2018 at 10:16:39PM +0800, Icenowy Zheng wrote:
> >> >>> From: Chen-Yu Tsai <wens@csie.org>
> >> >>>
> >> >>> On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
> >> >>> address space; on the A64 SoC this register is in the SRAM control=
ler
> >> >>> address space, and with a different offset.
> >> >>>
> >> >>> To access the register from another device and hide the internal
> >> >>> difference between the device, let it register a regmap named
> >> >>> "emac-clock". We can then get the device from the phandle, and
> >> >>> retrieve the regmap with dev_get_regmap(); in this situation the
> >> >>> regmap_field will be set up to access the only register in the
> >> >>regmap.
> >> >>>
> >> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >>> [Icenowy: change to use regmaps with single register, change commit
> >> >>>  message]
> >> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >>> ---
> >> >>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 48
> >> >>++++++++++++++++++++++-
> >> >>>  1 file changed, 46 insertions(+), 2 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> index 1037f6c78bca..b61210c0d415 100644
> >> >>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> @@ -85,6 +85,13 @@ const struct reg_field old_syscon_reg_field =3D=
 {
> >> >>>      .msb =3D 31,
> >> >>>  };
> >> >>>
> >> >>> +/* Specially exported regmap which contains only EMAC register */
> >> >>> +const struct reg_field single_reg_field =3D {
> >> >>> +    .reg =3D 0,
> >> >>> +    .lsb =3D 0,
> >> >>> +    .msb =3D 31,
> >> >>> +};
> >> >>> +
> >> >>
> >> >>I'm not sure this would be wise. If we ever need some other register
> >> >>exported through the regmap, will have to change all the calling sit=
es
> >> >>everywhere in the kernel, which will be a pain and will break
> >> >>bisectability.
> >> >
> >> > In this situation the register can be exported as another
> >> >  regmap. Currently the code will access a regmap with name
> >> > "emac-clock" for this register.
> >> >
> >> >>
> >> >>Chen-Yu's (or was it yours?) initial solution with a custom writeable
> >> >>hook only allowing a single register seemed like a better one.
> >> >
> >> > But I remember you mentioned that you want it to hide the
> >> > difference inside the device.
> >>
> >> The idea is that a device can export multiple regmaps. This one,
> >> the one named "gmac" (in my soon to come v2) or "emac-clock" here,
> >> is but one of many possible regmaps, and it only exports the register
> >> needed by the GMAC/EMAC.
> >
> > I'm not sure this would be wise either. There's a single register map,
> > and as far as I know we don't have a binding to express this in the
> > DT. This means that the customer and provider would have to use the
> > same name, but without anything actually enforcing it aside from
> > "someone in the community knows it".
> >
> > This is not a really good design, and I was actually preferring your
> > first option. We shouldn't rely on any undocumented rule. This will be
> > easy to break and hard to maintain.
>=20
> So, one regmap per device covering the whole register range, and the
> consumer knows which register to poke by looking at its own compatible.
>=20
> That sound right?

Yep. And ideally, sending a single serie for both the A64 and the R40
cases, in order to provide the big picture.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4ipq2z77j2redhq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrV4AoACgkQ0rTAlCFN
r3TTdQ//TwmNHiT2PyWgjVcBwdD7jwi6uvYG0gHFehSP5aK7OQ4LT34fKOHsTJ0k
yXZF2PIMel/e5SXEBKOOtSPrM8nhN4xBQVSlzXIGcMs6YlJAd6TSRkcE/yO4Sj0V
Q4UJ0LHh0wsbXJSyoclgPRNYLyyQlWDOpG74XjJbUUjNj29bamtGc/mEVwfVP+Ld
qCec9y81UYn6JsLKKv3/vNcs3b6vhBUBFA75/O2ThQrndGb2M/bFKRGg5ZGW9vT8
J3iedLMqtDJAj+pvh0B5EKN5CjI02tBmTd8xakHhdzIJ2Rtq1tGO3n5jI590ra1j
9bXm/88UVmUpTPgUNkh3kzsh8LZ7M8fvUZGI3HH6l55Z0wqO/YBDv2l8vKWnB4C2
hJt0EGAz5C+ur2KWU9eOZmcgQQSITMJBIaiTXX3HDDJs1JPqZ9EXTHWBdl4rJ+N8
EtUHPS0jdtgRM5aIpSIk5E+1jNkF3gCKDJ5DUYhxtdUm4z7bcGaBCE/7C6hYoESU
CRfj+nWo/pz+urqSwGCSe0G3kMtQUV3F9/eaM8IS7YaRfAKqD8dDuMuQWcKs+G3u
p999/MTRHW6yk2m8o/0Bcvf4XiTItSJvrVoJ7xPv48WDja4w8rgKiZDlQEQqlKnH
fQM72GKp8U2eb6vhQcxFNJaPXYf9PqhnaXIn6Q4MRZ57J4Ory14=
=1V8Y
-----END PGP SIGNATURE-----

--4ipq2z77j2redhq6--
