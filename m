Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B57C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A565B208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EDx7WkRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A565B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDGWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:22:22 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:43097
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeLDGWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QCNPpsu7KVTPprtaiSrruHt1P+up2OhSO11JMG4hnc=;
 b=EDx7WkROru5TWKudR3boOoEq0qKRVGBRnMuQqgYSwi+j4wVEToOkhAvjpVaC8SQfQxeQxXdkao4lNpJkXnwU9u9BsuSr0x4UK3S8aM2d2a7TJx7wH4JKxdmaLYE6hLlk4Hnz2YLnHdu6fqSYzRF4qYmlcBdPY4lsj4f1Ug7FfsA=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5782.eurprd04.prod.outlook.com (20.179.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 06:22:15 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 06:22:15 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: Improve the stability of lpspi data transmission
Thread-Topic: [PATCH] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Index: AQHUi5mzR+6qOh3oN0WleDPXtqyAsA==
Date:   Tue, 4 Dec 2018 06:22:15 +0000
Message-ID: <20181204062122.28745-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5782;6:E21Qs9RTt52g7JSgkWq/kb3w4j33/ZaVaaHLR/MS+Wg+klG2Xr0sdWTxvMuBOB4Sw+D6kdZDR3UqgS3FQZLP+K0OgEm2tfxkcJXh3phqbW/eWdHSoCQi7DHbBC6YwLuNZcrJ5eJJIZJ3EMMrqz9QgoeiWuswymxt0T1QQfAstBKxHjW6ZGFYUXFJhrdpxrPHq1eYeVeOy4VUBXmg9CZ8Ux6W0NZBnKlgSDvokK3vusbZqoTpbcvD0FxXH5e8zZvcHyJ9WNVYSEi6wdZq3AlFj2CY4GTWOPfXunLDMcuParSIZAHONjMXBRqYpmcop1tnd5D0tQQM/Q7TTtX5JZtozWmO7CsHEsSBQlorwolF6l0UlFx04lz1Yae/xg1eNGg04EO5R02YF/Wk6Jj80sB8ydg8EduW6rYVSRiotfoLJRSlLzQ7RMissajL20doIHQbF2wlOFJ0i6ovGiv3NuDyQg==;5:R8nG5p+9XrU53Tm6NWMyUnnGl/pkUeyourkK1KnMODoxXsxr5v8xWjzyxf4BiaQxugClk6qUCIiGMbz/QLCW77+tmR1aLemtCYV2P/5tN3ror4rxHPCarq6yof/z1l/ewXVGEMJW+av+dL4vYwRDpyMnjbfud0bVyB2gti+zupY=;7:v18qOJ2c2h8a0fQZpLygz9KRudrBDQdKIGH5mVPErZKZRPPBbTDS7iBpwCsTDcyGbDldLMzB04QumSZK2j/pK6ejO8SRNuPpT/iZR9DdZXf929Few6Pcq8mGlawp6gZG0kywk+TbHU+j4fMmSLvHrw==
x-ms-office365-filtering-correlation-id: 0b788fcb-a3dc-4a1a-8015-08d659b0d59a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5782;
x-ms-traffictypediagnostic: AM6PR04MB5782:
x-microsoft-antispam-prvs: <AM6PR04MB5782824F33E41497C1F468A5F3AF0@AM6PR04MB5782.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5782;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5782;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(2501003)(97736004)(3846002)(6116002)(14454004)(478600001)(486006)(53936002)(25786009)(4326008)(36756003)(6512007)(52116002)(5640700003)(8676002)(99286004)(66066001)(8936002)(81166006)(6506007)(1730700003)(81156014)(386003)(71200400001)(6486002)(5660300001)(2906002)(68736007)(6436002)(2616005)(2351001)(256004)(476003)(102836004)(186003)(305945005)(6916009)(106356001)(54906003)(86362001)(575784001)(316002)(7736002)(105586002)(1076002)(71190400001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5782;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0QtwodfGzP5zPK8YGIMKpsKi7f7NxPw1V7it0yKkW+crLlsx07aMXH5jy5UEISToaiJszv7x6VDxhLz+VNCydkQ1j6xbp4I1AL/Zi45PoTxOoz3KZrVITs5G8El7LKUsU0yaW6XDCPdAEedqFbJ8MyOSiM5lxeYxQFgJ7WYzbuj8zumTzELPP1+HRtW4YM7IYX3HLj7jdRL5WMFuggzQFsNJzNU8BxS6wkzMLIIsxpLo7jjwH5hY2hdANfPvRWUt5NlfwcvJR362Qq2kwCBZdsLBd4tzXyqiMqwMS6kGIDzhv9o8UeIg2KJpSS+9iG0cEnIpB9WuMETfAvPo8idVU24ew7eYcFpprqa5eo0+RzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b788fcb-a3dc-4a1a-8015-08d659b0d59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 06:22:15.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SR_TDF to judge if need to send data, and SR_FCF is to judge if
transmission end and to replace the waiting after transmission end.
This waiting has no actual meaning, for module will set the FCF
flag at the real end.

The changes of interrupt flag and ISR function reduce the times of
calling ISR. The use of the FCF flag improves the stability of the
data transmission. These two points generally improve the data
transfer speed of lpspi, especially when it is set to slave mode
it can support higher transfer speed of the host.

After making these changes, there is no need to use
fsl_lpspi_txfifo_empty(), so remove it.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 61 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 3e935db5ff02..f32a2e0d7ae1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -53,9 +53,11 @@
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
 #define SR_TCF		BIT(10)
+#define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
 #define SR_TDF		BIT(0)
 #define IER_TCIE	BIT(10)
+#define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
@@ -174,28 +176,10 @@ static int lpspi_unprepare_xfer_hardware(struct spi_c=
ontroller *controller)
 	return 0;
 }
=20
-static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi)
-{
-	u32 txcnt;
-	unsigned long orig_jiffies =3D jiffies;
-
-	do {
-		txcnt =3D readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
-
-		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
-			dev_dbg(fsl_lpspi->dev, "txfifo empty timeout\n");
-			return -ETIMEDOUT;
-		}
-		cond_resched();
-
-	} while (txcnt);
-
-	return 0;
-}
-
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
+	u32 temp;
=20
 	txfifo_cnt =3D readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
=20
@@ -206,9 +190,15 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_d=
ata *fsl_lpspi)
 		txfifo_cnt++;
 	}
=20
-	if (!fsl_lpspi->remain && (txfifo_cnt < fsl_lpspi->txfifosize))
-		writel(0, fsl_lpspi->base + IMX7ULP_TDR);
-	else
+	if (txfifo_cnt < fsl_lpspi->txfifosize) {
+		if (!fsl_lpspi->is_slave) {
+			temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
+			temp &=3D ~TCR_CONTC;
+			writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+		}
+
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+	} else
 		fsl_lpspi_intctrl(fsl_lpspi, IER_TDIE);
 }
=20
@@ -404,12 +394,6 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	if (ret)
 		return ret;
=20
-	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
-	if (ret)
-		return ret;
-
-	fsl_lpspi_read_rx_fifo(fsl_lpspi);
-
 	return 0;
 }
=20
@@ -421,7 +405,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
-	u32 temp;
 	int ret =3D 0;
=20
 	msg->status =3D 0;
@@ -441,13 +424,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	}
=20
 complete:
-	if (!fsl_lpspi->is_slave) {
-		/* de-assert SS, then finalize current message */
-		temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
-		temp &=3D ~TCR_CONTC;
-		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
-	}
-
 	msg->status =3D ret;
 	spi_finalize_current_message(controller);
=20
@@ -456,20 +432,23 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
roller *controller,
=20
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 {
+	u32 temp_SR, temp_IER;
 	struct fsl_lpspi_data *fsl_lpspi =3D dev_id;
-	u32 temp;
=20
+	temp_IER =3D readl(fsl_lpspi->base + IMX7ULP_IER);
 	fsl_lpspi_intctrl(fsl_lpspi, 0);
-	temp =3D readl(fsl_lpspi->base + IMX7ULP_SR);
+	temp_SR =3D readl(fsl_lpspi->base + IMX7ULP_SR);
=20
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
=20
-	if (temp & SR_TDF) {
+	if ((temp_SR & SR_TDF) && (temp_IER & IER_TDIE)) {
 		fsl_lpspi_write_tx_fifo(fsl_lpspi);
+		return IRQ_HANDLED;
+	}
=20
-		if (!fsl_lpspi->remain)
+	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 			complete(&fsl_lpspi->xfer_done);
-
 		return IRQ_HANDLED;
 	}
=20
--=20
2.17.1

