Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24853C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CCD21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CdQIl4Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CCD21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeK0Sov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:44:51 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:37392
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbeK0Sov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwqeMA8Fen56K8PasU3MUFi31z8sq71wAt4C3JYLc10=;
 b=CdQIl4UpDzOBaZLjtrot4c8xnyuD11BMFkGvDcrlPKoDchD/OreA92C/HZ8rfRFLaZyzNg2ESWJ3FjbzA14haVrimZ/XntHRZxbHV4J3Ib6nzrqoa8QcW8z1DeXE0QhLDuqe6xizpRumm7RUCMikHY6uhvjkb7Wm77XfZLD6JS0=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4092.eurprd04.prod.outlook.com (52.135.130.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 07:47:41 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 07:47:41 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2] can: flexcan: implement can Runtime PM
Thread-Topic: [PATCH V2] can: flexcan: implement can Runtime PM
Thread-Index: AQHUhiV5wk1xGdhjHE6M0UxVs0fcKA==
Date:   Tue, 27 Nov 2018 07:47:41 +0000
Message-ID: <20181127074524.17919-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0601CA0016.apcprd06.prod.outlook.com (2603:1096:3::26)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4092;6:t6H0c02lpKHH7Yt4QEVCSM2vmQQGQglDc8/CszzjfdCMHS2cKQ/v/LycWFbPmyEDo1EWIPWgI7qk3Asanxz2BZlZuja37r0YgHCV3qfxUbVXeDamK+/cOMwXe+Mis8KyNFXuEBVvnC41bEYa05zmzFJkHK/VWzDe+iBKYpK/VTYKgjSr9FzTUxKKL39VKOLp2ozm7bhlQsGrPN+bEuy0I6ia/Ei2laZVX8K01MrFBdhlMKGWFsAZhPr/GHgn4BbEI/C1eNDO9Qf7Htkh2QM6lypNqjc5bGBvtKHu/fxHm3WWfiDKpYuuFHBx/Nun6m103aj7XGwtBTmslytAH1WyxSc5e1mZ72Yx+hFZ5KyWl/biLxqy7KkyioCHo3YY6fh0LaqK6TKmRZWujBlMdi+JiNJHG3f4fa7WZqzvt7LFI6CS609lTb9CEKAwtQVOwK1vRhqjSgMsC/331WElOVQckg==;5:/B7b+LSfBETu7G68eieaBZxG0oAqdwzBTIFWXe7E+ywirlXf9f7K7A2fBIbDf/y3DgizLuTFoXgmhDNeAnVn1HOGIwZ90wJ5jIS7SI7KXTHRNaiUZuMnxYEHMArL8K0uQ6wv3fNcqAvsVcsXuctPJ+cxmdwfSrvhbmyg8Nb3u14=;7:9jj7CBp9ooAaoJUjKrhXE6CKgCr+Lk2pdtFTp5rb2e/ZWssG7t0dKMzInqsvCP9uKi/uYqkIf5t7lWzjU02qwebJJ4aD3YX9p+T1qW3cgams9B8i9EO57jGXZDjHEHpDMtLUxmL2pasrVUi+SyTUNQ==
x-ms-office365-filtering-correlation-id: 9ab84cb7-e19d-4d7c-64e4-08d6543c9beb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4092;
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-microsoft-antispam-prvs: <DB7PR04MB4092008D068AB5C79DCE929FE6D00@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4092;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4092;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(23433003)(54534003)(478600001)(4326008)(50226002)(3846002)(6116002)(99286004)(97736004)(71190400001)(71200400001)(2501003)(1076002)(316002)(6512007)(53936002)(25786009)(6486002)(6436002)(110136005)(54906003)(106356001)(52116002)(386003)(105586002)(6506007)(68736007)(36756003)(8676002)(256004)(14444005)(2616005)(102836004)(2906002)(14454004)(305945005)(186003)(476003)(7736002)(5660300001)(86362001)(26005)(486006)(66066001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4092;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CvgnJo1FHtTmVHHMuG7bWy+mEGc3e5amRSWzEcRTor0uLjoaECAUPXZGYBLFXUBnaC3ndraL9q7M23bQTzRl/gjnACcHTPh3nwDXMJ6bZobpowS3X4FfhvC19mBixAsPssh+nNGcyNiJU4uP0ZMD9x/3O+WBS1Lw9eX/E2OH5aud1wEeOducNWJl2AMRw+Aq8c/79Za5AypsMZ57womX1aDd0D32biQS3dI/+L8ItofWNb1d3nnkRnfHAfwNMlUTvGdVEK1MmBnGHft2RuJrHufy0y7bQX3pTsZNgX3EOSXbi9hbTmMiVXGT9GxrcIUf/OcECS9S+bXR7XLLjXPypk5U0CRQFXGNzh4qPqfy0pA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab84cb7-e19d-4d7c-64e4-08d6543c9beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 07:47:41.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Flexcan will be disabled during suspend if no wakeup function required and
enabled after resume accordingly. During this period, we could explicitly
disable clocks.

Implement Runtime PM which will:
1) Keep device in suspend state (clocks disabled) if it's not openned.
2) Make Power Domain framework be able to shutdown the corresponding power
   domain of this device.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*rebased on patch "can: flexcan: add self wakeup support".
	*add check when to do flexcan_clks_disable/enable() during
	 Runtime PM.
---
 drivers/net/can/flexcan.c | 119 ++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d12b2f7d2834..130a2cb04827 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
=20
@@ -277,6 +278,7 @@ struct flexcan_priv {
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
=20
+	struct device *dev;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
@@ -444,6 +446,27 @@ static inline void flexcan_error_irq_disable(const str=
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
@@ -570,19 +593,11 @@ static int flexcan_get_berr_counter(const struct net_=
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
@@ -1215,17 +1230,13 @@ static int flexcan_open(struct net_device *dev)
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
@@ -1288,10 +1299,8 @@ static int flexcan_open(struct net_device *dev)
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
@@ -1306,11 +1315,11 @@ static int flexcan_close(struct net_device *dev)
=20
 	can_rx_offload_del(&priv->offload);
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
@@ -1349,18 +1358,10 @@ static int register_flexcandev(struct net_device *d=
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
@@ -1389,13 +1390,8 @@ static int register_flexcandev(struct net_device *de=
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
@@ -1556,6 +1552,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->dev =3D &pdev->dev;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
@@ -1569,14 +1566,23 @@ static int flexcan_probe(struct platform_device *pd=
ev)
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
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
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
 		err =3D flexcan_setup_stop_mode(pdev);
 		if (err)
@@ -1588,8 +1594,11 @@ static int flexcan_probe(struct platform_device *pde=
v)
=20
 	return 0;
=20
- failed_register:
+ failed_rpm_put:
+	pm_runtime_put(&pdev->dev);
 	free_candev(dev);
+ failed_rpm_disable:
+	pm_runtime_disable(&pdev->dev);
 	return err;
 }
=20
@@ -1598,6 +1607,7 @@ static int flexcan_remove(struct platform_device *pde=
v)
 	struct net_device *dev =3D platform_get_drvdata(pdev);
=20
 	unregister_flexcandev(dev);
+	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
=20
 	return 0;
@@ -1607,7 +1617,7 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	if (netif_running(dev)) {
 		/* if wakeup is enabled, enter stop mode
@@ -1620,20 +1630,21 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 			err =3D flexcan_chip_disable(priv);
 			if (err)
 				return err;
+			err =3D pm_runtime_force_suspend(device);
 		}
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
@@ -1642,11 +1653,34 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 		if (device_may_wakeup(device)) {
 			disable_irq_wake(dev->irq);
 		} else {
-			err =3D flexcan_chip_enable(priv);
+			err =3D pm_runtime_force_resume(device);
 			if (err)
 				return err;
+			err =3D flexcan_chip_enable(priv);
 		}
 	}
+	return err;
+}
+
+static int __maybe_unused flexcan_runtime_suspend(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (netif_running(dev))
+		flexcan_clks_disable(priv);
+
+	return 0;
+}
+
+static int __maybe_unused flexcan_runtime_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (!netif_running(dev))
+		flexcan_clks_enable(priv);
+
 	return 0;
 }
=20
@@ -1676,6 +1710,7 @@ static int __maybe_unused flexcan_noirq_resume(struct=
 device *device)
=20
 static const struct dev_pm_ops flexcan_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
+	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_resume=
)
 };
=20
--=20
2.17.1

