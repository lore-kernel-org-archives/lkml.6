Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60478C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101FB2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XF6mRQak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101FB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLCIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:37 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:28530
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeLCIjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUFIqMUmU7aVctiSrOoJnSAVup/dBqZmvL17Uyu0wD4=;
 b=XF6mRQakO2MnxJVLEusg0aNfmjN8JRifes0+FHJ0gWJXsDzKKVHMPDfZJteKpL7x0y2ZoWpid0iB+YhXoh5iyPbtO7EWTF3ciUo80LgZF6hUJcOeDNjnH8yFPVPq+RqKjrhGuz43H/soUXFZvxc4uhnr8UOGfNAK7QJ6teSsFtA=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:29 +0000
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
Subject: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtQ==
Date:   Mon, 3 Dec 2018 08:39:18 +0000
Message-ID: <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4718;6:ScpS29w2hKBbO10PnIp1nMXhUmCILlOkcmfelVtcgkBS7peX+/Fqoj2jhoZyWQbvcRTXR2alN9HWOzm21+kaXlDK3UQo3NJKtmrVNdkxybx2JpbCeZdM/iEqPUQyxx9DWFKa4/ZbggRCan8CLtzkerYrORjh/Jp+RdymGOPwWoUFwsIKeCLdjNIqsOBFHj6oEhOyRIv36Z7KSKMMzK54ONF20qG6Lfc1i7slIsUl7PwSVYDyu6g0WiwvkUsU/e8IRrauD0F9s+xqJf+tqhlfFsLSddUdpC9yMYMEj+U6l6GgFudydS+1BGTw06hQdKB8/CYK/JZJdiigm1DPVC5JrbRj9DA/b7YaisYiX4aMIxvjk6frLgAXtv2YTPfLUBT5W8L9pu/k04URWAuBe+BU6Xl9BVb3mbtJZ0YAb+x1NX05fpQy1KNjT7TCxuUSqVmaRnlcNrII98UT4S3Od1ICrw==;5:hQAiWoI7eFgohmjOpYH5nPsPdv1LeFIt34i42B2g8MHT7eOswOENrVTyyllQOafpbqxpjWXiXVKTB1obaI2TjNuz/ICF+60qjVWHQdZkw2TEgGHYA6gIu8+COjOoJxXn1/9cepjL5UwcEsvXtlcdq1v+JbQbx8HWs4FQ9DMj8cI=;7:17BgCgL1NhdR2HuQlRuiicwrcanqG2Ko5K5eAas76bhlTB2efhqpypQE9RmSPQ0JpgfAAwNzp2pQn7l8ToYewcZBOvi+oVu8zIeI+kkLK4WIE8LV7qJB3x06tzCRhHWahxQ2vnZGZPqveI+NeJ568A==
x-ms-office365-filtering-correlation-id: 1e4d7252-0144-4f82-a31a-08d658fad073
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4718;
x-ms-traffictypediagnostic: VI1PR04MB4718:
x-microsoft-antispam-prvs: <VI1PR04MB47180A784F64C1890574272999AE0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4718;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4718;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(99286004)(6486002)(76176011)(305945005)(6512007)(6506007)(53936002)(66066001)(386003)(105586002)(106356001)(68736007)(256004)(71190400001)(71200400001)(5660300001)(110136005)(55236004)(54906003)(7416002)(14454004)(86362001)(478600001)(575784001)(6116002)(3846002)(25786009)(186003)(6666004)(2201001)(2501003)(97736004)(2906002)(81156014)(81166006)(6436002)(8676002)(4326008)(486006)(78486014)(36756003)(102836004)(52116002)(26005)(39060400002)(2616005)(8936002)(446003)(11346002)(316002)(476003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wEpH0U5EPJS0Ssdp4h0uT0wSHgqEu+FAocipzTYiKoCMnwXFjGewZ63oI+e3gTNxtIYNqDYgg/RppdkKC4LzEyCCUC6sH+tZ5Lg0GqMgrfp42KSwRhsL+DToJ910NDF3955fv8xYVKzqarictNq5rix/LhSqcI3zmsjCX+lUEWBOmsuZMgWSBd2rwlnIOEnqsG3BGmC2ggYItWI8jUQyQ6tGJYT6K1jgdGuCMFJJsYRO3OM6GBP48cHJiAxChbeTb+3koUkPkV3+QxPbcPRGUIcTccWm+SrkuWuhQ5depj7PwydZBJSSdJPYCgFTaNDggQXNMX39DOjYX6opt0yAPX8R6GpSDDJSCZEDsbG1lWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4d7252-0144-4f82-a31a-08d658fad073
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:18.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
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
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
 include/linux/mtd/spi-nor.h   |  8 ++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 398d273..7a2176d 100644
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
@@ -2093,7 +2098,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_4_4_4,
 	SNOR_CMD_READ_1_4_4_DTR,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_READ_1_1_8,
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
@@ -2110,7 +2115,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_4_4,
 	SNOR_CMD_PP_4_4_4,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
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

