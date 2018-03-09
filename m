Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeCIMkf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:40:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeCIMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:40:32 -0500
Date: Fri, 9 Mar 2018 12:40:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180309124017.GB5252@sirena.org.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
 <20180308112528.GC6019@sirena.org.uk>
 <20180309083414.s57eq3kw325magwz@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20180309083414.s57eq3kw325magwz@dell>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2018 at 08:34:14AM +0000, Lee Jones wrote:
> On Thu, 08 Mar 2018, Mark Brown wrote:

> > Linux.  Clocks are a big issue with audio stuff, right now sections of
> > the clock tree get handled in the CODEC driver but we're going to want
> > to push them out to a clock driver so we're not reimplementing handling
> > for clocks.

> How is the CODEC controlled?  Does it have its own registers?  I guess
> by "it's not a separate device or IP" you mean that it doesn't.  But
> that begs the question, how does this then device differ from all the
> other devices (adc, battery, charger, regulator, rtc, pwrbutton,
> usb-phy and led)?

I'm not convinced that this is a particularly good idea for the other
functions but anyway...  the big thing here is that in these devices the
CODEC is generally not the level that the IP is created at, it's a
collection of interlinked IPs which usually includes not only audio
stuff but also some clocking stuff.  The repeatable blocks that could
get reused independently are generally a level down from the CODEC
level, for example if you look at something like wm8994 there's a couple
of identical FLL IPs which could make sense to enumerate individually in
the DT.  The top level generally doesn't get reused and is purely an
encoding of what Linux is currently doing.

Regulators have a bit of this going on as well - you can see it in the
wm831x series of drivers where the devices have a bunch of consistently
defined regulators that are laid out in various configurations so we
have one platform device per physical regulator (not sure if that ever
got converted to DT).

Most of the other things you list are more at the level of the FLL where
it's a single thing doing a single task that is likely to be repeated
somewhere else as a block so there's more sense, though how often that
actually happens can be questionable.

> I'm asking, not to be awkward, but to avoid 50 lines of potentially
> unnecessary static code.  If this is a real (sub-)device, even if it's
> part of a larger, single device (MFD) then there is no reason why it
> can't be represented as a single, albeit empty node.

It never used to be that complicated to define MFD functions?  It was a
data table and then a function call to register the table en masse.
Certainly not anything it's worth defining an ABI to avoid.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqigLAACgkQJNaLcl1U
h9DJuAf+NhAk75SkmSnRIolTBoRHF2VIQd9lA7wM+lO6eOm3jWi8r3tCL01tF6Gq
kr9LEsRjVv2P5KeG2gT0n+JX/PFI8pdJ0RS1zvRclp0QcHNGc80LhRrH1togHwPz
2y1bIFOsOnerMVdzEcO0z2tmDzRV1EJ6H9w30ib2ITCmZv4M9/EW2C7U/mEkjh97
HbeOBLPNYxIfXZezy8D+WCzqHW0ThZ/tN6nMTtGahoQGoYH5pCF4f7o4geagw0zB
SFhZOXoS58z2WU06hWTOPq6mlG097zm8KIm23ex7mhdiKBYk8aqT17jn3Cbzate8
EW3CO/jYZdzf+pACbY/NcLmXkJLfeg==
=62I+
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
