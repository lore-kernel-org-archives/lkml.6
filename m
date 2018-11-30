Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C310C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A64E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xhjh7qXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A64E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeK3PhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:37:10 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:52709
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeK3PhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5jeEP8LDL6N8XyHEsMS5W9OWSljhVQonFR6duXpUz0=;
 b=xhjh7qXL7IJEop0J4Ux3epcOBsLEOHDN2iCDlI3aGer4H50udMc5Rguf2u7j8HOS9jZ9vCGyHrdPklpaaVxQAoZd54h68JbfsNbzmWmkEwkMxHGH/1wPSJ89eC1YHJkhXn5iNwNNvA9vbUH8rgxVtXORL9OwtwI8bMPVnqbGFrM=
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com (20.177.50.90) by
 VI1PR04MB4413.eurprd04.prod.outlook.com (20.177.55.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 04:29:05 +0000
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359]) by VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359%2]) with mapi id 15.20.1339.031; Fri, 30 Nov 2018
 04:29:05 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 1/4] spi: lpspi: Replace all "master" with "controller"
Thread-Topic: [PATCH V2 1/4] spi: lpspi: Replace all "master" with
 "controller"
Thread-Index: AQHUiGU6e8yE1Zw1ekGogryU74NfMQ==
Date:   Fri, 30 Nov 2018 04:29:05 +0000
Message-ID: <20181130042753.28756-2-xiaoning.wang@nxp.com>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To VI1PR04MB5021.eurprd04.prod.outlook.com
 (2603:10a6:803:59::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4413;6:YsL4AdXjcR48gLGFaD48poZG0WNmuNw7Y+j05mQR7pTh9mz+Z+uNOeXAj5UYH3nVuO2kEi+yuHde9OqEVKhyDRxvuMS/ft8OU1cpIxYreB6fAz+t09EImaJSSXCHIvkzUjUbGkdVS9vv3mFdQzFFra0WSN0+xK4DxYPlZ8+9jjCjfaz49qbKpXSPJKe4dvI3pfDPSx9Ac8zmgJk5e3v7X3RLheg2y46QKpXsyZxq9lXNrqHfmiHOHO1ApfmHIfQoUew2SZjsPQyoIYxgKidH1ie4NKG6AfpDINkTA7J99VzRAr0u70YXGgQs8V0PEmi0NQGiFmZpvpHCyQyBq2kQ7KlgY3YNx/MZPuGnwR3zKb2rucaVtyBIqidIAQXwwGbbs7K6LdnuaLnTaPf2Vj+3vTuF8j9iM4ZSPSbzvgrfaQgtsHGvAfjFAwWqXYE2C3pH8cERfgWeHqQm86Gc9OWwbA==;5:r2LZbnaKhu7VgYLZSre5AKUKhIfRVFvePKFwEB98TCpf1t/hxK6KIV1raj5OLnf2ai+C6ysqqr9xAjDVFcE0votZJWQR9U97/dh40+VN1gG0/405oOjDMLTTP8GQrhJs1EPQE69Lg+vb72emhCofY8krA6ePzQ/5ykGI5QYezXg=;7:2vtACpn5Mh4ACWLc2P5r2wNAUEnzI8i0CI1Pavlz+q5uSFMmb0jRg+UARaryvvDVfCJPWLlAem6hXN/At2/cvjZuAv3mEoi1KAZV9Q6ng7N3EbGix33Ursxia5LAmt67wT/7mYIpA9IsIUFDJw0AlQ==
x-ms-office365-filtering-correlation-id: d246843c-e8f3-4333-58a8-08d6567c5cba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4413;
x-ms-traffictypediagnostic: VI1PR04MB4413:
x-microsoft-antispam-prvs: <VI1PR04MB4413812E83760C31A89652F9F3D30@VI1PR04MB4413.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4413;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4413;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(54534003)(199004)(189003)(81156014)(6436002)(76176011)(53936002)(186003)(6506007)(81166006)(256004)(8676002)(6486002)(386003)(26005)(8936002)(11346002)(14444005)(99286004)(52116002)(7736002)(316002)(36756003)(2616005)(54906003)(86362001)(305945005)(102836004)(71200400001)(2351001)(14454004)(478600001)(2501003)(71190400001)(68736007)(476003)(1730700003)(6512007)(5640700003)(6916009)(105586002)(3846002)(486006)(66066001)(25786009)(106356001)(2906002)(6116002)(97736004)(446003)(5660300001)(4326008)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4413;H:VI1PR04MB5021.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CCk0eeqG0iSzIEImD1b+a6BXlihaebw3cQhJ0FlIvn1It3lYLL6Zb9kavZgvfkM5yK7xIYLSk5HjNsDLYoHB+4L0vkJENFoam6kdQs4L0Q8zfD7PZkWU0n31APB1nsQSrCb4dAMJOZ19JPiV28z0Gld5sajiZy+SbFO6TJmAyNHeDQY9dHvqvwt+gW510tlXFdNMWENxdooLvHB+u6xy0xfCDx/EAVsiS7kii5vMNd+OynwpVSKnk9jCTPP1YJR74/kDKiSGWgoIkmc/uC9z7cN2eCaquFesOD5eUnE35iib1bVIMRF8/rrSFKdAu5G6mELKPV4OIoyZeHN/ntP8KCiVdLFfejGrph1I7NuemNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d246843c-e8f3-4333-58a8-08d6567c5cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:29:05.4434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4413
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
V2:
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

