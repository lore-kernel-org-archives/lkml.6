Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52CDC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BB220651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JLG/1esf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BB220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJXLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:16:34 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:39072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbeJXLQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyIbRNlcdr2cr3asLMhzZyef7hh+0DWcBbT0h7DCDhc=;
 b=JLG/1esfJ4V8NQR8wldUr9Fj6Xp6+kA6Ii54w+WHD4MmLwwv6IEryq9DiGc5XS3kjUGe14UsDrUg0uOea27STNJny6E7AWHp6Y1ix8eG4vvRrB9Xrd2WM4pMZRrp2lkGvajcZ787a1dOlONba0wc8Q32YoCfOQwew4V0E+I9X6c=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4358.eurprd04.prod.outlook.com (52.135.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 02:50:23 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:50:23 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 1/5] spi: lpspi: Add slave mode support for imx7ulp
Thread-Topic: [PATCH 1/5] spi: lpspi: Add slave mode support for imx7ulp
Thread-Index: AQHUa0ROWv5KDz2tOEy+bVKJ5m0K0w==
Date:   Wed, 24 Oct 2018 02:50:22 +0000
Message-ID: <20181024024808.14485-1-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4358;6:3X3lBH43KN+96TfDtEpZrpPGQv8clKrdnrNjVsqaMLv7ynlZAyym6/dPXJlse6oqr6OcEQf1F2JQVgMwqdmhT5PCWPKmrnyGS3KV8xUn63aShaWFkbxIUDtw4Ol645uSSB0+XISZ3KjttUpOqL9heJdMo/2F3aQJw12c/NiszOM7ORBJ8llrXUEiQRcoztBzxS752xkPSRUiQ/2YtBh/Zx8lcVKMLBgPYQY2QxpcXtntWkLEDS569fB58+EQ1vvph4bZ/K6zDVI7WRoUChoid4srMvRVKkYPcp4hBwfNFNDEyOArHhatSZNd1cmdgMPSb8WRxs7wSU518Otu6ee5kfI0oLmBdi3Cja0x4gEMyzihUXyz/HaevlDofdnd0+CpSchZD48l4t0FF8VLJQOeTlkYO1BOPRjwBFF13Hke0aOGxYzcAhZW8zzXbzm0OtGv5uWTxAB0CV+GBHq9nTDZxA==;5:fI52EJ9Vcb64GEGWxh0agZAQKLjwQmFcfNBZt2mD0oPtVManFZG2bOWa8BAB1KHg9AlkzN8EHSi/O5H2HJGTEy+yRIuxbwLIPWQxPaE0zynDge610y3f1b+XMQfkEtWj7XslfdBGDSvrDfYD2WgS0il7NLYtX9RXQrw4Lh8siTc=;7:+AWmFQvbZozQ/KII86AlyEd8SDD3bmwCo5mzCpq9PhB1SgFSthNDpyiBKL7ODpOGVaiQXWhSWac/C2NNd9D1uPb3i2C+dm6NGErsc4bw0zDaMW2bQy9wfXHZcSBqqFQKPKBfNpftv4xKlTAn6d3txyvCMW27cQ9roz63RZJuwXSKQIXN05+gMYM4bCj0kT+uOoqKD5bP0QRvYUNTBeYTaBjdsqyUOqAYhzUodtaQR48+WxOTvZW/Gbk+lRippitB
x-ms-office365-filtering-correlation-id: c357091d-ad28-47eb-1152-08d6395b7152
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4358;
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB4358606FD6C2252D1BAA4F24F3F60@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4358;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4358;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(36756003)(53936002)(105586002)(71190400001)(99286004)(256004)(14444005)(386003)(6506007)(71200400001)(102836004)(8936002)(14454004)(7736002)(4326008)(305945005)(4744004)(1730700003)(81156014)(316002)(106356001)(5640700003)(81166006)(2351001)(2501003)(478600001)(6436002)(54906003)(3846002)(5660300001)(476003)(8676002)(6116002)(66066001)(6916009)(26005)(486006)(68736007)(25786009)(6512007)(6486002)(2900100001)(2616005)(2906002)(97736004)(86362001)(1076002)(52116002)(186003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4358;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y+6T4nvCL2RNpeW1K34BsWCEjGaTKTGl6xWz9XtelP07u59Ui2FqvAtQtUdeeCXP2Yygv2+MPXQSb/w40xBw32cyXi1yngl8nJ98JMdlbt0QMoGn6WDRp3RQFGy2F35MH/WW4Qi9AdnjmIgXs9WXDX/4tEKIEUBVAwcsaV7hPWiuU0Jadqvw125ScYWLP2wP+o1oto25y4bli+8NPD6KSDxbPSLAJi3uK9Yvtt2eVgP0BWpneyoqBKhMCW11q+bE/zFK7os8qGzxW/t4QKlz76k0hZVmRzCQiZXnrVhE2r1aOQkyEa9i8r2mwa3N02S/Irq6a40Oj3hUKq70LDISIeo04Um5+wP3RPSAg3Y2Y+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c357091d-ad28-47eb-1152-08d6395b7152
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:50:22.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPI slave mode support for imx7ulp, in PIO mode.

Add "spi-slave" attribute in spi node of dts file to boot.

For now, slave has to send the message which is same as the length of
message master sent.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 209 ++++++++++++++++++++++++------------
 1 file changed, 139 insertions(+), 70 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51670976faa3..86cb38d98a39 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,6 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2018 NXP
=20
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -54,6 +55,7 @@
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
+#define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
@@ -79,6 +81,7 @@ struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	bool is_slave;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -86,11 +89,14 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *);
=20
 	u32 remain;
+	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
=20
 	struct lpspi_config config;
 	struct completion xfer_done;
+
+	bool slave_aborted;
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -137,16 +143,18 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *=
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
@@ -202,22 +210,26 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi,
 {
 	u32 temp =3D 0;
=20
-	temp |=3D fsl_lpspi->config.bpw - 1;
-	temp |=3D fsl_lpspi->config.prescale << 27;
-	temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
-	temp |=3D (fsl_lpspi->config.chip_select & 0x3) << 24;
-
-	/*
-	 * Set TCR_CONT will keep SS asserted after current transfer.
-	 * For the first transfer, clear TCR_CONTC to assert SS.
-	 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
-	 */
-	temp |=3D TCR_CONT;
-	if (is_first_xfer)
-		temp &=3D ~TCR_CONTC;
-	else
-		temp |=3D TCR_CONTC;
-
+	if (!fsl_lpspi->is_slave) {
+		temp |=3D fsl_lpspi->config.bpw - 1;
+		temp |=3D fsl_lpspi->config.prescale << 27;
+		temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
+		temp |=3D (fsl_lpspi->config.chip_select & 0x3) << 24;
+
+		/*
+		 * Set TCR_CONT will keep SS asserted after current transfer.
+		 * For the first transfer, clear TCR_CONTC to assert SS.
+		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
+		 */
+		temp |=3D TCR_CONT;
+		if (is_first_xfer)
+			temp &=3D ~TCR_CONTC;
+		else
+			temp |=3D TCR_CONTC;
+	} else {
+		temp |=3D fsl_lpspi->config.bpw - 1;
+		temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
+	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
 	dev_dbg(fsl_lpspi->dev, "TCR=3D0x%x\n", temp);
@@ -227,7 +239,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_da=
ta *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
+	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -253,7 +265,8 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	if (prescale =3D=3D 8 && scldiv >=3D 256)
 		return -EINVAL;
=20
-	writel(scldiv, fsl_lpspi->base + IMX7ULP_CCR);
+	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
+					fsl_lpspi->base + IMX7ULP_CCR);
=20
 	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
@@ -270,13 +283,18 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
l_lpspi)
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 	writel(0, fsl_lpspi->base + IMX7ULP_CR);
=20
-	ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
-	if (ret)
-		return ret;
+	if (!fsl_lpspi->is_slave) {
+		ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
+		if (ret)
+			return ret;
+	}
=20
 	fsl_lpspi_set_watermark(fsl_lpspi);
=20
-	temp =3D CFGR1_PCSCFG | CFGR1_MASTER;
+	if (!fsl_lpspi->is_slave)
+		temp =3D CFGR1_MASTER;
+	else
+		temp =3D CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |=3D CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
@@ -291,7 +309,8 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
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
@@ -315,14 +334,51 @@ static void fsl_lpspi_setup_transfer(struct spi_devic=
e *spi,
 		fsl_lpspi->tx =3D fsl_lpspi_buf_tx_u32;
 	}
=20
+	if (t->len <=3D fsl_lpspi->txfifosize)
+		fsl_lpspi->watermark =3D t->len;
+	else
+		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
+
 	fsl_lpspi_config(fsl_lpspi);
 }
=20
-static int fsl_lpspi_transfer_one(struct spi_master *master,
+static int fsl_lpspi_slave_abort(struct spi_controller *controller)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	fsl_lpspi->slave_aborted =3D true;
+	complete(&fsl_lpspi->xfer_done);
+	return 0;
+}
+
+static int fsl_lpspi_wait_for_completion(struct spi_controller *controller=
)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	if (fsl_lpspi->is_slave) {
+		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev, "interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		if (!wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ)) {
+			dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
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
@@ -330,13 +386,13 @@ static int fsl_lpspi_transfer_one(struct spi_master *=
master,
 	fsl_lpspi->remain =3D t->len;
=20
 	reinit_completion(&fsl_lpspi->xfer_done);
+	fsl_lpspi->slave_aborted =3D false;
+
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
=20
-	ret =3D wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ);
-	if (!ret) {
-		dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
-		return -ETIMEDOUT;
-	}
+	ret =3D fsl_lpspi_wait_for_completion(controller);
+	if (ret)
+		return ret;
=20
 	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
 	if (ret)
@@ -347,10 +403,11 @@ static int fsl_lpspi_transfer_one(struct spi_master *=
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
@@ -366,7 +423,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master=
 *master,
=20
 		is_first_xfer =3D false;
=20
-		ret =3D fsl_lpspi_transfer_one(master, spi, xfer);
+		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -374,13 +431,15 @@ static int fsl_lpspi_transfer_one_msg(struct spi_mast=
er *master,
 	}
=20
 complete:
-	/* de-assert SS, then finalize current message */
-	temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
-	temp &=3D ~TCR_CONTC;
-	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	if (!fsl_lpspi->is_slave) {
+		/* de-assert SS, then finalize current message */
+		temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
+		temp &=3D ~TCR_CONTC;
+		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	}
=20
 	msg->status =3D ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(controller);
=20
 	return ret;
 }
@@ -410,30 +469,39 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_i=
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
+	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
+		controller =3D spi_alloc_slave(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	else
+		controller =3D spi_alloc_master(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+
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
-
-	master->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
-	master->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
-	master->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware;
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	master->dev.of_node =3D pdev->dev.of_node;
-	master->bus_num =3D pdev->id;
+	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
+						    "spi-slave");
+
+	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
+	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node =3D pdev->dev.of_node;
+	controller->bus_num =3D pdev->id;
+	controller->slave_abort =3D fsl_lpspi_slave_abort;
=20
 	init_completion(&fsl_lpspi->xfer_done);
=20
@@ -441,32 +509,32 @@ static int fsl_lpspi_probe(struct platform_device *pd=
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
@@ -475,24 +543,25 @@ static int fsl_lpspi_probe(struct platform_device *pd=
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
@@ -509,6 +578,6 @@ static struct platform_driver fsl_lpspi_driver =3D {
 };
 module_platform_driver(fsl_lpspi_driver);
=20
-MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_DESCRIPTION("LPSPI Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
 MODULE_LICENSE("GPL");
--=20
2.17.1

