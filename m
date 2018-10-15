Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B343C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B6C2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSC+ua1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B6C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJOT7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:40 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:37269
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbeJOT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zo8AWgVIPohKPkaxItV4rZx7dVTrfVzyCBq6uTe+8U=;
 b=BSC+ua1ZkwOmGMf2sIjHxSxpswvetkFpI2HAcASVZd5upqtum5a6bXchb/Uxv6v+Io3qTIen8kPm3JaGH7FyhGKNzZnoNnOgcm/7C+ty8NKNoOCWZTWdfFCknaIyxkNIN863RE1DxSzhXoBLcum9y7gDENiJXKJfmtDMIBitYAk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:34 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:34 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v2 6/7] spi: nxp-fspi: add mode flag bit for octal support
Thread-Topic: [PATCH v2 6/7] spi: nxp-fspi: add mode flag bit for octal
 support
Thread-Index: AQHUZICiJtjeG/J6fkyvAxlbjQsXOA==
Date:   Mon, 15 Oct 2018 12:14:33 +0000
Message-ID: <1539605534-22302-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:6cVQmfLq5zVwa95t4o+ZFgaz1lo8KAZ4XHAq0WPX/3SC6pcf/cPRHlOxDOeoq/m+cFTrXxxQUvukUJlIDJnOgphdoMONoL8e2oVDiByeOIIdguKzgtlyOX70melP6Ixicz21yrveTzR+IpQqvncqqpSgd04Jx1N8LhcTN/j9X8lVE6GpkhpCeH7koyJQZmh2e7fXI7F4HBNDC5BSF5eZyXHvXUwaRCifPiVFe+MKN1blk6figiNeh1/y52KWLTOA84AIbl65zLdNxXNvkl1tC3sA82yYMzWkiGGWlosbZzVSqzHHKbiZfFOOZVMf29eLJcA2G3DwudbZVrGtzYX9LnWtOD0732A3GH7+kueuJyiHf+Ubvg6n9RUfX1l/BW6kXEHtZzxY9cEfbf8DuRtls0XI6ff9BtI6uAuk9b+UlopzPMvBEugpY+E461Rstn7dRZUSytrAakSgd2VGH95N6Q==;5:8H4BQYSEMQQMo1z/uMVvDtARuJIt6EKW/g/vYqthJgYC9IDGr8l/jPt/9WekzhAjvSLKT+rJBx8J6BVO5RVX+m3L0CM7IgoPASwAKACl2UIwBTov+jvvUPD6X4YzqYtwP9v9wZewtweqDzgf1mzcRwTnewMr+Ogp1Qr0kt2bzRc=;7:CrRdy38lx4cTwvPtBCXWUk8SFBjK2eqxUJrjED1JAfH2HmJUpDXjQmiCZGQfab4ZHKQ2bTswIkwOEpPulxyT1IvjqUoO/mS9pGbKyOKQDDsD3RB8L0R9m1f6fEpKC1RtPwkrM3SbKM5183KG41oVwAI2SEA0Aox+5C/pW9imbvlczGXAL8FGXKtXmf3PAu9YGyTb6q3Xn3k7BB0CknTBAJGVxlSkFf7NAmanTSDmC+7CLetaBrFrOSLYRG64Ar8r
x-ms-office365-filtering-correlation-id: ca129908-707e-4a3a-2429-08d63297c43d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240434E74C4577D901550CC99FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CPosedw1NYbbKGszG+6P9Bbdv5be52gAtmMG+H0hxP9KSPstDcKRFnIinW/QV4zWoqyMLk8WAciTgHKcvguKlt+FBtkG8W7wn/GFgVDlEgLGGpSg/BzrMXx+WRpJbn2hj0ZFNjNOoqnoP0brvJ7apOyQpgRPK8IiLQbqkjcvQyaCu7j1NLPgTI1yO1umZzqxmt/oTUqEMBFKK+B0y7XG5W6uYtogc0lJ4ooCbVBswpJpU0PK6SMkIEqZ2fNKaqkZrbEUgpDE45hTJPq+WnVDh3oGLCsU65ahQdMyyqmOi5nkRTw0YGO+FzCYfxAGJqmLkVpZS1io2StwXgRH628FYXJ4RzMdyGPPOtb8/yVJK1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca129908-707e-4a3a-2429-08d63297c43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:33.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports octal mode data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 67eea88..c48ca94 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -993,8 +993,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.7.4

