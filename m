Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6935EC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A78E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5SzN72x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A78E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGCuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:44 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:17184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeLGCum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLuDSWfRMi89exufHEFDB+4k1RQQ4sNsuOrUPHSfO+M=;
 b=Y5SzN72xUb5rL3g4J2GxmJ66zTp3m5Qp8KADUkFMsdYcN+dmjAr6LP4IkYNqkHYKRzJwe0qfnu49SFIKaL6dWcI53kCq2+fzyZSdhxFyJhM3xjbm99PibBLYM5njrmJ46OVDm7e+CdZBNrwJr/7/otGpwQYQxjvVtl2I0wsZdds=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5798.eurprd04.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 02:50:36 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 02:50:36 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 2/4] spi: lpspi: Add slave mode support
Thread-Topic: [PATCH V3 2/4] spi: lpspi: Add slave mode support
Thread-Index: AQHUjdeh27Kj0k61eU2j0EgnRs/g1w==
Date:   Fri, 7 Dec 2018 02:50:36 +0000
Message-ID: <20181207024924.6315-3-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5798;6:Lp/qSrg7fYa5/TOfzOhKI93q7T/SU4up7vFmZqnB6Ezb9KOPFjfbpjGomivVxlNzDXMMqb40eIdKaI0XZY5uEVgpQVTd08N/on7oDbd2c6d35cpo6/TCTm79hEpAqThjUrCAFz6zXOyV8kihqU/10Tecj70XhY1yfDbGgx8uaUYMgS9Gzg00MisGbHlanLsejfFAiE1gE070itbSoO1nqWgnM8uNv44FYbvasKi30lD2Nhu8WxfESIoEA+xx5NBFJ2u++BxDibrTHS6HoGWKEnp2oIkRe4UuQaXCbFffNJHeMhUn1Y6rTkAgrZFmy+TRGdN61XiRFbz5arSQWNVL12k2oy4YqklH01RxwEqsBsUuT/OFPDYc6B8a7z3rexLnZhFldRbeL6NyycpuVzJRomTsfhJqO/ELvz/MCNx324BVuZ9drJ46THdZTqAS6bZxQQI+py93YyG6OSnaLAXDLw==;5:eTlMdRxnGL5StuBiB7pJsLB+NWru1t7IbiUoeHAHQuGsMyQCi59/ZT5W7ROPvOVrLehGbzJkhBEWahVGyfFENgszuVpE8WXH5mbAlOtmmcE3jNwI06YrRmNC3/5IYalSIoJ1EAT00/fKC24vrwAhMJ7xs7pXmAxtyFd0u8lI7ko=;7:pVmPESUyuB+3UhQtCDEMKSVd5m0cQnTxdh0n3yWnIMUAfjuHN1CzA6ulHe60AkxRjELbZOTRl+56ndbvsba/5QCRiOFTZmhawMCiRFICN9jU+m+RTXs6/S2SbgPhgMq8Q6tu4HjjKhA0dDcllltkXA==
x-ms-office365-filtering-correlation-id: 265a841e-11f2-4910-2203-08d65beec3e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5798;
x-ms-traffictypediagnostic: AM6PR04MB5798:
x-microsoft-antispam-prvs: <AM6PR04MB5798C867983E73434387CD77F3AA0@AM6PR04MB5798.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5798;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5798;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(54534003)(189003)(199004)(71200400001)(476003)(316002)(54906003)(71190400001)(14454004)(25786009)(256004)(6512007)(2501003)(6916009)(68736007)(52116002)(386003)(6506007)(2351001)(66066001)(6486002)(76176011)(6436002)(5640700003)(4326008)(106356001)(99286004)(105586002)(53936002)(186003)(36756003)(478600001)(1730700003)(26005)(2906002)(6116002)(3846002)(86362001)(8676002)(11346002)(1076002)(446003)(97736004)(486006)(102836004)(7736002)(305945005)(2616005)(8936002)(81166006)(81156014)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5798;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: edqmuJSqaUPDvLguir8B0v9PDtW5PwX3G41p3b5XzIz0M6LwQskylpR89elY2W7g+8/LicXoe2gQfBd6YZzonw9gQGa/BgjLGNhUPZthSpPFyghB3FpE/gPDPJdV2U8NylMb8JEa3i9MgLOwSSkNdOIXfp6AoC4/EuyLKVRZ0Zo5M/rc2chzJ61XupTyAmEmOUlAm+TRQWmsb8dI0ErD+hoP9Q+i6glF8xHMa2p3lD5vK+VIRcnC3HZxS5+WHjDvfCUR8FDLqTavPCyzI8YmqMX9YYr+tD1vTjq1nZ57rCzHbwSQmnyL9sEQJjAB93Or0Bk8oQkdqQngFRBnPXY+TLAdLV3m1jdeS3KAoUBpDT4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265a841e-11f2-4910-2203-08d65beec3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 02:50:36.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slave mode support to the fsl-lpspi driver, only in PIO mode.

For now, there are some limitations for slave mode transmission:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than
   this from master device will be dropped. Any data shorter than this
   from master will cause LPSPI to stuck due to mentioned limitation 2.
4. Only PIO transfer is supported in Slave Mode.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:=20
 - No change.
V3:
 - Add more detailed description in commit message.
---
 drivers/spi/spi-fsl-lpspi.c | 107 ++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 725d6ac5f814..cbf165e7bd17 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -55,6 +55,7 @@
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
+#define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
@@ -80,6 +81,7 @@ struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	bool is_slave;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -92,6 +94,8 @@ struct fsl_lpspi_data {
=20
 	struct lpspi_config config;
 	struct completion xfer_done;
+
+	bool slave_aborted;
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -206,21 +210,22 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi,
 	u32 temp =3D 0;
=20
 	temp |=3D fsl_lpspi->config.bpw - 1;
-	temp |=3D fsl_lpspi->config.prescale << 27;
 	temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
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
+		temp |=3D fsl_lpspi->config.prescale << 27;
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
+	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
 	dev_dbg(fsl_lpspi->dev, "TCR=3D0x%x\n", temp);
@@ -273,13 +278,18 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
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
@@ -322,6 +332,37 @@ static void fsl_lpspi_setup_transfer(struct spi_device=
 *spi,
 	fsl_lpspi_config(fsl_lpspi);
 }
=20
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
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -335,13 +376,13 @@ static int fsl_lpspi_transfer_one(struct spi_controll=
er *controller,
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
@@ -380,10 +421,12 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
roller *controller,
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
 	spi_finalize_current_message(controller);
@@ -421,8 +464,13 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	int ret, irq;
 	u32 temp;
=20
-	controller =3D spi_alloc_master(&pdev->dev,
+	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
+		controller =3D spi_alloc_slave(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	else
+		controller =3D spi_alloc_master(&pdev->dev,
 					sizeof(struct fsl_lpspi_data));
+
 	if (!controller)
 		return -ENOMEM;
=20
@@ -433,6 +481,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
+						    "spi-slave");
=20
 	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
@@ -441,6 +491,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 	controller->dev.of_node =3D pdev->dev.of_node;
 	controller->bus_num =3D pdev->id;
+	controller->slave_abort =3D fsl_lpspi_slave_abort;
=20
 	init_completion(&fsl_lpspi->xfer_done);
=20
--=20
2.17.1

