Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDCWLR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:11:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46482 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeDCWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:11:15 -0400
Date: Wed, 4 Apr 2018 00:11:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Message-ID: <20180403221113.GA9463@amd>
References: <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com>
 <20180331191939.GA8999@amd>
 <20180331194616.GA19388@amd>
 <20180331195524.GB19388@amd>
 <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd>
 <20180401153631.GA5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20180401153631.GA5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > If you had a register dump from android with mics working, preferably
> > not in speaker mode, perhaps I could try to figure it out?
>=20
> OK here are four diffs against starting the phone app for regular
> call, speaker call, and muted versions of them:
>=20
> http://muru.com/linux/d4/cpcap/
>=20
> Also, I'm connected over cdma right now, not 3g, but I doubt
> that makes a difference for the microphone.

Thanks!

When I apply register settings directly, I indeed get working "normal"
call working. Good. Diff for illustration is below. Clearly needs some
improvements.

And it shows that alsa mixers are expected to be simple and obvious on
D4 -- they just do not work.

Current version of phone gui is at
 https://github.com/pavelmachek/unicsy_demo

- ofono interface should be usable
- AT commands need a lot more work, and they'll probably never work
nicely in this design. They are just a temporary hack.

(ouch, and it should be rewritten, in Vala or better Rust...)
									Pavel

commit 06acc26c318558ed6a50b5a22afffeb9abbe7553
Author: Pavel <pavel@ucw.cz>
Date:   Wed Apr 4 00:04:34 2018 +0200

    Add support for "normal" (not handsfree) call.

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 7aaa4db..59c02b7 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -331,7 +331,7 @@ static const char * const cpcap_in_left_mux_texts[] =3D=
 {
 };
=20
 static const char * const cpcap_mode_texts[] =3D {
-	"Normal", "Call"
+	"Normal", "Handsfree", "Call",
 };
=20
=20
@@ -464,25 +464,11 @@ static int cpcap_mode_get_enum(struct snd_kcontrol *k=
control,
 	return 0;
 }
=20
-static int cpcap_mode_put_enum(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+static int enable_call(struct cpcap_audio *cpcap, int on)
 {
-	struct snd_soc_codec *codec =3D snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap =3D snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm =3D
-		snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned int muxval =3D ucontrol->value.enumerated.item[0];
-	unsigned int mask =3D BIT(e->shift_l);
 	int err;
-
-	printk("Requested mode %d\n", muxval);
-
-	mode =3D muxval;
-
-	switch (muxval) {
-	case 1:
-
+	unsigned long mask;
+=09
 		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
 					 0xffff, 0x0025);	// OK
 		if (err)
@@ -516,6 +502,56 @@ static int cpcap_mode_put_enum(struct snd_kcontrol *kc=
ontrol,
 				   0x0400, 0x0400);
 		if (err)
 			printk("error #1\n");
+
+		return 0;
+out:
+		printk("Error!\n");
+		return -EIO;
+}
+
+static int cpcap_mode_put_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =3D snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct cpcap_audio *cpcap =3D snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm =3D
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
+	unsigned int muxval =3D ucontrol->value.enumerated.item[0];
+	unsigned int mask =3D BIT(e->shift_l);
+	int err;
+
+	printk("Requested mode %d\n", muxval);
+
+	mode =3D muxval;
+
+	switch (muxval) {
+	case 1:
+		enable_call(cpcap, 1);
+		break;
+	case 2:
+		enable_call(cpcap, 1);
+
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+					 0xffff, 0x0cc6);
+		if (err)
+			goto out;
+
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXMP,
+					 0xffff, 0x0673);
+		if (err)
+			goto out;
+
+
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
+					 0xffff, 0x0001);
+		if (err)
+			goto out;
+	=09
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
+					 0xffff, 0x0601);
+		if (err)
+			goto out;
 	=09
 	default:
 		break;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrD/AEACgkQMOfwapXb+vKvAQCeK77gxTe+RBIJ3N/CjjJ3OWAN
oMYAoIonr0IkrxqyFhQ9wu4KmOi9ob7o
=1m4h
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
