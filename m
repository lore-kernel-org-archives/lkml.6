Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A73BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885C420834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tEiV6iiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885C420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeK2TNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:13:06 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:21760
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbeK2TNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1wJ89I5FQmpMyw+N54mHSbynoO2GQ3PGBBeZO/saLc=;
 b=tEiV6iiBwzQ/bZM/OLsfLdSwVkvD9TAsoHiWJgZ57RVFKwFoktRpxjjZ4emn3+zQn36xx+eBrz0dQbge3Djw6d3e3W2vXsAcSeQB/k+kYPPeFL8g5EykxTQVOuYD3cjTH++BEmDLTo2lRjMwznVkuR5eE5T926MgZ0ofuKuyUCc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5163.eurprd04.prod.outlook.com (20.176.235.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Thu, 29 Nov 2018 08:08:25 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 08:08:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3] can: flexcan: implement can Runtime PM
Thread-Topic: [PATCH V3] can: flexcan: implement can Runtime PM
Thread-Index: AQHUh7q0nJLzr7tbZEuTG1BqdpXB6w==
Date:   Thu, 29 Nov 2018 08:08:25 +0000
Message-ID: <20181129080559.18572-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5163;6:KUAxCDwiHU4IaV4qT+pLgY10MzxyOWXkSNrkodE/RTsrrWYOuZw79aBQMkwu3iSw2dXUKuVN3ZpIVJoFrNi3xHl19zroWnxYy9rMAVrx7ZJvLpBvMAWmjk2f3fG27gVA1cr+Hn0o5Zyg71mftQMkW2/4RiIb56WOh7c55XYj96A5EytZwvHks4pCiNmq52jXORLHGA49YjLlFRjanLK3b7TPh9/KmHcKyAJpwEgrHH/+QZlTh7AzrImY15Av4uNgPFG/6WD0AfB3wpcanJZk7rHo46PfdiPk8/RcM2EQa9V3/3XEeRM/2CzGDgd3C36Q7laVhmvbpnwK1Sz9ijo8naGs7lpLYsO3RAro53kEoLFMriHxVEVggQDHhyk6nV5CynuxBKFZTBIV8H6L101ydhiUukzcZVC7mQx0t8K4NlzutaareXbTxcNtjU3K4jQ1waQOibWM665YtbX2TpOA4w==;5:MGGF4DInsXGbzYOOdowoFhlsEILrYV7VyM1U4N7xLkSxbQhZVlgKVBMYii9bwOndHT4pxggTK5IrhonC+oHFAsHIrhdU6rpo4Z7H3quyRcP3SllgtMz/i6n5Cgx7ihbcKMIzqbbUiluP9u4e5ivW7HMosmrt2WyeDNsAgNVHNPo=;7:HvvaRx0uCpWHG1YCY9IMeP+A7z+BdSt32XMupJMoXf4LtXhC2gDY7HdoqPfCcBI7O4DiB1j3p+j+TGd0L/SzA/nZS7OkNUKAxOawLRdcOv+B7vWI5Ai93ks/aBaI1w1ZVQ2RaJWeLMpjQfq7pisNIw==
x-ms-office365-filtering-correlation-id: 20dc944a-9625-4c1a-0479-08d655d1d630
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5163;
x-ms-traffictypediagnostic: DB7PR04MB5163:
x-microsoft-antispam-prvs: <DB7PR04MB5163687E10C9B167056DB4D2E6D20@DB7PR04MB5163.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5163;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5163;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(23433003)(54534003)(199004)(26005)(8676002)(386003)(6486002)(36756003)(53936002)(52116002)(6506007)(2501003)(54906003)(81166006)(81156014)(6436002)(8936002)(186003)(14444005)(256004)(102836004)(97736004)(478600001)(486006)(2616005)(50226002)(105586002)(106356001)(5660300001)(110136005)(86362001)(3846002)(14454004)(68736007)(99286004)(316002)(71200400001)(71190400001)(66066001)(4326008)(476003)(2906002)(305945005)(6512007)(7736002)(25786009)(1076002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5163;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R/Rv4qwQlc7cSskhedlEUdAMX2uWfVam8XHzBgzBCvAZW1U5OnDELVIb6O8pFLGgcM1dKJWpKDrgahjmHbFwGls9jjNqV4OvH5KsK0BMK8Zn2ALZAdqlxNJfCkTPmxqELTRnbE80BSuZmBS/dM1fpH0iahhz/vgYRnbBXZxMBVYmDHW40Wp5exrxfUeKM8boR+hr1Ydu/IgaI13E40s+7b7wwE4e8ggAeo5O6LWFzqgTzX7nhRGYX2d7xuemLuMb2ASHhiD0ZH1WEZQyEuwKEe5fNbV/nWsv0wu7gPz534vcbvUOCDjuwoO5opaABSfQyGAiEr1b7mzL75vO6RHSRyPD16C2sW0F2Ue7ve76o+U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc944a-9625-4c1a-0479-08d655d1d630
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 08:08:25.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Flexcan will be disabled during suspend if no wakeup function required and
enabled after resume accordingly. During this period, we could explicitly
disable clocks.
Since PM is optional, the clock is enabled at probe to guarante the
clock is running when PM is not enabled in the kernel.

Implement Runtime PM which will:
1) Without CONFIG_PM, clock is running whether Flexcan opened or closed.
2) With CONFIG_PM, clock enabled while Flexcan opened and disabled when
3) Regardless of CONFIG_PM enabled or not, Flexcan runtime status is
   SUSPENDED during Flexcan closed and ACTIVE when Flexcan opened.
4) Make Power Domain framework be able to shutdown the corresponding power
   domain of this device.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*rebased on patch "can: flexcan: add self wakeup support".
V2->V3:
	*fix device fails to probe without CONFIG_PM.
---
 drivers/net/can/flexcan.c | 107 +++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..cc62a97237db 100644
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
@@ -570,19 +593,13 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
+	err =3D pm_runtime_get_sync(priv->dev);
+	if (err < 0)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	err =3D __flexcan_get_berr_counter(dev, bec);
=20
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1215,17 +1232,13 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
+	err =3D pm_runtime_get_sync(priv->dev);
+	if (err < 0)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	err =3D open_candev(dev);
 	if (err)
-		goto out_disable_per;
+		goto out_disable_clks;
=20
 	err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
 	if (err)
@@ -1288,10 +1301,8 @@ static int flexcan_open(struct net_device *dev)
 	free_irq(dev->irq, dev);
  out_close:
 	close_candev(dev);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+ out_disable_clks:
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1306,10 +1317,9 @@ static int flexcan_close(struct net_device *dev)
=20
 	can_rx_offload_del(&priv->offload);
 	free_irq(dev->irq, dev);
-	clk_disable_unprepare(priv->clk_per);
-	clk_disable_unprepare(priv->clk_ipg);
=20
 	close_candev(dev);
+	pm_runtime_put(priv->dev);
=20
 	can_led_event(dev, CAN_LED_EVENT_STOP);
=20
@@ -1349,18 +1359,14 @@ static int register_flexcandev(struct net_device *d=
ev)
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg, err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
+	err =3D flexcan_clks_enable(priv);
 	if (err)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	/* select "bus clock", chip must be disabled */
 	err =3D flexcan_chip_disable(priv);
 	if (err)
-		goto out_disable_per;
+		goto out_disable_clks;
 	reg =3D priv->read(&regs->ctrl);
 	reg |=3D FLEXCAN_CTRL_CLK_SRC;
 	priv->write(reg, &regs->ctrl);
@@ -1389,13 +1395,12 @@ static int register_flexcandev(struct net_device *d=
ev)
=20
 	err =3D register_candev(dev);
=20
-	/* disable core and turn off clocks */
+	return 0;
+
  out_chip_disable:
 	flexcan_chip_disable(priv);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+ out_disable_clks:
+	flexcan_clks_disable(priv);
=20
 	return err;
 }
@@ -1556,6 +1561,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->dev =3D &pdev->dev;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
@@ -1586,6 +1592,9 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
+
 	return 0;
=20
  failed_register:
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
@@ -1620,20 +1630,22 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 			err =3D flexcan_chip_disable(priv);
 			if (err)
 				return err;
+
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
@@ -1642,14 +1654,34 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 		if (device_may_wakeup(device)) {
 			disable_irq_wake(dev->irq);
 		} else {
-			err =3D flexcan_chip_enable(priv);
+			err =3D pm_runtime_force_resume(device);
 			if (err)
 				return err;
+
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
+	flexcan_clks_disable(priv);
+
 	return 0;
 }
=20
+static int __maybe_unused flexcan_runtime_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	return flexcan_clks_enable(priv);
+}
+
 static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
@@ -1676,6 +1708,7 @@ static int __maybe_unused flexcan_noirq_resume(struct=
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

