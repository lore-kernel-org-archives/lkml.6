Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeEaJV4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:21:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43804 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754092AbeEaJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:21:45 -0400
Date: Thu, 31 May 2018 11:21:33 +0200
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
Message-ID: <20180531092133.3gqepoabvuruiztz@flea.home>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-7-jernej.skrabec@siol.net>
 <20180521080759.rgviuva65ijcfm2e@flea>
 <218132669.UY7RKz0VPx@jernej-laptop>
 <20180524085021.qto6266adjvpj6ai@flea>
 <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uszjkr6mfqo6r23v"
Content-Disposition: inline
In-Reply-To: <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uszjkr6mfqo6r23v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> >> > > + if (tcon->quirks->needs_tcon_top) {
> >> > > +         struct device_node *np;
> >> > > +
> >> > > +         np =3D of_parse_phandle(dev->of_node, "allwinner,tcon-to=
p", 0);
> >> > > +         if (np) {
> >> > > +                 struct platform_device *pdev;
> >> > > +
> >> > > +                 pdev =3D of_find_device_by_node(np);
> >> > > +                 if (pdev)
> >> > > +                         tcon->tcon_top =3D platform_get_drvdata(=
pdev);
> >> > > +                 of_node_put(np);
> >> > > +
> >> > > +                 if (!tcon->tcon_top)
> >> > > +                         return -EPROBE_DEFER;
> >> > > +         }
> >> > > + }
> >> > > +
> >> >
> >> > I might have missed it, but I've not seen the bindings additions for
> >> > that property. This shouldn't really be done that way anyway, instead
> >> > of using a direct phandle, you should be using the of-graph, with the
> >> > TCON-top sitting where it belongs in the flow of data.
> >>
> >> Just to answer to the first question, it did describe it in "[PATCH 07=
/15] dt-
> >> bindings: display: sun4i-drm: Add R40 HDMI pipeline".
> >>
> >> As why I designed it that way - HW representation could be described t=
hat way
> >> (ASCII art makes sense when fixed width font is used to view it):
> >>
> >>                             / LCD0/LVDS0
> >>                 / TCON-LCD0
> >>                 |           \ MIPI DSI
> >> mixer0          |
> >>        \        / TCON-LCD1 - LCD1/LVDS1
> >>         TCON-TOP
> >>        /        \ TCON-TV0 - TVE0/RGB
> >> mixer1          |          \
> >>                 |           TCON-TOP - HDMI
> >>                 |          /
> >>                 \ TCON-TV1 - TVE1/RGB
> >>
> >> This is a bit simplified, since there is also TVE-TOP, which is respon=
sible
> >> for sharing 4 DACs between both TVE encoders. You can have two TV outs=
 (PAL/
> >> NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It even seems t=
hat you
> >> can arbitrarly choose which DAC is responsible for which signal, so th=
ere is a
> >> ton of possible end combinations, but I'm not 100% sure.
> >>
> >> Even though I wrote TCON-TOP twice, this is same unit in HW. R40 manual
> >> suggest more possibilities, although some of them seem wrong, like RGB=
 feeding
> >> from LCD TCON. That is confirmed to be wrong when checking BSP code.
> >>
> >> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0, TVE1 and =
LCD1 for
> >> pin muxing, although I'm not sure why is that needed at all, since acc=
ording
> >> to R40 datasheet, TVE0 and TVE1 pins are dedicated and not on PORT D a=
nd PORT
> >> H, respectively, as TCON-TOP documentation suggest. However, HSYNC and=
 PSYNC
> >> lines might be shared between TVE (when it works in RGB mode) and LCD.=
 But
> >> that is just my guess since I'm not really familiar with RGB and LCD
> >> interfaces.
> >>
> >> I'm really not sure what would be the best representation in OF-graph.=
 Can you
> >> suggest one?
> >
> > Rob might disagree on this one, but I don't see anything wrong with
> > having loops in the graph. If the TCON-TOP can be both the input and
> > output of the TCONs, then so be it, and have it described that way in
> > the graph.
> >
> > The code is already able to filter out nodes that have already been
> > added to the list of devices we need to wait for in the component
> > framework, so that should work as well.
> >
> > And we'd need to describe TVE-TOP as well, even though we don't have a
> > driver for it yet. That will simplify the backward compatibility later
> > on.
>=20
> I'm getting the feeling that TCON-TOP / TVE-TOP is the glue layer that
> binds everything together, and provides signal routing, kind of like
> DE-TOP on A64. So the signal mux controls that were originally found
> in TCON0 and TVE0 were moved out.
>=20
> The driver needs to know about that, but the graph about doesn't make
> much sense directly. Without looking at the manual, I understand it to
> likely be one mux between the mixers and TCONs, and one between the
> TCON-TVs and HDMI. Would it make more sense to just have the graph
> connections between the muxed components, and remove TCON-TOP from
> it, like we had in the past? A phandle could be used to reference
> the TCON-TOP for mux controls, in addition to the clocks and resets.
>=20
> For TVE, we would need something to represent each of the output pins,
> so the device tree can actually describe what kind of signal, be it
> each component of RGB/YUV or composite video, is wanted on each pin,
> if any. This is also needed on the A20 for the Cubietruck, so we can
> describe which pins are tied to the VGA connector, and which one does
> R, G, or B.

I guess we'll see how the DT maintainers feel about this, but my
impression is that the OF graph should model the flow of data between
the devices. If there's a mux somewhere, then the data is definitely
going through it, and as such it should be part of the graph.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--uszjkr6mfqo6r23v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsPvpkACgkQ0rTAlCFN
r3Qc6Q/+LV7BH85O9zzaF5ALnyh/7rt9AQBawz16kS/xUgtYxMUz8SBEBCytsLVP
Ik3+cJ7xd2OtfaPoUZl8532WyvyL1bN9v6mhfL3MMDtvMrdJ4MvzJSTvbmdeoyAv
vQMvzqrL6TbVpBVZmDt/jfJ00QADZb/lPWm5CiDqXHNIE7kXR6CKhmfJKuc7VIeG
4c7y/744Qo1HcWUAsY6UE80XiSHq5C9CGEw+r/bLQS5Z/eJ8BqlozAn9YPuQPOLN
X/c7hqD6dl558xE8Bc5Z89a+000rziYjpGARpxUj1yheApGQ02P39xcH8LhImtUH
QTu+nqHsawiPtHhKhxXoaZ0Bl1vuLF8gSDraMMVgn+lhJGcMdQO4LTTDElvPV6Gu
d2NptDSvVwHTEfcKs7lJRv+SJhGIOtFWwgLR3ta1xbG3F5JsukwPw1lwVCC3h/pW
74PSWFYJdcXQS6YxT7e5vgi7/owxatZTIhIp8CS7DPdd/q1vuiaUZDBwQzgLTszj
aSW2mMjpkj04bnax6BRhrZ6A4y6MLxRjbQvGYa7HI6hSbKgKo5cC4GoEZacsu0hb
QtcRUbOsF+Kg0qzEmW6AnWOXFfbExLAXKYB1uy9oGrFPxGZdtOOACiL9THcTLTCp
SYP0n3bZsev9SaTZRqA8jG1j1qStk4hdG0VbFv6XF7xVf0a5qG4=
=OA4k
-----END PGP SIGNATURE-----

--uszjkr6mfqo6r23v--
