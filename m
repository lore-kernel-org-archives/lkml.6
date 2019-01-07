Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4601C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kUbF55hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfAGHrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:47:49 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfAGHrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QCNPpsu7KVTPprtaiSrruHt1P+up2OhSO11JMG4hnc=;
 b=kUbF55hzoMW7N/ERPhDTRATllfplHtx1t6qA+cJ+5Ofn1jfjsGTmt6RjqS4doPxsQ3b6B5vEm38M0fV6bdnbemlLy6TdhaR6qxr8xZrE2NTx75Yv731Obc7kjHi0n92V+fuqGb2SHK/dIjJiQtYxpyjjFzmpMU+hbe4Ul/ZnFow=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:39 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:39 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 3/8] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Topic: [PATCH 3/8] spi: lpspi: Improve the stability of lpspi data
 transmission
Thread-Index: AQHUpl1DV1mbKBx0m0CaWZMRNLSwvA==
Date:   Mon, 7 Jan 2019 07:47:38 +0000
Message-ID: <20190107074639.6336-4-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:We6amYB95xa2W2Oy0ZbPFJgoSgKjoKGdge8SAI21Y40yEuiYeet+s58QbhOM1fDspN8QB5POi2YTBw72hU5oVVMgcL+5ZK5XhkJ0vBIKu8uKRl2xWIWSdbgDvM/Bj86DDGhRUFpfUooAant0nk9htt7SLd0A0zlkHRdA0Qqk/KgV1lCRQTcwRO53BnDfokMWufuTZaSKWzO9m7XBEOForJ470WdkuvUC66o19T3lJXUZ2/6h9ENpILDuk9rtvUXIt5ofJgn/RKGp9HJrBNj2B4uFlch9PYrxu4mq3jYPomH1e6EoP4kHzKLvm8KFf7+qJqK0xOrCbc48sIBRfH/A+9hpe/hkjefpUex9WcAPc06AFXDGu//tyTHufs5Xm/LvdoPLo2FdBylLUhm6WHprP4s2XW2D2s81husS1UGybxJzMtlEDZBGD4WwdKHXhHZw4u8DwjSEFbTR4h6owLSizQ==;5:MxaoiYVwZJ/+LYMqi4m1u63jQ6Sa/RqPhUDaFIMT5/UIvYLjnM2Me/WNWaRbw77LNZBYN6YWUcBuY2WL98sPxehqHwHaQRHy0S2dlOnvPNIRAMe2XcUVPCXo9uw8WSJumEt2WQgCa3TqmgiVta7EvUt2/0VIEXleh9sm2ofZYT+eU+IL3zfuxleNyKeJREqtIJyI+jvlsBLw3f4o1v1D5g==;7:WAE/jASF8fC2HE5WGdzn1Ne1ZxNWkhrDKRB9+DQqZVtDvl0RFtL2iCgBWe7B16MetvuXZUTqnLe+9E8M3gSd9vJ+REDvZGAOGhsuLkqgf0DWM3An+UgpDE1kHdShSX0U2N1ZOCIQxiEknWIfuxAmlQ==
x-ms-office365-filtering-correlation-id: 99660b39-ba8f-4040-0510-08d67474654e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB58314D8ADC5264ED312C606BF3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Alwx1heX6krE5ujSmv0I8haY91F2hftR8fUZ4Z3Hhqq8dScNEL0EXyECPX4boLSTKoL+5PFdKf1TPS0NCTGKQeGiumHEwdkR0BNrzn0izhvDv3UCH3eVITz/TgL87gNngvZ78I+IVzjrlY9w914xgRfEX1iE2drBQ3jv0LVt8Dlzm/Nq+WSgveK7jTB4ga3xBcZ5CHz90Ql0DI238VgshUUzKSzj9PFWBoM57k0sBYMWGKSma/VXdUoIuqN82myLMa37nBz8KafdF4SSToFDf4tOWxH+iRJkjJdUoe6l72rovPPfUU1ASkMRykKP9m8M
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99660b39-ba8f-4040-0510-08d67474654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:36.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
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

