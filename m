Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD00206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfAHR7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:59:48 -0500
Received: from shell.v3.sk ([90.176.6.54]:49974 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbfAHR7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:59:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E597100054;
        Tue,  8 Jan 2019 18:59:02 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P-TEw3pTDBCz; Tue,  8 Jan 2019 18:58:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A8B8E10004D;
        Tue,  8 Jan 2019 18:58:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CbEBF0mmHepZ; Tue,  8 Jan 2019 18:58:29 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4A5CFFFF78;
        Tue,  8 Jan 2019 18:58:26 +0100 (CET)
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
        Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 12/15] power: supply: olpc_battery: Move priv data to a struct
Date:   Tue,  8 Jan 2019 18:58:15 +0100
Message-Id: <20190108175818.705110-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variables for private data are not too nice. I'd like some
more, and that would clutter the global name space even further.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes since v2:
- Bring the allocaton of the priv data structure here

Changes since v1:
- Split out the move to devm_* into a separate patch

 drivers/power/supply/olpc_battery.c | 73 ++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 5323987d9284..c024aae01cb1 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -53,6 +53,12 @@
=20
 #define BAT_ADDR_MFR_TYPE	0x5F
=20
+struct olpc_battery_data {
+	struct power_supply *olpc_ac;
+	struct power_supply *olpc_bat;
+	char bat_serial[17];
+};
+
 /*********************************************************************
  *		Power
  *********************************************************************/
@@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
 	.get_property =3D olpc_ac_get_prop,
 };
=20
-static struct power_supply *olpc_ac;
-
-static char bat_serial[17]; /* Ick */
-
-static int olpc_bat_get_status(union power_supply_propval *val, uint8_t =
ec_byte)
+static int olpc_bat_get_status(struct olpc_battery_data *data,
+		union power_supply_propval *val, uint8_t ec_byte)
 {
 	if (olpc_platform_info.ecver > 0x44) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
@@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 				 enum power_supply_property psp,
 				 union power_supply_propval *val)
 {
+	struct olpc_battery_data *data =3D power_supply_get_drvdata(psy);
 	int ret =3D 0;
 	__be16 ec_word;
 	uint8_t ec_byte;
@@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
=20
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret =3D olpc_bat_get_status(val, ec_byte);
+		ret =3D olpc_bat_get_status(data, val, ec_byte);
 		if (ret)
 			return ret;
 		break;
@@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
-		val->strval =3D bat_serial;
+		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
+		val->strval =3D data->bat_serial;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		ret =3D olpc_bat_get_voltage_max_design(val);
@@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc =3D {
 	.use_for_apm =3D 1,
 };
=20
-static struct power_supply *olpc_bat;
-
 static int olpc_battery_suspend(struct platform_device *pdev,
 				pm_message_t state)
 {
-	if (device_may_wakeup(&olpc_ac->dev))
+	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&data->olpc_ac->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
 	else
 		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
=20
-	if (device_may_wakeup(&olpc_bat->dev))
+	if (device_may_wakeup(&data->olpc_bat->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
 				   | EC_SCI_SRC_BATERR);
 	else
@@ -601,9 +605,15 @@ static int olpc_battery_suspend(struct platform_devi=
ce *pdev,
=20
 static int olpc_battery_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct power_supply_config psy_cfg =3D {};
+	struct olpc_battery_data *data;
 	uint8_t status;
=20
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
+
 	/*
 	 * We've seen a number of EC protocol changes; this driver requires
 	 * the latest EC protocol, supported by 0x44 and above.
@@ -620,9 +630,13 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
=20
 	/* Ignore the status. It doesn't actually matter */
=20
-	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
-	if (IS_ERR(olpc_ac))
-		return PTR_ERR(olpc_ac);
+	psy_cfg.of_node =3D pdev->dev.of_node;
+	psy_cfg.drv_data =3D data;
+
+	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
+	if (IS_ERR(data->olpc_ac))
+		return PTR_ERR(data->olpc_ac);
+
 	if (of_property_match_string(pdev->dev.of_node, "compatible",
 					"olpc,xo1.5-battery") >=3D 0) {
 		/* XO-1.5 */
@@ -634,42 +648,45 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
=20
-	olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
+	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
 	if (IS_ERR(olpc_bat)) {
 		ret =3D PTR_ERR(olpc_bat);
 		goto battery_failed;
 	}
=20
-	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
 		goto eeprom_failed;
=20
-	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
+	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
 		goto error_failed;
=20
 	if (olpc_ec_wakeup_available()) {
-		device_set_wakeup_capable(&olpc_ac->dev, true);
-		device_set_wakeup_capable(&olpc_bat->dev, true);
+		device_set_wakeup_capable(&data->olpc_ac->dev, true);
+		device_set_wakeup_capable(&data->olpc_bat->dev, true);
 	}
=20
 	return 0;
=20
 error_failed:
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 eeprom_failed:
-	power_supply_unregister(olpc_bat);
+	power_supply_unregister(data->olpc_bat);
 battery_failed:
-	power_supply_unregister(olpc_ac);
+	power_supply_unregister(data->olpc_ac);
 	return ret;
 }
=20
 static int olpc_battery_remove(struct platform_device *pdev)
 {
-	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(olpc_bat);
-	power_supply_unregister(olpc_ac);
+	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
+
+	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
+	power_supply_unregister(data->olpc_bat);
+	power_supply_unregister(data->olpc_ac);
+
 	return 0;
 }
=20
--=20
2.20.1

