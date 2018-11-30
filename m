Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9801C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4EA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x8pFRaar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4EA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeK3UCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:02:11 -0500
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:29328
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeK3UCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGlC3LyMKP/PA+rgr00HSpynhkPiaTFl+Hw5hHRUEIg=;
 b=x8pFRaarrsNsbgpkVJ9t6JNODsImRWnkbu86tg2nta/44cFjyPhTudvuMvGQgdTufbN9JduhIkmQDHEF3t9RMBEE1kQn9t6IvGEpmAkLYcc/6fgbiN+UQb9AmySuXKbrOhV+vVbBtCXR9bH5G1S6ZdDw5t7X1HbO5fFwT/SoZTQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5435.eurprd04.prod.outlook.com (20.178.104.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 08:53:27 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1361.022; Fri, 30 Nov 2018
 08:53:27 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4] can: flexcan: implement can Runtime PM
Thread-Topic: [PATCH V4] can: flexcan: implement can Runtime PM
Thread-Index: AQHUiIoop/n4puOahUOXMKD8lZBLIQ==
Date:   Fri, 30 Nov 2018 08:53:26 +0000
Message-ID: <20181130085119.7948-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0153.apcprd06.prod.outlook.com
 (2603:1096:1:1f::31) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5435;6:sXmnvYZhIaddGvFpXJkcLOxqau9lfseQewSIAyeHoR8SUeb+sUZLUkPDwT2icjHkju5IYWJbhBytaNxBkZFP6B+SkFHBBEI2LKraYqEDf1QLrbXxmtU//rm50vMRhtp9UimS5tM5Eb4ViUlwsXxUhrZQSFF7zr+N39peJW7H1GY0UdXcRMJFpFpOMhYS0N+SpBzaOU+yElb6JsnfH5G6gto/P4hXX7fpTXjzfpR+ePTcb4716G0jMK8vsgI5YMXA1FDNSFxliszIzGdzI4G7pu2yXLQBA9AoKQunspjEDcCyWit31MG2KKpBYla/TWkbWoYo0z0jcmA21blq1aUKrEGtmJIUnDp4AMSgGC0lJhoGs5mWUziCs3NWAtoVzArAVC8QkhtM5ZXUUcSpNB4+fSRxMQqV0Nt+agX+hehMkCDZUJvwJVm9ksDlMOHREP/IFMT1nDbV3K0O2BcTfFzhLw==;5:ES2wo57sCTm6s1Xv0ClDHXy+8TPXVukml6yFmBYuOdQ88HQzWiY+zQ8cIELQLGmdy4GqwaMFBvXPadEYdt3QXnOOia/wdzzoHFdTN3B5B/ZBlBOHfigRbSxiZMEuvI00jazqDH5LvzmrGdtaxEXUcS1+UbDZJ/wjI0Gv1wluGEE=;7:fTRZtxPr5bTPmmxdBGmT2KhKVbcK5G3c8XFcR/TdEwwFwYy0Rjn03LStHq3tdRf/6qGLlkiEnDxGsuo9YSYMc3e+lQ9zBp+RPdWYeoiu4scLxyPPZaYqZA6fD9hJt0zx9DgTtfzZNtmhI162IzAe0Q==
x-ms-office365-filtering-correlation-id: b03ff923-a6c1-496b-221d-08d656a14ab1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5435;
x-ms-traffictypediagnostic: DB7PR04MB5435:
x-microsoft-antispam-prvs: <DB7PR04MB5435BF47A99CF6CFF23765D9E6D30@DB7PR04MB5435.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5435;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5435;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(54534003)(23433003)(189003)(199004)(97736004)(52116002)(6512007)(8676002)(86362001)(81166006)(81156014)(2906002)(316002)(6506007)(478600001)(2501003)(50226002)(99286004)(14454004)(386003)(54906003)(110136005)(5660300001)(36756003)(1076002)(102836004)(6116002)(3846002)(26005)(8936002)(71200400001)(68736007)(6436002)(7736002)(305945005)(106356001)(186003)(4326008)(71190400001)(25786009)(486006)(2616005)(105586002)(476003)(256004)(14444005)(66066001)(6486002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5435;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4BmDKEVzZQyeMld7kjx2e4xG1Qgu0WhKF2VpUgmMjINZk15yCxyPsBbKKmpq3OQJfkmv1ScX6Yw4nfZWAyS3bL2zmo/XS9mtwtRnHAntyv7d07/3rZ+29g4dWdFgyR+Eldfbsl8PFzVS/9kWFhYDeIb7LRfNF0KkpYj3ugH54K686/3EEhnXkmQkXAks1/49GYnhJZTD0oTzib+G3gqETp88UfcFUZtBNRWL4W/dQpsfMizj0ieeOEqtjT6dXuJieKBox9bdGa/5F0bILdDdnZRHWHZRj/XVRkXIh2TW1+WLkEFr5WKG4jX/LUY9IA8Q4GmVybUoQaojxH9+xCR9ji5UZtrMC86EknWp2uRq+4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03ff923-a6c1-496b-221d-08d656a14ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 08:53:26.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5435
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
1) Without CONFIG_PM, clock is running whether Flexcan up or down.
2) With CONFIG_PM, clock enabled while Flexcan up and disabled when
   Flexcan down.
3) Disable clock when do system suspend and enable clock while system
   resume.
4) Make Power Domain framework be able to shutdown the corresponding
   power domain of this device.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*rebased on patch "can: flexcan: add self wakeup support".
V2->V3:
	*fix device fails to probe without CONFIG_PM.
V3->V4:
	*runtime pm enable should ahead of registering device.
	*disable device even if keeping the clocks on.
---
 drivers/net/can/flexcan.c | 111 +++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..cad42f20cfe5 100644
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
@@ -1389,14 +1395,13 @@ static int register_flexcandev(struct net_device *d=
ev)
=20
 	err =3D register_candev(dev);
=20
-	/* disable core and turn off clocks */
- out_chip_disable:
 	flexcan_chip_disable(priv);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+	return 0;
=20
+ out_chip_disable:
+	flexcan_chip_disable(priv);
+ out_disable_clks:
+	flexcan_clks_disable(priv);
 	return err;
 }
=20
@@ -1556,6 +1561,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->dev =3D &pdev->dev;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
@@ -1569,6 +1575,10 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
=20
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	err =3D register_flexcandev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
@@ -1586,6 +1596,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
+	pm_runtime_put(&pdev->dev);
 	return 0;
=20
  failed_register:
@@ -1598,6 +1609,7 @@ static int flexcan_remove(struct platform_device *pde=
v)
 	struct net_device *dev =3D platform_get_drvdata(pdev);
=20
 	unregister_flexcandev(dev);
+	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
=20
 	return 0;
@@ -1607,7 +1619,7 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	if (netif_running(dev)) {
 		/* if wakeup is enabled, enter stop mode
@@ -1620,20 +1632,22 @@ static int __maybe_unused flexcan_suspend(struct de=
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
@@ -1642,14 +1656,34 @@ static int __maybe_unused flexcan_resume(struct dev=
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

