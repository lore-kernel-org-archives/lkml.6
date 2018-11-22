Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F14C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F8C20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oU8G7U+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F8C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392154AbeKVPwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:19 -0500
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:9280
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ81MyWrWwMfzrt0qU8DpB4GJKsOk/+I3YoXTbzRq6s=;
 b=oU8G7U+BvaDn9rl/i3S/0FLCngz8Lsz7hrzqLmzD89ltwJedwgvsqE1nO157TyExjpLQm9b8kok8VQLtjS5jk6bD1m0sWn9CVdNe5TJK2zVVjEPLGHXKbNA0ps+Wgt+iivZECVnT6vOeCu2wI/EctGdnIbxUcsgpcviojkRfunI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:31 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:31 +0000
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
Subject: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Topic: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Index: AQHUgiJAcEpOMRHFo0C5hsFrjEN72A==
Date:   Thu, 22 Nov 2018 05:14:31 +0000
Message-ID: <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:PeVD9N95CZCoTFYNaSD+deWvwcNc1h0Ld+eMCgelvySfoCOsVITzlloITAoUNvNd9QqQNJEpbZCf9wrfm46GNQlrtp+UIC/UORdbQhBCXID1kTrS9lM+CHUKNEjYsTd2PgoU/FSz8VyIF85vOtclT/ER+P//CrQIzUxjxLFV+YyVBokA3/A1Q1kt0D1zLJ9qT5V2sVGm6SqkqoOx2SJ41lsgwQ09p8oxs73VCPLuv+q6UINkYs7Gt6efLXA/32HTYBqNrRZHzLHVOCkR77XqoaBrMm2JDI2asBAFZcER6zuLksfjmfrQ1AyUt3zYOnwdzdIUNizRlq8yf9WKHnhLdBAtPP48YHSVJ4acgSmeeHtqpTtoWY8N7Aa6ZEAvKgyYmfbVlylJgKywxRGqHKX0w1orZ4uSRmTu2Rm0tRpTsc479mwrZhSX7KttAfrxb3PxMtGzOT+IQAw6HWd8QXpqgA==;5:6cAERYt82UkqcQL08QknpWnGdxQTZs/cOpRu6EHnXpE7MKuNka37F7kVZeEXqS1i741V701R0vvJyYWOkmxsO4EkEAQj37O2OUnxIpTD9arGWta/4+nHY+GE/wvmI3EOBwNmlBM+ILfnnte51ijBC5EaZEh7quRUTc+E/UhYtZs=;7:4YqK3nPpUyXbpV+FtI2hFbPfP4314ZiJWDVmtCUOO2PVK44BIMVKeT5bMM8mNKzM/n6JraYkda0t4qJzqwc/OGxbfTG1rqnOxS1sqyDTYpVIleJvAX7+SmpV0lT0NsCTP7TKB56i0aGkrN7pXJLDhQ==
x-ms-office365-filtering-correlation-id: abb0a8b4-20b1-439c-e69c-08d650396227
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB305563FD14BC4F2D5C41F42999DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(575784001)(305945005)(86362001)(7736002)(7416002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vF7B61F93YkeZQ4Hyg3BZkAaYvMFSpjw3u4v5/iKy/nbaJJ7iRuPWNpaFmgMDulp2pkPDoGI1lbqRjAzHP4SzdFAzSL6x2cY9in+AdD7P52JzFjm32+qHsI3XHRsU5HauoCj1HtkqW/oV68GGAQGSDek0qpQciAG7Hep805zAizgdIcDr0AyNydji27IvkaY9gb4Ft6k5o1l0G/cm1LU6d2WBsIloDBCgU5tbxv0h0myelJL/vDRSwYMGDddhPTqaFC8szctE1FhQVD5EdKhB70URGkYpcYEpkEPYSd51ic14L1m+uOKX4KKTDmoaK3ghbySQ1ZrPUgPPpIZU6xfR/S1dVkLpFAPOHUI5swFaIY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb0a8b4-20b1-439c-e69c-08d650396227
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:31.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octo mode I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTO: transmit with 8 wires
 SPI_RX_OCTO: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v4:
- Rebase on top of v4.20-rc2
Changes for v3:
- Modified string 'octal' with 'octo'.
- Add octo mode support in spi_setup().
Changes for v2:
- Incorporated review comments of Boris.
---
 drivers/spi/spi.c       | 12 ++++++++++--
 include/linux/spi/spi.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca5940..af4e4c6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1617,6 +1617,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_TX_OCTO;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1635,6 +1638,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_RX_OCTO;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
@@ -2823,7 +2829,8 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
+		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
@@ -2832,7 +2839,8 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits =3D spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits =3D bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6be77fa..e2d69eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -154,7 +154,9 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
-#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_TX_OCTO	0x2000			/* transmit with 8 wires */
+#define	SPI_RX_OCTO	0x4000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

