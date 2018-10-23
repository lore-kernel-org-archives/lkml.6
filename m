Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B74CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333220671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FaGM/p7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1333220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeJWSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:15 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:47104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeJWSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDVNlXmislBhd/6jjP8bMBd4mTtArfhSUu8tm31dIUM=;
 b=FaGM/p7Ddi06yo32WIOsxZseROSd67ToX0/1/p7iY9BiMrHv9A4PoocUhfMbLjGtjNVFTjgibQolYEFZ4fX6fH7HCUysDDbUzZi8f4mq4GarsKfQhoThMtjeBUHLZ4ge9HypxBEOXi3wSHN3oheIWwA2W0zzEVTOQFH9nhfUV0g=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:06 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:06 +0000
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
Subject: [PATCH v3 1/7] spi: add support for octo mode I/O data transfer
Thread-Topic: [PATCH v3 1/7] spi: add support for octo mode I/O data transfer
Thread-Index: AQHUarP2kz0cLmXyWk6HoE2nhS/6Jw==
Date:   Tue, 23 Oct 2018 09:37:06 +0000
Message-ID: <1540287311-1572-2-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:PzeMXwRjZRN8fCjBsp2aVcn/4+Zb9Az8RN2qIb42IuKvOIgqjcQwcPS8yvGQ70ZUHjteeZGxi/W/ZaFoFxrcNIEfwf6Oivt2aZHQKELzBHa+rqybEIrDiiToaH2TUHyZ5aPW3IKUHjbM8DAIpN0Kx560mSm8/7Rfp9V4o2HmVAkcvH/Ki4BO2HwgUE3K2xhSPAieyekIlNz5rpzQgfO5G6qBip29lt1yOv6WTERfX8vo2AaKZmAOkSU6N6PbWRaa96t97HRAmliPCP0ALXQzr/13vOVl4Bo7xRSyZUjkw6NhQuxIbVylcaHYfpwvNJZ2UAXQ5ATwZC3bAiw+QL6yij4sl6FdJ97WUYMu+1nI0X0c32wnDhy53la71QA5V/teT07TvO/vv62Nq4fVy0FVtWYiAFFBe+zIuIiigJz2rbr0u3PPieIyoifZ086SlHnx9ZynJKgBh6Z8q/MSoRmMOQ==;5:z1QKnF61Wo4lPFL9pwmW9YsiolM1m6EBJs5J/KCJ/RM7cYhEMvPG2WKdwFJRUL2k2hAppU1EwVRuGUS7A5XdIQZPLcQPKzWStLPb69mvvFqnKHivZ4E/ReHZ7qcotDj5ecMWuz+/AVBp4gGlhS/xDBFFoOnyNy9MHXVtL3gzQEw=;7:1LqntoGRsqj09BPsRqjEqLdxKx4lAup8gX0ytrYWK2uz8i4Ci3LVboDZu58b8uCxhpLGBYvljhMhXk+fb/AKTubG8e+6o/mcefKwrVFZGx/CFSjiaheoLTYIhwn4Kw8SwHVvZF1q7/QjzYFIdSlWZHB9tSIF9v6Hj/SrUzjnIOLoFWAytTNN2gIP2gfVVluWIBb+9FOBUNPyTdB5sCkQlxJG/1GxNekh7nwfLHlNiMwN6445KRbPj/EwYT80pHu/
x-ms-office365-filtering-correlation-id: d32094a2-f492-4104-b674-08d638cb1882
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB50225488964E1EF4F3DD821E99F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(575784001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VqLkTTcnen6duu2cN3dH785+6nDftu0XeZB0PZH7+juQtt6Z8ERq2MzqvS9Slfv0XdKQ89VdXL8YxqxK8QqwIA8lZDZSKUl/+shpIRLTFhiRHH7H7mgWYLl4uJdgVSu72kVyPN+ccL0dZb/rFthA/ZXvzAkA1uSH5RzEdGpsdv5rzB3td/7T2z8C3p4sZw0UanDIvnjWo5PxWGvfXZ6TNxZMyPYQnkpRa+wbh76dFCtu3SZdFSpvIcHxWHSTBm72OXXXZa4DUv/lmxqv7OuCGsP3CmUyIIuba+g22bVfh9M+bDjBohwrGcHhgFwD9dVhEkQfF6RBGSScOqoWJ1gEebtK8y6cODQSZMufiwx9PvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32094a2-f492-4104-b674-08d638cb1882
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:06.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
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
---
Changes for v3:
- Modified string 'octal' with 'octo'.
- Add octo mode support in spi_setup().
Changes for v2:
- Incorporated review comments of Boris.

 drivers/spi/spi.c       | 12 ++++++++++--
 include/linux/spi/spi.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6..6d57fa7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
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
@@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
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
@@ -2770,14 +2776,16 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
+		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
 	 */
 	bad_bits =3D spi->mode & ~spi->controller->mode_bits;
 	ugly_bits =3D bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..cea4e49 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTO	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTO	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

