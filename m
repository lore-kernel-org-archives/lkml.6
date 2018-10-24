Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80444C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA920651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vIXrYVLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEA920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJXLQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:16:38 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:39072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbeJXLQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCmEIgqz28Pjx223HIWbwU9cfufZqTEF7grtfALqcUY=;
 b=vIXrYVLJuUgXl2iqhdcnamUo+UG/EAUYlam8hdlRk7h4e0CiP9vk3OrWwralt3FgMYDV1A/SX0l/E+2hipdy7lILail0GPuwagk4cSEgBw57lfaJKW0TCQDrj9ctsdrdLwiGGk0Bzv3wuFUT37xaRqPZhVh8A5AagZoelfMYRHE=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4358.eurprd04.prod.outlook.com (52.135.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 02:50:25 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:50:25 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 2/5] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Topic: [PATCH 2/5] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Index: AQHUa0RQizu8o77faE+3IlXaes0uvA==
Date:   Wed, 24 Oct 2018 02:50:25 +0000
Message-ID: <20181024024808.14485-2-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4358;6:i2MQ7osH5EQSzf17SVilwmge5/GeUom4yy+1Dx9AsQmI4xRYrXb18gNuECORj4eoXAPXZPh0k+Z3cxfK625L2ckNWUqXClEvlF9/fbKdZLU2ZpViGr5cCgOlbb+0WbzlwEIM0Oz9cFhNTSc8reNpBJkVHbnwkBeMJ+jxx+1hY4k9ZI6EWBpQSapNvbnatEVTJKYJ+RgYDHt5owtRR3UgJQK/Cect3y854VqHppueyt59R0EK8yxskkrrT6pvtx7JH5lLftHgbrfXKB1n6DSuhZNduNTsdzX9vwRinK1zjs8GR+qklJ6+wBkzoq4f8FPieYYrG1xDRVVuqJ4JIMgI2HsriZCHEzrW2kBL1K4d6R0Kg0sf2TIiTsTQGCITSou+K4tcDzfA8C8l95ootuQbbpp7bxQ0YO0o+0+Yj4oeqxG73cPy9QLWGUwBTlbDMwRxX+vjJPU3xIznqgA4fJkDxg==;5:2eoxygB0SircjYk0U1JhAlYZ+fzp1dFXl6IaPxxA73U1XUmiBjzpL4eyfJfR0ZqAnI/hlpnqNZQAM9BJPibjt7HTeav+qv2pYCto1TMt1qg8iO9FhYBg9WcluZ6mck8J4Hu0zDw8q4pMDELSRher9hsaPrjxZRYpkihD0rfBtgU=;7:T+GwGbZmhAnp5XTWL2ElAzL0+1bQtBeO3WXG+jwUXIfpb4cu2a3DssCvLUOHqQ5dnOFLDfbQLPArZeLmAtIl5yMDnEMpVzasoP+0O83AG8t3SBiOh8iH7Pw0l0piIOZn+AuzomI7KSMfmGzZY23geu4r8rZp+G/DCHLbFIvoOs97nPrS32jFyKZ7a8ZBSLPh4wJG0LUDu/zxpnEO78Yi0gEgnF7BUzikC+ocsXdcTyCU0t7XJWa74mIKv/VzOHDH
x-ms-office365-filtering-correlation-id: df304f1f-18f4-4a9f-ecb4-08d6395b72b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4358;
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB43582166083F00FB3D3F9F4CF3F60@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4358;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4358;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(36756003)(53936002)(105586002)(71190400001)(99286004)(256004)(386003)(6506007)(71200400001)(102836004)(8936002)(14454004)(7736002)(4326008)(305945005)(1730700003)(81156014)(316002)(106356001)(5640700003)(81166006)(2351001)(2501003)(478600001)(6436002)(54906003)(3846002)(5660300001)(476003)(8676002)(6116002)(11346002)(66066001)(6916009)(26005)(486006)(446003)(68736007)(76176011)(25786009)(6512007)(6486002)(2900100001)(2616005)(2906002)(97736004)(86362001)(1076002)(52116002)(186003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4358;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r/PVXXi7iyk7Zshy4mScxLpt+aJNdtdowTsSyCnwcLZnu0cdKzzy+WFro9UomBqxUDKthHnIKplleqpiShlHd2fbT+jjQ6y4qr+3E1tsgJ0ylI2xQba6VlcAxkgpNQHaMMYJk4jtBK/75OdDvpv64IbgCWNYswIqJVokEGLhiC+eZHNqEWPcOw1aNFM5BMeF+kmpmdkc7VWVPuaBhsuYdI0xNU5XUK4dOdxesrkVMAg/p1BenWwA551qfYj8b16RTblakoxVd78IzC/EhjUfT5U0a3QK/7FnV680xk92UvgsdYvox6lrggIB4+XRaDB26nfJev4YLRn+Kjrz7RY3yLiCJcS49V2wKzPNy/v3/B0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df304f1f-18f4-4a9f-ecb4-08d6395b72b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:50:25.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SR_TDF to judge if need send data, and SR_FCF to judge if
transmission end to replace the waiting after transmission end. This
waiting has no actual meaning, for the real end will set the FCF
flag.

Resolved an issue that could cause a transmission timeout when
transferring large amounts of data.

After making these changes, there is no need to use
fsl_lpspi_txfifo_empty(), so remove it.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 59 +++++++++++++------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 86cb38d98a39..58397acbce2f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -49,9 +49,11 @@
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
@@ -161,28 +163,10 @@ static int lpspi_unprepare_xfer_hardware(struct spi_c=
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
@@ -193,9 +177,15 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_d=
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
@@ -398,8 +388,6 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
-	fsl_lpspi_read_rx_fifo(fsl_lpspi);
-
 	return 0;
 }
=20
@@ -411,7 +399,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
-	u32 temp;
 	int ret =3D 0;
=20
 	msg->status =3D 0;
@@ -431,13 +418,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
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
@@ -446,20 +426,23 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
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
-			complete(&fsl_lpspi->xfer_done);
-
+	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
+		complete(&fsl_lpspi->xfer_done);
 		return IRQ_HANDLED;
 	}
=20
--=20
2.17.1

