Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5899C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F8204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7eVPKHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfAGHrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:47:52 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfAGHru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsTYGiTrph/9s0ecqljN0BsKCunFASj6/+ScYmUFbKY=;
 b=I7eVPKHPmscG5mUZmRfciQPwcu0bkS9jm/5kPahLTLfHGGtFj8zOa5xqkmOlxIEx2HKxNVdcuZzDfAnv5jDALRPiKEJOKWlxeAtbx4DeeTfqVzTdxMC3TIkG6+iVgSutm20zXZwloQnT7oneZaH34FUZm0hA4AoZIxzWe9SLjx0=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:43 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:43 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 5/8] spi: lpspi: Fix CLK pin becomes low before one transfer
Thread-Topic: [PATCH 5/8] spi: lpspi: Fix CLK pin becomes low before one
 transfer
Thread-Index: AQHUpl1Fxjq2QyxfRUeWJr0Qhjp+XA==
Date:   Mon, 7 Jan 2019 07:47:43 +0000
Message-ID: <20190107074639.6336-6-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:3FvKmK5YnfJX6rSa96XzZwSFfVRBZwQvOxNilwp5pX+WXtd3LjRk5ELXRDp3qk79hlCJxYr1u++PMdkMJw/gOnNdoHU/5Ymam2R474l5YGoLTttdhkwp+ceFLg/F1pzOVMKezus6oPQgZpXBku92VFdh8QV1Z+k7YdPsAYOVs4GJB1HLpd4mWkU1jiy44m4IcI498dWwU932hlvquXlsMXf4LOTOZjF5GCKua9keF5j3K4FpeVbHYoV6EgQ7oG7enhJH0rXmmHlI/+3+SkChydR9pDP3wrs4LWXXzFK7i8a0kcQ4jSK1D2Y9rQGig5yPkCyF0Gf2OND/0A/j8z/OUcdWcPKdRV3C+5Wm5HpVsdOb0nJizqwNoZaoiMxXJ1RDcQKOC/PxI6ZOLDa+PwqOl2Susb1K0dg92gf+V5pULhveuRlFniNOatDxrSb8MQ1aqxA1V/wxa/LG2dxD+Z7/Pw==;5:YBpghyX8JwPLt3yOkCY1jwKtTiY04p5wZBstB7jdaP8Tp+KrsNt6x6udQTn1eAYM8JY5Tw5N6S4niFZLF2qufOvU8k/fYTOsrGMy1Y3NfCJaNtyyYEsrPjw/LIR/u2yjPyJlHWr/KDfIdD0wLMRbRQoy/4T6OqFimdvuae+bmBHMA0LF50+HePC6agAw2Ums+vSpZNqzaySeC2DvrcGM+w==;7:xICIBdc7H4hObeJeVg4paSh1ba9vy4e2fnmvKSkAP+d57dnbIjvilU1M8Hawj0zGMAxBdN4ePNcj4TR55QgT7TUYqFxMEXHlroSpyGfVvtZp4XcgqjH/rZpkwoQ4Mkz6Kczb3D0vfULTC9CdHAacHg==
x-ms-office365-filtering-correlation-id: 0851298b-727e-41f7-1b7c-08d67474681e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB583166D1999229DD11D88593F3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uTfmIMzS7wArsZJZAnlIefQk3Xv21rDQZa51TFX7UOmqcUR7IwUBpiFcYlwTcX+4P/DsqaHX2iZUcGayW2Yu5AvO4MONxSWG6ydU6sHPS8dxigf0ybsfgF2gmwBsQj1Kn+f055nlePtj6V3yyYbFJm53yTsD4OV4+RwAjRCTZ7FvbNU6Egs03Rz4WZS8eVh4qS3+dMI0zAG30eJVm4LrADIsjHjiQeIN3ZhHOZypoNSc5WmM7SxVziIt6Tt6uuxRuyEn4B7+I/H2O/vLQaDbErucNDIj60mwVcITzjXsOCUCmFa1iZrOBndlEwuoTtdd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0851298b-727e-41f7-1b7c-08d67474681e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:41.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Reset operation in fsl_lpspi_config(). This RST may cause both CLK
and CS pins go from high to low level under cs-gpio mode.
Add fsl_lpspi_reset() function after one message transfer to clear all
flags in use.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51c85cf0bd9f..84dcb9e176b8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -281,10 +281,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
_lpspi)
 	u32 temp;
 	int ret;
=20
-	temp =3D CR_RST;
-	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
-	writel(0, fsl_lpspi->base + IMX7ULP_CR);
-
 	if (!fsl_lpspi->is_slave) {
 		ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
 		if (ret)
@@ -375,6 +371,24 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u32 temp;
+
+	/* Disable all interrupt */
+	fsl_lpspi_intctrl(fsl_lpspi, 0);
+
+	/* W1C for all flags in SR */
+	temp =3D 0x3F << 8;
+	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
+
+	/* Clear FIFO and disable module */
+	temp =3D CR_RRF | CR_RTF;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -396,6 +410,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
+	fsl_lpspi_reset(fsl_lpspi);
+
 	return 0;
 }
=20
--=20
2.17.1

