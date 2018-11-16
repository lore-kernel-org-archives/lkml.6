Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F96C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470DD20858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470DD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390319AbeKQCiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:38:15 -0500
Received: from shell.v3.sk ([90.176.6.54]:57131 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390279AbeKQCiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:38:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8EEEB52BCA;
        Fri, 16 Nov 2018 17:25:09 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MT5pcP-7ImJU; Fri, 16 Nov 2018 17:24:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1E65752C9A;
        Fri, 16 Nov 2018 17:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QC0bbS4oxfgI; Fri, 16 Nov 2018 17:24:24 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 158FB52FB0;
        Fri, 16 Nov 2018 17:24:19 +0100 (CET)
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
Subject: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get battery version
Date:   Fri, 16 Nov 2018 17:23:59 +0100
Message-Id: <20181116162403.49854-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using the x86 OLPC platform specific call to get the board
version. It won't work on FDT-based ARM MMP2 platform.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Sort the new include a bit higher

 drivers/power/supply/olpc_battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 5a97e42a3547..5323987d9284 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/jiffies.h>
@@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
 	if (IS_ERR(olpc_ac))
 		return PTR_ERR(olpc_ac);
-
-	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
+	if (of_property_match_string(pdev->dev.of_node, "compatible",
+					"olpc,xo1.5-battery") >=3D 0) {
+		/* XO-1.5 */
 		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo15_bat_props);
-	} else { /* XO-1 */
+	} else {
+		/* XO-1 */
 		olpc_bat_desc.properties =3D olpc_xo1_bat_props;
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
@@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
=20
 static const struct of_device_id olpc_battery_ids[] =3D {
 	{ .compatible =3D "olpc,xo1-battery" },
+	{ .compatible =3D "olpc,xo1.5-battery" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, olpc_battery_ids);
--=20
2.19.1

