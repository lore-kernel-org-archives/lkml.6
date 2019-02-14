Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32923C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FD218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfBNXDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33547 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfBNXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:03:11 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 999C080378; Fri, 15 Feb 2019 00:03:01 +0100 (CET)
Date:   Fri, 15 Feb 2019 00:03:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214230307.GA17358@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>I suggest that we deal with this special case by adding 3 custom
> >>>sysfs attributes:
> >>>
> >>>1) "mode" which when read, prints, e.g. :
> >>>manual [on-when-charging]
> >>
> >>While this allows _user on console_ to control everything using echo,
> >>it is not suitable for applications trying to control LEDs.
> >>
> >>As there's nothing special about the case here, I believe we should
> >>have generic solution here.
> >>
> >>My preffered solution would be "hardware" trigger that leaves the LED
> >>in hardware control.
> >
> >As you explained in the parts which I snipped, there are many
> >devices which have a similar choice for a LED being under hw or
> >user control. I can see how this looks like a trigger and how we
> >could use the trigger API for this.
> >
> >I believe though, that if we implement a "virtual" (for lack of
> >a better word) trigger for this, that this should be done in the
> >LED core. I can envision this working like this:
> >
> >1) Add a:
> >
> >hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
>=20
> Please note that we have support for hw patterns in the pattern trigger.
> (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
> breathing pattern).
> We have also support for hw blinking in timer trigger via blink_set op.
>=20
> In addition to that there is brightness_hw_changed sysfs attribute
> with led_classdev_notify_brightness_hw_changed() LED API.
>=20
> Couldn't they be used in concert to support the specific features
> of the device in question?

I believe main issue here is this:

Hardware can automatically control the LED according to the charging
status, or it can be used as normal software-controlled LED.

I believe we should use trigger to select if hardware controls it or
not (and then add driver-specific files to describe the
details). Other proposal is in the mail thread, too.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxl86sACgkQMOfwapXb+vIVrwCfWOOXkUNNo1qHi9oaIcJFMEWH
/W8AnRJZrracf/phzx/edwilQCQPKppD
=yr9G
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
