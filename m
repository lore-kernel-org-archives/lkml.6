Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FBF20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EmUD1nLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FBF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeJWSAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:21 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:47104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeJWSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rzG3WPQ/vWy/Leb+z3Nf/BqWWvlqg4q9mYhu/fDnlQ=;
 b=EmUD1nLr2hrYkVjU2QWcFtdL1G5AJWMe+9XIb/u4F6vuVuBXCNlHXExh+zOUWW0QXyTHnoOoEMH59W7LQSkW2HWjF1WdhnT8nuZ7ki98UKRDTXRUM/m1rrRhRFfFtErjcx5eIFWzykFYZ+ZxoxOTm37rL9G+syTbntgnvgc2Np0=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:19 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:19 +0000
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
Subject: [PATCH v3 3/7] mtd: spi-nor: add opcodes for octo Read/Write commands
Thread-Topic: [PATCH v3 3/7] mtd: spi-nor: add opcodes for octo Read/Write
 commands
Thread-Index: AQHUarP935+sB2jvbkig6f9EUeBcCg==
Date:   Tue, 23 Oct 2018 09:37:19 +0000
Message-ID: <1540287311-1572-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:1PwrmJ7vnS44BQASRiF3MSmpfLaX3p3dczJi7Ls3owPnPJ6AEFnm6az9SxPQjARe/V43MUQTj1FVLmWazZSkj2MdPczwbDzbadXdrewj36GGnw6ZHWiLfPSx8b/CzRoxsSRIMxHokj7dZV+alcvNjuU+63OLLAzQEDX00KcyDFXfWD+gkTYq2iVTgn7UcT43yWZC+Ql3O9M0IMgIMw+oBwW6V4CpFGrRs6hjMwS7/hhM3X4E4N1hw0gFSGkmcwg70wV+HbMJRxuoFUiAkAPqAtIZv8zZcqC8SbCD8CC1RZVNPE9efM+AMaIlxGml8EFMGtnx7qK5Sy1lMx7YkVRKYOOrYpxtYY1kpmrpO+PCbbaCf5XcDaJbv+F+1tjoYZtDRRXNydLaJJ/+d+9h1JmgyN8EzEGJ+DbK2Z6Gy4UgbbDROGx15FMtClRQgQNx+ekBHXhGl+PkRI2FD7Kse8hKZA==;5:gFxfaZZMycoS/D/4OXdHqsrgc53yd99GpU1X4nRc7GPu61IzTZEoSHesYf9hPx0eYSm1MyaVtnPVvc6/7yac1Q86gnMqwzaHDtfK0lqiEJ0K+Q2V5QeSAKHvuL6LMaayBD/ZGgAB/lyFAs6FmR+VuAp9TUOsjl+g9FKPElAbCZM=;7:s15F9+d0ABVyz9d85sXsfSouQRTPYT3J5UPsr+88CX3eXqrLp9XSlCt8zg0ED7cu839WBPJho+Q0hwOc5GnZCVy48VqS6/HSAzuhQ7WLgBx1a1aA8ZlsQDmx9yLOoq4uO1s0dhGRkafwrOXOvCVc5YZX9XNBY2unWaJUGs1cTEpkgtYNMp7qpo6vfLkuwYNmlR7K2gJ7QpNlG956CW5hIZJz4flAAbeqKkZaR99wxEbhoTdD1anQR04eUYgNpUjs
x-ms-office365-filtering-correlation-id: a6b1781d-dd2b-45cf-b504-08d638cb2009
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022FA4D51A785DB6183148999F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(575784001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(68736007)(25786009)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BmiM6noa5srAI0VU0govCaTWlJSQne1M8Bvr/NlaR138mbpIP9ZNWBO2hCb5QShqhfAZIMBQWG2qQamOgBvhubsCWXApyxuku29M/YyhkbCzVnVBzsgopj8d+leHxszNn43pD0hrw0I4ThgNzwCLivNeTVXzq9vI6xpiXJRKXQo69wuL/Ba4E+uxkzHaZoRPUJBP2CcUZRFNdmnWVd3X4YlwhRMqeASdjKr+LsX5z2iTa4pYeq0rn6QjwNPJ82FqD2zY4AoZfF6QRW8qwzRBu5rIS2koODxZmSuwrQvgl26gzufSTB73RrF/o0oyBnklYsbS0VRYFLnne6bFDEWH31maTB0AX+yXmstmGHSpAfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b1781d-dd2b-45cf-b504-08d638cb2009
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:19.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
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
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++++++++
 include/linux/mtd/spi-nor.h   |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0b8a6e0..120c3bc 100644
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

