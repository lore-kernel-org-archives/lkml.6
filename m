Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4A9214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cd1Z+7am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4A9214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbeKUXG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:06:28 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:44352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730321AbeKUXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVBtzbhji/ddUG4xsZyNK8htMrFPpLLh3qEy7FuOdno=;
 b=cd1Z+7amSDR/YqEamL5SOBDfkilLyhePWOWen8DdOsn2vbPrdalrwoOw073aEXT6rdTQr6McYA+gNaV8yz5I/bLhTdjIDjAEmjI5bJjWCb4PiDqHZ7Qr5zw0NfpbPUfS9IUM91IMDSjJjo7u5EwiAU8S18vFnK/5VmPAIL5ohIw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4987.eurprd04.prod.outlook.com (20.176.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 12:32:08 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 12:32:08 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Topic: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Index: AQHUgZY37Zcqeh+WZkOJKhpyijlTpQ==
Date:   Wed, 21 Nov 2018 12:32:08 +0000
Message-ID: <20181121122957.2684-2-qiangqing.zhang@nxp.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4987;6:Uu2zNKaOPxdoZU2Br1DNmcEMcpufz+4iKTXNWpGu9dj7mlThc6f1drMipnQ5OceqlMxJEdrM28ysJEca+v9pqyeNlTyKWCV0nNhMyQAf6hsA6te6+jCpY/CpFNULYi7A3pnWTj/vzSkC7w5crGsdDLnJpN23x4tqWcrCBxL8svICwPdgqi5PLDivAkMKemVpLHTcKTBy5ecb454k+Wwf/9kPIXT6Gw688z4C26ayLWMQsF2wQFpkYiIatp/YC3rUIQDCw4Tek8pZW76biL/q4sKLdbBI/i9rzqPpdGnycKTfRFX75nN7XuEuXHk5G7WpqYR28kQNHGv+Q0v492I93Y6x71DtG39zuteMvg9Wy/T1Nu1Q8sHptZklGjvL1WFBep7L5Smw/V/3aYVlYZ13g1ca4MGboC7CTsAm2TEZxNmD5L4tK1vID5QFUIoUHZ4oOKa8BXssKG/F7lB14/GT+A==;5:nMG7WsBmpwqnglBiRYJPDiJcCZxTQnWE2OZGJ4U5tyUqEjx0HxQ4rbd0nZfG0WvqeVcadXFWJiPv8cGn62Dwt0wjL3uvzzAK/laYAXM9+zt2hEcDGjfDURUArlDERsdWPzY6U1l0DxZlmrwWliYqyqAubYTtGAE5c8dVkfVUn+0=;7:7xL/oHfLQBcO44lFUoj9eDnovIlT+TQvg91ofmhmaDgeYKK8NuR99tmPqqH/YDzJ6Jm8XkWkGaVgy6TDkhAYRempFXjYf+X/s7GRulmzJoPzx/F4H3vMDr+V4Or1EypM3Qcro9DKOI6OYbPyXaKGoQ==
x-ms-office365-filtering-correlation-id: b1123090-47ae-48dc-a702-08d64fad5a40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4987;
x-ms-traffictypediagnostic: DB7PR04MB4987:
x-microsoft-antispam-prvs: <DB7PR04MB49873C9CAEF74EB9B2EE0D67E6DA0@DB7PR04MB4987.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4987;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4987;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(478600001)(99286004)(102836004)(6436002)(14454004)(52116002)(6506007)(486006)(2616005)(3846002)(76176011)(6116002)(476003)(386003)(6486002)(256004)(5024004)(14444005)(26005)(106356001)(54906003)(11346002)(110136005)(86362001)(446003)(25786009)(105586002)(66066001)(2900100001)(6512007)(53936002)(5660300001)(81156014)(81166006)(4326008)(186003)(1076002)(2906002)(8676002)(50226002)(305945005)(8936002)(7736002)(316002)(36756003)(97736004)(68736007)(71190400001)(71200400001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4987;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z72EaqfiBMf87ijR7DC+7duuqezitOzODjQVPuDPtl5NaN+BJYiBv14SDeQCohZi0yS5VrOXeG6/XqyBQ2t7Srp3L2tz4lPo0RmIHHdIo1LYz9Sh6ylwKU0YLug+VzmhNWaK7If2OaGmpcSU5YsGM+8tBnYa76FB4kvEsWpyThyXOatx86G2KERInp3hzCt1u2INNEn5TRdgn4SJvDTiJ25Wb3luFYr/n9YXuoGaYhMpoN55zWkrP0jZcUtEsGTTjLCMXMjukndG8Fmhst4klTCpNRnRetSxL91EWaiDfRueQD6PC6tWr00ei4iwdyArn3BALjdFmdVwGZcLIAa1XWSHl60po7ekN6cEU3nENCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1123090-47ae-48dc-a702-08d64fad5a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 12:32:08.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

If wakeup is enabled, enter stop mode, else enter disabled mode. Self wake
can only work on stop mode.

Starting from IMX6, the flexcan stop mode control bits is SoC specific,
move it out of IP driver and parse it from devicetree.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 154 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 8e972ef08637..83431810316e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -19,11 +19,14 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
=20
 #define DRV_NAME			"flexcan"
=20
@@ -131,7 +134,8 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
+	FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
+	FLEXCAN_ESR_WAK_INT)
=20
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -190,6 +194,7 @@
 #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offl=
oading */
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error p=
assive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register =
access */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to suppor=
t wakeup */
=20
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -254,6 +259,14 @@ struct flexcan_devtype_data {
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
@@ -270,6 +283,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	struct flexcan_stop_mode stm;
=20
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
@@ -293,7 +307,8 @@ static const struct flexcan_devtype_data fsl_imx28_devt=
ype_data =3D {
=20
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
@@ -353,6 +368,35 @@ static inline void flexcan_write_le(u32 val, void __io=
mem *addr)
 	iowrite32(val, addr);
 }
=20
+static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enab=
le)
+{
+	struct flexcan_regs __iomem *regs =3D priv->regs;
+	u32 reg_mcr;
+
+	reg_mcr =3D priv->read(&regs->mcr);
+
+	if (enable)
+		reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
+	else
+		reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
+
+	priv->write(reg_mcr, &regs->mcr);
+}
+
+static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
+{
+	/* enable stop request */
+	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+}
+
+static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
+{
+	/* remove stop request */
+	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			   1 << priv->stm.req_bit, 0);
+}
+
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *pri=
v)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
@@ -940,6 +984,10 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mcr |=3D FLEXCAN_MCR_FEN |
 			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	}
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE)
+		reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
+
 	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
=20
@@ -1244,6 +1292,58 @@ static void unregister_flexcandev(struct net_device =
*dev)
 	unregister_candev(dev);
 }
=20
+static int flexcan_setup_stop_mode(struct platform_device *pdev)
+{
+	struct net_device *dev =3D platform_get_drvdata(pdev);
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *gpr_np;
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
+	gpr_np =3D of_find_node_by_phandle(phandle);
+	if (!gpr_np) {
+		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
+		return PTR_ERR(gpr_np);
+	}
+
+	priv =3D netdev_priv(dev);
+	priv->stm.gpr =3D syscon_node_to_regmap(gpr_np);
+	if (IS_ERR(priv->stm.gpr)) {
+		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
+		return PTR_ERR(priv->stm.gpr);
+	}
+
+	of_node_put(gpr_np);
+
+	priv->stm.req_gpr =3D out_val[1];
+	priv->stm.req_bit =3D out_val[2];
+	priv->stm.ack_gpr =3D out_val[3];
+	priv->stm.ack_bit =3D out_val[4];
+
+	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x ack_bit =
%u\n",
+		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit, priv->stm.ack_g=
pr,
+		priv->stm.ack_bit);
+
+	device_set_wakeup_capable(&pdev->dev, true);
+
+	return 0;
+}
+
 static const struct of_device_id flexcan_of_match[] =3D {
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
@@ -1396,6 +1496,12 @@ static int flexcan_probe(struct platform_device *pde=
v)
=20
 	devm_can_led_init(dev);
=20
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
+		err =3D flexcan_setup_stop_mode(pdev);
+		if (err)
+			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
+	}
+
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
@@ -1426,9 +1532,17 @@ static int __maybe_unused flexcan_suspend(struct dev=
ice *device)
 	int err;
=20
 	if (netif_running(dev)) {
-		err =3D flexcan_chip_disable(priv);
-		if (err)
-			return err;
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
+		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
@@ -1447,14 +1561,45 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
-		err =3D flexcan_chip_enable(priv);
-		if (err)
-			return err;
+		if (device_may_wakeup(device)) {
+			flexcan_enable_wakeup_irq(priv, false);
+		} else {
+			err =3D flexcan_chip_enable(priv);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int __maybe_unused flexcan_noirq_suspend(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (netif_running(dev) && device_may_wakeup(device))
+		flexcan_enable_wakeup_irq(priv, true);
+
+	return 0;
+}
+
+static int __maybe_unused flexcan_noirq_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (netif_running(dev) && device_may_wakeup(device)) {
+		disable_irq_wake(dev->irq);
+		flexcan_exit_stop_mode(priv);
 	}
+
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resume);
+static const struct dev_pm_ops flexcan_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_resume=
)
+};
=20
 static struct platform_driver flexcan_driver =3D {
 	.driver =3D {
--=20
2.17.1

