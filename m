Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3468CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1F020663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeKXKT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:19:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40933 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:19:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D46A78080F; Sat, 24 Nov 2018 00:33:07 +0100 (CET)
Date:   Sat, 24 Nov 2018 00:33:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Message-ID: <20181123233309.GA4340@amd>
References: <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de>
 <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de>
 <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
 <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
 <20181122131802.GB13339@amd>
 <s5h8t1l5ish.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <s5h8t1l5ish.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > > > You have general-purpose LED, yet you are treating it as "som=
ething
> > > > > > > special". That means ugly code (quoted above) and lack of fle=
xibility.
> > > > > > >

> > I'd prefer this to be normal LED and "mic muted" to become normal
> > trigger.
>=20
> But how would you solve the existing problem?
>=20
> As already mentioned, you'll need to hook the LED trigger and the
> actual mixer value change.  This is the biggest missing piece, and
> it's the very reason we have the exported symbol from the platform
> driver side.
>=20
> So, if you prefer in that way, please implement that for the existing
> driver (thinkpad_acpi and dell-laptop) at first.  I'll be really happy
> to get rid of the present ugly solution!  But it's been there just
> because it's not so trivial at all.  FWIW, this must be all done
> inside the kernel; otherwise you'll hit a regression.

Ok, what about something like this?

Tested, and it did not work. I guess I hooked it up at the wrong place
in LED subsystem... or maybe thinkpad x60 is wrong machine to test on.

Anyway, it looks less ugly than current code in alsa. We should not
really be using mixer settings to turn LED on and off.

Plus, it works in similar way triggers and LEDs "usually" do, and has
all the flexibility.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

commit e7d6d170f2f45ea7a42c9ebb31869f440382e3ad

    leds: ledtrig-sound: provide indication of muted microphone
   =20
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 9bcb64e..c5ea19e 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+=3D ledtrig-camera.o
 obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+=3D ledtrig-panic.o
 obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+=3D ledtrig-netdev.o
 obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+=3D ledtrig-pattern.o
+obj-y					+=3D ledtrig-sound.o
diff --git a/drivers/leds/trigger/ledtrig-sound.c b/drivers/leds/trigger/le=
dtrig-sound.c
new file mode 100644
index 0000000..608df35
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-sound.c
@@ -0,0 +1,23 @@
+/* GPLv2+.
+ * Copyright 2018 Pavel Machek <pavel@ucw.cz>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+
+DEFINE_LED_TRIGGER(ledtrig_micmute);
+
+void ledtrig_mic_muted(bool muted)
+{
+	led_trigger_event(ledtrig_micmute, muted ? LED_FULL : LED_OFF);
+}
+EXPORT_SYMBOL(ledtrig_mic_muted);
+
+static int __init ledtrig_micmute_init(void)
+{
+	led_trigger_register_simple("mic-muted", &ledtrig_micmute);
+
+	return 0;
+}
+device_initcall(ledtrig_micmute_init);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index e4a9a00..c30e1cb 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -494,6 +494,14 @@ static inline void ledtrig_cpu(enum cpu_led_event evt)
 }
 #endif
=20
+#ifdef CONFIG_LEDS_TRIGGERS
+extern void ledtrig_mic_muted(bool m);
+#else
+static inline void ledtrig_mic_muted(bool m) {}
+#endif
+
+
+
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
 extern void led_classdev_notify_brightness_hw_changed(
 	struct led_classdev *led_cdev, enum led_brightness brightness);
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 276150f..3ec1f61 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/leds.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/tlv.h>
@@ -3929,6 +3930,7 @@ static void call_micmute_led_update(struct hda_codec =
*codec)
 		val =3D !spec->micmute_led.capture;
 		break;
 	}
+	ledtrig_mic_muted(!spec->micmute_led.capture);
=20
 	if (val =3D=3D spec->micmute_led.led_value)
 		return;
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helpe=
r.c
index 568575b..f1b2265 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -23,6 +23,8 @@ static void update_tpacpi_mute_led(void *private_data, in=
t enabled)
 	if (old_vmaster_hook)
 		old_vmaster_hook(private_data, enabled);
=20
+	printk("mute led... %d\n", !enabled);
+
 	if (led_set_func)
 		led_set_func(TPACPI_LED_MUTE, !enabled);
 }


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv4jjUACgkQMOfwapXb+vJAGgCeMG4/q2ENCFEKzXy0t38q3MXG
SXEAoJ1ul32RBQTk3ftSyS1sCDHRevmK
=xYkY
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
