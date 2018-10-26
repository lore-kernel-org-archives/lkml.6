Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D63ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552B62084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkrtHjSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552B62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJZRgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:36:54 -0400
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:43856
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeJZRgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMX/e+gX0qy7iqAh9XUuvaQrvZ137dmnCiu+L1Gpo7Y=;
 b=GkrtHjSi2+q8LiU6QYuu688KobxRejVORXKAc1lT+qR8WazeBL2xTr3tBfi8avyjMz8auCnmgeRK2JGTzsWNEmA/aNPHh0miJEMyZFpCjUYT/qrXLZxZZr6gN5L/y42W2MNREdv4OjtxE7vVy+rXwAkD+mCjo1vEur1KpLesW20=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 09:00:35 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:00:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 1/2] can: flexcan: Add self wakeup support
Thread-Topic: [PATCH V2 1/2] can: flexcan: Add self wakeup support
Thread-Index: AQHUbQpba0Y0q2AWAU6Po+m2Y8KW1A==
Date:   Fri, 26 Oct 2018 09:00:35 +0000
Message-ID: <20181026085814.23370-2-qiangqing.zhang@nxp.com>
References: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5322;6:7+udaSvBJJAaDchZ0fs//jdoFMTEuogykkc8G59B3UYZth24HUEtHurORmHu9HMdJMFvLqfU6fFIohIJU77wL4evPXZZy7/VWl07+m6ELMGYsIvm/R6MmugceJeHh9oCf4JO3MGaFwM0EbFkzuYX7nh8qvhugQXVAtUBoUx7pRJdYFlHIN5Jh7x9kisL2iXjMHJ3gvpJqCL40TKsH+Y2wiHDk5qFYcjE6tw3ybU0y2ygH/J2Vaq5MPUxpup/+LPTZfp9eVj5q/kvHMZ74EzBN4+rA7QGSJtZ8tYozkLh9CjdFnT4Ek2+Gmiw3TlFUXBkvJiIdQBAEMlXOTbH9ATwB6gA6hSFZhJ8HtGyzTh5Il5sVGLo9UCKG23oQXQ/1fbUzi3j8HXcPYwJ76gq3+70l0JvbtlcNuIcH+KzefWdTH1nsilK1XiNT0rmf+W/gHLGvnmt/xOrEd7GycZo3xpd+A==;5:JM9DQgNP4Rgd6Mcu6wDxzU5MQ/0luVGQy8LmqJ3kuqo6P61scYLLsCGBulppikI6ViNKeiX6YS6dy/65bAtqtvdlBqV3Vhq91ahA2NN4jFRu2slFP84VzHXjWOyeqUi/ML+ULP0DOUt7QuVHnccROsF23noqR8rIihL6GLOM6ik=;7:l03OzGZ45XUH0xn2srlMy6P6ryYiSpeS9/H7B/Db2emzMwm4d9FsY6xWTDijjUBaFTeSNlHz6tiyFPiyYO0kK20EbWKnnLmXvDsmDnu+NwQ5Gg1j5DXAvy9awidoeq1cl51FX4ETMvIA8pAw1Kdcmg==
x-ms-office365-filtering-correlation-id: 8d81684f-9d64-426b-ed4e-08d63b217dec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-antispam-prvs: <DB7PR04MB53222BD630E400EA36765D51E6F00@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5322;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5322;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(6916009)(5660300001)(14454004)(6512007)(478600001)(53936002)(97736004)(106356001)(186003)(2900100001)(36756003)(2501003)(2351001)(5250100002)(54906003)(316002)(66066001)(71190400001)(71200400001)(105586002)(102836004)(1076002)(25786009)(14444005)(256004)(4326008)(5024004)(446003)(11346002)(305945005)(26005)(5640700003)(2616005)(6486002)(7736002)(3846002)(8936002)(6116002)(86362001)(99286004)(76176011)(486006)(52116002)(6506007)(8676002)(386003)(68736007)(6436002)(2906002)(50226002)(81156014)(81166006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xn1stElI9DxJwTLZgv4aN70yuFEWCHJCqP/pwhcEOTkDFUPvhnd5PISQMamFiw439Y9hFR2gLBTmLFyOw1R/rBSSiD9KQFkSJFsT8Fs5im8H+CfhcRhIdG320dwIQoBIHou5R0V9E8uPZYEyhs3TvgStt9jmrOTHUmAhkCzsgPKQxqM2eXyHuW320sja5w7cLmFBA61jqRZ1IPMQmQbfDDK6Pn1RDzDtZLNutBymxJSH4UbUJeRpPh1itvzVuRqq5tXBWJRMSIjJPCISPDGfWQyyPjBpoDPcLxa+xgOtOXdKcczPwY2+DO3vaErgjQLYXF2kGILVGMPbKS0Odrpq2hrJCqP4UnS8uW1kRd6+NFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d81684f-9d64-426b-ed4e-08d63b217dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:00:35.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

If wakeup is enabled, enter stop mode, else enter disabled mode.
Self wake can only work on stop mode.

Starting from IMX6, the flexcan stop mode control bits is SoC specific,
move it out of IP driver and parse it from devicetree.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 141 +++++++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3813f6708201..d4708ba28c44 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -19,12 +19,17 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
=20
 #define DRV_NAME			"flexcan"
=20
@@ -132,7 +137,8 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
+	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
+	 FLEXCAN_ESR_WAK_INT)
=20
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -255,6 +261,14 @@ struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
=20
+struct flexcan_stop_mode {
+	struct regmap *gpr;
+	u8 req_gpr;
+	u8 req_bit;
+	u8 ack_gpr;
+	u8 ack_bit;
+};
+
 struct flexcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -272,6 +286,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	struct flexcan_stop_mode stm;
=20
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
@@ -392,6 +407,22 @@ static void flexcan_clks_disable(const struct flexcan_=
priv *priv)
 	clk_disable_unprepare(priv->clk_per);
 }
=20
+static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
+{
+	/* enable stop request */
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+}
+
+static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
+{
+	/* remove stop request */
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			1 << priv->stm.req_bit, 0);
+}
+
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *pr=
iv)
 {
 	if (!priv->reg_xceiver)
@@ -955,6 +986,10 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mcr |=3D FLEXCAN_MCR_FEN |
 			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	}
+
+	/* enable self wakeup */
+	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK | FLEXCAN_MCR_SLF_WAK;
+
 	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
=20
@@ -1240,6 +1275,56 @@ static void unregister_flexcandev(struct net_device =
*dev)
 	unregister_candev(dev);
 }
=20
+static int flexcan_of_parse_stop_mode(struct platform_device *pdev)
+{
+	struct net_device *dev =3D platform_get_drvdata(pdev);
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *node;
+	struct flexcan_priv *priv;
+	phandle phandle;
+	u32 out_val[5];
+	int ret;
+
+	if (!np)
+		return -EINVAL;
+
+	/* stop mode property format is:
+	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
+	 */
+	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);
+	if (ret) {
+		dev_dbg(&pdev->dev, "no stop-mode property\n");
+		return ret;
+	}
+	phandle =3D *out_val;
+
+	node =3D of_find_node_by_phandle(phandle);
+	if (!node) {
+		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
+		return PTR_ERR(node);
+	}
+
+	priv =3D netdev_priv(dev);
+	priv->stm.gpr =3D syscon_node_to_regmap(node);
+	if (IS_ERR(priv->stm.gpr)) {
+		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
+		return PTR_ERR(priv->stm.gpr);
+	}
+
+	of_node_put(node);
+
+	priv->stm.req_gpr =3D out_val[1];
+	priv->stm.req_bit =3D out_val[2];
+	priv->stm.ack_gpr =3D out_val[3];
+	priv->stm.ack_bit =3D out_val[4];
+
+	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x ack_bit =
%u\n",
+			node->full_name, priv->stm.req_gpr,
+			priv->stm.req_bit, priv->stm.ack_gpr,
+			priv->stm.ack_bit);
+	return 0;
+}
+
 static const struct of_device_id flexcan_of_match[] =3D {
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
@@ -1271,6 +1356,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	struct flexcan_regs __iomem *regs;
 	int err, irq;
 	u32 clock_freq =3D 0;
+	int wakeup =3D 1;
=20
 	reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
 	if (PTR_ERR(reg_xceiver) =3D=3D -EPROBE_DEFER)
@@ -1400,6 +1486,16 @@ static int flexcan_probe(struct platform_device *pde=
v)
=20
 	devm_can_led_init(dev);
=20
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		err =3D flexcan_of_parse_stop_mode(pdev);
+		if (err) {
+			wakeup =3D 0;
+			dev_dbg(&pdev->dev, "failed to parse stop-mode\n");
+		}
+	}
+
+	device_set_wakeup_capable(&pdev->dev, wakeup);
+
 	pm_runtime_put(&pdev->dev);
=20
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
@@ -1437,10 +1533,18 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 	int err =3D 0;
=20
 	if (netif_running(dev)) {
-		err =3D flexcan_chip_disable(priv);
-		if (err)
-			return err;
-		err =3D pm_runtime_force_suspend(device);
+		/* if wakeup is enabled, enter stop mode
+		 * else enter disabled mode.
+		 */
+		if (device_may_wakeup(device)) {
+			enable_irq_wake(dev->irq);
+			flexcan_enter_stop_mode(priv);
+		} else {
+			err =3D flexcan_chip_disable(priv);
+			if (err)
+				return err;
+			err =3D pm_runtime_force_suspend(device);
+		}
=20
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
@@ -1461,10 +1565,12 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 		netif_device_attach(dev);
 		netif_start_queue(dev);
=20
-		err =3D pm_runtime_force_resume(device);
-		if (err)
-			return err;
-		err =3D flexcan_chip_enable(priv);
+		if (!device_may_wakeup(device)) {
+			err =3D pm_runtime_force_resume(device);
+			if (err)
+				return err;
+			err =3D flexcan_chip_enable(priv);
+		}
 	}
 	return err;
 }
@@ -1489,10 +1595,27 @@ static int __maybe_unused flexcan_runtime_resume(st=
ruct device *device)
 	return 0;
 }
=20
+static int __maybe_unused flexcan_noirq_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	/* exit stop mode during noirq stage avoid continuously entering
+	 * wakeup ISR before CAN resume back.
+	 */
+	if (netif_running(dev) && device_may_wakeup(device)) {
+		disable_irq_wake(dev->irq);
+		flexcan_exit_stop_mode(priv);
+	}
+
+	return 0;
+}
+
 static const struct dev_pm_ops flexcan_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
 	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume,
 						NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, flexcan_noirq_resume)
 };
=20
 static struct platform_driver flexcan_driver =3D {
--=20
2.17.1

