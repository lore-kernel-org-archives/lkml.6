Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBHUks (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:40:48 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53575 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:40:47 -0500
Date: Thu, 8 Feb 2018 21:40:43 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
Message-ID: <20180208204043.mqryuqhx7a6z4v3b@flea>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180207103905.mtyzgu73mmifyvvj@flea>
 <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyfgkvs73hwzbv65"
Content-Disposition: inline
In-Reply-To: <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyfgkvs73hwzbv65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 01:49:59PM +0100, Giulio Benetti wrote:
> Hi,
>=20
> Il 07/02/2018 11:39, Maxime Ripard ha scritto:
> > On Wed, Jan 24, 2018 at 08:37:28PM +0100, Giulio Benetti wrote:
> >>>>> Also, how was it tested? This seems quite weird that we haven't cau=
ght
> >>>>> that one sooner, and I'm a bit worried about the possible regressio=
ns
> >>>>> here.
> >>>>
> >>>> It sounds really strange to me too,
> >>>> because everybody under uboot use "sync:3"(HIGH).
> >>>> I will retry to measure,
> >>>> unfortunately at home I don't have a scope,
> >>>> but I think I'm going to have one soon, because of this. :)
> >>>
> >>> Here I am with scope captures and tcon0 registers dump:
> >>> tcon0_regs =3D> https://pasteboard.co/H4r8Zcs.png
> >>> dclk_d0 =3D> https://pasteboard.co/H4r8QRe.png
> >>> dclk_de =3D> https://pasteboard.co/H4r8zh4R.png
> >>> dclk_vsnc =3D> https://pasteboard.co/H4r8Hye.png
> >>>
> >>> As you can see circled in reg on registers,
> >>> TCON0_IO_POL_REG =3D 0x00000000.
> >>> But on all the waveforms you can see:
> >>> - dclk_d0: clock phase is 0, but it starts with falling edge, otherwi=
se
> >>> the rising front overlaps dclk rising edge(not good), so to me this is
> >>> falling, then I mean it Negative.
> >>> - dclk_de: de pulse is clearly negative, even if register is 0 and it=
s'
> >>> polarity bit is 0.
> >>> - dclk_vsnc: same as dclk_de
> >>> - dclk_hsync: I didn't take scope screenshot but I can assure you it's
> >>> negative.
> >>>
> >>> You can also check all the other registers about TCON0.
> >>>
> >>> Now I proceed testing it on A33, maybe the peripheral is slightly
> >>> different between Axx SoCs, if I find it that way,
> >>> it should be only a check about SoC or peripheral ID,
> >>> and treat polarity as it should be done.
> >>
> >> Here I am with A33 waveforms:
> >> tcon0_regs =3D> https://pasteboard.co/H4rXfN0M.png
> >> dclk_d0 =3D> https://pasteboard.co/H4rVXwy.png
> >> dclk_de =3D> https://pasteboard.co/H4rWDt8.png
> >> dclk_vsnc =3D> https://pasteboard.co/H4rWRACu.png
> >> dclk_hsync =3D> https://pasteboard.co/H4rWK6I.png
> >>
> >> It behaves the same way as A20, so as I mean IO polarity,
> >> all signals(except D0-D23), are inverted.
> >> For A33 I've used A33-OLinuXino.
> >> For A20 our LiNova1.
> >=20
> > If you have an A33 handy, you probably want to read that mail:
> > https://lists.freedesktop.org/archives/dri-devel/2017-July/147951.html
> >=20
> > Especially the 90-phase part.
>=20
> Here is a summary of different SoCs TCON:
> With DCLK_Sel:
> 0x0 =3D> normal phase
> 0x1 =3D> 1/3 phase
> 0x2 =3D> 2/3 phase
>=20
> A10, A20

Have you tested the option 4 and 5 there too?

> With DCLK_Sel:
> 0x0 =3D> normal phase
> 0x1 =3D> 1/3 phase
> 0x2 =3D> 2/3 phase
> 0x5 =3D> DCLK/2 phase 0
> 0x4 =3D> DCLK/2 phase 90
>=20
> A31, A31s, A33, A80, A83T

Ok, great, so Chen-Yu was right :)

I guess the option 5 (DCLK/2 phase 0) is still to early, just like
you've shown in the previous captures?

> Also I've found that TCON1 has not this feature,
> nor first, nor second case(at least is not described on user manuals).

At lot of things are not described, unfortunately...

> So I could handle differently according to SoC.
> Unfortunately there is not TCON register keeping IP version,
> so the only way I see is to create a long if-or statement to understand
> which kind of TCON we're using.

You can base that on the compatible, and add a field in the
sun4i_tcon_quirks structure, that will avoid the if statements you
mentionned.

> But what sounds not the best to me, is that DCLK is divided by 2 if
> using phase 90. So we need to reconsider also bitclock driver according
> to this.
> I don't know if it make sense.
>=20
> IMHO, I would keep only:
> - As normal =3D> "0x1 =3D> 1/3 phase"

So that would mean sampling at raising edge on this one??

> - As inverted =3D> "0x0 =3D> normal phase"

And falling edge?

If so, and if remember the captures properly, the sampling would occur
right before the rise, and not really around the fall.

Would 2/3 be better here?

> According to scope captures above on both A20 and A33.
> Unfortunately I don't have other boards for the other SoCs to take captur=
es.
>=20
> What do you think?

I guess we can make that part applicable to all SoCs, we haven't seen
any significant differences on those part.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--kyfgkvs73hwzbv65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp8tbEACgkQ0rTAlCFN
r3SCQw/8CZHV3V+UwCDI4rMf8UaE2KucAzW9EFcGG6hUoTekQ32rEZQLAkHW0CFW
Qbe+mETAlTKKPxEUTE/OUm23T6iNLW46UBHV2nLmYqiy+c72FVK1AGMZRToc0Iz+
Bp94xbqniuw510BIihk9AVv0MHk+UBxIODsNIxg1JPq3iCK6PenZtQjJnzxHiBVp
EK/mT3lcU4tHcK4+smK7maR7/MjYgmN/jbP6jqJ30hcoZpGUmcdMtIgLzcAZesI1
XpBzWDSFptzzhwNRQQ38l4uK0dr9XWzSFz6OvPIzSJW3StE/nfZQw6xnDzDnYWPH
Ub8UdXSb6rQooJPNFaybI6xGTf7/xWvb2igSrERoH9LZSPV00f+wloyk2uyQDreC
fsR6P/T2UZkPJ2HcP4PO3TxnuUBqugGsjVi5HxKg/1d+gcPXquzr27CmNaEOBWKA
H2Yn9Pb6aWdqF76TefLK+cY2Sy+UrB3Ik21hLmctWufNZvYJQXOGl5ZUpYtDvhtE
vTmKpGXwOzBib56wPJn0SQU1X4kFq59rkk294c4e2Fewg1bsv7iDVXbKmSrY2ppr
T5IqzLrZtNxmxmSSsASo/Ye642H3EcuePWDCGIuVDBEXBWZ1o2aCRfijhb34sIry
sATMd2X86AZY9mDELD3E7vUJdDCtf+yN8KtAEF+UhVo0TBFJX/U=
=jphS
-----END PGP SIGNATURE-----

--kyfgkvs73hwzbv65--
