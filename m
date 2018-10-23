Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CCC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276DE20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k0ulnDDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276DE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJWNi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:38:56 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:61492
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbeJWNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8G7Cr/+6WK1GXBJbbiNXCW8FhCYb3WqUeldABEQ35M=;
 b=k0ulnDDCwRYBr30WjkHWSivCDeWNMzeTgoO0rAFeYyEP7yon4qqpOEgcEhkWngg8/FuRG2lK6fH2KjqlCXfxvKOMg0m41zEARTuMIosbrr06w29c3xLZ0fnP813R4L0DsUKp6Xc8K7dM3OE7qwb/h6a+PRcl1xCJ3s07H48FI7Y=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4299.eurprd04.prod.outlook.com (52.135.131.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:17:06 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:17:06 +0000
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
Subject: [PATCH V1 1/2] can: flexcan: Add self wakeup support
Thread-Topic: [PATCH V1 1/2] can: flexcan: Add self wakeup support
Thread-Index: AQHUao+kfwXwhsQel0e+OiFzJfQX6g==
Date:   Tue, 23 Oct 2018 05:17:06 +0000
Message-ID: <20181023051449.2116-2-qiangqing.zhang@nxp.com>
References: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4299;6:AzsSxLSyxzMJzD6wzqPaZE5RSIAqp0zCNEb7a0MkfseJRZzDX1ou4JD89EukeF5npAWCAbxDb6WCk3PwpIkplE9Wtd9uPnTCOpV8nfD+5RD5K7E7jC3POuxB+P0gfVp7qbW6teTuCy7JCFPB9fzDZ4fQfl87A4EAEy2v1ZzdMotzItEggTfvDOG7of3XB8/IATGjEFAoePG+vRQC93LWLfo22AcODH8KjQRzRzKml7EiRYWzXuRIypVn/48a42e53wUO4lzYAlif3sXx+De7pSJayFmLbp0gGwqJGm43v9zIKjkZBnADFMq/HfDJXFDAj7enj9Uo+d6K3/Z/RGl3MFTiIRDqkz2y2nRw7K1j5XvypZCi5NZ/gCALvrmLJCYdfpoepKVTRuvz6PdyOCjoTRCvuqGTd9o8dTipsvGf1cr5jkRPNrmI/yeMxVTDd9WanUKwg+CgkY1CLVXinsLoIw==;5:KIQXShgDG03AhlgCiJ7D1dzPeUyRCvJ2MMvH+0JlRLM6z+kDSHgcnMCrjHB4FB84lXAH6Ttp/wnPXkg/CozVA+/wfEOGA+LR7RjEYkAa+mV2R3ENr3spUbTEVfGCFw5NLawnZRr3NBDIzMfwFV/jm87lhoMXuyND83mUIEyVJzM=;7:MdDHahTXnqZm3+hK2S9dFU+eCdBxiz1Oclxk5QpMjn29C5LtJBOkzsaUxy/SujNiryEoeBXfa41t+ZcU7PoHkDyA3rmHqoXJBKi8jraf+HsJLQGyhDoJPAZZ43vrZxSEpxLPFNN9UuIxOA449ddp5b+d5rwal7cuqHfXXJtTiDCymmhE3S6hrJhzhpCoDjSVA8xlQ4fFVB49AkmNQ7yRdlMzYboPg8FhmArPDiLfNrYjn6ekkPn0UR7NwAnS5ITq
x-ms-office365-filtering-correlation-id: 0c5e56b6-6c35-4d6a-2db7-08d638a6c685
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4299;
x-ms-traffictypediagnostic: DB7PR04MB4299:
x-microsoft-antispam-prvs: <DB7PR04MB4299FEB89A6C6DCBAEE5D8D7E6F50@DB7PR04MB4299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4299;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4299;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(486006)(52116002)(6436002)(99286004)(5640700003)(102836004)(6486002)(476003)(26005)(6916009)(186003)(71190400001)(36756003)(106356001)(5250100002)(446003)(71200400001)(105586002)(11346002)(2616005)(76176011)(5660300001)(3846002)(305945005)(2501003)(2900100001)(7736002)(25786009)(1076002)(4326008)(14454004)(6116002)(97736004)(478600001)(316002)(68736007)(6506007)(66066001)(86362001)(386003)(5024004)(2351001)(14444005)(8676002)(81166006)(54906003)(50226002)(6512007)(53936002)(8936002)(256004)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4299;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZzNUDcNtLDHnkVIw7IouMwXxIiQxnS26YhjjA0ED3rAaYPrwqEDki+qIeNSwk6ApbTTC/Hs0CPEBXZvPfOwaZRmQJALVFd6exDJo53ekxpnk+gVkG23SDCUKn/NurgjZnz4uCdx9nEQvLTp3tZXJPRwydfHH4WQtroms2/fl3n+O1HK4r/Ug2utUFMrNzBeEUrsd2jK7OUWrOEOURuCURrlru00hCDG9f9ldqvdSvJCYWSvampN+uvubmDCN0xuyJCW7ZztLkELw834co3+inb5uwaQZIcA8y91pi90wONMAHEGCM3wcxwEFjf4hChv5AbNMCwkLXeT3SJvL4wr3MfrgHQ8OxCzuCyVf4uxp6Pk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5e56b6-6c35-4d6a-2db7-08d638a6c685
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:17:06.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4299
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
index 3813f6708201..9e05d01da85f 100644
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
+	ret =3D of_property_read_u32_array(np, "stop-mode", out_val, 5);
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

