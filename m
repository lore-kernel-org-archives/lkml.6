Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B14DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140CB2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfAGSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:36:28 -0500
Received: from shell.v3.sk ([90.176.6.54]:44590 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfAGSfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:35:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87FA8FFD8D;
        Mon,  7 Jan 2019 19:35:41 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R5Ic5nGpn4Qc; Mon,  7 Jan 2019 19:35:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EA5A9FFD9F;
        Mon,  7 Jan 2019 19:34:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lqq6xmiEv_MM; Mon,  7 Jan 2019 19:34:51 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 567B0FFD8C;
        Mon,  7 Jan 2019 19:34:48 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 14/16] power: supply: olpc_battery: Use devm_power_supply_register()
Date:   Mon,  7 Jan 2019 19:34:37 +0100
Message-Id: <20190107183439.50626-15-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v1:
- This was split off the "power: supply: olpc_battery: Move priv data to
  a struct" patch.

 drivers/power/supply/olpc_battery.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index c024aae01cb1..0c9f7ce6b26b 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -633,7 +633,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
 	psy_cfg.of_node =3D pdev->dev.of_node;
 	psy_cfg.drv_data =3D data;
=20
-	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
+	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
 	if (IS_ERR(data->olpc_ac))
 		return PTR_ERR(data->olpc_ac);
=20
@@ -648,15 +648,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
=20
-	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
-	if (IS_ERR(olpc_bat)) {
-		ret =3D PTR_ERR(olpc_bat);
-		goto battery_failed;
-	}
+	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
+	if (IS_ERR(data->olpc_bat))
+		return PTR_ERR(data->olpc_bat);
=20
 	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
-		goto eeprom_failed;
+		return ret;
=20
 	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
@@ -671,10 +669,6 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
=20
 error_failed:
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-eeprom_failed:
-	power_supply_unregister(data->olpc_bat);
-battery_failed:
-	power_supply_unregister(data->olpc_ac);
 	return ret;
 }
=20
@@ -684,9 +678,6 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
=20
 	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(data->olpc_bat);
-	power_supply_unregister(data->olpc_ac);
-
 	return 0;
 }
=20
--=20
2.20.1

