Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbeFAPal (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:30:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58349 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753201AbeFAPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:30:08 -0400
Date: Fri, 1 Jun 2018 17:29:49 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Message-ID: <20180601152949.tmw7aitfoo536nxs@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
 <20180531092133.3gqepoabvuruiztz@flea.home>
 <2293030.uW1p7mJGcj@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iqpyme5tpgykkisw"
Content-Disposition: inline
In-Reply-To: <2293030.uW1p7mJGcj@jernej-laptop>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iqpyme5tpgykkisw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 07:54:08PM +0200, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 31. maj 2018 ob 11:21:33 CEST je Maxime Ripard napisal(=
a):
> > On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> > > >> > > + if (tcon->quirks->needs_tcon_top) {
> > > >> > > +         struct device_node *np;
> > > >> > > +
> > > >> > > +         np =3D of_parse_phandle(dev->of_node, "allwinner,tco=
n-top",
> > > >> > > 0);
> > > >> > > +         if (np) {
> > > >> > > +                 struct platform_device *pdev;
> > > >> > > +
> > > >> > > +                 pdev =3D of_find_device_by_node(np);
> > > >> > > +                 if (pdev)
> > > >> > > +                         tcon->tcon_top =3D
> > > >> > > platform_get_drvdata(pdev);
> > > >> > > +                 of_node_put(np);
> > > >> > > +
> > > >> > > +                 if (!tcon->tcon_top)
> > > >> > > +                         return -EPROBE_DEFER;
> > > >> > > +         }
> > > >> > > + }
> > > >> > > +
> > > >> >=20
> > > >> > I might have missed it, but I've not seen the bindings additions=
 for
> > > >> > that property. This shouldn't really be done that way anyway, in=
stead
> > > >> > of using a direct phandle, you should be using the of-graph, wit=
h the
> > > >> > TCON-top sitting where it belongs in the flow of data.
> > > >>=20
> > > >> Just to answer to the first question, it did describe it in "[PATCH
> > > >> 07/15] dt- bindings: display: sun4i-drm: Add R40 HDMI pipeline".
> > > >>=20
> > > >> As why I designed it that way - HW representation could be describ=
ed
> > > >> that way> >>=20
> > > >> (ASCII art makes sense when fixed width font is used to view it):
> > > >>                             / LCD0/LVDS0
> > > >>                =20
> > > >>                 / TCON-LCD0
> > > >>                =20
> > > >>                 |           \ MIPI DSI
> > > >>=20
> > > >> mixer0          |
> > > >>=20
> > > >>        \        / TCON-LCD1 - LCD1/LVDS1
> > > >>       =20
> > > >>         TCON-TOP
> > > >>       =20
> > > >>        /        \ TCON-TV0 - TVE0/RGB
> > > >>=20
> > > >> mixer1          |          \
> > > >>=20
> > > >>                 |           TCON-TOP - HDMI
> > > >>                 |         =20
> > > >>                 |          /
> > > >>                =20
> > > >>                 \ TCON-TV1 - TVE1/RGB
> > > >>=20
> > > >> This is a bit simplified, since there is also TVE-TOP, which is
> > > >> responsible
> > > >> for sharing 4 DACs between both TVE encoders. You can have two TV =
outs
> > > >> (PAL/ NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It ev=
en
> > > >> seems that you can arbitrarly choose which DAC is responsible for
> > > >> which signal, so there is a ton of possible end combinations, but =
I'm
> > > >> not 100% sure.
> > > >>=20
> > > >> Even though I wrote TCON-TOP twice, this is same unit in HW. R40 m=
anual
> > > >> suggest more possibilities, although some of them seem wrong, like=
 RGB
> > > >> feeding from LCD TCON. That is confirmed to be wrong when checking=
 BSP
> > > >> code.
> > > >>=20
> > > >> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0, TVE1 =
and
> > > >> LCD1 for pin muxing, although I'm not sure why is that needed at a=
ll,
> > > >> since according to R40 datasheet, TVE0 and TVE1 pins are dedicated=
 and
> > > >> not on PORT D and PORT H, respectively, as TCON-TOP documentation
> > > >> suggest. However, HSYNC and PSYNC lines might be shared between TVE
> > > >> (when it works in RGB mode) and LCD. But that is just my guess sin=
ce
> > > >> I'm not really familiar with RGB and LCD interfaces.
> > > >>=20
> > > >> I'm really not sure what would be the best representation in OF-gr=
aph.
> > > >> Can you suggest one?
> > > >=20
> > > > Rob might disagree on this one, but I don't see anything wrong with
> > > > having loops in the graph. If the TCON-TOP can be both the input and
> > > > output of the TCONs, then so be it, and have it described that way =
in
> > > > the graph.
> > > >=20
> > > > The code is already able to filter out nodes that have already been
> > > > added to the list of devices we need to wait for in the component
> > > > framework, so that should work as well.
> > > >=20
> > > > And we'd need to describe TVE-TOP as well, even though we don't hav=
e a
> > > > driver for it yet. That will simplify the backward compatibility la=
ter
> > > > on.
> > >=20
> > > I'm getting the feeling that TCON-TOP / TVE-TOP is the glue layer that
> > > binds everything together, and provides signal routing, kind of like
> > > DE-TOP on A64. So the signal mux controls that were originally found
> > > in TCON0 and TVE0 were moved out.
> > >=20
> > > The driver needs to know about that, but the graph about doesn't make
> > > much sense directly. Without looking at the manual, I understand it to
> > > likely be one mux between the mixers and TCONs, and one between the
> > > TCON-TVs and HDMI. Would it make more sense to just have the graph
> > > connections between the muxed components, and remove TCON-TOP from
> > > it, like we had in the past? A phandle could be used to reference
> > > the TCON-TOP for mux controls, in addition to the clocks and resets.
> > >=20
> > > For TVE, we would need something to represent each of the output pins,
> > > so the device tree can actually describe what kind of signal, be it
> > > each component of RGB/YUV or composite video, is wanted on each pin,
> > > if any. This is also needed on the A20 for the Cubietruck, so we can
> > > describe which pins are tied to the VGA connector, and which one does
> > > R, G, or B.
> >=20
> > I guess we'll see how the DT maintainers feel about this, but my
> > impression is that the OF graph should model the flow of data between
> > the devices. If there's a mux somewhere, then the data is definitely
> > going through it, and as such it should be part of the graph.
>=20
> I concur, but I spent few days thinking how to represent this sanely in g=
raph,=20
> but I didn't find any good solution. I'll represent here my idea and plea=
se=20
> tell your opinion before I start implementing it.
>=20
> First, let me be clear that mixer0 and mixer1 don't have same capabilitie=
s=20
> (different number of planes, mixer0 supports writeback, mixer1 does not,=
=20
> etc.). Thus, it does matter which mixer is connected to which TCON/encode=
r.=20
> mixer0 is meant to be connected to main display and mixer1 to auxiliary. =
That=20
> obviously depends on end system.
>=20
> So, TCON TOP has 3 muxes, which have to be represented in graph. Two of t=
hem=20
> are for mixer/TCON relationship (each of them 1 input and 4 possible outp=
uts)=20
> and one for TV TCON/HDMI pair selection (2 possible inputs, 1 output).
>=20
> According to current practice in sun4i-drm driver, graph has to have port=
 0,=20
> representing input and port 1, representing output. This would mean that =
graph=20
> looks something like that:
>=20
> tcon_top: tcon-top@1c70000 {
> 	compatible =3D "allwinner,sun8i-r40-tcon-top";
> 	...
> 	ports {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		tcon_top_in: port@0 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
> 			reg =3D <0>;
>=20
> 			tcon_top_in_mixer0: endpoint@0 {
> 				reg =3D <0>;
> 				remote-endpoint =3D <&mixer0_out_tcon_top>;
> 			};
>=20
> 			tcon_top_in_mixer1: endpoint@1 {
> 				reg =3D <1>;
> 				remote-endpoint =3D <&mixer1_out_tcon_top>;
> 			};
>=20
> 			tcon_top_in_tcon_tv: endpoint@2 {
> 				reg =3D <2>;
> 				// here is HDMI input connection, part of board DTS
> 				remote-endpoint =3D <board specific phandle to TV TCON output>;
> 			};
> 		};
>=20
> 		tcon_top_out: port@1 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
> 			reg =3D <1>;
>=20
> 			tcon_top_out_tcon0: endpoint@0 {
> 				reg =3D <0>;
> 				// here is mixer0 output connection, part of board DTS
> 				remote-endpoint =3D <board specific phandle to TCON>;
> 			};
>=20
> 			tcon_top_out_tcon1: endpoint@1 {
> 				reg =3D <1>;
> 				// here is mixer1 output connection, part of board DTS
> 				remote-endpoint =3D <board specific phandle to TCON>;
> 			};
>=20
> 			tcon_top_out_hdmi: endpoint@2 {
> 				reg =3D <2>;
> 				remote-endpoint =3D <&hdmi_in_tcon_top>;
> 			};
> 		};
> 	};
> };

IIRC, each port is supposed to be one route for the data, so we would
have multiple ports, one for the mixers in input and for the tcon in
output, and one for the TCON in input and for the HDMI/TV in
output. Rob might correct me here.

> tcon_tv0: lcd-controller@1c73000 {
> 	compatible =3D "allwinner,sun8i-r40-tcon-tv-0";
> 	...
> 	ports {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		tcon_tv0_in: port@0 {
> 			reg =3D <0>;
>=20
> 			tcon_tv0_in_tcon_top: endpoint {
> 				// endpoint depends on board, part of board DTS
> 				remote-endpoint =3D <phandle to one of tcon_top_out_tcon>;

Just curious, what would be there?

> 			};
> 		};
>=20
> 		tcon_tv0_out: port@1 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
> 			reg =3D <1>;
>=20
> 			// endpoints to TV TOP and TCON TOP HDMI input
> 			...
> 		};
> 	};
> };
>=20
> tcon_tv1: lcd-controller@1c74000 {
> 	compatible =3D "allwinner,sun8i-r40-tcon-tv-1";
> 	...
> 	ports {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		tcon_tv1_in: port@0 {
> 			reg =3D <0>;
>=20
> 			tcon_tv1_in_tcon_top: endpoint {
> 				// endpoint depends on board, part of board DTS
> 				remote-endpoint =3D <phandle to one of tcon_top_out_tcon>;
> 			};
> 		};
>=20
> 		tcon_tv1_out: port@1 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
> 			reg =3D <1>;
>=20
> 			// endpoints to TV TOP and TCON TOP HDMI input
> 			...
> 		};
> 	};
> };
>=20
> tcon_lcd0 and tcon_lcd1 would have similar connections, except that for=
=20
> outputs would be LCD or LVDS panels or MIPI DSI encoder.
>=20
> Please note that each TCON (there are 4 of them) would need to have uniqu=
e=20
> compatible and have HW index stored in quirks data. It would be used by T=
CON=20
> TOP driver for configuring muxes.

Can't we use the port/endpoint ID instead? If the mux is the only
thing that changes, the compatible has no reason to. It's the same IP,
and the only thing that changes is something that is not part of that
IP.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--iqpyme5tpgykkisw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsRZmwACgkQ0rTAlCFN
r3TN/Q//a9mYpLlewMXK9vgypq5/Zic25ZKA3r7lp8C+PGSz2tyJokEsuW6zOw/J
Sp8pmnBK96iIloTP2diTiE9UdIYzR5SH5ctpImsUWXW0RQi0X1oAkwP26bPIoSQv
01oHIRLB8hWqLyFSvW1QEKL0COQA2yC3V4TekOe9NDXSc5wtAcE16MXa71tbFZQr
DHKZxRPPLGkjiHaVMo+dFT9G2JDfmfVxhT7wHWbKYS663aboMO3J0rE7lAsBYpjp
y6fxhZ8AXI/dczl+C7w4vrsbyubJqonikmpQ9DKthDvsr5te659KUSp3zFkrjACV
0Wui4timd53EIRWQEvpAQ9FnBROkrZuZvQjk5B5z6SF7oEJUZlZUBlDL+pdBMIIP
OWo2+rDdRoeByKdvf815wZVGCkR/HmiOT6JATkmvmCC5yCqbmeI9jfviUgv0Z18A
zg89OL3ltZzcO7CEtDCM77w6daWfE0TXwfNtsM8nxPfx30wVxCKPTVb+kiCGpP9q
V3vLKouwFDVEOioMl46TOT0E5oK+dblmupf8u4AR9ORnJirzZP/ubhKvTZ5metsC
GBEScNCuuP91ZY+GG+8tyohiyp/fsCTazyYldUsyk+nslpMTcnnNUUy7lKxGtrG1
q8uuNjgD7Z7K5+7JAen7Z768Kpjh0hUAgb+3mANntOclK2CLxsw=
=8z9V
-----END PGP SIGNATURE-----

--iqpyme5tpgykkisw--
