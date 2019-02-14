Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E87218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394474AbfBNM2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:28:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42752 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfBNM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:28:44 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BB15A80353; Thu, 14 Feb 2019 13:28:34 +0100 (CET)
Date:   Thu, 14 Feb 2019 13:28:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214122840.GA21860@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Jacek, could we get you to comment here? I'd prefer "hardware" trigger...

> >>That assumes that breathing is the default setting on all hardware
> >>and again I don't see why not to export this functionality to
> >
> >Save the status on boot, then restore it on rmmod/reboot/poweroff? :-).
>=20
> Which works until the system freezes one time. I believe that
> if we are going to do a LED driver for the charging LED on these
> devices, we MUST offer a way to put it back in its original
> state, even if the state is foo-barred at bootup.
>=20
> >>userspace. Just because something does not fit in the existing
> >>API is IMHO not a good reason to not expose it to userspace.
> >>
> >>I suggest that we deal with this special case by adding 3 custom
> >>sysfs attributes:
> >>
> >>1) "mode" which when read, prints, e.g. :
> >>manual [on-when-charging]
> >
> >While this allows _user on console_ to control everything using echo,
> >it is not suitable for applications trying to control LEDs.
> >
> >As there's nothing special about the case here, I believe we should
> >have generic solution here.
> >
> >My preffered solution would be "hardware" trigger that leaves the LED
> >in hardware control.
>=20
> As you explained in the parts which I snipped, there are many
> devices which have a similar choice for a LED being under hw or
> user control. I can see how this looks like a trigger and how we
> could use the trigger API for this.
>=20
> I believe though, that if we implement a "virtual" (for lack of
> a better word) trigger for this, that this should be done in the
> LED core. I can envision this working like this:

Agreed about the LED core.

> 1) Add a:
>=20
> hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
>=20
> Callback to struct led_classdev which when implemented by a driver
> like the current PMIC LED controller would do what it says.
>=20
> 2) Have the core create and register a virtual hardware trigger the
> first time a LED cdev which has this callback gets registered.
>=20
> When configured as the trigger for this LED device this trigger calls
> hw_control_set(cdev, true) and when unregistered calls
> hw_control_set(cdev, false)
>=20
> Taking a quick look at the trigger code, a problem with this is
> that normally any trigger can work with any led device, so this
> "hardware" trigger will show up in the list of possible
> triggers for each device.
>=20
> This problem can be solved by making the activate method for the
> hardware trigger check the classdev has a hw_control_set callback
> and if not return -EINVAL, or maybe -ENXIO but still this is somewhat
> inconsistent with other triggers, which AFAIK work with any LED.

I guess other option is to modify core so that it does not list
"hardware" trigger for leds that don't support it.

> >Alternatively I could imagine "hardware" sysfs attribute, containing
> >0/1, with 0=3D=3Dsoftware controlled, 1=3D=3Dhardware controlled.
>=20
> Hmm, maybe call it "hardware_controlled" instead ? Otherwise this
> would work for me and I would personally prefer this solution. This
> could even be done in the LED core using the hw_control_set callback
> I proposed, to make sure it is handled consistently between devices.

This should be in LED core, yes.

> >The rest of attributes would have to be Cove-specific, yes (but still
> >should fit with the rest of LED subsystem).
>=20
> Right, I see that the triggers attribute already uses the fmt where
> on "cat" all options are listed and the current active one has [] around =
it,
> so I think the pattern and frequency attributes I proposed should work
> well, although thinking more about this I believe the freq. attribute sho=
uld
> be called pattern_freq to make clear it applies to blinking / breathing
> set through the pattern attribute.

Take a look at blinking trigger. It can already do hardware
acceleration, but uses different format than what you proposed.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlXvgACgkQMOfwapXb+vK75wCfRohINirLNSVrYOl223Wl8k+y
x1wAoKy6w9XdMNw15J+x4331bdMEUdSs
=ei2J
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
