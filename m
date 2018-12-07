Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951AD2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="REWLg46I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951AD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGCux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:53 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:26304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbeLGCun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Hb5h9V94px7odogKjNdwED38EDbw3OCPMR1IfFi8I=;
 b=REWLg46IHBzHMzuwiVQngTc8+t1islorFjLnJSJs166kVXAwRzzVe+lyTOTZ3xz5FU2cF4TfZ5rCefCqv6+FwF4JgYjBK//EoOR7F18Apev0AWnruSa3YkpeII+pVmA1owHo8t3DS+jhWqA9PjE72Bt8lLL2uXPM1lq6FW44PJQ=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4072.eurprd04.prod.outlook.com (52.135.167.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 02:50:39 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 02:50:39 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 3/4] spi: lpspi: Let watermark change with send data length
Thread-Topic: [PATCH V3 3/4] spi: lpspi: Let watermark change with send data
 length
Thread-Index: AQHUjdeiAOXMLGxdRE6nL28AyZObZw==
Date:   Fri, 7 Dec 2018 02:50:38 +0000
Message-ID: <20181207024924.6315-4-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4072;6:mWdb8UAuygd5nAv4xAaIHq8bzvL5Mc4tUmKoDbUGnatCKtf9aE0pj5Y/7AXLEP+LbsTLeAFu4son4eFogycrpYZdARzYxXBuDMZ7qB2v+zeBjD8cTtuc/8ZH6x5wWoEbJ8SH9AWDypEWO3R0ZTXUtXbvOVplZQ1NugEwodTGrdf6NzL5olEe/zP8kTQm62EJ5SLUgnH2Vng8ktzSr/yf77ronRPLEIZQJtjVCLh3lCTiPfCTVpWR7n6Dk10OVcG3ZzKGJ4+ePM9vEavzPQhomxGpWd5MOfpZjfv7XfKdiY9hRMvb2e1huSsPBfKuhrnwQc3uWM1qxosDlkI7/a+9ZPLD8M2qQGbOJXQKd4rWMz7frHL/8guOd0xNw14h94OTNyyAYRr09fOV1Ic4WPkgncpvElYlIzv4K/qs7TwizRJzZcoqO4rdr9bhPxsWD2P/RJR0YiPx/z22doWNltLWBA==;5:L1sIUZmhRbfNOALB/4nekeJFS54HBMGuE5JcirB77yhFBZpXUkKbNN4oWPiNAROMtKGC/PLijO7suHhMyL6cnCboC7OsyP8NRc5y/h/nGXpHcZ8ki5SWU8pxw2uBLALuHaJsH5/vRtVfHRIXDwZc7nRqlAEKyN93eX0uN3vSoRE=;7:lOg22rLyE6vFbVo68dZ21ilsOB88PI24+XsbJHyzsDtYXD/89rSh3FbIWwpmHkwVWg/SnUgu3WmF3JCFfCpsZZTE16iGC1EFvasMJkQfVoR3lO9XSt6vXW9Kjw9bksaQ/O6f93r5lqzpqHOIYwks/A==
x-ms-office365-filtering-correlation-id: bba12499-7812-44aa-4b5a-08d65beec521
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4072;
x-ms-traffictypediagnostic: AM6PR04MB4072:
x-microsoft-antispam-prvs: <AM6PR04MB4072450D84E09D2D7B6F5D63F3AA0@AM6PR04MB4072.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4072;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4072;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(54534003)(199004)(6486002)(1076002)(8676002)(316002)(76176011)(1730700003)(81156014)(81166006)(97736004)(54906003)(52116002)(2906002)(5640700003)(99286004)(68736007)(5660300001)(25786009)(66066001)(478600001)(106356001)(2351001)(3846002)(6916009)(105586002)(6116002)(6436002)(7736002)(11346002)(2616005)(476003)(446003)(305945005)(8936002)(486006)(26005)(4326008)(36756003)(53936002)(71190400001)(71200400001)(86362001)(256004)(6512007)(14454004)(186003)(102836004)(2501003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4072;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xSsW1M8HR5saPfnQNyiSb4cfRebmhfAYhVBgNUo5P9tuWLlYP3pMXwStIz98jYAcArBAkwuXS5CANjkcbOe2qELcgNGE1QmqD3IuIJqOrh8zZODpDBpId+1w3b1yC4bODRSGOFXqL0/W6OO5Af3MGuL/vf9uVZUc3Du88m+FuS7zeF3qWCF5ZI6BJECWXRirGWBRlXdwFq531aTjCYSOugaTDvTCxIdsa8U1bL/ekh+ObS7XtbBoPk8Nzks9rt4C0KcXuDZNW4RV3IUIOW8+YcysL6QHDwk2IM27jxWk0f8xLBhNRgUfGsgjg+AHo6mx8y0rRWSi95ycWDrRtg/Av5t9oXo3Gi0zRAyfPiFRaTE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba12499-7812-44aa-4b5a-08d65beec521
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 02:50:38.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure watermark to change with the length of the sent data.
Support LPSPI sending message shorter than tx/rxfifosize.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2/V3:
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

