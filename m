Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFEC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8DF2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="omb1KIjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8DF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLGCul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:41 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:17184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeLGCuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHThIk8fDDEJfOXx4gFkgF/DQFc4X0o9bbBKeKPxEXw=;
 b=omb1KIjj/WZgGwZ24fjSC77LRpZE4SQvUwNJHACp3F/LCNHiXiv22wqtPHFIOWKXPBK4iDStth5NaGVbkboMkyFM6P/GZWpvBrXRw09d9uf+qhWkTss4S8OTJnUi5MaKysjGRLXfJzUm6ao1AO88/0QLOND+mjpc6P0UdbwjdDs=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5798.eurprd04.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 02:50:34 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 02:50:34 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 1/4] spi: lpspi: Replace all "master" with "controller"
Thread-Topic: [PATCH V3 1/4] spi: lpspi: Replace all "master" with
 "controller"
Thread-Index: AQHUjdeg0+sBOSEVtEi0nHBu80zSLA==
Date:   Fri, 7 Dec 2018 02:50:34 +0000
Message-ID: <20181207024924.6315-2-xiaoning.wang@nxp.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181207024924.6315-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To AM6PR04MB5016.eurprd04.prod.outlook.com (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5798;6:yX1Q5VQQSJMwLWXvDxnYtLf/AfxbNGyZyzRzOA8Ujx+lsI0ZNTStu6hbiwZE9Xm0yn2Eb3HU4BccHTn8gEjDC8o+mRdi0H5al8lWlmCoTVjitvE5nnIRf8WNs2Z9zvCdUd+aYBBbkJHEot8lCpVszyY/+d5tWAzLZY9RMesbUayvSUYOE+DvFESKyFBYAn0Jhz/pudowPHAppqPrYSjj5tyaGO4ymDY++b6frsz/49upF5xkte7NEkDPCXHWcatV3EExwj4nyEwGSovFmEIsZsinJIVhQSDpStwz8sKEXB4lY1ARd/5Lbf7Bfqq4sL663H3fa0WLxnEmkrEL2RJvTQC5R8y7nGmAEq51YvmGr5fArRKVo2++I0PN7EfjXAbgH4h9kPXytbUFhdqI2X/RZMiTfHJB/km1q89vSPDq6OhPKOZuPKa04a83fYgeyxKmgFsGG06hWhmtsflYMoccGQ==;5:YqKgtbAPtnK613aX1u83AXJFJ0AmpaityDL60WoAmK6nITV+q1oUVRqeQWlMctnKO1KBRRFcJgMyXDqxMqBDQ8HbQ9CeGG+ZLnG+I4mldMvj4HSDkwnbhczZe3z54caDaVpSLhrDMwWPByULtpPf7w15h6VxfTI1Ao53Ni+qkJg=;7:aizBAfpWRh2I4x5FI+EonBlrFVX+DFaJzCBXgNn/k75f/aCLcq1r+uPWnyUAAygHPp2FZI0PrjJIuPGVf7Ny3KrJOo32VA+fHws/EgS7cmHuokmAf3vVXZcFhfwbcM3AHAeIFNiUvvjJDQcnUmQWVg==
x-ms-office365-filtering-correlation-id: fa1e2e86-005c-4890-6590-08d65beec29b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5798;
x-ms-traffictypediagnostic: AM6PR04MB5798:
x-microsoft-antispam-prvs: <AM6PR04MB57986F3287CEE95D12A20F68F3AA0@AM6PR04MB5798.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5798;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5798;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(54534003)(189003)(199004)(71200400001)(476003)(316002)(54906003)(71190400001)(14454004)(25786009)(256004)(14444005)(6512007)(2501003)(6916009)(68736007)(52116002)(386003)(6506007)(2351001)(66066001)(6486002)(76176011)(6436002)(5640700003)(4326008)(106356001)(99286004)(105586002)(53936002)(186003)(36756003)(478600001)(1730700003)(26005)(2906002)(6116002)(3846002)(86362001)(8676002)(11346002)(1076002)(446003)(97736004)(486006)(102836004)(7736002)(305945005)(2616005)(8936002)(81166006)(81156014)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5798;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iIXjw53CYu5pIPfewCl6lG3FPbaePWqEUXRteOANPQhExmnY2+Bms46L3ldu5oxvj/QQhpFTta8DJam+8pD3mpPcZ8Q95AAsIBFAjb+2xk2eiuq5y4F0CUGrtqBSTeIPp8QhRGMk5vqzZwnMku7Ij9Sj2ZxfRUKMjr8qkt7c/x2c0hNMzNdp73ghjHtUp8Pt0RExRP6Xkwsky+nh3r5H4ZaYfQ4dwVvTmbsC06poe4kr+HgTzaW7PgA9USIuXpB4+8KvjlWv9XmbJmBurWz0hSwIqTuWnnhV88fcwkHtXSUZiFRHWSaUfDsGLGlp1Pjj1LhrMdr9IILDGYFyS7jnWKf9KoAlOroErcAp6905roQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1e2e86-005c-4890-6590-08d65beec29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 02:50:34.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable the slave mode and make the code more readable,
replace all related structure names and object names which is
named "master" with "controller".

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2/V3:
 - No change.
---
 drivers/spi/spi-fsl-lpspi.c | 84 ++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51670976faa3..725d6ac5f814 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,6 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2018 NXP Semiconductors
=20
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -137,16 +138,18 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *=
fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
=20
-static int lpspi_prepare_xfer_hardware(struct spi_master *master)
+static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	return clk_prepare_enable(fsl_lpspi->clk);
 }
=20
-static int lpspi_unprepare_xfer_hardware(struct spi_master *master)
+static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
@@ -291,7 +294,8 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
lpspi)
 static void fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(spi->master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
=20
 	fsl_lpspi->config.mode =3D spi->mode;
 	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
@@ -318,11 +322,12 @@ static void fsl_lpspi_setup_transfer(struct spi_devic=
e *spi,
 	fsl_lpspi_config(fsl_lpspi);
 }
=20
-static int fsl_lpspi_transfer_one(struct spi_master *master,
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
 	int ret;
=20
 	fsl_lpspi->tx_buf =3D t->tx_buf;
@@ -347,10 +352,11 @@ static int fsl_lpspi_transfer_one(struct spi_master *=
master,
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
+static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
@@ -366,7 +372,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master=
 *master,
=20
 		is_first_xfer =3D false;
=20
-		ret =3D fsl_lpspi_transfer_one(master, spi, xfer);
+		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -380,7 +386,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master=
 *master,
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
 	msg->status =3D ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(controller);
=20
 	return ret;
 }
@@ -410,30 +416,31 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_i=
d)
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
-	struct spi_master *master;
+	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
 	u32 temp;
=20
-	master =3D spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
-	if (!master)
+	controller =3D spi_alloc_master(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	if (!controller)
 		return -ENOMEM;
=20
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, controller);
=20
-	master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
-	master->bus_num =3D pdev->id;
+	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
+	controller->bus_num =3D pdev->id;
=20
-	fsl_lpspi =3D spi_master_get_devdata(master);
+	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
=20
-	master->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
-	master->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
-	master->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware;
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	master->dev.of_node =3D pdev->dev.of_node;
-	master->bus_num =3D pdev->id;
+	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
+	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node =3D pdev->dev.of_node;
+	controller->bus_num =3D pdev->id;
=20
 	init_completion(&fsl_lpspi->xfer_done);
=20
@@ -441,32 +448,32 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 	fsl_lpspi->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fsl_lpspi->base)) {
 		ret =3D PTR_ERR(fsl_lpspi->base);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret =3D irq;
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	ret =3D devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(fsl_lpspi->clk)) {
 		ret =3D PTR_ERR(fsl_lpspi->clk);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	ret =3D clk_prepare_enable(fsl_lpspi->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
@@ -475,24 +482,25 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
-	ret =3D devm_spi_register_master(&pdev->dev, master);
+	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto out_master_put;
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
 	}
=20
 	return 0;
=20
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(controller);
=20
 	return ret;
 }
=20
 static int fsl_lpspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master =3D platform_get_drvdata(pdev);
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct spi_controller *controller =3D platform_get_drvdata(pdev);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
@@ -509,6 +517,6 @@ static struct platform_driver fsl_lpspi_driver =3D {
 };
 module_platform_driver(fsl_lpspi_driver);
=20
-MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_DESCRIPTION("LPSPI Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
 MODULE_LICENSE("GPL");
--=20
2.17.1

