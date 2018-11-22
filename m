Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835BEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9FC20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7qWJ3vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9FC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392199AbeKVPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:36 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:30147
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yIqAzmWTLrc5faxXlepvYMcRmo08ToVkh/EJqvgn2s=;
 b=f7qWJ3vnmEc6HAGNDRtsuYAaRmuVeg3QeFCpJxblKDKi4X+lWeJvG2NsFbF24XigygRRUQi6zjOERu0D9D2B8zPST60txuA6qkNXDC3jMrA9ORaoOGEsLigTcOLhfiHsQNjfI/rjn8roSZyH9fefBDw1wQkXHRCd10XeAJZjPOQ=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:49 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:49 +0000
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
Subject: [PATCH v4 4/7] mtd: spi-nor: add octo read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v4 4/7] mtd: spi-nor: add octo read flag for flash
 mt35xu512aba
Thread-Index: AQHUgiJKOabH5QrebUa55cHJjfKX3g==
Date:   Thu, 22 Nov 2018 05:14:48 +0000
Message-ID: <1542863544-21257-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:tphQAewlkq1eOcdzGonzEZqTCOkBIQCYwzknNJMiq/twmEx8bk6aDSAf0dh8AYdlQY9nFdJL3ZROUt7uQcV4yKoup5j65VvnPtfh0lGYSpZjOk4rNWdYs6OwxnBPfOvgUKZE8QTLw9dCI8DKWhFxcvfbgQv0QstwbBSE7I9HH4+gFries22bunbMpwpuxeFzipPn+SkEMWjbf6duw/ef9AQEHGEusoFsbfBzWSIhOTvn3jETOPTpe/sqetadVdiFle90MVSDmYOSEAkgHKN+7vkkHN0v4SNo4DSP2cwM4tf2IY6XWL+xE7rxwkKkA97I9J3VyJPVQc5ym2043rifd968lljAGObjV3KnMVyjllfpXTBav0F5T002NhUEmbED/95TWNbyDIoLxTWKl1/CHmQ4+QctUBkjnV9X62zc4Wmz6NzWSe/Nzm0EksNGPzCn/j4/mnO9Vb4g06wpKlL2gQ==;5:Q/VPIK69aFdZU1ISF881T4FmugcWRKUI5YrxBt8cfPAk3idvBNBO7e7ZD9t/qPn40KXc6Gs958NJ9rB9nimdTIrW4wIz91+osDXtk6SdT2eTo2S48im0EM5LzgngVsTkKOaPbonLgpYgIQAGEHRkEQ/Nm5T7sRpQ+6Z2MdKHP9I=;7:qAcYr/uJnazgmlx5ks7jErV+A0o+x8CEPOw5ujf0zmtqZ4XROJSYlIM9El4qRSCLGA+6ZRhBTflpulvf0Q21IDimF6stSMf0/J1dr4NHy0l0TT63VVsL7vQwuZLlVNDhGYyBN3s4e4zMS/vE+Zz+tg==
x-ms-office365-filtering-correlation-id: 4a2e78a6-1e7b-4841-7015-08d650396cb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB305566268FA3562F2EBAD16E99DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(14444005)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: izWiJkqOvb/tDY6OFGlRFgDUp9XgrP0GGqAzr6DxGQCoVPEaGwzwJzfr+IEAKuBOFISAg6JrPahnSc5rJsfliGJe1mBMZANL3k5TwyFCmaQpEh5V/rwC/EQHmyGUDmfmZq4MREXEV1JOzeCxiM82NRywNbwdhHGFcdXSycvsHsq1Faz3Exce+Ta75J97lHusz0DmWLhknn4QnaEF8JxczOr0u8ZYy1REnrbBJ5L4ienjaXBI3aHBh9q2b55M+jpeNJK5a9VeEfzz3idfQZfDhBrGnMfphHI8+UN3Ftzz/gFvShXyuSOEJ7gI2OavoXDWkIEVeo9AWWUS0JHitMXyRY7hHGSHjY3OHpKhcnzbZZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2e78a6-1e7b-4841-7015-08d650396cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:49.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octo read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTO_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 356ac5d..347f17f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1413,7 +1413,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTO_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4

