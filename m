Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F79C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AD32146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0D9wYBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AD32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLDGZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:25:04 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:35008
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeLDGZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zw+UN/rgbr0IFDl7BPqVNsyqeGnwD/2Is1cv6bBdXU=;
 b=D0D9wYBLSskCcKpUtrJ5rL/enwNVVtIpOr/d2NXfqzt87dDuL9pIeHxyydPzozpsH9Jpwy8RJQJDWCG2DjYiTCrJDj8AYMq/lDVoK4sj2QhQPCEOHSqHECv3K/E9x8dZkI2n6lWzzZH3F/MtY76U54d8nfgFhZvZ0Not/0d1VSw=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5720.eurprd04.prod.outlook.com (20.179.1.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 06:24:59 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 06:24:59 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: Add cs-gpio support
Thread-Topic: [PATCH] spi: lpspi: Add cs-gpio support
Thread-Index: AQHUi5oV18iLHkPhlEO5KoZOnZS+lA==
Date:   Tue, 4 Dec 2018 06:24:59 +0000
Message-ID: <20181204062313.28942-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5720;6:PG7/tH1SeZWCRPM8M2+LaTDLXYj/QmsoH+PXRi7mlZnrmEnMSv/lYGbDuctBUdZk1sM1Nj+xr8oB8k7D/s6mcIwSb0N4oahoNFz46nKpvfsDoFfempCToQJivcELv/E02Eprit7rjzjl305qmmmJEIHnXzjzSIEm56lCi2XKLjf16ip8RUtFUeB0YoNHwVsZhQNYb+C/exlhwKAI6LFVf4larZoZI4sk0k1FLpQfgfwzdvlUC/9SdZ57UyUiIOSdI/NfCxu2oUPec/GRC8N4GtwTy7J9JRndWIw3y9M3ks+2IVS2PNzh2/R6YYyPpKLOAySKQb1hHWuqlOjfmUgXsMMT6s1iayf5JgNVAVL0VY0jVvC/g81fh7c38caRNCxsQiUWVvDtyR7scLiNH4F+QysN7U7Xym+BDQ8siTrlWh/OADiQWa1eY4qcREIbTLxBgmWn8eSXEITw88DUWsYcOw==;5:Eiyea5oRxfvczTEHi4iEePjfSti7OrwdTVlMCKvayniOvaRTpWpjY5Yqy9F2LZQf3b6I6E6kpkxXiX6Nbfqk+C2rZ4UQRxEGQM4xkrbWsITeDWCtkX8TI01+rAuX4YyuSV5+UlTPm+pcVtxoPqfCKVSKC4Jvg05i/6C/fcxGh58=;7:8fdSmwksGBUWEMIe9m9+qFi9VxEAzWrCJFdqwrU76K/AAkozygXlJ3MBKZh/yKIMxwS3zNpeINzh+gsez/J1J2qQPURv1r6+dT46TgwTZ02dERwkrq8hbOFloKMSgngyZJ0+xUA9Jb5vrlrmwQ9LRw==
x-ms-office365-filtering-correlation-id: 2d6b9eb4-b3f5-4dc9-fdc2-08d659b13758
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5720;
x-ms-traffictypediagnostic: AM6PR04MB5720:
x-microsoft-antispam-prvs: <AM6PR04MB5720D3A75224553D2B965FC3F3AF0@AM6PR04MB5720.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5720;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5720;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(6506007)(71190400001)(14444005)(256004)(71200400001)(6512007)(2906002)(26005)(5640700003)(6916009)(6436002)(66066001)(8676002)(1730700003)(186003)(6486002)(4326008)(99286004)(5660300001)(2616005)(476003)(68736007)(52116002)(386003)(102836004)(486006)(53936002)(36756003)(305945005)(575784001)(86362001)(6116002)(3846002)(105586002)(1076002)(316002)(7736002)(54906003)(106356001)(478600001)(81166006)(81156014)(2351001)(14454004)(8936002)(2501003)(97736004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5720;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wXt3Wb8Wt6gzLxYN+8GmjvV/WhS7BHfiqkzmOIDELgTGqgiQbZlEspoL6l/jsD9n36kSJBY0dfLRBbY03i5rViMZGZinAf7KMzVSDeE+yAfKOXruBkcjkd+G5rtQXnAW1dMfzwXoaUpkx5G7CmcTXX2yDdkN2VC4zgo0Yq7g0lqCSBN6sx2r5k5ZY6e+K+wi1QuRJv7Lhxoxt9SfYm25mil6Lp/mNJ2a5blsNMV8fWimnpO5LIR2HbjFYjVJT0uVhxOeK6MtXRWT1ggLjx1Ozr45SUAi7ehe9bx7LzU/0V5cUD1wf4CcMBbziFlHeua7ITWAmoxk2k3tpBJ98aGeNVYmdTw4Y2WhE829URkO/M8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6b9eb4-b3f5-4dc9-fdc2-08d659b13758
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 06:24:59.5138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
fsl_lpspi_unprepare_message() to enable and control cs line.
These two functions will be only called at the beginning and the ending
of a message transfer.

Still support using the mode without cs-gpio. It depends on if attribute
cs-gpio has been configured in dts file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a7d01b79827b..c6fe3f94de19 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -16,7 +17,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/spi-imx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -28,6 +31,10 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+#define LPSPI_CS_ACTIVE		1
+#define LPSPI_CS_INACTIVE	0
+#define LPSPI_CS_DELAY		100
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -104,6 +111,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[0];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -176,6 +185,48 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static void fsl_lpspi_chipselect(struct spi_device *spi, bool enable)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	enable =3D (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable);
+
+	if (!gpio_is_valid(gpio))
+		return;
+
+	gpio_set_value_cansleep(gpio, enable);
+}
+
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+						struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+	struct spi_device *spi =3D msg->spi;
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	if (gpio_is_valid(gpio)) {
+		gpio_direction_output(gpio,
+				fsl_lpspi->config.mode & SPI_CS_HIGH ? 0 : 1);
+	}
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+
+	return 0;
+}
+
+static int fsl_lpspi_unprepare_message(struct spi_controller *controller,
+						struct spi_message *msg)
+{
+	struct spi_device *spi =3D msg->spi;
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
+	return 0;
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -512,10 +563,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
fsl_lpspi)
=20
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	struct device_node *np =3D pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
+	struct spi_imx_master *lpspi_platform_info =3D
+		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int ret, irq;
+	int i, ret, irq;
 	u32 temp;
=20
 	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
@@ -539,6 +593,29 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
+	if (!fsl_lpspi->is_slave) {
+		for (i =3D 0; i < controller->num_chipselect; i++) {
+			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
+
+			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
+				cs_gpio =3D lpspi_platform_info->chipselect[i];
+
+			fsl_lpspi->chipselect[i] =3D cs_gpio;
+			if (!gpio_is_valid(cs_gpio))
+				continue;
+
+			ret =3D devm_gpio_request(&pdev->dev,
+					fsl_lpspi->chipselect[i], DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+		}
+
+		controller->prepare_message =3D fsl_lpspi_prepare_message;
+		controller->unprepare_message =3D fsl_lpspi_unprepare_message;
+	}
+
 	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
--=20
2.17.1

