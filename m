Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5372086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5372086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJKArG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:47:06 -0400
Received: from shell.v3.sk ([90.176.6.54]:54714 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbeJKArF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AF300AE23F;
        Wed, 10 Oct 2018 19:23:54 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vbNj-pXjtM_Q; Wed, 10 Oct 2018 19:23:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D4420BCFAD;
        Wed, 10 Oct 2018 19:23:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UKlJIzD9Q5Vy; Wed, 10 Oct 2018 19:23:16 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 90E96BCFBE;
        Wed, 10 Oct 2018 19:23:10 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
Date:   Wed, 10 Oct 2018 19:23:00 +0200
Message-Id: <20181010172300.317643-16-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The battery and the protocol are essentially the same as OLPC XO 1.5,
but the responses from the EC are LSB first.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index dde9863e5c4a..2adf33b9f641 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -56,6 +56,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
 	int new_proto;
+	int little_endian;
 };
=20
 /*********************************************************************
@@ -321,6 +322,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
er_supply_propval *val)
 	return ret;
 }
=20
+static s16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_byte)
+{
+	if (data->little_endian)
+		return le16_to_cpu(ec_byte);
+	else
+		return be16_to_cpu(ec_byte);
+}
+
 /*********************************************************************
  *		Battery properties
  *********************************************************************/
@@ -393,7 +402,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
@@ -401,7 +410,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
@@ -432,21 +441,21 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
+		val->intval =3D (int)ecword_to_cpu(data, ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 6250 / 15;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 6250 / 15;
 		break;
 	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret =3D olpc_ec_cmd(EC_BAT_SERIAL, NULL, 0, (void *)&ser_buf, 8);
@@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
 	if (ecver[0] > 0x44) {
 		/* XO 1 or 1.5 with a new EC firmware. */
 		data->new_proto =3D 1;
+	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+		/* XO 1.75 */
+		data->new_proto =3D 1;
+		data->little_endian =3D 1;
 	} else if (ecver[0] < 0x44) {
 		/*
 		 * We've seen a number of EC protocol changes; this driver
--=20
2.19.0

