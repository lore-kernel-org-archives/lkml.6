Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D692081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XSSC8sMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D692081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbeLCIjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:14 -0500
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:21654
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbeLCIjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwpmnhJYKSxWI/smX6DS9cVPW0aQ+K6nMhBM1K8RUjc=;
 b=XSSC8sMiZnjPIrKzuNm4HPkvHn6JeYlBYrVRYq52368+CKXw/xfLEj8A5hsVTTGLM8MDnQssAMRQ6Gpvvj+Tu+ukFRqUBvLUwlxXwr8Gql5tVmSur6/LeQdr/jrivFscn7XgNSh3LwNMInk5bWPzZkgVpCrrK5X3IAvfCrNStPc=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:06 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:06 +0000
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
Subject: [PATCH v5 1/7] spi: add support for octal mode I/O data transfer
Thread-Topic: [PATCH v5 1/7] spi: add support for octal mode I/O data transfer
Thread-Index: AQHUiuOnnN1e2/pCsEWSJd8HL2GM2A==
Date:   Mon, 3 Dec 2018 08:39:06 +0000
Message-ID: <1543826226-30898-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4718;6:77AOlIlifkJa2jxl+u29EB6V8uewPQP5yKENK5Jfa6jhKpl2MCHcMxoecpdfLvFaWD18ed8P/RvTfsMd6zZXMlztpd/X10/9xj/zUqIMdp6foR00/JJa/iRhTWaNoxCpNunJffjCWTatRT7/K8OWJpHwBO2H3TQvNsZPfS7IidglK7f4R34QguPBIJoXHQvHNuUUX3Rm7Z3lsvR9Dc/Ykcwtf9N/ZJpicLWW8g+Ba7aVnKje5DmgfXqjj7Uvv0ntP1RcIIhJ+1/0IpEyqGdnJoSYMnP0MYrrPCI0IvNs1bXYtUZW60AclS5i+h5E1Va1oaPboI/10KS4d7sd80ltelCp/qvf2O9zTccWuB1AWKHniRXmmdx50H60BXdvnKx4WedaWFZscaUwGG9554ZbQ6e69X36nCkpc8UwkYq5+TddPfXs4O4Ds9eiFiEecbKxs6KquescT0GUK+P27+CfZQ==;5:prAfx4itjM9ov4NNSKXOH+3qvYnUzpOCLnQ/1oUP67bQX1CPqcYa/cRV9PUDSlBxjLWpAz0cVkkWW7OeGi9APNP6CcyISpZfuZAUWej1VzC5acYDvLLoHhYr0e2L+gF8at1Vht3gLBOXn42vmuMcHtWAGSV5QcDGGA1kr0dk/CM=;7:P8AjbGMtlytgYBgrUOA5INsGWv6YsG3HApC69lSFfcKAXz58wep13xxumuaZy6CFLlEhFcNuOyigG3t7dEsr3XJCQK+17/knJr89l9ylTqvBI9hr2jcGLIC/o4vWQeQNG/+JMfsXOGjxSr/rdITr0A==
x-ms-office365-filtering-correlation-id: 0f4eb8d1-26e6-406e-dfff-08d658fac930
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4718;
x-ms-traffictypediagnostic: VI1PR04MB4718:
x-microsoft-antispam-prvs: <VI1PR04MB4718491558C8CC2B0F3DEDA899AE0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4718;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4718;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(99286004)(6486002)(76176011)(305945005)(6512007)(6506007)(53936002)(66066001)(386003)(105586002)(106356001)(68736007)(256004)(71190400001)(71200400001)(5660300001)(110136005)(55236004)(54906003)(7416002)(14454004)(86362001)(478600001)(575784001)(6116002)(3846002)(25786009)(186003)(2201001)(2501003)(97736004)(2906002)(81156014)(81166006)(6436002)(8676002)(4326008)(486006)(78486014)(36756003)(102836004)(52116002)(26005)(39060400002)(2616005)(8936002)(446003)(11346002)(316002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mbX1AN693ki/aVaHhyAfXzQ/xc5AdtKpRGnfzkZYlBBQjVmNko9TlbX6XDtsY3KMJ0+JYIUwXStFJ8RnqEr9UojdvFduiqt7XUf3QvTRCxsNHKaMG9D882Dik8K8BcpqKezVGSpLzbAYzPPoylvcnZWcu/ScQxXWvM0WRyfgcf4QhhbF8xFChHebirWKnBChX1S+02wYo1B6CGuCuZhbfVhhAgadSSjFCxc1jDNuaVjSAzsVSucCcIYR9D2zPL6zFwBCGpgnL2KpxPMCOrwDFh+8HDFpdmvF+XhKWP12YwJBVA6ySanHlTDNe0AqqqZkNYAERlVMANdtkTk9/G0ei6OTVFo77Z3+exyK2srByuc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4eb8d1-26e6-406e-dfff-08d658fac930
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:06.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal mode I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
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
index 6ca5940..95249b8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1617,6 +1617,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_TX_OCTAL;
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
+			spi->mode |=3D SPI_RX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
@@ -2823,7 +2829,8 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
@@ -2832,7 +2839,8 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits =3D spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits =3D bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6be77fa..0c1ca5d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -154,7 +154,9 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
-#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

