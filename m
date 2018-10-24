Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2918FECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECECC20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECECC20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJYEY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:24:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38044 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeJYEY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:24:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C08978080F; Wed, 24 Oct 2018 21:55:28 +0200 (CEST)
Date:   Wed, 24 Oct 2018 21:55:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20181024195529.GA23069@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
 <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-24 21:17:25, Jacek Anaszewski wrote:
> On 10/24/2018 10:31 AM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> +
> >>> +		The gradual dimming format of the software pattern values should b=
e:
> >>> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> >>> +		duration_3 ...". For example:
> >>> +
> >>> +		echo 0 1000 255 2000 > pattern
> >>> +
> >>> +		It will make the LED go gradually from zero-intensity to max (255)
> >>> +		intensity in 1000 milliseconds, then back to zero intensity in 2000
> >>> +		milliseconds:
> >>> +
> >>> +		LED brightness
> >>> +		    ^
> >>> +		255-|       / \            / \            /
> >>> +		    |      /    \         /    \         /
> >>> +		    |     /       \      /       \      /
> >>> +		    |    /          \   /          \   /
> >>> +		  0-|   /             \/             \/
> >>> +		    +---0----1----2----3----4----5----6------------> time (s)
> >>> +
> >=20
> > Ok, so I got around to testing this.
> >=20
> > echo "0 1000 10 2550 0 1000 0 100" > pattern
> >=20
> > makes expected pattern [  .-xXx-.  ].
> >=20
> > But when I do
> >=20
> > echo "0 1000 10 2550 0 1000" > pattern
> >=20
> > I only get expected pattern on the first iteration, then I get
> > [    Xx-.   ].
>=20
> This is because the tuples are processed in a loop, without
> discerning between start and end of the sequence.
>=20
> So this sequence ends up being squashed, because of the
> comparison:
>=20
> if (data->curr->brightness =3D=3D data->next->brightness) {
> 	//step change od brightness
> 	...
> 	/* Skip the tuple with zero duration */
>=20
> Here we actually only assume that this is zero duration since it
> is not checked. Possibly needs fixing.
>=20
> 	pattern_trig_update_patterns(data);
> 	/* Select next tuple */
> 	pattern_trig_update_patterns(data);

I came up with this (untested).

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/=
ledtrig-pattern.c
index ce7acd1..174a298 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -87,9 +87,10 @@ static void pattern_trig_timer_function(struct timer_lis=
t *t)
 					   data->curr->brightness);
 			mod_timer(&data->timer,
 				  jiffies + msecs_to_jiffies(data->curr->delta_t));
-
-			/* Skip the tuple with zero duration */
-			pattern_trig_update_patterns(data);
+			if (!data->next->delta_t) {
+				/* Skip the tuple with zero duration */
+				pattern_trig_update_patterns(data);
+			}
 			/* Select next tuple */
 			pattern_trig_update_patterns(data);
 		} else {



> In effect we have:
>=20
> 0 -> 10    // dimming
> 10 -> 0    // dimming
> 0 skipped  // step
> 10 -> 0    // dimming
> 0 skipped  // step
> 10 -> 0    // dimming
> ...
>=20
> In order to get "rise - fall - rise - fall" sequence you need
> only two tuples:

Well, I wanted "rise - fall - delay - rise - fall - delay"
sequence. Let me test the patch...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQzjEACgkQMOfwapXb+vKLkACeIHhMioSMLFhRKkNBlfclo3zN
R5kAnRbvPqhpQxgvSggL2wIi9/fC84oX
=5tUS
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
