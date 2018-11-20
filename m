Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC83C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1522020831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mt8bZy2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1522020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeKTWYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:24:20 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:46487 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeKTWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:24:20 -0500
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="23492616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Nov 2018 04:55:25 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 20 Nov 2018 04:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8uBLor+RPu4f9r5iacsUJFcGTzRsv8kqTqS0KNSR1Q=;
 b=mt8bZy2Wj1/vkWDLQYeGYVnUEDOdzHIUq1zb6KAYrXFr7ICVTlOqLuIwx4/fQ3gRaQRCPV5xK5jaEdbK84t+pt2fJeuJqUKsQShefW7UXkVEbZqD4Me8ronKY25KKuCE1kDjvQawtwnwdXtLtR1xvdmaIk+O99uAd4sZud+Nq7U=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1716.namprd11.prod.outlook.com (10.173.33.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 11:55:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 11:55:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <Cyrille.Pitchen@microchip.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
Thread-Topic: [PATCH] mtd: spi-nor: parse SFDP 4-byte Address Instruction
 Table
Thread-Index: AQHUgMfp7padVqHddU2ujFJxxustTw==
Date:   Tue, 20 Nov 2018 11:55:21 +0000
Message-ID: <20181120115512.15958-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::27) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1716;6:s1qRPSe4p8GR9eqE+z7CeuQfXEhz47MqwIrk5biw4rmKHAvLZ3V6lQT0j4Uath9HxzUj1vVEf2iDm1xMgOhyB5z3Y/p01JvaKiof6xD6YxHNSGR5vYNicj8nuqNDkcDKCPtJkhTZGV5ZajgZ9CJYsjS0/KXJlkgqm35JF0ltoNuFymYGHLTHfoQfvRqU3uPpG5YYoIRJWNgsHe3Z0KDgDAL6PwVFXbLSFyCG6qqhXq7TY0mv9L+LThT9W7xTtPgk1bWTWE8xmrgFN1XCKz8dGkj2CN3BbpjTAPFcDSwY87t9MYLHOmXphDiIS/K9MoeKKuE6CY0eogjYqtXZKA6EEuZDLZ2cdMW90N03OsshyAFF5s9P6kJJrAvAWQxtOVao8ARquHB2hHsdct/WHzmXjxkNKFrb8bZj4DbF6pSJosahkV4DwHKbihCQeRuWcVM6bcjjNR5hMw4zQGBvt+VPlA==;5:XLwn6tsfZsVLd1BkLItquy6mqLldPyXWkRNzPzCzJAVjtcwwZPDMa40qLuD8ejwdcML166mvt5WPWHk9ZybzGYW1D/S1J9I6rnjLZVnetAtAqPUjsfN3MU5D9CKuVMjlYX2+/iHBpZa82la6xwApSIjs3uKVwlpeLJafPW3kMJE=;7:o+bLw0VqH1JCAOfrt7eHwIaR2p6vcQAOoByhIe+S4mw9N1atqJgGfvkjf60DU7pZqEftlzt6NCpx4sBFKm8Jw7TWOHHrSClQRJHVze/7BQObstN+SpxeSoEWz+19WKLFcxGDTqXSdO8ICV+pclEKjg==
x-ms-office365-filtering-correlation-id: 9bcc6b5d-9827-4250-8c23-08d64edf0c10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1716;
x-ms-traffictypediagnostic: BN6PR11MB1716:
x-microsoft-antispam-prvs: <BN6PR11MB1716C2AF7A2517C31B4EA300F0D90@BN6PR11MB1716.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1716;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(6116002)(3846002)(6506007)(386003)(66066001)(6486002)(6436002)(81156014)(8676002)(81166006)(1857600001)(6636002)(1076002)(2501003)(105586002)(71190400001)(71200400001)(7736002)(72206003)(478600001)(14454004)(305945005)(106356001)(25786009)(5660300001)(256004)(2900100001)(476003)(110136005)(316002)(2616005)(486006)(52116002)(36756003)(8936002)(54906003)(99286004)(2906002)(2201001)(186003)(102836004)(68736007)(97736004)(575784001)(86362001)(6512007)(53936002)(4326008)(39060400002)(107886003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1716;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x3jRr2C+PQYEr4pKjxg8JUQvtJ7LabKhSum+8Ry8FCFO00hYTGGHZVmn5KvA42TcgxcsUgr1eQRZJ/P8E8nJcCSWUUH2DhHP42VD/wlsmbr/LT6bXcRMk0skzg+EzE2/ZETaayaMfuGZwv6bVnP3vrcT8G1dfGnoGu9hymDW6pMBVs0SZHxwe/KQcL+4rxLMQV+xuDMfphjdK0IPqMwBpq5JWB4BxStyhgGCLSovhkKtnQSzGs8gyLmOs1oj6dMWbYWIMECwNjLw+OXONGuAm8IPBzGU9+gW+AzbjMnpSY/sgTYnuicgmRGhbDiOou9md/nhMHbSGcYUcNnWWNTOgmxh2WBft5dRnupf59aT2vg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc6b5d-9827-4250-8c23-08d64edf0c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:55:21.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1716
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

Add support for SFDP (JESD216B) 4-byte Address Instruction Table. This
table is optional but when available, we parse it to get the 4-byte
address op codes supported by the memory.
Using these op codes is stateless as opposed to entering the 4-byte
address mode or setting the Base Address Register (BAR).

Flashes that have the 4BAIT table declared can now support
SPINOR_OP_PP_1_1_4_4B and SPINOR_OP_PP_1_4_4_4B opcodes.

Tested on MX25L25673G.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
[tudor.ambarus@microchip.com:
- rework erase and page program logic,
- pass DMA-able buffer to spi_nor_read_sfdp(),
- various minor updates.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Depends on spi_nor_sort_erase_mask() defined in
"[PATCH v2] mtd: spi-nor: fix selection of uniform erase type in flexible c=
onf".

 drivers/mtd/spi-nor/spi-nor.c | 189 ++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4c7e4dc25006..3495557b4948 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2268,6 +2268,7 @@ struct sfdp_parameter_header {
=20
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
+#define SFDP_4BAIT_ID		0xff84	/* 4-byte Address Instruction Table */
=20
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
@@ -3101,6 +3102,190 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 	return ret;
 }
=20
+#define SFDP_4BAIT_DWORD_MAX	2
+
+struct sfdp_4bait {
+	/* The hardware capability. */
+	u32		hwcaps;
+
+	/*
+	 * The <supported_bit> bit in DWORD1 of the 4BAIT tells us whether
+	 * the associated 4-byte address op code is supported.
+	 */
+	u32		supported_bit;
+};
+
+/**
+ * spi_nor_parse_4bait() - parse the 4-Byte Address Instruction Table
+ * @nor:		pointer to a 'struct spi_nor'.
+ * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the 4-Byte Address Instruction Table length and version.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_4bait(struct spi_nor *nor,
+			       const struct sfdp_parameter_header *param_header,
+			       struct spi_nor_flash_parameter *params)
+{
+	static const struct sfdp_4bait reads[] =3D {
+		{ SNOR_HWCAPS_READ,		BIT(0) },
+		{ SNOR_HWCAPS_READ_FAST,	BIT(1) },
+		{ SNOR_HWCAPS_READ_1_1_2,	BIT(2) },
+		{ SNOR_HWCAPS_READ_1_2_2,	BIT(3) },
+		{ SNOR_HWCAPS_READ_1_1_4,	BIT(4) },
+		{ SNOR_HWCAPS_READ_1_4_4,	BIT(5) },
+		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
+		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
+		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
+	};
+	static const struct sfdp_4bait programs[] =3D {
+		{ SNOR_HWCAPS_PP,		BIT(6) },
+		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
+		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
+	};
+	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] =3D {
+		{ 0u /* not used */,		BIT(9) },
+		{ 0u /* not used */,		BIT(10) },
+		{ 0u /* not used */,		BIT(11) },
+		{ 0u /* not used */,		BIT(12) },
+	};
+	struct spi_nor_pp_command *params_pp =3D params->page_programs;
+	struct spi_nor_erase_map *map =3D &nor->erase_map;
+	struct spi_nor_erase_type *erase_type =3D map->erase_type;
+	u32 *dwords;
+	size_t len;
+	u32 addr, discard_hwcaps, read_hwcaps, pp_hwcaps, erase_mask;
+	int i, ret;
+
+	if (param_header->major !=3D SFDP_JESD216_MAJOR ||
+	    param_header->length < SFDP_4BAIT_DWORD_MAX)
+		return -EINVAL;
+
+	/* Read the 4-byte Address Instruction Table. */
+	len =3D sizeof(*dwords) * SFDP_4BAIT_DWORD_MAX;
+
+	/* Use a kmalloc'ed bounce buffer to guarantee it is DMA-able. */
+	dwords =3D kmalloc(len, GFP_KERNEL);
+	if (!dwords)
+		return -ENOMEM;
+
+	addr =3D SFDP_PARAM_HEADER_PTP(param_header);
+	ret =3D spi_nor_read_sfdp(nor, addr, len, dwords);
+	if (ret)
+		return ret;
+
+	/* Fix endianness of the 4BAIT DWORDs. */
+	for (i =3D 0; i < SFDP_4BAIT_DWORD_MAX; i++)
+		dwords[i] =3D le32_to_cpu(dwords[i]);
+
+	/*
+	 * Compute the subset of (Fast) Read commands for which the 4-byte
+	 * version is supported.
+	 */
+	discard_hwcaps =3D 0;
+	read_hwcaps =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(reads); i++) {
+		const struct sfdp_4bait *read =3D &reads[i];
+
+		discard_hwcaps |=3D read->hwcaps;
+		if ((params->hwcaps.mask & read->hwcaps) &&
+		    (dwords[0] & read->supported_bit))
+			read_hwcaps |=3D read->hwcaps;
+	}
+
+	/*
+	 * Compute the subset of Page Program commands for which the 4-byte
+	 * version is supported.
+	 */
+	pp_hwcaps =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(programs); i++) {
+		const struct sfdp_4bait *program =3D &programs[i];
+
+		/*
+		 * The 4 Byte Address Instruction (Optional) Table is the only
+		 * SFDP table that indicates support for Page Program Commands.
+		 * Bypass the params->hwcaps.mask and consider 4BAIT the biggest
+		 * authority for specifying Page Program support.
+		 */
+		discard_hwcaps |=3D program->hwcaps;
+		if (dwords[0] & program->supported_bit)
+			pp_hwcaps |=3D program->hwcaps;
+	}
+
+	/*
+	 * Compute the subset of Sector Erase commands for which the 4-byte
+	 * version is supported.
+	 */
+	erase_mask =3D 0;
+	for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		const struct sfdp_4bait *erase =3D &erases[i];
+
+		if (dwords[0] & erase->supported_bit)
+			erase_mask |=3D BIT(i);
+	}
+
+	/* Replicate the sort done for the map's erase types in BFPT. */
+	erase_mask =3D spi_nor_sort_erase_mask(map, erase_mask);
+
+	/*
+	 * We need at least one 4-byte op code per read, program and erase
+	 * operation; the .read(), .write() and .erase() hooks share the
+	 * nor->addr_width value.
+	 */
+	if (!read_hwcaps || !pp_hwcaps || !erase_mask)
+		goto out;
+
+	/*
+	 * Discard all operations from the 4-byte instruction set which are
+	 * not supported by this memory.
+	 */
+	params->hwcaps.mask &=3D ~discard_hwcaps;
+	params->hwcaps.mask |=3D (read_hwcaps | pp_hwcaps);
+
+	/* Use the 4-byte address instruction set. */
+	for (i =3D 0; i < SNOR_CMD_READ_MAX; i++) {
+		struct spi_nor_read_command *read_cmd =3D &params->reads[i];
+
+		read_cmd->opcode =3D spi_nor_convert_3to4_read(read_cmd->opcode);
+	}
+
+	/* 4BAIT is the only SFDP table that indicates page program support. */
+	if (pp_hwcaps & SNOR_HWCAPS_PP)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP],
+					SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_4)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_4],
+					SPINOR_OP_PP_1_1_4_4B,
+					SNOR_PROTO_1_1_4);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_4_4)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
+					SPINOR_OP_PP_1_4_4_4B,
+					SNOR_PROTO_1_4_4);
+
+	for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		if (erase_mask & BIT(i))
+			erase_type[i].opcode =3D (dwords[1] >>
+						erase_type[i].idx * 8) & 0xFF;
+		else
+			spi_nor_set_erase_type(&erase_type[i], 0u, 0xFF);
+	}
+
+	/*
+	 * We set nor->addr_width here to skip spi_nor_set_4byte_opcodes()
+	 * later because this latest function implements a legacy quirk for
+	 * the erase size of Spansion memory. However this quirk is no longer
+	 * needed with new SFDP compliant memories.
+	 */
+	nor->addr_width =3D 4;
+	nor->flags |=3D SPI_NOR_4B_OPCODES;
+
+	/* fall through */
+out:
+	kfree(dwords);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -3198,6 +3383,10 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err =3D spi_nor_parse_smpt(nor, param_header);
 			break;
=20
+		case SFDP_4BAIT_ID:
+			err =3D spi_nor_parse_4bait(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
--=20
2.9.4

