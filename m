Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0762086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0762086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeH2N1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:27:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59751 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2N1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:27:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 466CD803CC; Wed, 29 Aug 2018 11:31:05 +0200 (CEST)
Date:   Wed, 29 Aug 2018 11:31:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        lee.jones@linaro.org
Subject: [PATCH] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180829093104.GA22065@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Sebastian Reichel <sre@kernel.org>
   =20
Add support for the audio-codec node by converting from
devm_of_platform_populate() to devm_mfd_add_devices().
  =20
Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 5276911..20d9692 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
=20
+#include <linux/mfd/core.h>
 #include <linux/mfd/motorola-cpcap.h>
 #include <linux/spi/spi.h>
=20
@@ -216,6 +217,53 @@ static const struct regmap_config cpcap_regmap_config =
=3D {
 	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
 };
=20
+static const struct mfd_cell cpcap_mfd_devices[] =3D {
+	{
+		.name          =3D "cpcap_adc",
+		.of_compatible =3D "motorola,mapphone-cpcap-adc",
+	}, {
+		.name          =3D "cpcap_battery",
+		.of_compatible =3D "motorola,cpcap-battery",
+	}, {
+		.name          =3D "cpcap-charger",
+		.of_compatible =3D "motorola,mapphone-cpcap-charger",
+	}, {
+		.name          =3D "cpcap-regulator",
+		.of_compatible =3D "motorola,mapphone-cpcap-regulator",
+	}, {
+		.name          =3D "cpcap-rtc",
+		.of_compatible =3D "motorola,cpcap-rtc",
+	}, {
+		.name          =3D "cpcap-pwrbutton",
+		.of_compatible =3D "motorola,cpcap-pwrbutton",
+	}, {
+		.name          =3D "cpcap-usb-phy",
+		.of_compatible =3D "motorola,mapphone-cpcap-usb-phy",
+	}, {
+		.name          =3D "cpcap-led",
+		.id            =3D 0,
+		.of_compatible =3D "motorola,cpcap-led-red",
+	}, {
+		.name          =3D "cpcap-led",
+		.id            =3D 1,
+		.of_compatible =3D "motorola,cpcap-led-green",
+	}, {
+		.name          =3D "cpcap-led",
+		.id            =3D 2,
+		.of_compatible =3D "motorola,cpcap-led-blue",
+	}, {
+		.name          =3D "cpcap-led",
+		.id            =3D 3,
+		.of_compatible =3D "motorola,cpcap-led-adl",
+	}, {
+		.name          =3D "cpcap-led",
+		.id            =3D 4,
+		.of_compatible =3D "motorola,cpcap-led-cp",
+	}, {
+		.name          =3D "cpcap-codec",
+	}
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	const struct of_device_id *match;
@@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	return devm_of_platform_populate(&cpcap->spi->dev);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
+				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
 }
=20
 static struct spi_driver cpcap_driver =3D {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluGZ9gACgkQMOfwapXb+vKiNwCeLKzTh3gLXV5XlGB6ldV0+8Yw
hxYAoKf6f4J4Dheg2ZRYexoOoMV9fmgw
=OsPN
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
