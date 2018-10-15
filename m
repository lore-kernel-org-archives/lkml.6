Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D9C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A8120881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uIKT6Thw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A8120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeJOTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:32:59 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:40576
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbeJOTc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcWVntAi4IsR1DyHqW4HMz12ZIYgg87aIYfzgghftaE=;
 b=uIKT6ThwKBC0CDbZltnksfA6FeVtCl6XQ2VJdx0K/hEksXoESksgdII3wNGoV0IS1Vp3dcX9rmp2CAOj9TdRe5cxWGGSX9oPWBQkIwp9LBqPU8mfuxHDlWpxfS7F5aq/rzNTcIvSvku+H7FHdUmH/Aiz1zajoIevo8Umc8AxG3c=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:01 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:01 +0000
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
Subject: [PATCH v2 1/7] spi: add support for octal I/O data transfer
Thread-Topic: [PATCH v2 1/7] spi: add support for octal I/O data transfer
Thread-Index: AQHUZHzsiV0kUSLvEEOUFn0AqcywiQ==
Date:   Mon, 15 Oct 2018 11:48:01 +0000
Message-ID: <1539603969-21076-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:if8rNo0SB8TP19X/T4UDkYWua+xKHtFuSX/03R2/kxzsW2iy5sa+QHiJA1BgA0Mh5VQqjAghMWfYcHRp83OJl13KsoqPm37xlIOpnN5gkqH548lnIpEjNi5E5DFeQvIxz9ZgfmF8nMNnf1cJGRc0kLhVUbRvbCh2IwOGXVk9Q2G9nrehZzC2+n0upDfzS8aH3BE2tfQ9Nig9MaIM8wHXlTC+7StatS0n2dlY4LH4pO33mUHTB/6cpU4neDRZNdC1mTHJTceiKdVQgT2ix1oOFTpXAhFX6u2BrrhZbDEq5CnqnEXbKY7JCnC/iEd4y+E/XbB1tC2AP1U3E3LJAsmHuXecdqwENGjU4uz9W/nhybX2I6Q7jMcZqDkm3gbR6cro4lAdGVXhMVLSxYq24r5hRY268hjY7vd2NfgP/w12ws9K4YaiPIK/XqX5/ASu24/gm8Yms2rgHLn5PYPLdzNR5goiy7cV5yAzPjjIhxFb7eI=;5:UMvPD49wg/QH5/dOgM6sJidEIyqGJHrI4qPQ2ovS8pry6aQtOFMfVcnMYQ+nEKH/2L8gppSs7dm7yTSxRkfHJrbH6i+agESCCvj3ayT/M9zvTPlB5RYzZhAMrwYlk5YcHXTeHpsXzcqNz4HiroL2LXBlvUCfNlDhXgbgrLn4XeE=;7:CRHlhgv6U4MoTQYhPe0AG9VKdEMN6u0uRSJqe4CjFGD19xS/P7wiMTT46Ip9wbVbo+eiUsK4MswEhYN7f7jy5M+EugeX69HJUBrmnxfV2POb5oAMHepmNEmvHcjkDesF5x21R2t/BXbvVVcsdQmdao8eKDEfxvUx0c17W4kuJHyvqMwbW5hMCnNaIypMGUhNNfigfsXij7HrnR9q50nfuFS4UmBnGycbO43b3ZaF+5rMjCFYRA22BKa6KlP9fh+S
x-ms-office365-filtering-correlation-id: b76c6f14-65cf-4051-b0c5-08d632940f01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB16161F405C2ADA830822F1BF99FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(53936002)(7736002)(256004)(6512007)(25786009)(6486002)(6436002)(575784001)(86362001)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(76176011)(99286004)(39060400002)(2900100001)(478600001)(476003)(11346002)(2616005)(486006)(446003)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(386003)(71190400001)(6506007)(105586002)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qzbwPBTaBBRcf3LrbBie6l8vdk9xO6L5tucFhRJL4hiODNwZo09tS7qGpSr3WFvXqmpFTdJX/77vbR/fiFOVIxo8xwaucmAYDuUvPMAFyx4jovXae2t9CGxJLENzfsqe0lXC67h+ceyN3aPphGvBs5+FIM2EApoN33HXidMDmX2v5Z0gz7YFWWPKegjpbnrazNtqJaJdHI9ptfPg3vRJPg9AYDVb3P5ldx/WrjLa45YLPTcf+UMd+emlzsz6DxYipsx2BkbCTVIxOxuJ1tjOWIYlOnkOj/N4qD0AjpdUKTxL9IzXoLcF3s3jS0u7mTlgX8EKQZ0R792XbbOfOMf3Md53X8/4ppJq5hpMLG/k0i0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76c6f14-65cf-4051-b0c5-08d632940f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:01.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris.

 drivers/spi/spi.c       | 6 ++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6..80f672f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
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
@@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
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
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..2d21307 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

