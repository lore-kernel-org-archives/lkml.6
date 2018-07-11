Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669C20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E669C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeGKIFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:05:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51129 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:05:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5EC8D80576; Wed, 11 Jul 2018 10:02:21 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:02:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180711080218.GA21225@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180710161123.azym6sbboriuj4yc@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Its parent is gpio@4805d000 , and that one seems to be present.
> >=20
> > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > driver				       driver_override  gpio
> > gpiochip5  modalias  of_node  power  subsystem  uevent
>=20
> Sorry, something went wrong with merging this. The parent
> of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> not gpio6.

Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
driver.

Still can't get it to actually vibrate.=20

user@devuan:/sys/bus/platform/drivers/pwm-vibrator/vibrator$ sudo fftest /d=
ev/input/event3
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event3 opened
Features:
  * Absolute axes:=20
    [00 00 00 00 00 00 00 00 ]
  * Relative axes:=20
    [00 00 ]
  * Force feedback effects types: Periodic, Rumble, Gain,=20
    Force feedback periodic effects: Square, Triangle, Sine,=20
    [00 00 00 00 00 00 00 00 00 00 03 07 01 00 00 00 ]
  * Number of simultaneous effects: 16

Setting master gain to 75% ... OK
Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
Uploading effect #1 (Constant) ... Error: Invalid argument
Uploading effect #2 (Spring) ... Error: Invalid argument
Uploading effect #3 (Damper) ... Error: Invalid argument
Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
Enter effect number, -1 to exit
5
Now Playing: Weak Rumble
Enter effect number, -1 to exit

0
Now Playing: Sine vibration
Enter effect number, -1 to exit
5
Now Playing: Weak Rumble
Enter effect number, -1 to exit
^C



diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index 45305e8..c27fc87 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -159,13 +159,7 @@
=20
 		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
 	};
-};
-
-&dss {
-	status =3D "okay";
-};
=20
-&gpio6 {
 	pwm8: dmtimer-pwm-8 {
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&vibrator_direction_pin>;
@@ -192,7 +186,10 @@
 		pwm-names =3D "enable", "direction";
 		direction-duty-cycle-ns =3D <10000000>;
 	};
+};
=20
+&dss {
+	status =3D "okay";
 };
=20
 &dsi1 {
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c..debeb70 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_devic=
e *pdev)
 	timer_pdata =3D dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
 		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret =3D -EINVAL;
+		ret =3D -EPROBE_DEFER;
 		goto put;
 	}
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltFuYkACgkQMOfwapXb+vK/GwCfQSwrRqHmWj9PksscqKKoiZe0
GNkAoIPXiK6v4gx+OFfegqT8u1XHasEK
=RHBm
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
