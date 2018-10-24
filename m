Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF55206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrKbiwGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF55206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJXQZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:25:34 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:18785
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeJXQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6CGE6YrtEV7iMmz+UQAvGtnoSiNEbKQi5zw2vhU1WE=;
 b=YrKbiwGXa0LjJh2SFjxSsbdX4VIln+FdWryo2k3NG3Toohf94xJDWu5u8MUpaSQVJCi/xzB/ccbVUNhwFo7JWMu2xdbcFfdO8xe1MzIRh8WPbyeSujbiy76KG07mDycYB0DOUiWB6EuPmJdhv78hwYnQowgzxxG88i+/8Fkj6C8=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4934.eurprd04.prod.outlook.com (20.177.33.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Wed, 24 Oct 2018 07:58:30 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 07:58:30 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
Thread-Topic: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
Thread-Index: AQHUa29a5XgBPdp6xEeoRC7tzwrsxQ==
Date:   Wed, 24 Oct 2018 07:58:30 +0000
Message-ID: <20181024075617.19548-4-xiaoning.wang@nxp.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0127.apcprd06.prod.outlook.com
 (2603:1096:1:1d::29) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4934;6:4soAgWPaLPv9H0Qkfuz/peCqyNxzy1Xp17GUMi5OI7HbkCFaTpE08D59qXU6E3fIPFjqLrOeuD7vLi82Euo9VI21Vy3ud0CiudM81JQgQbW0X0zLb9zfKCt4dCjvi8ASac4ThdBK95gJwBKdsGpNs9FMZYg/174sC0LaM8NDICfoMtgajkFoDJptg3j0XjY2LAdpf9IW1GDekx+EZDiXNI9p4kEAyFoc4XVUZYCdibeyfwzKN++MpI9oJ4NSZxky2qY1sxIYB/v5s5mdcY6XHcHqDppHggpgz/YhZeO69XTPchywRkowrX/4CB2kVla2pc1d5gQ0dEW5ykva27Jm6BwBVYmQJjCTL7ZLHTvUnwXli75QHq7vw1y4h0zZxRVRKL3NZSIC6eIYBA9LrGPI+9dHaP8c6BdsPdaUvTZR8DErA+ahOZZBotYogqeXyijgvjnTQAjprwUbNYfSi4Gh9w==;5:kCrojLIq9u3RWC5psW9koCTzSqy0a8W/SzLtkwbj26qTHlUmAIfDIcGTERyHm1c0Y4udiCEzXp2kTwUXtn6Km+NwTfnwUge6JSIpOyjwPnRPWi18A8iPGmcNjKy00M3zNMvdYzSgOmjiXgIiB3qd8gK//aeXeQDuz4ltr1HkB28=;7:2uo3PfyDtNm89ZeqTBfNUrufZXUuGi7EtgtLLo4IqlRYBcy1Jqc7VKJFYPMYr67R7kFHfsK/RsS9jxJ2HtxKDDrZ7UaCIFBe8NzFGm22oCdAgTjYbD7fpxGrl/irKgYXx87FberSsFqgTKl/LqAAgQ==
x-ms-office365-filtering-correlation-id: 5efbad96-1189-4fb6-0690-08d639867ca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4934;
x-ms-traffictypediagnostic: AM6PR04MB4934:
x-microsoft-antispam-prvs: <AM6PR04MB493453A1BF919E5F5824DDE0F3F60@AM6PR04MB4934.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4934;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4934;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(5660300001)(2351001)(105586002)(6506007)(386003)(486006)(106356001)(446003)(2616005)(11346002)(476003)(2906002)(68736007)(6116002)(1730700003)(81166006)(81156014)(97736004)(2900100001)(8676002)(8936002)(5250100002)(1076002)(71200400001)(186003)(6346003)(71190400001)(2501003)(3846002)(66066001)(26005)(14444005)(6436002)(6512007)(4326008)(6486002)(52116002)(316002)(54906003)(5640700003)(6916009)(256004)(76176011)(25786009)(99286004)(478600001)(14454004)(575784001)(53936002)(86362001)(102836004)(36756003)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4934;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-microsoft-antispam-message-info: kbIiHKEOHe4yuQRPSH73FVxOFvIaVxd8GhcHRKZOceKaypyz0HI9BB+2iMly7A7/UAtsxRTMXA5sAqQV1Pw/2vS5mg9XTXvcOjzhk3mP/ze+/yELjDJ74k0iV3KrofEuBBd4otDHhCR/Rdo9Zsl8/a+6NjqNHL1mkPEsqgjXbpQ9Xc0N2t8fHbwrga8lUAcMGNOWkXWTLUpCt4lmU+Cl9e0n+j4VSWxvxkmIv44XbaKciXIslngprXWR2ynCuxKJpalnsYvuAd8PgQU6VSSWUMWvu9bgZOLTJGczUUCpm3NF5H5X4VKioO5+hkDIuV75ZhFB2F/l5Af37iU1MiepPq2cVUiFON84nM8BxiXbnxI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efbad96-1189-4fb6-0690-08d639867ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 07:58:30.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the runtime pm for lpspi module

BuildInfo:
	- U-Boot 2018.03-imx_4.14.y

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
V2:
 - Add pinctrl/consumer.h include to fix the Warning error: implicit
   declaration of function 'pinctrl_pm_select_sleep_state'.
---
 drivers/spi/spi-fsl-lpspi.c | 117 ++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b51746c2de00..1be29daa9f92 100644
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
@@ -152,13 +156,9 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
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
@@ -170,8 +170,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
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
@@ -458,6 +458,45 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
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
@@ -483,6 +522,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, fsl_lpspi);
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
@@ -529,28 +569,21 @@ static int fsl_lpspi_probe(struct platform_device *pd=
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
@@ -571,16 +604,50 @@ static int fsl_lpspi_remove(struct platform_device *p=
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

