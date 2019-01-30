Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7620881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfA3XLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:11:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37275 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfA3XLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:11:14 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 130A2801FE; Wed, 30 Jan 2019 23:35:36 +0100 (CET)
Date:   Wed, 30 Jan 2019 23:35:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
Message-ID: <20190130223542.GA22040@amd>
References: <20190130183005.833-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190130183005.833-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-30 12:30:05, Dan Murphy wrote:
> Add a documentation of LED Multicolor LED class specific
> sysfs attributes.

No, sorry. This does not most of the requirements.

								Pavel

Requirements for RGB LED interface:

1) Userspace should be able to set the white color

2) Userspace should be able to arbitrary color from well known list
and it should approximately match what would CRT, LCD or OLED monitor
display. Color list is for example here:

	 https://www.rapidtables.com/web/color/RGB_Color.html

    2a) LEDs probably slightly change color as they age. That's out of
    scope, unless the variation is much greater than on monitors.

    3a) Manufacturing differences cause small color variation. Again,
    that's out of scope, unless the variation is much greater than on
    monitors.

Nice to have features:

3) Full range of available colors/intensities should be available to
userspace

4) Interface should work well with existing triggers

5) It would be nice if userland knew how many lumens are produced at
each wavelength for each setting (again, minus aging and manufacturing
variations).

6) Complexity of math in kernel should be low, and preferably it
should be integer or fixed point

Problems:

a) RGB LEDs are usually not balanced. Setting 100% PWM on
red/green/blue channels will result in nothing close to white
light. In fact, to get white light on N900, blue and green channel's
PWM needs to be set pretty low, as in 5%.

b) LED class does not define any relation between "brightness" in
sysfs and ammount of light in lumens. Some drivers use close to linear
relation, some use exponential relation. Human eyes percieve logarithm
of lumens. RGB color model uses even more complex function.

	   https://en.wikipedia.org/wiki/Gamma_correction
	   #Windows, Mac, sRGB and TV/video standard gammas
	   https://en.wikipedia.org/wiki/SRGB#Specification_of_the_transformation

c) Except for white LEDs, LEDs are basically sources of single
wavelength of light, while CRTs and LCDs produce broader
spectrums.

d) RG, RGBW and probably other LED combinations exist.

e) Not all "red" LEDs will produce same wavelength. Similar
differences will exist for other colors.

f) We have existing RGB LEDs represented as three separate
monochromatic LEDs in sysfs.



> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../ABI/testing/sysfs-class-led-multicolor    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Docum=
entation/ABI/testing/sysfs-class-led-multicolor
> new file mode 100644
> index 000000000000..19f8da9b150e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
> @@ -0,0 +1,38 @@
> +What:		/sys/class/leds/<led>/color/sync_enable
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	read/write
> +		Writing a 1 to this file will enable the sychronization of all
> +		the defined color LEDs within the LED node.  Writing a 0 to
> +		this file will disable syncing.
> +
> +What:		/sys/class/leds/<led>/color/sync
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	write only
> +		Writing a 1 to this file while sync_enable is set to 1 will
> +		synchronize all defined LEDs within the LED node.  All LEDs
> +		defined will be configured based on the brightness that has
> +		been requested.
> +
> +		If sync_enable is set to 0 then writing a 1 to sync has no
> +		affect on the LEDs.
> +
> +What:		/sys/class/leds/<led>/color/<led color>
> +Date:		January 2019
> +KernelVersion:	5.0
> +Contact:	Dan Murphy <dmurphy@ti.com>
> +Description:	read/write
> +		These files are dynamically created based on the colors defined
> +		by the registrar of the class.
> +		The led color(s) can be but not limited to red, green, blue,
> +		white, amber and violet.  If sync is enabled then writing the
> +		brightness value of the LED is deferred until a 1 is
> +		written to /sys/class/leds/<led>/color/sync.  If syncing is
> +		disabled then the LED brightness value will be written
> +		immediately to the LED driver.
> +
> +		The value of the color is from 0 to
> +		/sys/class/leds/<led>/max_brightness.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxSJr4ACgkQMOfwapXb+vKwnQCfeJ/O6IsFSsFE1Y0rSrmPQ4PZ
VGIAnime4cDvW6qR8HXvnNHFWetJ7c6j
=cIQe
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
