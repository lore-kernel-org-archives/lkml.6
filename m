Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbeCWKJj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:09:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53653 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeCWKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:09:32 -0400
Date: Fri, 23 Mar 2018 11:09:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180323100930.GA21644@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180322234832.o24ut5ahon46mdu4@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > # CONFIG_SND_OMAP_SOC_RX51 is not set
> > # CONFIG_SND_OMAP_SOC_N9 is not set
> > CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
> > CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy
>=20
> That's not needed (but does not hurt). The Droid 4
> has no TWL companion chip and uses CPCAP instead.

Aha, thanks. I was doing wild experiments to get something that
boots... I turned them off.

> > Any ideas?
>=20
> You probably did not enable the soundcard driver, that binds against
> "audio-graph-card" compatible and connects the codec driver with the
> SoC driver: CONFIG_SND_AUDIO_GRAPH_CARD

Ok, that certainly changed things; I am now getting this:

Mar 23 08:39:17 devuan kernel: [   11.633605] asoc-audio-graph-card soundca=
rd: GPIO lookup for
 consumer pa
Mar 23 08:39:17 devuan kernel: [   11.644958] asoc-audio-graph-card soundca=
rd: using device tr
ee for GPIO lookup
Mar 23 08:39:17 devuan kernel: [   11.656677] of_get_named_gpiod_flags: can=
't parse 'pa-gpios'
 property of node '/soundcard[0]'
Mar 23 08:39:17 devuan kernel: [   11.669738] of_get_named_gpiod_flags: can=
't parse 'pa-gpio'=20
property of node '/soundcard[0]'
Mar 23 08:39:17 devuan kernel: [   11.682617] asoc-audio-graph-card soundca=
rd: using lookup ta
bles for GPIO lookup
Mar 23 08:39:17 devuan kernel: [   11.694427] asoc-audio-graph-card soundca=
rd: lookup for GPIO
 pa failed

Indeed the dts does not seem to contain any gpios

        soundcard {
                compatible =3D "audio-graph-card";
                label =3D "Droid 4 Audio";

                simple-graph-card,widgets =3D
                        "Speaker", "Earpiece",
                        "Speaker", "Loudspeaker",
	                "Headphone", "Headphone Jack",
	                "Microphone", "Internal Mic";

                simple-graph-card,routing =3D
	                "Earpiece", "EP",
		        "Loudspeaker", "SPKR",
                        "Headphone Jack", "HSL",
                        "Headphone Jack", "HSR",
	                "MICR", "Internal Mic";

                dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
	};

Any more ideas? :-)

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq00loACgkQMOfwapXb+vL71wCfei9Wakmc6L0+DQQ6ydjcLxIl
d54AnAmfV0UHVbqUBgYCCLQbQS1kZVmN
=VTw6
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
