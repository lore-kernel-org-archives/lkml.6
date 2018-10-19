Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83389ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347D321476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mehLK1Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJSRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:51:10 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:42256
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbeJSRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et5/mtTtSljg45gNnDoDZRx5x5K9v09nKbsXQODg8TI=;
 b=mehLK1EmRW48GMRCWVctoD2CW+v5qwCaIr9GL8YMMx/SaaYUnBN6CHT7VJY/exbXTRGdXxtUGxI7bjojk9eL4JtP0ZsW1tzjog9pC3+IzBC4JAw6GSl/4FUup0VUU1t6NMvGSulNdcpH72uQd24IGjittBPawLdgXgc5q4JjtQA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4092.eurprd04.prod.outlook.com (52.135.130.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Fri, 19 Oct 2018 09:45:44 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2%4]) with mapi id 15.20.1228.035; Fri, 19 Oct 2018
 09:45:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Topic: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Index: AQHUZ5CBGViPzGvSBkmCEccitD7z+w==
Date:   Fri, 19 Oct 2018 09:45:44 +0000
Message-ID: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0146.apcprd04.prod.outlook.com
 (2603:1096:3:16::30) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4092;6:4cffjAAQaU63cX1wDXPXL9YIExgQZg5ilHJan5QtDrUDtnh3pNQESStKUc59hvUiZzdLsnmsIykWpDQuH9OjjkLm9EjaHUBQMG9DdXSUgMf4h85P6YOl471IV6SITTkOjRykSbFMczbqJbhWNm9kTy0BeQYVnlaPhxM6FKg3yrlQcUxsQe/NlRT73gD+zV/tlHL7jLWXR3s0qglT7aybQTwuNRpqcmgMM2tioan4U0tXu+BqWLiFZ/79ztgJ0TaJ03Py1l8nI8YgKcmJvDsTwTscHzRJr3tNDU44nhyDvAg7CxmaFqMEKazJO43jIu0Qk5/v3kdrkMVrtZR+IagQ2L7CuuBK713ngeXCSFUTJEVvh9My7XyOMgP70+6qq3xBhfDFM9h+yd5jcDynwxnioGly1GQoKWd3fjfcJoRVTEMXa56rh6CuMBowZyPHuOEMKg0OuLdnqpYH/dIrQXAycg==;5:Y6lWAySwIGnfmrlqT2eCt9i30UHkHYjgLVqlbNg+gaGgA7kUFiQc0ohdmiqnrBSMX1qrlajs8peQeJnM+4Nb+vh1j/4L4sw5Mr0pWPPBDTjPvdCU+SnWkjxXgHhkCDfTpsQjkP3GTjHrkpybAl2cJbm8/uSbYV7H5ZM87Qassq0=;7:bTLr0rJIazfAK9T1uWF69hn/z5vsM09/Chcw2NhpDaLOWzWaV/rHOW+n6aR5ys7cNk7AXXQ0ZYZjCXTYi2Tr7Vo5xNdhbee0qwilcMgwMzUaKtociYq3hEX3/fvLA69iQKlM4DzEiXkZhgKUtcH/fuDZj9HLOF1eVedjIst/e6MBMrkUUIGkRB2FiP94dpONgKEXgTWH9swwHduOd035kAXYsUsUBsg9bz7CNtr7vNBxZpn3l5djz2U4A7eVaFFk
x-ms-office365-filtering-correlation-id: e294f96d-cc42-4bd8-4223-08d635a7a37d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4092;
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-microsoft-antispam-prvs: <DB7PR04MB409231BDFEEAC6207C1DC1B3E6F90@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4092;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4092;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(23433003)(81166006)(105586002)(81156014)(26005)(102836004)(54906003)(2616005)(316002)(66066001)(4326008)(110136005)(8676002)(6436002)(3846002)(52116002)(8936002)(186003)(6116002)(1076002)(68736007)(386003)(6486002)(50226002)(2900100001)(53936002)(25786009)(6506007)(99286004)(6512007)(5250100002)(5024004)(86362001)(14444005)(1857600001)(305945005)(478600001)(486006)(71200400001)(2906002)(71190400001)(2201001)(7736002)(2501003)(36756003)(256004)(14454004)(5660300001)(476003)(106356001)(97736004)(334744003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4092;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e8p36HZyUgVgtlFWi7NjxI3lIFUbvv2OlEwK6oS+RyaZexw7g7J9l5QfExP57ez2n+VhkJLYdq8CWuP8MFQEy4SPfhplOAendGNWORIJQKcUzkEYClrjvThjASfpT8A24t9vS/lIp5n6dA6R9CC59vrEpNMyUOjk6PQFaX4jhHGDwdnyVnb7gU5bLGTIsQ5TRb1FPFF3bGglcSqOfL3LEq1rvGGH5jvmBkQKB0Qgnz8rk/EbsxEQC2zrWsplc7gy7pBRvQd51Vsr6aIE/LNt595pqcen/yGhYbAedpELplvbuqDJ2q0BCs9loOrRTZwEF8WPRb8s8zUxD9T4y5570H/0OOnHq5vuxEXOUHStg58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e294f96d-cc42-4bd8-4223-08d635a7a37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 09:45:44.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Flexcan will be disabled during suspend if no wakeup function required
and enabled after resume accordingly. During this period, we could
explicitly disable clocks.

Implement Runtime PM which will:
1) Keep device in suspend state (clocks disabled) if it's not openned
2) Make Power Domain framework be able to shutdown the corresponding power
domain of this device.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 125 +++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 43 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 8e972ef08637..3813f6708201 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
=20
 #define DRV_NAME			"flexcan"
@@ -266,6 +267,7 @@ struct flexcan_priv {
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
=20
+	struct device *dev;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
@@ -369,6 +371,27 @@ static inline void flexcan_error_irq_disable(const str=
uct flexcan_priv *priv)
 	priv->write(reg_ctrl, &regs->ctrl);
 }
=20
+static int flexcan_clks_enable(const struct flexcan_priv *priv)
+{
+	int err;
+
+	err =3D clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err =3D clk_prepare_enable(priv->clk_per);
+	if (err)
+		clk_disable_unprepare(priv->clk_ipg);
+
+	return err;
+}
+
+static void flexcan_clks_disable(const struct flexcan_priv *priv)
+{
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
+}
+
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *pr=
iv)
 {
 	if (!priv->reg_xceiver)
@@ -495,19 +518,11 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
-		return err;
-
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
+	pm_runtime_get_sync(priv->dev);
=20
 	err =3D __flexcan_get_berr_counter(dev, bec);
=20
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1096,17 +1111,13 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
+	err =3D pm_runtime_get_sync(priv->dev);
 	if (err)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	err =3D open_candev(dev);
 	if (err)
-		goto out_disable_per;
+		goto out_pm_runtime;
=20
 	err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
 	if (err)
@@ -1128,10 +1139,8 @@ static int flexcan_open(struct net_device *dev)
 	free_irq(dev->irq, dev);
  out_close:
 	close_candev(dev);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+ out_pm_runtime:
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1145,11 +1154,11 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
=20
 	free_irq(dev->irq, dev);
-	clk_disable_unprepare(priv->clk_per);
-	clk_disable_unprepare(priv->clk_ipg);
=20
 	close_candev(dev);
=20
+	pm_runtime_put(priv->dev);
+
 	can_led_event(dev, CAN_LED_EVENT_STOP);
=20
 	return 0;
@@ -1188,18 +1197,10 @@ static int register_flexcandev(struct net_device *d=
ev)
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg, err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
-		return err;
-
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	/* select "bus clock", chip must be disabled */
 	err =3D flexcan_chip_disable(priv);
 	if (err)
-		goto out_disable_per;
+		return err;
 	reg =3D priv->read(&regs->ctrl);
 	reg |=3D FLEXCAN_CTRL_CLK_SRC;
 	priv->write(reg, &regs->ctrl);
@@ -1228,13 +1229,8 @@ static int register_flexcandev(struct net_device *de=
v)
=20
 	err =3D register_candev(dev);
=20
-	/* disable core and turn off clocks */
  out_chip_disable:
 	flexcan_chip_disable(priv);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
=20
 	return err;
 }
@@ -1342,6 +1338,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->dev =3D &pdev->dev;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
@@ -1388,22 +1385,35 @@ static int flexcan_probe(struct platform_device *pd=
ev)
 	if (err)
 		goto failed_offload;
=20
+	pm_runtime_enable(&pdev->dev);
+	err =3D pm_runtime_get_sync(&pdev->dev);
+	if (err < 0) {
+		dev_err(&pdev->dev, "pm_runtime_get failed(%d)\n", err);
+		goto failed_rpm_disable;
+	}
+
 	err =3D register_flexcandev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
-		goto failed_register;
+		goto failed_rpm_put;
 	}
=20
 	devm_can_led_init(dev);
=20
+	pm_runtime_put(&pdev->dev);
+
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
 	return 0;
=20
+ failed_rpm_put:
+	pm_runtime_put(&pdev->dev);
+ failed_rpm_disable:
+	pm_runtime_disable(&pdev->dev);
  failed_offload:
- failed_register:
 	free_candev(dev);
+
 	return err;
 }
=20
@@ -1413,6 +1423,7 @@ static int flexcan_remove(struct platform_device *pde=
v)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
=20
 	unregister_flexcandev(dev);
+	pm_runtime_disable(&pdev->dev);
 	can_rx_offload_del(&priv->offload);
 	free_candev(dev);
=20
@@ -1423,38 +1434,66 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	if (netif_running(dev)) {
 		err =3D flexcan_chip_disable(priv);
 		if (err)
 			return err;
+		err =3D pm_runtime_force_suspend(device);
+
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
 	priv->can.state =3D CAN_STATE_SLEEPING;
=20
-	return 0;
+	return err;
 }
=20
 static int __maybe_unused flexcan_resume(struct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
-		err =3D flexcan_chip_enable(priv);
+
+		err =3D pm_runtime_force_resume(device);
 		if (err)
 			return err;
+		err =3D flexcan_chip_enable(priv);
 	}
+	return err;
+}
+
+static int __maybe_unused flexcan_runtime_suspend(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	flexcan_clks_disable(priv);
+
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resume);
+static int __maybe_unused flexcan_runtime_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	flexcan_clks_enable(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops flexcan_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
+	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume,
+						NULL)
+};
=20
 static struct platform_driver flexcan_driver =3D {
 	.driver =3D {
--=20
2.17.1

