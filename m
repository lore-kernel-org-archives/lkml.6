Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeBAKOO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:14:14 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:43091 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBAKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:14:13 -0500
Date: Thu, 1 Feb 2018 11:14:11 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
Message-ID: <20180201101411.d23efsjt7jdyi4zh@flea.lan>
References: <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
 <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b4ob6mpkow4vbiy5"
Content-Disposition: inline
In-Reply-To: <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4ob6mpkow4vbiy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:07:09PM +0100, Giulio Benetti wrote:
> > > > > I don't really know what the polarity of D0 would be just by
> > > > > judging at that capture, but we would have noticed if the colors
> > > > > were inverted for quite some time now.
> > > >=20
> > > > D0-D23 are correct.
> > > >=20
> > > > With that capture, I mean to show you instead dclk is inverted, as
> > > > dclk samples D0 on falling edge.
> > >=20
> > > Ah right, DCLK being the first channel?
> >=20
> > Yes, sorry I didn't place a label on channels
> >=20
> > >=20
> > > > So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
> > > > 1/3 clock phase seems enough to me to be considered POSEDGE,
> > > > 2/3 instead risks to go too much to the right of D0(even if it
> > > > could work).
> > >=20
> > > Do you have captures with both settings?
> >=20
> > Not now, but asap I'm going to take.
>=20
> Here we are:
> 1/3 phase: https://pasteboard.co/H4VehON.png
> 2/3 phase: https://pasteboard.co/H4Veq8a.png
>=20
> Yellow: D0
> Blue: DCLK
>=20
> As you can see:
> 1/3 phase has DCLK rising edge almost in the middle of D0
> 2/3 phase has DCLK rising edge that comes too late
>=20
> I would go for "1/3 phase" for Rising edge and "normal phase" for
> Falling edge.
>=20
> What do you think?

It seems fair. This need a whole lot of comments though :)

> > > That it's going to be a nightmare... We've advertised since the very
> > > beginning something, and we're about to break it. I'm not sure we want
> > > to do that.
> >=20
> > I can take care about that.
> > But I also think that a lot of displays work because they use only
> > DE-mode, almost ignoring HSync and VSync signals(HV-mode).
> >=20
> > In any case I have to produce these patches because of my company's
> > board based on A20 and A33, and modify defconfig according to it.
> > The only technical nightmare I see is to produce a commit for every
> > defconfig to be modified and copy-paste che commit-log substituing board
> > name(1-2 days of work).
> > Problem is testing, but we're speaking about something that probably was
> > badly working, but you couldn't see it on display.
> > So I think this is only an improvement at the end.
> >=20
> > I'm sorry I've taken bad news.
> > Drink 1 glass of Spritz to go over! :)
>=20
> IMHO I think that we have only to take care about displays that don't have
> DE signal.
>
> If DE signal exists, then displays are driven through DE only for back and
> front porch as I know, and on most displays I've used, Hsync and VSync are
> ignored.
> DE is used not only for Data Enable, but also for sync the very beginning=
 of
> frame, the rest of syncing is done by pause between every line sent.
> This is should be why nobody noticed it before,
> I think almost every display is used in DE mode only.
> So, if we fix bug for HSync and VSync, risk should be very low.
> Indeed, everybody or almost, use sync:3 because display ignore those 2
> signals (HSync and VSYnc) in favour of DE.
> And I don't know how many people checked with oscilloscope signals after
> getting display working in a few.

I know I did, but I apparently didn't pay attention to that and was
more focused on getting the timings right :)

But clearly this is a separate discussion that needs to be held on the
U-Boot ML.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--b4ob6mpkow4vbiy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpy6HIACgkQ0rTAlCFN
r3Scuw//c1s72z37oz4reek541RT7NvFFBpSGcL+TFLVMYW/SFd4VM4wPxaaVj0V
Y/M2jeHUvyOauKl4uFmGoQnqdvbtbL0fObJ5iMScCfsdQcLH5mEDa5oqwvk4UvV/
lNBwKLESMO3SvwUzmLKB65n2DdB9kGu35+wFEY67OvFPXsZZLwIeIC7JLzvVatnn
gGUsV4xr7qKPAYcnSr61UbywOqA7AaWMTYv2nbnxR8GiyRClrMLuPd5+Hd+8j34R
cb6DgJozAoP3L9xfq4zjtQf+WPzDkRDtkwxkIJc21UTc/CSryVNdzVZ432wwBRza
7ToMEH+rSwCrrSe435ley5jofzW4STXbfGtOOSzjUHTmG1N/zCvA+V27QCa2s/Dv
82Z31ml9hSEcQqpU5oF37gQCnLq7VSeYXpuNJRD32fVkciWiqrIsHIq6pZoqCfRz
RwbexmAY2o0QzPb5MxXNnW59DCRv2ZR5k1pkrK/CGGgcpaFHsRrbIRI1yvakTHoh
cqEBp3sVObxIAS8DiQY6H859D+tDZdkOdRkrLUr9SVF6L0qwEq3HCALxmcvIS9Op
BNw7ihDrZqMSjf9MuXdknhwHsBOQXHtCnTj53pWhqCBtis6Q2ZmIRM0MwA3OhB6x
d16503TnIFdxASyuOMWLvX5bB8HIiepxcCEMSoGloWM/lNoiTGE=
=55xU
-----END PGP SIGNATURE-----

--b4ob6mpkow4vbiy5--
