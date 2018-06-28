Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A80C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3408D257F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3408D257F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966285AbeF1UpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:45:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51392 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966173AbeF1UpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:45:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8BABD805A3; Thu, 28 Jun 2018 22:45:17 +0200 (CEST)
Date:   Thu, 28 Jun 2018 22:45:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180628204516.GA29146@amd>
References: <20180628134227.GA1719@arbeit>
 <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180628202955.GA1534@imap.1und1.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-28 22:29:57, Andreas Klinger wrote:
> Hi Pavel,
>=20
> Pavel Machek <pavel@ucw.cz> schrieb am Thu, 28. Jun 20:56:
> > Hi!
> >=20
> > > Send out a morse code by using LEDs.
> > >=20
> > > This is useful especially on embedded systems without displays to tel=
l the
> > > user about error conditions and status information.
> > >=20
> > > The trigger will be called "morse"
> > >=20
> > > The string to be send is written into the file morse_string and sent =
out
> > > with a workqueue. Supported are letters and digits.
> > >=20
> > > With the file dot_unit the minimal time unit can be adjusted in
> > > milliseconds.
> > >=20
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> >=20
> > Can we get more general "pattern" trigger? Some LEDs can do that in
> > hardware, and it is more general than plain morse.
> >=20
> > Ouch and it already was implemented :-). Patch is in attachment.
>=20
> The idea of the morse trigger is so be able so send out a short error
> code or if needed also a complete sentence. The morse code don't need
> extra explanation to the user. Decoding can be found everywhere.

Yeah, well... I don't think decoding sentences in morse code is going
to be much fun.

And we don't really want encoder in kernel. Just do encoding in
userspace, and use pattern trigger to display it.

For many uses, morse code is "too geeky", and other patterns will be
used.

Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
charging, " .xXx. " for everything okay...

> With the pattern trigger one need a translation of the letters and
> numbers into morse code. This is what the morse trigger is doing.
>=20
> So from my perspective the pattern trigger is something different than
> the morse one.

Well, pattern trigger is more generic, and can do everything morse
trigger can do. Lets do that instead.

> Another question:
> The pattern trigger is not in mainline. Do you know why?

Needs to be resubmitted, I'd say.

								Pavel

> > +++ b/Documentation/leds/ledtrig-pattern.txt
> > @@ -0,0 +1,86 @@
> > +LED Pattern Trigger
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This is a LED trigger allowing arbitrary pattern execution. It can do =
gradual
> > +dimming. This trigger can be configured to repeat the pattern a number=
 of
> > +times or indefinitely. This is intended as a way of communication for =
embedded
> > +systems with no screen.
> > +
> > +The trigger can be activated from user space on LED class devices as s=
hown
> > +below:
> > +
> > +  echo pattern > trigger
> > +
> > +This adds the following sysfs attributes to the LED:
> > +
> > +  pattern - specifies the pattern. See syntax below.
> > +
> > +  repeat - number of times the pattern must be repeated.
> > +	writing -1 to this file will make the pattern
> > +	repeat indefinitely.
> > +
> > +The pattern will be restarted each time a new value is written to
> > +the pattern or repeat attribute. When dimming, the LED brightness
> > +is set every 50 ms.
> > +
> > +pattern syntax:
> > +The pattern is specified in the pattern attribute with an array of com=
ma-
> > +separated "brightness/length in miliseconds" values. The two components
> > +of each value are to be separated by a space.
> > +
> > +For example, assuming the driven LED supports
> > +intensity value from 0 to 255:
> > +
> > +  echo 0 1000, 255 2000 > pattern
> > +
> > +Or:
> > +
> > +  echo 0 1000, 255 2000, > pattern
> > +
> > +Will make the LED go gradually from zero-intensity to max (255) intens=
ity
> > +in 1000 milliseconds, then back to zero intensity in 2000 milliseconds:
> > +
> > +LED brightness
> > +    ^
> > +255-|       / \            / \            /
> > +    |      /    \         /    \         /
> > +    |     /       \      /       \      /
> > +    |    /          \   /          \   /
> > +  0-|   /             \/             \/
> > +    +---0----1----2----3----4----5----6------------> time (s)
> > +
> > +
> > +
> > +To make the LED go instantly from one brigntess value to another,
> > +use zero-time lengths. For example:
> > +
> > +  echo 0 1000, 0 0, 255 2000, 255 0 > pattern
> > +
> > +Will make the LED stay off for one second, then stay at max brightness
> > +for two seconds:
> > +
> > +LED brightness
> > +    ^
> > +255-|        +---------+    +---------+
> > +    |        |         |    |         |
> > +    |        |         |    |         |
> > +    |        |         |    |         |
> > +  0-|   -----+         +----+         +----
> > +    +---0----1----2----3----4----5----6------------> time (s)
> > +

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls1SNwACgkQMOfwapXb+vKiDgCeJ1roVYvSkYtGRqe3UmDuHvZo
VPUAoKOMofhs2mlyNB2iHu7yL6TufO3y
=9tDE
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
