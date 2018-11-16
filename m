Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82315C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA120858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbeKQCi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:38:26 -0500
Received: from shell.v3.sk ([90.176.6.54]:57160 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390306AbeKQCiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:38:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 876C052FB0;
        Fri, 16 Nov 2018 17:25:19 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PwbUUI4kReoR; Fri, 16 Nov 2018 17:24:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0B81552A9A;
        Fri, 16 Nov 2018 17:24:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 33Ms218LSzzE; Fri, 16 Nov 2018 17:24:27 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4485F530C9;
        Fri, 16 Nov 2018 17:24:20 +0100 (CET)
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
Subject: [PATCH v2 16/17] power: supply: olpc_battery: Avoid using platform_info
Date:   Fri, 16 Nov 2018 17:24:02 +0100
Message-Id: <20181116162403.49854-17-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wouldn't work on the DT-based ARM platform. Let's read the EC versio=
n
directly from the EC driver instead.

This makes the driver no longer x86 specific.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/Kconfig        |  2 +-
 drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f27cf0709500..dd7ae1431098 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -151,7 +151,7 @@ config BATTERY_PMU
=20
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
+	depends on OLPC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
=20
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 4433eb10a23d..ec5dfb8fcb8a 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -20,8 +20,6 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
-
=20
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
 #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
@@ -57,6 +55,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	int new_proto;
 };
=20
 /*********************************************************************
@@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,14 +607,32 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 	struct power_supply_config psy_cfg =3D {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
+	int ret;
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
+
+	/* See if the EC is already there and get the EC revision */
+	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
+	if (ret) {
+		if (ret =3D=3D -ENODEV)
+			return -EPROBE_DEFER;
+		return ret;
+	}
=20
-	/*
-	 * We've seen a number of EC protocol changes; this driver requires
-	 * the latest EC protocol, supported by 0x44 and above.
-	 */
-	if (olpc_platform_info.ecver < 0x44) {
+	if (ecver > 0x44) {
+		/* XO 1 or 1.5 with a new EC firmware. */
+		data->new_proto =3D 1;
+	} else if (ecver < 0x44) {
+		/*
+		 * We've seen a number of EC protocol changes; this driver
+		 * requires the latest EC protocol, supported by 0x44 and above.
+		 */
 		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
-			"battery driver.\n", olpc_platform_info.ecver);
+			"battery driver.\n", ecver);
 		return -ENXIO;
 	}
=20
--=20
2.19.1

