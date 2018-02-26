Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeBZXNi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:13:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35033 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeBZXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:13:37 -0500
Date: Tue, 27 Feb 2018 00:13:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Baluta <daniel.baluta@gmail.com>, linus.walleij@linaro.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, peter.ujfalusi@ti.com,
        Linux-ALSA <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com,
        khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
        martijn@brixit.nl,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>, abcloriens@gmail.com,
        sakari.ailus@linux.intel.com, pali.rohar@gmail.com,
        clayton@craftyguy.net, linux-omap@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>, patrikbachan@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
Message-ID: <20180226231336.GA18565@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-26 16:02:22, Daniel Baluta wrote:
> On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> JFYI: This issues is tracked in the regression reports for Linux 4.16
> >> (http://bit.ly/lnxregrep416 ) with this id:
> >>
> >> Linux-Regression-ID: lr#4b650f
> >
> > Ok, so it seems that issue is bigger: whole sound subsystem does not
> > work. /proc/asound/cards is empty.
> >
> > 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
> >
> > I tried to revert sound/soc changes, and sound is broken, too. Nasty
>=20
>=20
> dmesg log?

Partial dmesg is at:
https://github.com/pavelmachek/missy/blob/master/db/phone/nokia/n900/pavel/=
2018.1291171648263/dmesg.out

I should be able to get full one...

I did git bisect, and the winner seems to be:

pavel@duo:/data/l/linux-n900$ git bisect bad
c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
commit c85823390215e52d68d3826df92a447ed31e5c80
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Dec 27 16:37:44 2017 +0100

    gpio: of: Support SPI nonstandard GPIO properties

    Before it was clearly established that all GPIO properties in the
        device tree shall be named "foo-gpios" (with the deprecated
        variant
	    "foo-gpio" for single lines) we unfortunately merged a few
        bindings
	    which named the lines "gpio-foo" instead.

    This is most prominent in the GPIO SPI driver in Linux which names
        the lines "gpio-sck", "gpio-mosi" and "gpio-miso".

    As we want to switch the GPIO SPI driver to using descriptors, we
        need devm_gpiod_get() to return something reasonable when
        looking
	    up these in the device tree.

    Put in a special #ifdef:ed kludge to do this special lookup only
        for the SPI case and gets compiled out if we're not enabling
        SPI.
	    If we have more oddly defined legacy GPIOs like this, they
        can be
	    handled in a similar manner.

    Reviewed-by: Rob Herring <robh@kernel.org>
        Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Unfortunately, it does not seem to revert cleanly on my v4.16 branch.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUlJ8ACgkQMOfwapXb+vKASQCfdxxKqVMl+wtMQMhG4xobuWfg
aGMAoJAYqZc27+2AfYbfRnKyCDcd4vKm
=XNfI
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
