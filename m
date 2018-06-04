Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeFDLut (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:50:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeFDLuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:50:46 -0400
Date: Mon, 4 Jun 2018 13:50:34 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Message-ID: <20180604115034.kuy35s4ajewapk4m@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
 <20180531092133.3gqepoabvuruiztz@flea.home>
 <2293030.uW1p7mJGcj@jernej-laptop>
 <20180601152949.tmw7aitfoo536nxs@flea>
 <CAGb2v667pdjfHXYpBk1ER5sC8vgpcaOFKEbEByWoD1zh9Z0cyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg2qk4tpb6lactdj"
Content-Disposition: inline
In-Reply-To: <CAGb2v667pdjfHXYpBk1ER5sC8vgpcaOFKEbEByWoD1zh9Z0cyg@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg2qk4tpb6lactdj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 09:19:43AM -0700, Chen-Yu Tsai wrote:
> On Fri, Jun 1, 2018 at 8:29 AM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > On Thu, May 31, 2018 at 07:54:08PM +0200, Jernej =C5=A0krabec wrote:
> >> Dne =C4=8Detrtek, 31. maj 2018 ob 11:21:33 CEST je Maxime Ripard napis=
al(a):
> >> > On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> >> > > >> > > + if (tcon->quirks->needs_tcon_top) {
> >> > > >> > > +         struct device_node *np;
> >> > > >> > > +
> >> > > >> > > +         np =3D of_parse_phandle(dev->of_node, "allwinner,=
tcon-top",
> >> > > >> > > 0);
> >> > > >> > > +         if (np) {
> >> > > >> > > +                 struct platform_device *pdev;
> >> > > >> > > +
> >> > > >> > > +                 pdev =3D of_find_device_by_node(np);
> >> > > >> > > +                 if (pdev)
> >> > > >> > > +                         tcon->tcon_top =3D
> >> > > >> > > platform_get_drvdata(pdev);
> >> > > >> > > +                 of_node_put(np);
> >> > > >> > > +
> >> > > >> > > +                 if (!tcon->tcon_top)
> >> > > >> > > +                         return -EPROBE_DEFER;
> >> > > >> > > +         }
> >> > > >> > > + }
> >> > > >> > > +
> >> > > >> >
> >> > > >> > I might have missed it, but I've not seen the bindings additi=
ons for
> >> > > >> > that property. This shouldn't really be done that way anyway,=
 instead
> >> > > >> > of using a direct phandle, you should be using the of-graph, =
with the
> >> > > >> > TCON-top sitting where it belongs in the flow of data.
> >> > > >>
> >> > > >> Just to answer to the first question, it did describe it in "[P=
ATCH
> >> > > >> 07/15] dt- bindings: display: sun4i-drm: Add R40 HDMI pipeline".
> >> > > >>
> >> > > >> As why I designed it that way - HW representation could be desc=
ribed
> >> > > >> that way> >>
> >> > > >> (ASCII art makes sense when fixed width font is used to view it=
):
> >> > > >>                             / LCD0/LVDS0
> >> > > >>
> >> > > >>                 / TCON-LCD0
> >> > > >>
> >> > > >>                 |           \ MIPI DSI
> >> > > >>
> >> > > >> mixer0          |
> >> > > >>
> >> > > >>        \        / TCON-LCD1 - LCD1/LVDS1
> >> > > >>
> >> > > >>         TCON-TOP
> >> > > >>
> >> > > >>        /        \ TCON-TV0 - TVE0/RGB
> >> > > >>
> >> > > >> mixer1          |          \
> >> > > >>
> >> > > >>                 |           TCON-TOP - HDMI
> >> > > >>                 |
> >> > > >>                 |          /
> >> > > >>
> >> > > >>                 \ TCON-TV1 - TVE1/RGB
> >> > > >>
> >> > > >> This is a bit simplified, since there is also TVE-TOP, which is
> >> > > >> responsible
> >> > > >> for sharing 4 DACs between both TVE encoders. You can have two =
TV outs
> >> > > >> (PAL/ NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It=
 even
> >> > > >> seems that you can arbitrarly choose which DAC is responsible f=
or
> >> > > >> which signal, so there is a ton of possible end combinations, b=
ut I'm
> >> > > >> not 100% sure.
> >> > > >>
> >> > > >> Even though I wrote TCON-TOP twice, this is same unit in HW. R4=
0 manual
> >> > > >> suggest more possibilities, although some of them seem wrong, l=
ike RGB
> >> > > >> feeding from LCD TCON. That is confirmed to be wrong when check=
ing BSP
> >> > > >> code.
> >> > > >>
> >> > > >> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0, TV=
E1 and
> >> > > >> LCD1 for pin muxing, although I'm not sure why is that needed a=
t all,
> >> > > >> since according to R40 datasheet, TVE0 and TVE1 pins are dedica=
ted and
> >> > > >> not on PORT D and PORT H, respectively, as TCON-TOP documentati=
on
> >> > > >> suggest. However, HSYNC and PSYNC lines might be shared between=
 TVE
> >> > > >> (when it works in RGB mode) and LCD. But that is just my guess =
since
> >> > > >> I'm not really familiar with RGB and LCD interfaces.
> >> > > >>
> >> > > >> I'm really not sure what would be the best representation in OF=
-graph.
> >> > > >> Can you suggest one?
> >> > > >
> >> > > > Rob might disagree on this one, but I don't see anything wrong w=
ith
> >> > > > having loops in the graph. If the TCON-TOP can be both the input=
 and
> >> > > > output of the TCONs, then so be it, and have it described that w=
ay in
> >> > > > the graph.
> >> > > >
> >> > > > The code is already able to filter out nodes that have already b=
een
> >> > > > added to the list of devices we need to wait for in the component
> >> > > > framework, so that should work as well.
> >> > > >
> >> > > > And we'd need to describe TVE-TOP as well, even though we don't =
have a
> >> > > > driver for it yet. That will simplify the backward compatibility=
 later
> >> > > > on.
> >> > >
> >> > > I'm getting the feeling that TCON-TOP / TVE-TOP is the glue layer =
that
> >> > > binds everything together, and provides signal routing, kind of li=
ke
> >> > > DE-TOP on A64. So the signal mux controls that were originally fou=
nd
> >> > > in TCON0 and TVE0 were moved out.
> >> > >
> >> > > The driver needs to know about that, but the graph about doesn't m=
ake
> >> > > much sense directly. Without looking at the manual, I understand i=
t to
> >> > > likely be one mux between the mixers and TCONs, and one between the
> >> > > TCON-TVs and HDMI. Would it make more sense to just have the graph
> >> > > connections between the muxed components, and remove TCON-TOP from
> >> > > it, like we had in the past? A phandle could be used to reference
> >> > > the TCON-TOP for mux controls, in addition to the clocks and reset=
s.
> >> > >
> >> > > For TVE, we would need something to represent each of the output p=
ins,
> >> > > so the device tree can actually describe what kind of signal, be it
> >> > > each component of RGB/YUV or composite video, is wanted on each pi=
n,
> >> > > if any. This is also needed on the A20 for the Cubietruck, so we c=
an
> >> > > describe which pins are tied to the VGA connector, and which one d=
oes
> >> > > R, G, or B.
> >> >
> >> > I guess we'll see how the DT maintainers feel about this, but my
> >> > impression is that the OF graph should model the flow of data between
> >> > the devices. If there's a mux somewhere, then the data is definitely
> >> > going through it, and as such it should be part of the graph.
> >>
> >> I concur, but I spent few days thinking how to represent this sanely i=
n graph,
> >> but I didn't find any good solution. I'll represent here my idea and p=
lease
> >> tell your opinion before I start implementing it.
> >>
> >> First, let me be clear that mixer0 and mixer1 don't have same capabili=
ties
> >> (different number of planes, mixer0 supports writeback, mixer1 does no=
t,
> >> etc.). Thus, it does matter which mixer is connected to which TCON/enc=
oder.
> >> mixer0 is meant to be connected to main display and mixer1 to auxiliar=
y. That
> >> obviously depends on end system.
> >>
> >> So, TCON TOP has 3 muxes, which have to be represented in graph. Two o=
f them
> >> are for mixer/TCON relationship (each of them 1 input and 4 possible o=
utputs)
> >> and one for TV TCON/HDMI pair selection (2 possible inputs, 1 output).
> >>
> >> According to current practice in sun4i-drm driver, graph has to have p=
ort 0,
> >> representing input and port 1, representing output. This would mean th=
at graph
> >> looks something like that:
> >>
> >> tcon_top: tcon-top@1c70000 {
> >>       compatible =3D "allwinner,sun8i-r40-tcon-top";
> >>       ...
> >>       ports {
> >>               #address-cells =3D <1>;
> >>               #size-cells =3D <0>;
> >>
> >>               tcon_top_in: port@0 {
> >>                       #address-cells =3D <1>;
> >>                       #size-cells =3D <0>;
> >>                       reg =3D <0>;
> >>
> >>                       tcon_top_in_mixer0: endpoint@0 {
> >>                               reg =3D <0>;
> >>                               remote-endpoint =3D <&mixer0_out_tcon_to=
p>;
> >>                       };
> >>
> >>                       tcon_top_in_mixer1: endpoint@1 {
> >>                               reg =3D <1>;
> >>                               remote-endpoint =3D <&mixer1_out_tcon_to=
p>;
> >>                       };
> >>
> >>                       tcon_top_in_tcon_tv: endpoint@2 {
> >>                               reg =3D <2>;
> >>                               // here is HDMI input connection, part o=
f board DTS
> >>                               remote-endpoint =3D <board specific phan=
dle to TV TCON output>;
> >>                       };
> >>               };
> >>
> >>               tcon_top_out: port@1 {
> >>                       #address-cells =3D <1>;
> >>                       #size-cells =3D <0>;
> >>                       reg =3D <1>;
> >>
> >>                       tcon_top_out_tcon0: endpoint@0 {
> >>                               reg =3D <0>;
> >>                               // here is mixer0 output connection, par=
t of board DTS
> >>                               remote-endpoint =3D <board specific phan=
dle to TCON>;
> >>                       };
> >>
> >>                       tcon_top_out_tcon1: endpoint@1 {
> >>                               reg =3D <1>;
> >>                               // here is mixer1 output connection, par=
t of board DTS
> >>                               remote-endpoint =3D <board specific phan=
dle to TCON>;
> >>                       };
> >>
> >>                       tcon_top_out_hdmi: endpoint@2 {
> >>                               reg =3D <2>;
> >>                               remote-endpoint =3D <&hdmi_in_tcon_top>;
> >>                       };
> >>               };
> >>       };
> >> };
> >
> > IIRC, each port is supposed to be one route for the data, so we would
> > have multiple ports, one for the mixers in input and for the tcon in
> > output, and one for the TCON in input and for the HDMI/TV in
> > output. Rob might correct me here.
> >
> >> tcon_tv0: lcd-controller@1c73000 {
> >>       compatible =3D "allwinner,sun8i-r40-tcon-tv-0";
> >>       ...
> >>       ports {
> >>               #address-cells =3D <1>;
> >>               #size-cells =3D <0>;
> >>
> >>               tcon_tv0_in: port@0 {
> >>                       reg =3D <0>;
> >>
> >>                       tcon_tv0_in_tcon_top: endpoint {
> >>                               // endpoint depends on board, part of bo=
ard DTS
> >>                               remote-endpoint =3D <phandle to one of t=
con_top_out_tcon>;
> >
> > Just curious, what would be there?
> >
> >>                       };
> >>               };
> >>
> >>               tcon_tv0_out: port@1 {
> >>                       #address-cells =3D <1>;
> >>                       #size-cells =3D <0>;
> >>                       reg =3D <1>;
> >>
> >>                       // endpoints to TV TOP and TCON TOP HDMI input
> >>                       ...
> >>               };
> >>       };
> >> };
> >>
> >> tcon_tv1: lcd-controller@1c74000 {
> >>       compatible =3D "allwinner,sun8i-r40-tcon-tv-1";
> >>       ...
> >>       ports {
> >>               #address-cells =3D <1>;
> >>               #size-cells =3D <0>;
> >>
> >>               tcon_tv1_in: port@0 {
> >>                       reg =3D <0>;
> >>
> >>                       tcon_tv1_in_tcon_top: endpoint {
> >>                               // endpoint depends on board, part of bo=
ard DTS
> >>                               remote-endpoint =3D <phandle to one of t=
con_top_out_tcon>;
> >>                       };
> >>               };
> >>
> >>               tcon_tv1_out: port@1 {
> >>                       #address-cells =3D <1>;
> >>                       #size-cells =3D <0>;
> >>                       reg =3D <1>;
> >>
> >>                       // endpoints to TV TOP and TCON TOP HDMI input
> >>                       ...
> >>               };
> >>       };
> >> };
> >>
> >> tcon_lcd0 and tcon_lcd1 would have similar connections, except that for
> >> outputs would be LCD or LVDS panels or MIPI DSI encoder.
> >>
> >> Please note that each TCON (there are 4 of them) would need to have un=
ique
> >> compatible and have HW index stored in quirks data. It would be used b=
y TCON
> >> TOP driver for configuring muxes.
> >
> > Can't we use the port/endpoint ID instead? If the mux is the only
> > thing that changes, the compatible has no reason to. It's the same IP,
> > and the only thing that changes is something that is not part of that
> > IP.
>=20
> I agree. Endpoint IDs should provide that information. I'm still not
> sure How to encode multiple in/out mux groups in a device node though.

I guess we can do that through different ports?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bg2qk4tpb6lactdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsVJ4kACgkQ0rTAlCFN
r3RQXhAAhVnDYPntwqfRjFW1d8mT8N4+37rXnOv44JypSe9k9nksBTAJLSO+HrnW
jU5Y+uwL7xc6kI9LkfpZqQ7WdgDeHQKJfiGxJBOrN22kzfNSCwM744TdSLZXHmWv
cg5cstdGu4mJ4RBpYYxnvMPqHzUrLu/JNLXh3Uy+blKk18Puh/MU7qwUmAKa6hnJ
YNJK5b0+7k+RvcdwTocd4tA1SljAOoNeaHFEqsky7x+/pK7a4JraqaRhp/ajQJ4L
PONl0UUNZdW+i9TWKbSOr/FsqYLuvk44J9fluvWedr5o9YwLCRpIkeWdwOct9EAy
+Xrq3r2/ERXzLZkTUVGM3r68EdU0ywAeur903vzPOsZPcY4ISkVqk3fOg8wtwsEY
6AOatuEjJzAScE1T2/dh4Rri8076WqEUwhsRJCK4/twCfoc/9AgzDQeAF73efCHq
qPib1NZsfcVqvzGs83WM4P2338hcmOd5N/kjExB3oqLS7j1h4dR3PpGwFMS86zyn
k+ywpy24MF8f0Espz29KuxLpHcdBgIPyZdbAsKVtHk9qhwYnmQPEDk4vqXXyMTr2
qpHX30bWNHEs6PgEy87wevR21O72oI4aCSwmYGbQDt2kfIdFK8YVBHOCBxHWJvgz
FT2moi8hq/7O0KFElVj+gPOljtT89Wp8FEMvJaySIjWYCqDkSIE=
=UhNI
-----END PGP SIGNATURE-----

--bg2qk4tpb6lactdj--
