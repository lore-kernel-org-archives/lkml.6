Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB962C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843AC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WlGY76BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843AC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeK3PhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:37:16 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:52709
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeK3PhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DINdt3VaBqOcXbGcwOYzP4gcoA19v3P+jSyQjNr6MQ0=;
 b=WlGY76BCnZplQib5GaEtwt76FAD53q2JjNp48b/QEdEhBAsfO1/2iPwfdJYJWCvefuDwxmTd94k1p8mKyO65vwvDp3TPIm62fDAppb9hPoCRrtsoV9seI52dzOiR1TmTpLrB0tTqY5eOTvDM8ERMxmUUVZWkOPM1vB2jcWHQ170=
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com (20.177.50.90) by
 VI1PR04MB4413.eurprd04.prod.outlook.com (20.177.55.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 04:29:10 +0000
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359]) by VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359%2]) with mapi id 15.20.1339.031; Fri, 30 Nov 2018
 04:29:10 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 3/4] spi: lpspi: Let watermark change with send data length
Thread-Topic: [PATCH V2 3/4] spi: lpspi: Let watermark change with send data
 length
Thread-Index: AQHUiGU9oRTA1aQw9k+q+bT+aC4nHA==
Date:   Fri, 30 Nov 2018 04:29:09 +0000
Message-ID: <20181130042753.28756-4-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4413;6:Cr1voLOHRBy5HZRSq4NLYzEFiqINNttBSER/8k0d1HLyDht9+L6E+bADwUS0AmG/KwpelW7pc5dYuLV50K0G0pInN6u4zDLsg9S/bkdatzujgLkTWzA1IoxVqpmoFzfTqptFsdC7BUUB49WF+kvbDsvnY3G/Q8VusgPpthVNvXLHRkQfSnVd+LO1FUUkN+d5JcrsGomTJugI0RSWSNaKl2x4MdqzMtjq20E8MCtRKHkT7VExoAkw8rDU8kpQBbarb/GgSX73Om6PUWZoZ1lBVSW+ttu8xaNLowCCRi8n3dJsF69Tib2Lgq87RbQFETTQNtdPWR9zqVpfaWxxeVIKOidxs3zA+OMATIWS+e72UARD8Ulpt007Y5m5RMXSUpYkU4Yowx24LKbUhbLQvMZ7SLPxbnFdMD4EM4ICO9GeiZrOM5wRYvMzPUs1rich2uEUNBzrkH7O7SASkosqMuAQVg==;5:9No7QO+YSrDe5ZKzmj6NLow65RzkkJebWi4JiQgUwPnYuyIR1CgFfuefA2EVuzsN0MO9ZQppU8xpckQa9mXQVOJ6CoQBiqU9Csj+9Fzn9u6/5XRji1f2FQDLCT79waQqsk0YaNVsKgtJ86nZtbsc4kzz+3jg77LeZ+yit99yYsY=;7:1+hxz/S82/NO7CYq3EjRyEI7QhBdQPZ7aA2xKEhoIUKLPvjRNNuVEslVzz7o3TP1Z0dHrSbdkyLMaQXtQw0btUbigqAhESL/F5abkCQCO//PIMBPPPbh+BzcMsqIevWunOB2MWqWG6gspTuuqaCT7Q==
x-ms-office365-filtering-correlation-id: 1ef38d76-03cb-4df4-4eb8-08d6567c5f58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4413;
x-ms-traffictypediagnostic: VI1PR04MB4413:
x-microsoft-antispam-prvs: <VI1PR04MB4413608909C3305E6781387CF3D30@VI1PR04MB4413.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4413;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4413;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(54534003)(199004)(189003)(81156014)(6436002)(76176011)(53936002)(186003)(6506007)(81166006)(256004)(8676002)(6486002)(386003)(26005)(8936002)(11346002)(99286004)(52116002)(7736002)(316002)(36756003)(2616005)(54906003)(86362001)(305945005)(102836004)(71200400001)(2351001)(14454004)(478600001)(2501003)(71190400001)(68736007)(476003)(1730700003)(6512007)(5640700003)(6916009)(105586002)(3846002)(486006)(66066001)(25786009)(106356001)(2906002)(6116002)(97736004)(446003)(5660300001)(4326008)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4413;H:VI1PR04MB5021.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QqHSgPSz9mGeWEMjhS6pXXgCLmL4gLt6iCdjGIv36PpwC1vQXW31KDKCordCIP0Ss2XbZU5r1Ks26ujXVncxKR4BvvZEnJtSZE1NW/2vjk82IEsmcIG3MDx/RxLG6qRqw22Y5mR3MFo4NuktqwvPkTmITbQ7wFSrT+Jfbnd8ozKXIdRjG6sGq3Qm/XUnLbKlj0K0FTw2nMPzTn3ZA71ygtZsZjHRXlaSfTOeJO0E7ZEsMEepX0MMoGZ/2rtyptLH1ehH7vaZO2vPkaazyR5ElSk0c6ghwOAIGixlvKewwn5GZvkfWRDPDHWtiaPmPeEbApn40T4MvTI4TgyrWFcL04vKd9sUI8zIAtVC+f/T4C8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef38d76-03cb-4df4-4eb8-08d6567c5f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:29:09.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure watermark to change with the length of the sent data.
Support LPSPI sending message shorter than tx/rxfifosize.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:
 - No change.
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index cbf165e7bd17..08dcc3c22e88 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -89,6 +89,7 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *);
=20
 	u32 remain;
+	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
=20
@@ -235,7 +236,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_da=
ta *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
+	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -261,7 +262,8 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
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
@@ -329,6 +331,11 @@ static void fsl_lpspi_setup_transfer(struct spi_device=
 *spi,
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
--=20
2.17.1

