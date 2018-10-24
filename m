Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D5C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7493F206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vLiUFu0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7493F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeJXQZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:25:35 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:60224
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbeJXQZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1EfRKBoY4l2GovADyxAOpEVB0fLeb+tKNxSF6oAmCU=;
 b=vLiUFu0e+/SkC80S3FQ2Fsm7NyAv7B68nPgYc2o1GKVjaEGvRyG/Ixe9qM4DioNdUlI5xdc4/sMtyCU7vVP2tsdsCtokQ2ishsjtDfMSqTSqWNWV1oF6Hl5Kj//fOh4M+qn0aWOpCD5VVi2/5mq+ke4X4+071jSkNYdJ7IfJGFQ=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5176.eurprd04.prod.outlook.com (20.177.35.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Wed, 24 Oct 2018 07:58:25 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 07:58:25 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 2/5] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Topic: [PATCH V2 2/5] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Index: AQHUa29X9nAr+zpQS0C6LvbX2gcPjA==
Date:   Wed, 24 Oct 2018 07:58:25 +0000
Message-ID: <20181024075617.19548-2-xiaoning.wang@nxp.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0127.apcprd06.prod.outlook.com
 (2603:1096:1:1d::29) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5176;6:EebaE/Mko+3oK7Z49xJn9pQQbLJT97zSSvEStM5nRrGXGbDvKWeckca1wXSDTCL2fDoB9MqLiM9sqb6cmwm7iP6JNRCuVIaK7r6iWHLBJypMqo4WHq8OzaJDPr+5enjOG+SX39foi2+8Q86drumh8MMkbXL6Kj/jSDOnetXRJf6od/S13zWTPnAscOYUMhTlb/fsPixKdJ66VJPcH95CIfT8wf81P/d8Er7mR31nehERjn01N/pGFauz2uOjYn+iRczxjn8Z/YqN6aaL9qqitoTNoZL6kWl7cQJD9gDLRkgzlB5tr1R06cuSGSfksJmQzG74pshus/Qn0YfSFAPEowfjc+y4rRTKfK8XvonO1rakQ3HjObkUwAZCkHMdlvvLaVWINF/C7DB4ehQoU0aWWHW9hjrWF0/QA6cUAU+vi/2/MU00fwagsA79Zfon0dHu3Z7p2TplvwH8EpPHnPsd9A==;5:GnEMu9VRBuOeq21NwxpAcXUlSSsr+ulGEzFkR+CbqFjLAv2BUar+6qqtcROIysVV5qIToIhrFvWdwFqn23jZoFm9K+y7bGju2nEbA1VSHXJmMHZJt05JLFzkfsFQIYGGoIgNkhsj3g/6fM/BUzyG7pDsStNpUM5u/Fi5W9xM5RU=;7:jehcMoRq1TbJvbmg2J/ZCm41v2fNBIgG9VKmbHKft9UxzZb2pnKe7qBOD3XOmnBJBssatKZjRC/wQ2bVtlUBEFAaR+Ypyielkpp/+E8Ys1fLyJDjcvWp6Ss90Fyh7z8Zmm2D3YD5RnKvl9iK22531g==
x-ms-office365-filtering-correlation-id: 418c7dae-d218-4c51-ee4a-08d6398679c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5176;
x-ms-traffictypediagnostic: AM6PR04MB5176:
x-microsoft-antispam-prvs: <AM6PR04MB5176F7B783D0BB211FEDE9F0F3F60@AM6PR04MB5176.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5176;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5176;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(6512007)(26005)(71190400001)(5640700003)(36756003)(6916009)(68736007)(71200400001)(256004)(14444005)(4326008)(6486002)(6436002)(53936002)(305945005)(7736002)(25786009)(102836004)(81166006)(81156014)(1730700003)(14454004)(6506007)(386003)(2501003)(2900100001)(54906003)(97736004)(8676002)(8936002)(5250100002)(476003)(86362001)(76176011)(186003)(486006)(2616005)(2906002)(52116002)(446003)(3846002)(6116002)(478600001)(11346002)(105586002)(106356001)(66066001)(316002)(99286004)(2351001)(1076002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5176;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BNzE1mvg2d7yZ53DsfCte9ptR5JY4bZjkrFABv77DfOv4vAy5tBs3aaYmPYZeGr5zNCwiqkXq/KI/8yBWsMOHzDZ/Ugjj+OArVN58wXJXnsZ4jBsvotQhtx5bssT1QiYAVZgU2q94NeV1kBzYOTqYw7EqzgqyRZKyR/aDFVgFzG3cUhdnp3wH5mML3hzuJK9yARfPUsupPZGq46z7uxbGoHBpLtRiO6Fi2aOgWtVRLFWK6nWLBJg8perYrPzzUwghUkX4++eabN2HuimVsc/sd5hHz9BVDooWtsdJ04p8C63La+/TQ+Gqb3XX9XCCm69cc8JOmSkjs4dSLruEAP6Jdk8QGO5GW9TSBTgHaM7ytE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418c7dae-d218-4c51-ee4a-08d6398679c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 07:58:25.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5176
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
V2:
 - Sorry for my negligence.
   Fix an issue which happened when I split the patch from my work git
   tree. Forgot to delete fsl_lpspi_txfifo_empty() code.
---
 drivers/spi/spi-fsl-lpspi.c | 63 +++++++++++++------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 86cb38d98a39..79a3d4a82628 100644
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
@@ -394,12 +384,6 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
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
@@ -411,7 +395,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
-	u32 temp;
 	int ret =3D 0;
=20
 	msg->status =3D 0;
@@ -431,13 +414,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
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
@@ -446,20 +422,23 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
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

