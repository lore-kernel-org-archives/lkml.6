Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4995FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfAJRmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:58401 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbfAJRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2EDD91002E6;
        Thu, 10 Jan 2019 18:42:26 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IsD_WR98FtqE; Thu, 10 Jan 2019 18:42:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D96091002F0;
        Thu, 10 Jan 2019 18:42:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pjagQpml1qh3; Thu, 10 Jan 2019 18:42:04 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 114A81002EF;
        Thu, 10 Jan 2019 18:42:04 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v5 7/7] power: supply: olpc_battery: Add OLPC XO 1.75 support
Date:   Thu, 10 Jan 2019 18:40:05 +0100
Message-Id: <20190110174005.1202564-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110174005.1202564-1-lkundrak@v3.sk>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
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

 drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index a6c89d002d5d..52de90049980 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -57,6 +57,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
 	int new_proto;
+	int little_endian;
 };
=20
 /*********************************************************************
@@ -322,6 +323,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
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
@@ -394,7 +403,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
@@ -402,7 +411,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
@@ -433,21 +442,21 @@ static int olpc_bat_get_property(struct power_suppl=
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
@@ -621,7 +630,11 @@ static int olpc_battery_probe(struct platform_device=
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

