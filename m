Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77731C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DA020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pNGX3APq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DA020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbeKVPwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:32 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:7680
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrG1FcxOhIOOKh4I9G7mQAfx2MqB2CJ4iZ/CqtAgKfQ=;
 b=pNGX3APq8uKurVkuQC+LiIT9YCFs9pdQ55RcgT7Q5ADiQus5dcrkP2m0ISzoDnTVRv1FzBv4rV3IxpgVcWL+Z8sXAPiRsVpS1llGcrM8NtfDJf+5bW8P4huYO7Eo1AoVhEpTmw8s00xgJkYRZfRtGRwkWSJRYIQ8CP67ByV6Kvs=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:43 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:43 +0000
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
Subject: [PATCH v4 3/7] mtd: spi-nor: add opcodes for octo Read/Write commands
Thread-Topic: [PATCH v4 3/7] mtd: spi-nor: add opcodes for octo Read/Write
 commands
Thread-Index: AQHUgiJGD5XQNtWIwEObW7mzq+FeDA==
Date:   Thu, 22 Nov 2018 05:14:43 +0000
Message-ID: <1542863544-21257-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:sq7E7ppVetYdo9Rlu8rsrtgGi4iRZA0wk0rm77Nraz0Nhsls4y+y1VqSdfZh6jjOR/fERFJ2mTP2VTKmZadb83ro8TG4kofx32FOdrBGupqgDZpQwzZKXuBdvnQE8EbkpI+hcwPrRoug2VTwz4ByAns8mLX5LgtTwpeSEe7R4aK+lComfTqIxAbZUve0G2vRmebPii51nMNk/lq41cmP1JavdbJXwDxpj/X1srQvZDP3uWZk9b6JUlMeIYwh6r5O2BMK5kaiea5BwRyn6PmlJ8OQkueUJXdsPoH6RGuCNqAjmRrlHLmLs4z5rLF2ME2COY0kJBvdDyAubXvq9yKowWz0cI+9WMXVj0k1zI+lsOFLnqc/EnMn9b6ou8JvTLZPvO6LxZyqluHRg0IskTS4GrifVIiuyAbhPi03JjfXXf1SB5F7I1lS/lmz/t949aO0VkKLkdeR4/DTKX6qByITWw==;5:YpfS5Y8vdv3GFj8d1hOwB2Tj3cQssBOHVJ0KhYym6XbPYkCnS8lw792/3EllyE1bxT6bku3i3rH0O0UAO2x+QEIiWQn3WyWjlqzN4cXOX2yK+QAloivbZe76kCZS0gxepIrbb3YZeQZBQlsIS8vczjWPMCtCeiidp0zo6HHaAKo=;7:D11aYUHs3RvnpVbUzsq7nMGu6N11Orni1ncH6b/vrr4xkQuBHDO1MOe+VXx1rWYQt7j568Xjcij+lapVWNyKDDRkicLfkhz0FvqaFHRq71d3ORB009LNzLtlQ2FpQyK01+OO5o8LHqieTK7vI5xXSw==
x-ms-office365-filtering-correlation-id: f7cbc696-ad09-4441-e5b7-08d65039693b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB30555681559A01739F680ADD99DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(575784001)(305945005)(86362001)(7736002)(7416002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OqpzdqS4FZdP6mezQzqRivnGO45eaIn781yyAbmqlQi5QxrQaH/fXdufILfmoAicHErQeC4UDemW/LtRNxHu5DPRMmt1H7T5cdlDtMHJloUC57tIo2zXJczxfDKZGdyNxbkXgOPMD5PdGCzhpbw2PcTmyv8mwCOmcd2r1+RZZFbUAsJA37k0LwtGoHS5zBKpXTa3frG/fXI/OvbbEH6d38WaEPKVU5vwkVVUswui6EMblC2ZgInr5WDebxafA2ZSvJ+KUkzVEzguqpnWXV9md9XG3bE3IuysfXDNmjRQeWFH3YQdeeFp9AdXSnSI/jTfhQyZ+V7CObo3jFymc6JQUOpKhUBJ8XGDzGmHtoLfySM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cbc696-ad09-4441-e5b7-08d65039693b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:43.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add opcodes for octo I/O commands
  * Read  : 1-1-8 and 1-8-8 protocol
  * Write : 1-1-8 and 1-8-8 protocol
  * opcodes for 4-byte address mode command

- Entry of macros in _convert_3to4_xxx function

- Add flag specifying flash support octo read commands.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++++++++
 include/linux/mtd/spi-nor.h   |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 398d273..356ac5d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -90,6 +90,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_OCTO_READ	BIT(15)	/* Flash supports Octal Read */
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
+	if (info->flags & SPI_NOR_OCTO_READ) {
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

