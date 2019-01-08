Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D435206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfAHR7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:59:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:49974 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfAHR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:59:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5F50810004D;
        Tue,  8 Jan 2019 18:59:09 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DmRxrrDkJ9k9; Tue,  8 Jan 2019 18:58:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1EC1C100055;
        Tue,  8 Jan 2019 18:58:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sHoPwIEEqCg7; Tue,  8 Jan 2019 18:58:31 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7EB6D100061;
        Tue,  8 Jan 2019 18:58:27 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
Date:   Tue,  8 Jan 2019 18:58:18 +0100
Message-Id: <20190108175818.705110-16-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The battery and the protocol are essentially the same as OLPC XO 1.5,
but the responses from the EC are LSB first.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Fix the version conditional

Changes since v1:
- s/s16 ecword_to_cpu/u16 ecword_to_cpu/
- s/u16 ec_byte/u16 ec_word/

 drivers/power/supply/Kconfig        |  2 +-
 drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 67a3bb26da39..66e4d1958de3 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -151,7 +151,7 @@ config BATTERY_PMU
=20
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
-	depends on OLPC
+	depends on OLPC_EC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
=20
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 8ebb4284cf05..e32c1e457026 100644
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
+static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
+{
+	if (data->little_endian)
+		return le16_to_cpu(ec_word);
+	else
+		return be16_to_cpu(ec_word);
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
@@ -620,7 +629,11 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
 	if (ret)
 		return ret;
=20
-	if (ecver > 0x44) {
+	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+		/* XO 1.75 */
+		data->new_proto =3D 1;
+		data->little_endian =3D 1;
+	} else if (ecver > 0x44) {
 		/* XO 1 or 1.5 with a new EC firmware. */
 		data->new_proto =3D 1;
 	} else if (ecver < 0x44) {
--=20
2.20.1

