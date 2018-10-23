Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C92C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB490207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSHyVx/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB490207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeJWSA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:27 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:47104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728548AbeJWSAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfrTXoZG6eK6bbB5BaJyAY0kDt1bRK34E3DWIq5cXHU=;
 b=HSHyVx/aQuU+qId+THMVJWKVp9d1dSB9wpZatP8va1FT5MIf/YwpySHogl1Xy5D4LiyFMr2qHmfGPNShdcn4aMfPyLFeQZRU55JZYQDI2J8QPQlbFL3QAHMZHbB9f57KSzhsg1pMSq0WjzNAeiDrDoGjL3FRFs80410SNy9NCAw=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:39 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:39 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 6/7] spi: nxp-fspi: add octo mode flag bit for octal
 support
Thread-Topic: [PATCH v3 6/7] spi: nxp-fspi: add octo mode flag bit for octal
 support
Thread-Index: AQHUarQJFib3X2sTsU+eCnYlpZh0fw==
Date:   Tue, 23 Oct 2018 09:37:38 +0000
Message-ID: <1540287311-1572-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0141.apcprd04.prod.outlook.com
 (2603:1096:3:16::25) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:Jj++ic93vpRyEMkiN5VVlYzYdYeuK9SHlQXBQhy72e02x4A13xit9+pKCCOnyTCFyRMgme2yAzhLUCLCskeafPBFsD2XcE4/erc4giAk4Rvz5lA4c/TpcLbdizQotN2GDIlPeC8tBjUh2SRBL7UZTqHOesS4aaD0T/l80fv9eVn/gQdiBkoLnxz3+wo10R0fhwP8QqqCXyKfs2LuU+L6qiTGwE6gOf4rX3CrqEDwBFB4kifGRwVGyGfnReJIZThFTXa4IwNgxXcasZ5o0VFGHtsu1/zY6C/yZZMUM4sfhY7pCqBafPVgDeqg5anfWUyK0Ji3sw9cysU7A2L1MbOsRubNnzBpUR63bT185KGKAppJfZQdbEPkZ2X7+FKjWgpYzSJbtRvQU2xWPWly3mkJCI3wVl88Ra+Yr+oOnnGmIyOVDQLA7cJ2rgtIxjJSMCEbr22HKqHKDT7sWftqSgY2wg==;5:OCVLg5rK4QV6jBhyK7LL0JrGjHv1v5o1rvlAtjCSU8JH0pGXlHYTg+m95K8cfrWFQSvOHUkXckQ/KQ3PKTMWg4qYP2mh0/zB3JoVjTSOkOuWrH0mIbwxIGQvtjCmLUoTpCoY97WTYMiQlfWPJUQLbKHXO2XE6/0RerWnGDZLcNA=;7:/39LFSr81zES014OT7FpDdra723EtGp16FHtcM/aoLCNhyeMlBeci3UCI834fxrgsJi3pkO63baoqg9hbYSJScligvkAi1EIfc/rvru391h+ORYWa51H3GMOiAx3xXIwur5Gm22OSXWfsFKCGjGTKFQg65LbFpVxHDRwFUFSe2PdPL3IbAf8Ki6A8O9BFu4HYIgGtcNUSCk6nKMovKEdnRWFuUYRZk4tJSzVsuNoxxdZjbrOeUKIFmPF6OgHraQd
x-ms-office365-filtering-correlation-id: 8a79277d-4db5-478d-9928-08d638cb2ba4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022B00B5092B3A373D31FF199F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QVz24stktWo2pdTb6B2pnGmGLgd22WwpbAQ95umN1NFr7a4rCU3JUeJbrPAeIZzTC2oY+hd7i+dMl2sxL7z++nhblScHUYpkI/b+3SlNkgQ946ZbP+P1zaZxzWBSSmGX6znaUWkUKZ60AYNRcahGrfzikozryT3/OVus/VXyuXhkFPCi5g95KcLFmujNIX3qeoA4LHX2e36gOGf6+BUARnCxD6iB4JsofO+7Tc99/K9HFQThGFUt0ruo8JadFkENAt5A4km6ZmdEPDYR+urZhFen7AGaStKGsBbGg3RAVkl3irJcIPZXkbJ3Pl9BpJyT6bTotfxEu6kC4E3K4X0D0AjNozxiuSp+ASvzUsGzH3o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a79277d-4db5-478d-9928-08d638cb2ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:38.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octo mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 67eea88..332b730 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -993,8 +993,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.7.4

