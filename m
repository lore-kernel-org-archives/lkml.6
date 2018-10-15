Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF7C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A82083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BErEOgzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2A82083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeJOT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:22 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:9376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ0/JgVp/APCSXROLBC8g4dk/xsAJcWKzy3GjBlvnv8=;
 b=BErEOgzM1zQHmexrhvht52+ZV6wxka0G6aWJHzCO3Q0gZQS4LOYRh4jvx7qwgv3j7m/Y3u+JF1c8teQVw6xncU9b6Jv8PXHQGgkDbWg9yVYWL5dOYp5J7zyxX4BqRfW867W+xmAfBpuOFckBq/E3wJXTR+GdPZo3jruaytO4KDo=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:15 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:15 +0000
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
Subject: [PATCH v2 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v2 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUZICXAkTkZcvXNkqjh+fEDBQzWA==
Date:   Mon, 15 Oct 2018 12:14:15 +0000
Message-ID: <1539605534-22302-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:Ky8D4QDVVk4kVvHikpOjX7rqyJq//RKR57EOvhHL/KRoyNd/amaudJqHqH8U6NN5+mwEjXa0qHRmXvW37P6ZGpnZ44OBVHj4GbUemwI+zO7PID6l1dpcWlSCi/e5UNV9le/ziQRbhdHWnYHjMPaOCCLZZQPd+JKbTaLwW2HE36phm/+KwxMJfyn/D657bp6CZJRX1NFMvXktofwfWRKpwRZSyGPDiAp15TM+p9RBjrc0LviNaRpd5Ql/b6KTytm4z5ctfgyez0hSGx+8PbOB67J3qDk8XLB+71YVPj8A9a5kQETmahJLuOoPnz3YkIbmSTYeQBaVxQiIcF0T/TmKAYWOoVz5N5omlvkSYhML8h5TLDHIOcd6nKS5bwPydJTc+1rSu84iUaLBJkT+2vu3Ixo9gniM6EmjGBW1L4FblNE5GX/S0yHZAgaiJGKjTxXJujEmzCfyubKbuqJYiten0Q==;5:+9I14c1bfqhmdwRvRaCg47G5jPfTBOqK14mIHoCEATR5ID4T1NfBHJYIvQISbzkfZCasTyMew4uGZ9m0pV0SfApYGJpgn8bgvULyylhVDrwlgCVE38bAOAQDFwhtiWEav/PlfTSfmgConGVyIURO1/78qLvK2omlPBSzdVgeKvI=;7:ROdC3HiVNfmSQk3ihSBNS0HvHRanJgOuLf1qN5GKrG9bz6zuBcb34GcN2Ob2N1VmbbKgPiL7WwZY96qZ4x4aPxdHHLn3KdcL9CYhzkkaEufuaMlCijHtiDIWCtCJWDV2fYJP7wQUZX3autFhBc12Sc6xAvofDY5iF+sBGb6PtvQql788lXhGSfZ88CIZPC7bssVxGBPu+A7AvBT1TH3G64SGjjGBgYkGNKw08jqMVCzA1bypAmHeCJjBpyum9Spj
x-ms-office365-filtering-correlation-id: 162a5fbb-bfe3-47bc-e064-08d63297b949
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB424006416016B5FFE850163499FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(575784001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pn0xYYJzDcMOlUeGca5aSyE5L5/bRkxJ+JBv5VyXG8PXR1PNs0KFVzeU26XnyOJnU/cOt1DulAxfr0vCk3IQ8Omi7sTZ09CQX7zMHrn0yXCjqvNf2XbBV9rrcGZ4ezZR3WdhGUo5q4d/tFCYluKh34MILYwgUyElX6MEV3Gp168ymaCJzXZSJvFxKENojwt/3x2h2JqF1JBO2YvA/zzhIgXN5dYNKkcqFNF8OAKv6+3YN5M224bNzHcAiJhXJK5PgmG1qtQdkEdSx0CGxzYcyFcuZVjUosX+0/ktRwFfRO1+j2ja2b/vMZyJ8nL4zL18H4teUGOFlzjhDoLJ6B4+eVXeCGqjsdx/6nVyTImMKqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162a5fbb-bfe3-47bc-e064-08d63297b949
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:15.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add opcodes for octal I/O commands
  * Read  : 1-1-8 and 1-8-8 protocol
  * Write : 1-1-8 and 1-8-8 protocol
  * opcodes for 4-byte address mode command

- Entry of macros in _convert_3to4_xxx function

- Add flag specifying flash support octal read commands.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++++++++
 include/linux/mtd/spi-nor.h   |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0b8a6e0..7c64ff0 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -90,6 +90,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
=20
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -209,6 +210,8 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
 		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
 		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
 		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
+		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
+		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
=20
 		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
 		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
@@ -225,6 +228,8 @@ static inline u8 spi_nor_convert_3to4_program(u8 opcode=
)
 		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
 		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
 		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
+		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
+		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
 	};
=20
 	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
@@ -3195,6 +3200,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 					  SNOR_PROTO_1_1_4);
 	}
=20
+	if (info->flags & SPI_NOR_OCTAL_READ) {
+		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+					  0, 8, SPINOR_OP_READ_1_1_8,
+					  SNOR_PROTO_1_1_8);
+	}
+
 	/* Page Program settings. */
 	params->hwcaps.mask |=3D SNOR_HWCAPS_PP;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 8b1acf6..019f534 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -50,9 +50,13 @@
 #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
 #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
+#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
 #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
@@ -73,9 +77,13 @@
 #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) =
*/
 #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI)=
 */
+#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
--=20
2.7.4

