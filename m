Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024DF2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="abTo3kLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024DF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeK3PhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:37:14 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:52709
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbeK3PhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVst4VPCBw+13Zq6VhZOWTU/5nk0rfZAxzd1IxUmj14=;
 b=abTo3kLKzvonNzzNeQgO8Jdzlkl6E7fMPggdeCn1TUCkLVESQEdVWF+XZ7Ok7dlG4PMdiPb5iRQ4PllfzpkEcocqzw7ri0FeDHn/kBT/aEKvhMXfX6EsHBTx+qqALGWKZ0tjxyfP+NgEy/LrXh+6Vc1fsDFDpVmrAv+6aHceztQ=
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com (20.177.50.90) by
 VI1PR04MB4413.eurprd04.prod.outlook.com (20.177.55.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 04:29:07 +0000
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359]) by VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359%2]) with mapi id 15.20.1339.031; Fri, 30 Nov 2018
 04:29:07 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 2/4] spi: lpspi: Add slave mode support
Thread-Topic: [PATCH V2 2/4] spi: lpspi: Add slave mode support
Thread-Index: AQHUiGU7+nXCPpo/10u8LfXub+g0qA==
Date:   Fri, 30 Nov 2018 04:29:07 +0000
Message-ID: <20181130042753.28756-3-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4413;6:g1Xpw2bUJX0A1c2W3HGKtie0I6+xOUIdCc8R0YBjOVA0bTqhU2CRSLLCBL+Je95ktQk3F+kpc83MeKNoGyl5MvuaTOr/YhiR5mnqBWIWOdmWWSzc1ZfqEQTFPUD2fGA6vU2jWXdMgtSXo0EjsJqC0bCySEVxd0MFaLRTVc3NBUkL9h4tXe6iGoNHy8PPho7V+U9+RailgdSx1IxyhjpYRGhPY3pI4bT+B8FDYiIi91NZEAOWb+OjOuCZdvQHowOgSscBVb/FPdR5GXZ6TsmrzqWZ4M9heyzmo++qrSgy0dKNoQ08q/WXQiTzoeRVPcCpEOS8mdHoft1ZgotTy5Myo1iJyKth4s1OLDVvyYXwdoW1AISRPyyJuFCeTEgaA/1d+cuj8LhambrKPKHaCImN+MenVC7i4Blgx/Q0PUO0TGPx57KsFDsUZjd2eGXE5nTgXyKEUU4mwUJ3eHSIwjdpNw==;5:kwPAcdksYvBZAV5X6O7G/F2k/UeS0UWX6i+70RKa7EumhcQ8RKwSjEC1CmtD0ZdypUQ64ifO/mVigqAmHKArqO/X0/4n/yegwOc2z7yVVD/kLaAqlhlw5+fNitDqIIUQNiWtTD0CIEU+Df5wLw05fLWOTngq2oRhm8HLIcJrSAw=;7:CME5/BaCIz/P7y2ofQcz/zK+kYXFkZKaFcMGxaCV/rVHyvggAxSGbGQOrn17gA1BHbLkznzPFg9J3TvDyiW9ycLMA0QsMgeQny4wHfQrVawjC1ZijDK/NhsC1HjCiU7jGzy9ll5pKN/Yt/5fYJQxdQ==
x-ms-office365-filtering-correlation-id: cea4ea7a-88c9-4c8c-e735-08d6567c5e0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4413;
x-ms-traffictypediagnostic: VI1PR04MB4413:
x-microsoft-antispam-prvs: <VI1PR04MB44138010A330CE994922DDB3F3D30@VI1PR04MB4413.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4413;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4413;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(54534003)(199004)(189003)(81156014)(6436002)(76176011)(53936002)(186003)(6506007)(81166006)(256004)(8676002)(6486002)(386003)(26005)(8936002)(11346002)(99286004)(52116002)(7736002)(316002)(36756003)(2616005)(54906003)(86362001)(305945005)(102836004)(71200400001)(2351001)(14454004)(478600001)(2501003)(71190400001)(68736007)(476003)(1730700003)(6512007)(5640700003)(6916009)(105586002)(3846002)(486006)(66066001)(25786009)(106356001)(2906002)(6116002)(97736004)(446003)(5660300001)(4326008)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4413;H:VI1PR04MB5021.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mWU1rnPwWWdEHcruBs3sRLV+p59w6vQBpF87h+ZuVp9kmbqhSEx0aWTkwZTQNpPVHXcrJZ8s6sSXQY0wwOSJTcjHmhNKUn1lEU2ebVlw9IwKFIHmxmciBOjpTVQ4LzbX8s1nKmJBn2RrlqlCGdBNf6YUdVKF6jtXVldOiu9Sm3Yzj4+AQmbteEflrz43qmmU8/yJcqIbSCN5EIXjhkbvLeFX9bUaNkppdMOM2mcIDiGoqehqldj64aMCefsWzwlr/SpKifxoc/ZGQqbSGoC+vehCTvrRjmlWPJfqpXXaWXHFUx4WTJ+O40Fcd/4/ldBoZyFwpSkmFhQEmveNPb7CqD91vZoWc/5rsovWDGRt/VM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea4ea7a-88c9-4c8c-e735-08d6567c5e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:29:07.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slave mode support to the fsl-lpspi driver, only in PIO mode.

For now, there are some limitations for slave mode transmission, which
have been mentioned in cover-letter.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:
 - No change.
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

