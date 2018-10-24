Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DFAC7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F220832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nz6FWcJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0F220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJXLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:16:42 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:39072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeJXLQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkDy/10rfVyk3kFl/ZIlGeUvahNPDmr3nbBPdwHFx+E=;
 b=Nz6FWcJfY9uOXAf8r+BoPRN8Nz74Y3YyphnTdchrpdI7fxeKUSpRvR0emheCAr8M9KfsTaZONVNRBozIl9/sWIejD7J2xqfx2b/FLpUxhNBUSnAVQrfzDZZrPd5yNypVH6Kx2xNUX8x7tuAZwRs54KIPiHT1ZInzpucu1/Rc1uU=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4358.eurprd04.prod.outlook.com (52.135.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 02:50:29 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:50:29 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: [PATCH 4/5] spi: lpspi: enable runtime pm for lpspi
Thread-Topic: [PATCH 4/5] spi: lpspi: enable runtime pm for lpspi
Thread-Index: AQHUa0RTVdeDoWJiFEiPdIovVZAROw==
Date:   Wed, 24 Oct 2018 02:50:29 +0000
Message-ID: <20181024024808.14485-4-xiaoning.wang@nxp.com>
References: <20181024024808.14485-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4358;6:tNLMDUffx8SC1wKuPxLq633xM8WEzz3qlwpktTpXaam/ZbYNQ6tuBUGDktjycgnFwAD0U3YXmehKCrPFCrCtK7S932nD/3vrwPlZMQTLOwXRxOY0WP7oB9C+RriSnaz0q6iRZIOiEPAbHvLyWDskYaaj56REw7oUGum1ZRiIdXD8AOLeIAFMAtLYtOSqfu8lE/MOBx4CN0KNk8rtR73gDsQHFaGtUGcKfTE4NT7sPeVH72en4snFan5OlQaN1ouFazVDClJtuDlsaHBX4gRQ//DSZJalztQPlRww3O2kuSaJqXZPuS2pdSGJg8s8em2GMej8fzfyjpqZuGFOMgGuew51/kmO4qMe9OQE4R7e/jAScceanwVbaiqxFgv/ue8AYs/kccWM9jXM0iEEDf8ZjZ42xIeWVWABWoyTq52Mbfa95I3irCHgZK6Bu/uM5Nqfpf6j1rXSt0SQ5ac9iKzOmA==;5:eDvbCX75GocdqnoC130qTLjX01O7mKXNJgMZY0PjbnYXPWC9bqVU5fpgxn2oflO6enLqfZarq70/QrCdBtA/D0GHwDoPVhWVPhkkfD3Fd1a0Laa+qtZFa8f+5rTOgJ0Ne6sxUlU93I13zBx9+8xbo/0L0TrC26aAiH0AI98F11U=;7:8/EssZOp3buoh5z6fVrsaaaSTFXm+IO8ecGmREI6rFUIS5o2MgOd4/cOO1S/VpMBzPBF5+sB8X4/bCFsBqiuyCcs/hw+2d4Hpr400+W65m8+OHOBfVkzkfqAyn7ibsAsfGM1fQ3wEQFyP1qeDvKoBIi0HX0bTX+NEodNmVu/TzA0s5kpRe/WP0tiCF5hxRGYPEz5pvLdoEzLpNQHcf9kCmmHGEY6PHUWLWBQPGrnujxuIGtTJDg+NOhTA6/DbvJj
x-ms-office365-filtering-correlation-id: bcb89c08-4850-4b3d-8f8e-08d6395b7580
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4358;
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB4358FD4153562464155A36C0F3F60@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4358;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4358;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(575784001)(36756003)(53936002)(105586002)(71190400001)(99286004)(256004)(14444005)(386003)(6506007)(71200400001)(102836004)(8936002)(14454004)(7736002)(4326008)(305945005)(1730700003)(81156014)(316002)(106356001)(5640700003)(81166006)(2351001)(2501003)(478600001)(6436002)(54906003)(3846002)(5660300001)(476003)(8676002)(6116002)(11346002)(66066001)(6916009)(26005)(486006)(446003)(68736007)(76176011)(25786009)(6512007)(6486002)(2900100001)(2616005)(2906002)(97736004)(86362001)(1076002)(52116002)(186003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4358;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: er0H6DQ4wZ+QwLzbSUiS57M9ec1PU8DGH48CDlHdZ6SAIvuMUuosUdJ5qb/VClS8majrLMihfdo1l+iT5JXbgV9htAJpfLMOCOIOya6IdxjwF9gulAl2e8JNq9GorsisabyEtrrw1wvXlT4y6JVEippLkIHP9xv5Pee4/f8Jngdb2/C8NNQCA2yYHJrKK1Dksk25ppGBopwPzSQSY0BZIPTI0OIBDqMHQLE1NqoHe9b5dfbPu42TQJ7Ro5wtO26Lp9Kx4AdmCtvZw30dBCSZ46LiFd50pSbVYpUPTb8SM7UZs0gq/MV1WB2/MQqDExfoFT3QbTSPn/zGGESxyp1+46Ja3/+x6DX3LgtiesZMMB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb89c08-4850-4b3d-8f8e-08d6395b7580
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:50:29.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
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
 drivers/spi/spi-fsl-lpspi.c | 116 ++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a4ad3e881a5e..a8a6699e2741 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -21,9 +21,12 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
+#include <linux/pm_runtime.h>
=20
 #define DRIVER_NAME "fsl_lpspi"
=20
+#define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -152,13 +155,9 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
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
@@ -170,8 +169,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
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
@@ -462,6 +461,45 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
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
@@ -487,6 +525,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, fsl_lpspi);
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
@@ -533,28 +572,21 @@ static int fsl_lpspi_probe(struct platform_device *pd=
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
@@ -575,16 +607,50 @@ static int fsl_lpspi_remove(struct platform_device *p=
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

