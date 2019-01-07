Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B002C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B4E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B3RMxSGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfAGHsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:48:06 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbfAGHsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4MDWxyFCX+HEH0Ae8OsSY8J/Hk9HoqF7glI82BBpw4=;
 b=B3RMxSGUdR6CoUzNZgwvFkr1172ILQIFXLt2Q5RqyZWCPpRvwvN+vpdO2wR16y8EYqzws2EVURN1EYqslJvguIH6Zw9l2x1olhdLtzzAxVJFfiiJYpZNZF7P4JPDDdWi80lwOvLvsVmgu0ZG8pyl5EI/aSugQqV1monbAC7PlG0=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:49 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:49 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 8/8] spi: lpspi: add dma mode support
Thread-Topic: [PATCH 8/8] spi: lpspi: add dma mode support
Thread-Index: AQHUpl1JuxXLuDkCkkulrWz7se7ixw==
Date:   Mon, 7 Jan 2019 07:47:49 +0000
Message-ID: <20190107074639.6336-9-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:n2eSczK+W5/pSVEU+o1ZomMVz6V/Xcjaz85wyj9o2HSlBhr7NDG3I4lEoz2ULp3gK5hVzg2LPeEczQPiNT0S2iFgc1hXt18MANQPoPU2LxHhaFGzPH/wvVaEm7DnIoeWiyvpREiLJGcU+TPSBQNZwcPqWUvcbcYKYLbjD+740tix9C7/0m6+ggOAEndo4k9qz7l3CoPRnkixpmXKHO6eZj266dGoCyR8iIm75dfbrWHUaeZlcH48QAU6mRoB58anOfIKAUe5DIvK/QaT4oH9q7ro9dQUVY19nOFgwwxk7g1FCH7DzWyFWuP1uv1ddiQjcRlrluJHoBb+Pmajr9Lr+S5kTtIcGQbtp5sX5AhMhKZAZ2XJU5jLbpmpKAsj6YtVoYKwsypgiZyJ03S5LcKClhjOd/QJrLbgzWYBAjXWiSP+0PdQ5E2NwIcbivYt2Tbmc+vK/TwTMSoSCLwRwQ5W5w==;5:H5VFkiaAQZjqoLTII57bicsSVFN3UEdjf7/sHEplbvXYbzbhLfxr4a/8nOtud+LOWSBZKzPjKXVgIPHGBp4Koi/ssu/fxuIwT/4osPTI+52u8ImL22DmrNnTHV+ruOk9/kU7SrQKo1zyVnxDhRg8ud282SI1+tHNCc6pb0/EJw4zuyMKS9pFbyJ6d7AVdWmNT1BkSOWtbWDwvx3veEEaqw==;7:HnYt8OPvUvI9Al4wf7n1ulbonFFZAdsy+rn9BpbkyRnZLVDg2M2rMRpqcuoQA4sEu3Jwv6LiOz9olrvzuUGUZHUxkMQHBr227CrJvHF4cS2uPhOXkN7H6QBazCAVTBp0I/nVh7J+9s5bC3s0hI53Xg==
x-ms-office365-filtering-correlation-id: 583e8e15-0832-4b2c-4ec7-08d674746bf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB583127D757860E41A68CBA44F3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(14444005)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(4744004)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EGoGpj4B6ZjPQvJzmBA4CIJhgLKOzpXjIXe5NvakT3uIPn0VcL1iCGduAAQPbjPSvGVcNPrwoLXAfWTX1EYFLKc6po0g+vZEgnVGf7dX2rYrPLGdKy49fEB/9sk1y/UJHQsUa5wAkGSi00OvemvMOdNgDn5L8dkjzyGTGWhVNr3YSflX4INKJC3eHygg2XvPSJU+HNO0Z2TFJN4l/Ju3W4hZQ90W+UdQBSD3KqaUA/w3XGCRC7ZBUeO2OGFe5E0WqzY/16Yu8gPN8U+sZUVv0LoUHX6NbUEPDTqY9DMaj/IgnsEkH8LkwcL9A2mrk4Rx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583e8e15-0832-4b2c-4ec7-08d674746bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:47.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma mode support for LPSPI. Any frame longer than half txfifosize will
be sent by dma mode.

For now, there are some notes:
1. The maximum transfer speed in master mode depends on the slave device,
   at least 40MHz on i.MX8 series (tested by spi-nor on 8qm-lpddr4-arm2
   base board);
2. The maximum transfer speed in slave mode is 15MHz(i.MX7ULP),
   22MHz(i.MX8 series).

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 318 ++++++++++++++++++++++++++++++++++--
 1 file changed, 306 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 83e15366b739..85e4e36b71a3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -19,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -31,6 +34,9 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+/* The maximum bytes that edma can transfer once.*/
+#define FSL_LPSPI_MAX_EDMA_BYTES  ((1 << 15) - 1)
+
 #define LPSPI_CS_ACTIVE		1
 #define LPSPI_CS_INACTIVE	0
 #define LPSPI_CS_DELAY		100
@@ -68,6 +74,8 @@
 #define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
+#define DER_RDDE	BIT(1)
+#define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
@@ -95,6 +103,7 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
+	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
@@ -105,6 +114,8 @@ struct fsl_lpspi_data {
 	void (*tx)(struct fsl_lpspi_data *);
 	void (*rx)(struct fsl_lpspi_data *);
=20
+	u32 bytes_per_word;
+	u32 bits_per_word;
 	u32 remain;
 	u8 watermark;
 	u8 txfifosize;
@@ -115,6 +126,11 @@ struct fsl_lpspi_data {
=20
 	bool slave_aborted;
=20
+	/* DMA */
+	bool usedma;
+	struct completion dma_rx_completion;
+	struct completion dma_tx_completion;
+
 	int chipselect[4];
 };
=20
@@ -162,6 +178,35 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *f=
sl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
=20
+static int fsl_lpspi_bytes_per_word(const int bpw)
+{
+	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+}
+
+static bool fsl_lpspi_can_dma(struct spi_controller *controller,
+			      struct spi_device *spi,
+			      struct spi_transfer *transfer)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+	unsigned int bytes_per_word;
+
+	if (!controller->dma_rx)
+		return false;
+
+	if (fsl_lpspi->is_slave)
+		return false;
+
+	bytes_per_word =3D fsl_lpspi_bytes_per_word(transfer->bits_per_word);
+	if (bytes_per_word !=3D 1 && bytes_per_word !=3D 2 && bytes_per_word !=3D=
 4)
+		return false;
+
+	if (transfer->len < fsl_lpspi->txfifosize / 2)
+		return false;
+
+	return true;
+}
+
 static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -250,11 +295,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi,
 		 * For the first transfer, clear TCR_CONTC to assert SS.
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
-		temp |=3D TCR_CONT;
-		if (is_first_xfer)
-			temp &=3D ~TCR_CONTC;
-		else
-			temp |=3D TCR_CONTC;
+		if (!fsl_lpspi->usedma) {
+			temp |=3D TCR_CONT;
+			if (is_first_xfer)
+				temp &=3D ~TCR_CONTC;
+			else
+				temp |=3D TCR_CONTC;
+		}
 	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
@@ -265,7 +312,11 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_d=
ata *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
+	if (!fsl_lpspi->usedma)
+		temp =3D fsl_lpspi->watermark >> 1 |
+		       (fsl_lpspi->watermark >> 1) << 16;
+	else
+		temp =3D fsl_lpspi->txfifosize >> 1;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -301,12 +352,59 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_dat=
a *fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);
=20
-	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
+	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
=20
 	return 0;
 }
=20
+static int fsl_lpspi_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx =3D {}, tx =3D {};
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	switch (fsl_lpspi_bytes_per_word(fsl_lpspi->bits_per_word)) {
+	case 4:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction =3D DMA_MEM_TO_DEV;
+	tx.dst_addr =3D fsl_lpspi->base_phys + IMX7ULP_TDR;
+	tx.dst_addr_width =3D buswidth;
+	tx.dst_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "TX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	rx.direction =3D DMA_DEV_TO_MEM;
+	rx.src_addr =3D fsl_lpspi->base_phys + IMX7ULP_RDR;
+	rx.src_addr_width =3D buswidth;
+	rx.src_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
@@ -332,15 +430,22 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
l_lpspi)
 	temp |=3D CR_RRF | CR_RTF | CR_MEN;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
=20
+	temp =3D 0;
+	if (fsl_lpspi->usedma)
+		temp =3D DER_TDDE | DER_RDDE;
+	writel(temp, fsl_lpspi->base + IMX7ULP_DER);
+
 	return 0;
 }
=20
-static int fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
+				     struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(spi->controller);
=20
+	fsl_lpspi->bits_per_word =3D t->bits_per_word;
 	fsl_lpspi->config.mode =3D spi->mode;
 	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
 	fsl_lpspi->config.speed_hz =3D t ? t->speed_hz : spi->max_speed_hz;
@@ -368,6 +473,11 @@ static int fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
+	if (fsl_lpspi_can_dma(controller, spi, t))
+		fsl_lpspi->usedma =3D 1;
+	else
+		fsl_lpspi->usedma =3D 0;
+
 	return fsl_lpspi_config(fsl_lpspi);
 }
=20
@@ -406,8 +516,10 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_=
lpspi)
 {
 	u32 temp;
=20
-	/* Disable all interrupt */
-	fsl_lpspi_intctrl(fsl_lpspi, 0);
+	if (!fsl_lpspi->usedma) {
+		/* Disable all interrupt */
+		fsl_lpspi_intctrl(fsl_lpspi, 0);
+	}
=20
 	/* W1C for all flags in SR */
 	temp =3D 0x3F << 8;
@@ -420,6 +532,128 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl=
_lpspi)
 	return 0;
 }
=20
+static void fsl_lpspi_dma_rx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_rx_completion);
+}
+
+static void fsl_lpspi_dma_tx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_tx_completion);
+}
+
+static int fsl_lpspi_calculate_timeout(struct fsl_lpspi_data *fsl_lpspi,
+				       int size)
+{
+	unsigned long timeout =3D 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout =3D (8 + 4) * size / fsl_lpspi->config.speed_hz;
+
+	/* Add extra second for scheduler related activities */
+	timeout +=3D 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
+static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
+				struct fsl_lpspi_data *fsl_lpspi,
+				struct spi_transfer *transfer)
+{
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long timeout;
+	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	int ret;
+
+	ret =3D fsl_lpspi_dma_configure(controller);
+	if (ret)
+		return ret;
+
+	desc_rx =3D dmaengine_prep_slave_sg(controller->dma_rx,
+				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx)
+		return -EINVAL;
+
+	desc_rx->callback =3D fsl_lpspi_dma_rx_callback;
+	desc_rx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&fsl_lpspi->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx =3D dmaengine_prep_slave_sg(controller->dma_tx,
+				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback =3D fsl_lpspi_dma_tx_callback;
+	desc_tx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&fsl_lpspi->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	fsl_lpspi->slave_aborted =3D false;
+
+	if (!fsl_lpspi->is_slave) {
+		transfer_timeout =3D fsl_lpspi_calculate_timeout(fsl_lpspi,
+							       transfer->len);
+
+		/* Wait eDMA to finish the data transfer.*/
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+	} else {
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_tx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_rx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+	}
+
+	fsl_lpspi_reset(fsl_lpspi);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -446,6 +680,54 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	return 0;
 }
=20
+static void fsl_lpspi_dma_exit(struct spi_controller *controller)
+{
+	if (controller->dma_rx) {
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx =3D NULL;
+	}
+
+	if (controller->dma_tx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx =3D NULL;
+	}
+}
+
+static int fsl_lpspi_dma_init(struct device *dev,
+			      struct fsl_lpspi_data *fsl_lpspi,
+			      struct spi_controller *controller)
+{
+	int ret;
+
+	/* Prepare for TX DMA: */
+	controller->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret =3D PTR_ERR(controller->dma_tx);
+		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		controller->dma_tx =3D NULL;
+		goto err;
+	}
+
+	/* Prepare for RX DMA: */
+	controller->dma_rx =3D dma_request_slave_channel(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret =3D PTR_ERR(controller->dma_rx);
+		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		controller->dma_rx =3D NULL;
+		goto err;
+	}
+
+	init_completion(&fsl_lpspi->dma_rx_completion);
+	init_completion(&fsl_lpspi->dma_tx_completion);
+	controller->can_dma =3D fsl_lpspi_can_dma;
+	controller->max_dma_len =3D FSL_LPSPI_MAX_EDMA_BYTES;
+
+	return 0;
+err:
+	fsl_lpspi_dma_exit(controller);
+	return ret;
+}
+
 static int fsl_lpspi_setup(struct spi_device *spi)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -483,7 +765,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
+		ret =3D fsl_lpspi_setup_transfer(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -491,7 +773,11 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
=20
 		is_first_xfer =3D false;
=20
-		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
+		if (fsl_lpspi->usedma)
+			ret =3D fsl_lpspi_dma_transfer(controller, fsl_lpspi,
+						     xfer);
+		else
+			ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -662,6 +948,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 		ret =3D PTR_ERR(fsl_lpspi->base);
 		goto out_controller_put;
 	}
+	fsl_lpspi->base_phys =3D res->start;
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -703,6 +990,13 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
+	ret =3D fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
+	if (ret =3D=3D -EPROBE_DEFER)
+		goto out_controller_put;
+
+	if (ret < 0)
+		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
--=20
2.17.1

