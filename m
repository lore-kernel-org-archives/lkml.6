Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C0B2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvhuCMY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C0B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeLDGX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:23:26 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:58880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbeLDGXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHiaeE5YVO2Q5p1SnXP7EAFe8jqJ8G3Pzj9PdcNp0OI=;
 b=fvhuCMY8HQIgYaUPCEgLxyMu+coaREUcNLsL5dTYCucungwlL/NYwiydHLTfPg2IyGJ+m8K85E735RWogN0lh32WdOEz7x32KwPaGSvW/Y0XcgNSjw+EYvPa9/Hwh/Bj5SAzxg6l//FKx2Nan2+bnL07n4WC8xJsu0rB9RJB6KY=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 06:23:20 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 06:23:20 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Thread-Topic: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Thread-Index: AQHUi5nZC//vtxGbN0eH4Ul4gq7Xkw==
Date:   Tue, 4 Dec 2018 06:23:19 +0000
Message-ID: <20181204062224.28844-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:m7iiarbvrtkh4kGY2bbz47n/2GrKCvc1oN/EJvNUx1zqLpR9yuMeJ5h86b81DHsvPDY7ykNZGTmCoZW2ZcIc0Aiv0YQkJNABwsnqZWl5OfmBUUEt38Ji4ziY6juqbMO2ety5Zlls4tWACxInSSGk8hqvI3BgMvlb2hjjz8EdGdNpXTqcHnKYrG9qKmt5zrRY3YDoF/6XbBoR14dmOOF6ZnWI3ALwlVfQMQGyfufDHhwNnWAosDiK1gG3UHIJxWGct33dmMg/vjslo73/FH/GN3ptwYRRC9jlztSf1rRkvmCN3zX0dXumq1gl4UlfOkiLuod/7hLiSnfpKSulrtwd1ycWKzIZRL64xwNhJlaFXrSgQneUEtm1fRA6WLhJql7m4cToU9202T6gzKbj79KeglInSD+/FUM0/GDz+3RkqarHaMiW55jkYZ8WeBqELoYTbA2jA9PipfeFzeuKPUUzxA==;5:1JAH/Ol/fWGbM8bPyqpPaj1H1n6FpyMa0o3gh7qKr72eY5LgzUPhOQwXNDPzdV9IVxHzerWs/zQrDxgd797szxxP19PuescdYZaosVa36EyD3gDl4nw0gdlmSVvfzwa/wrLNfb7X9vdElkkg8KrvKaXrdo/BOkuEi0eSht/sI24=;7:xZf5ACdoZ110oOQ9u1/YffTtRZGFi6vEUSXomhjRZtYFgwt1DC4S+aCEGV44MWD62kd4OcOXkLk9uddcB8h+WAByC82EfeYSVAGpDU+9eP679nupf28LnwGokaVhNJHc0fMdU/JVD0fOvW/yL4b0/A==
x-ms-office365-filtering-correlation-id: 4c700e0e-de60-467e-f067-08d659b0fc08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB41528E3D4F8CB62C6A458EFCF3AF0@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(186003)(53936002)(256004)(478600001)(5640700003)(6512007)(97736004)(316002)(6916009)(5660300001)(105586002)(2351001)(106356001)(1076002)(305945005)(7736002)(52116002)(99286004)(6506007)(81166006)(6436002)(71200400001)(68736007)(14454004)(81156014)(25786009)(386003)(2906002)(102836004)(3846002)(6116002)(4326008)(8936002)(1730700003)(71190400001)(476003)(36756003)(486006)(54906003)(575784001)(2501003)(26005)(6486002)(66066001)(86362001)(2616005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nniEuefoQ1EtMYeyoOm/ptJboh+qnpNwlTCwXFOzyZTNsf2GI6Vqm6DNHPuozrq4bg2hi8lhQF4/cwAbiktiEQBO7RA35M+mUYYr6sSBhdk41KeqqsP9CD0U8rOOx7MPek1UR6TKMECEUL5orEtceWzF4Skj6rCc/ToIXDBvUDm3QfIcQUektJsvJrIFem02elzKihXMpjX/kLSHotJIk6iLxaeNznIFIkG3G8BqZw9PJx98TdReS4vVg5O8XDUaSStp9wShqQCBfvZYfPMJNhG7PaikkecWJPeGlNViqhxRWwD19EEoSl7WNnQI/Ux187vcDWbs6ZfcWWyefPuR6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c700e0e-de60-467e-f067-08d659b0fc08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 06:23:20.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
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
index f32a2e0d7ae1..a7d01b79827b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -279,10 +279,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
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
@@ -373,6 +369,24 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
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
@@ -394,6 +408,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
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

