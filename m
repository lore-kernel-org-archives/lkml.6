Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2662087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fnCOTvQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLDGTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:19:54 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:2344
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeLDGTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skc3pMeaEi/A/K9LRJK3IXrs21SiOuV/XLYyYyl/ChQ=;
 b=fnCOTvQJ4Vyfy5knk9vgtu7gdRzunUawvXYgeeVIQKyBBRzVGOMLEvgRMIkuv0Am06py8CFp0pM2ovPTg2h0AfATI5W2vyasUfwDkY33mjUg1VJ/eOaF68O0HhnHQWk/1NPEAMVwXcXOweF0mQImR9iQ5R3t7xk92Cmwiuijwk8=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4246.eurprd04.prod.outlook.com (52.135.168.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 06:19:49 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 06:19:49 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: lpspi: enable runtime pm for lpspi
Thread-Topic: [PATCH] spi: lpspi: enable runtime pm for lpspi
Thread-Index: AQHUi5lbAahFdcVEeUKVpS14WP0PHg==
Date:   Tue, 4 Dec 2018 06:19:48 +0000
Message-ID: <20181204061904.28567-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0087.apcprd06.prod.outlook.com
 (2603:1096:3:14::13) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4246;6:TW/7WD5Bl1y2e9/BI9EDaQZDoK40AxkCmi5AaDGdj5k4RlH+qVJ9q7i1QzN9QiiLCG13YTzr80a1KJDoLcN7D15SJ+DFrHheKJxJq7Qa+7a/N3B6cinFs2j3K1h4ePs+8Q+Kju0XAMUGz05XLLNH4Cd6DXkZoCYN5CMcNwo/hsTI/+UxyJ981T8MCMG9CaHD5fxjKRaGtRJs8IgqNHldWnmkAYG676EJKIsLrgkUwJ5BD99nWt0fZJquOHfPwj63ZRgsy4O1SZDJ9DbJDlehWqGsv2R4OhHCAO1UaNabnbh1k4tcYei+P00a5H0dMCCQg4TRnvTlL1Yxo+f2CInB9ACWYUQd2yZxi5tLIDS857KAKND5ToPANjWj24Oomp0NVgS+4+De8E7JBvitL4Pirl7enGPKTIxSDBCbjBBzuBa1EncalPLBsxFBlehMoyhao0IJ/6za5/QUNf5eogSLeA==;5:GlOUsJ9FqXgQ/+PhPXPgaayveCq7vwDDMmXozynGmvX9Ha79hdcDDf4hYb9vBLAI5dWP0xgECBNKC5TbS/9e1kdtbKtC5ty9rI2khQkNj9bHzYhOS6f5IziyfdMQ7UVEM5BE90iKziDdbhU3zXQqTSpdOnSql7kodb/buj1MGKk=;7:19uSnf7TgOB1mNr5TnslU3qGy06wiU2J8Ax+/ZWxoMyyAcaat0lKeWDa3NJxU2aAPdZy/UjhTV3POTTmOdw4nveemNDVcbu4I8iWFLKWkE07TgHeTlulJ60a/Q9Zqmsq8E+NzBuKtugfkpZkyJi08g==
x-ms-office365-filtering-correlation-id: 97b9c7be-cad7-4979-32cd-08d659b07e1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4246;
x-ms-traffictypediagnostic: AM6PR04MB4246:
x-microsoft-antispam-prvs: <AM6PR04MB4246635FC7AB36A6401DE621F3AF0@AM6PR04MB4246.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4246;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4246;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(316002)(1076002)(86362001)(575784001)(68736007)(2501003)(6916009)(2906002)(14454004)(66066001)(54906003)(4326008)(99286004)(26005)(106356001)(105586002)(6116002)(3846002)(2351001)(186003)(486006)(6506007)(386003)(52116002)(102836004)(7736002)(2616005)(476003)(97736004)(305945005)(8676002)(1730700003)(81156014)(36756003)(81166006)(256004)(14444005)(71200400001)(71190400001)(6512007)(478600001)(53936002)(6486002)(6436002)(25786009)(8936002)(5640700003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4246;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U8GQegMhykZXeECtJQYpBn7E+g+Hx/9lIT0clFNSqHmUcVKPS1/QuNumLTkFzWqi4BBGMHPdWTYbZY/FetjNBWQWe4sM42UBVYwrOGtLxnZX7KhcDpLIpRmq3qP9JOAjyNTXykHpyok6Hko/Gl85Cq2Y804AjOYMvjJj/monJf+d+AwEoKA96YGCmSAPnEoKJNrBT0oSxsH8hUFjpgQfhApX76PI0lXvEdpnNsYnL7DaeQslsYPKG8f9N8VgDviWkLBXyGlDM8ZEcBjVVSo3uUhiZLZT85eHHHLiqmKFegTM5TIDWzHYeNq9qeVkq5fwS9jWbiKmGFnIO/Sv/KLgCDNpAbnDgml01Tufmw83upo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b9c7be-cad7-4979-32cd-08d659b07e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 06:19:48.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Han Xu <han.xu@nxp.com>

	Enable the runtime power management for lpspi module.

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 117 ++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5802f188051b..3e935db5ff02 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -16,7 +16,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -24,6 +26,8 @@
=20
 #define DRIVER_NAME "fsl_lpspi"
=20
+#define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -150,13 +154,9 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 				spi_controller_get_devdata(controller);
 	int ret;
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
 		return ret;
 	}
=20
@@ -168,8 +168,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-	clk_disable_unprepare(fsl_lpspi->clk_per);
+	pm_runtime_mark_last_busy(fsl_lpspi->dev);
+	pm_runtime_put_autosuspend(fsl_lpspi->dev);
=20
 	return 0;
 }
@@ -476,6 +476,45 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
)
 	return IRQ_NONE;
 }
=20
+int fsl_lpspi_runtime_resume(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_per);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fsl_lpspi_runtime_suspend(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+
+	return 0;
+}
+
+static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct device *dev =3D fsl_lpspi->dev;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSL_LPSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
@@ -501,6 +540,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, fsl_lpspi);
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
@@ -547,28 +587,21 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
+	/* enable the clock */
+	ret =3D fsl_lpspi_init_rpm(fsl_lpspi);
+	if (ret)
 		goto out_controller_put;
-	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi per clock, ret=3D%d\n", ret);
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
-		goto out_controller_put;
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
+		return ret;
 	}
=20
 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
@@ -589,16 +622,50 @@ static int fsl_lpspi_remove(struct platform_device *p=
dev)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	pm_runtime_disable(fsl_lpspi->dev);
+
+	spi_master_put(controller);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fsl_lpspi_suspend(struct device *dev)
+{
+	int ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+	ret =3D pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_lpspi_resume(struct device *dev)
+{
+	int ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "Error in resume: %d\n", ret);
+		return ret;
+	}
+
+	pinctrl_pm_select_default_state(dev);
=20
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_lpspi_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
+				fsl_lpspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
+};
=20
 static struct platform_driver fsl_lpspi_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
 		.of_match_table =3D fsl_lpspi_dt_ids,
+		.pm =3D &fsl_lpspi_pm_ops,
 	},
 	.probe =3D fsl_lpspi_probe,
 	.remove =3D fsl_lpspi_remove,
--=20
2.17.1

