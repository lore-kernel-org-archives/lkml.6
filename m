Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D1C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A52086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qzQObTVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1A52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKHUmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:09 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18956 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeKHUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:09 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="20844180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:13 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qBLrX4OJMi6nva5Gagm1lxJejQ6UsnDhO4vKo0e0BQ=;
 b=qzQObTVD1W9Ljhv16wX4kRUCrLktsBi0jOj+pxMmMroapMhGZ0YSQWNtW0mNyilSyrjqbVyHh3NgJuTMaKoNvfTOqrUmrA7kP2vDx0L8h7+MxIOGK0QapRV6i4/T4U+ZQLrw01QdprtegGRKfj2Hbz1BE3T+C57jYA3ylYIbuXY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:07:09 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/7] mtd: spi-nor: fix iteration over smpt array
Thread-Topic: [PATCH 2/7] mtd: spi-nor: fix iteration over smpt array
Thread-Index: AQHUd1MxxRyOdK7pfkW8L7t/3gBulQ==
Date:   Thu, 8 Nov 2018 11:07:09 +0000
Message-ID: <20181108110653.21063-3-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181108110653.21063-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0009.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:zMy041KOomJEannMvClW2UR4Rrw3iHPakqhtCih1Yrfk6uiFG6pyanRklH9tmcAg/RKc/AkK9aKwkiEEkDUgtuWxw0ACnP8s4NYcZJBAjv2dSPJXXIHn182sJb0Lje5FmzQ1Vg5LGAGAyxJffOQtCMe62U4+NVMst7D7jV166gSAQzjgbEoYlJrNGIgITqLF0u72Swsi1PveLhSA4wrZkbgV59z8VxFR2nXhFuDs4gFWbxc0u69+6CoXZ/U6RfxjLFnrdNWAV44gR9PIlXZAyba4i2pRTs8MqAOqbcXV7mXsZcSWzGs15lAJsM0DFYOkWvq2dPpiNqX9d5sL2blJd//ubEVmRIrZo1aOSnehOMfRrNIVL4rdcMfLxG/YJmemarDVlXnk1XrjreD6fFW1uG9GwlApFr5/ahRQJHF+WXqcMTWM2oP/5/HHrySCKZ2KkJglKhvZjOZDbiAbl+cYNg==;5:hmyBh1CRgp75gy0qByq+ltHKUBUtVtU3pj7Ry8hfZ5szeKv/BxjakH7TWPVviPitbaccB65qyphUUtEbaJoKI1CkQk3Uvox9+nKg+jcTXrLF79sjdRS6fGQVAEROE12EOrMyhe+gIRKehMO76D4BEeSScF0BcR0EuFl0BeQdOX0=;7:47B05BLNbcAqwm53Qih/2SqrCLuDgRTe18ttYhcJl0dt4bvBDeOk6ZV/4gXyim4MR4PLQJ8GxWxb9EE0N95By+mzAHHZ/ry90c4q8zaepcwagbKqSM3OBmixdlUxUrpsBoxoUcxck5hfu4fIAtwDOw==
x-ms-office365-filtering-correlation-id: 086cfef4-65c7-4e59-9192-08d6456a539a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB19877DC7809EA9557B00D3B1F0C50@BN6PR11MB1987.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1987;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1987;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(72206003)(8676002)(81166006)(5660300001)(81156014)(102836004)(14454004)(68736007)(305945005)(26005)(86362001)(1076002)(2201001)(39060400002)(7736002)(8936002)(2906002)(2900100001)(36756003)(3846002)(6116002)(71200400001)(71190400001)(107886003)(97736004)(6436002)(6486002)(110136005)(54906003)(2501003)(2616005)(11346002)(446003)(99286004)(53936002)(6512007)(256004)(4326008)(478600001)(66066001)(52116002)(386003)(6506007)(186003)(25786009)(316002)(105586002)(76176011)(476003)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qp8/6CV1ExjtUksJ8G6GCgw4nkA2Fz3R8PBYXL74duF3md650GUGl1bByuQsnJ7itPp6CUYS6WdbiMNUbpNBsNmh+NMtVaetQHAeHIBtlLe8lQTniFHLjgTw1ovVztr3OzrN8s63UrOp4hPSJbMxrpiNJcjgVIbLo+mvhdAw5kCUxQj23wynCmu4e0Jsm+A4ykFcttRUtiVqulroZW/AOJEy8DuqfsTS0RZZyZg6Y90aXrJpVlX6AAYs5wIwaW+6HC4jK1ocCvJnPaqxgkOMON/+uR8DwNo2+8fF66tSJWZErDGelhZ7CKB6aZldGhEwlpptq+i2EWRRsblL4U+GsvALLFAYKx5lrRMi9uBVtrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 086cfef4-65c7-4e59-9192-08d6456a539a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:09.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate over smpt array using its starting address and length
instead of the blindly iterations that used data found in the array.

This prevents possible memory accesses outside of the smpt array
boundaries in case software, or manufacturers, misrepresent smpt
array fields.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2cdf96013689..59dcedb08691 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2860,12 +2860,15 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
nor *nor, const u32 settings)
  * spi_nor_get_map_in_use() - get the configuration map in use
  * @nor:	pointer to a 'struct spi_nor'
  * @smpt:	pointer to the sector map parameter table
+ * @smpt_len:	sector map parameter table length
  */
-static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt)
+static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt,
+					 u8 smpt_len)
 {
 	const u32 *ret =3D NULL;
-	u32 i, addr;
+	u32 addr;
 	int err;
+	u8 i;
 	u8 addr_width, read_opcode, read_dummy;
 	u8 read_data_mask, data_byte, map_id;
=20
@@ -2874,9 +2877,10 @@ static const u32 *spi_nor_get_map_in_use(struct spi_=
nor *nor, const u32 *smpt)
 	read_opcode =3D nor->read_opcode;
=20
 	map_id =3D 0;
-	i =3D 0;
 	/* Determine if there are any optional Detection Command Descriptors */
-	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+	for (i =3D 0; i < smpt_len; i +=3D 2) {
+		if (smpt[i] & SMPT_DESC_TYPE_MAP)
+			break;
 		read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
 		nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
 		nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i]);
@@ -2892,18 +2896,33 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
_nor *nor, const u32 *smpt)
 		 * Configuration that is currently in use.
 		 */
 		map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
-		i =3D i + 2;
 	}
=20
-	/* Find the matching configuration map */
-	while (SMPT_MAP_ID(smpt[i]) !=3D map_id) {
+	/*
+	 * If command descriptors are provided, they always precede map
+	 * descriptors in the table. There is no need to start the iteration
+	 * over smpt array all over again.
+	 *
+	 * Find the matching configuration map.
+	 */
+	while (i < smpt_len) {
+		if (SMPT_MAP_ID(smpt[i]) =3D=3D map_id) {
+			ret =3D smpt + i;
+			break;
+		}
+
+		/*
+		 * If there are no more configuration map descriptors and no
+		 * configuration ID matched the configuration identifier, the
+		 * sector address map is unknown.
+		 */
 		if (smpt[i] & SMPT_DESC_END)
-			goto out;
+			break;
+
 		/* increment the table index to the next map */
 		i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
 	}
=20
-	ret =3D smpt + i;
 	/* fall through */
 out:
 	nor->addr_width =3D addr_width;
@@ -3025,7 +3044,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 	for (i =3D 0; i < smpt_header->length; i++)
 		smpt[i] =3D le32_to_cpu(smpt[i]);
=20
-	sector_map =3D spi_nor_get_map_in_use(nor, smpt);
+	sector_map =3D spi_nor_get_map_in_use(nor, smpt, smpt_header->length);
 	if (!sector_map) {
 		ret =3D -EINVAL;
 		goto out;
--=20
2.9.4

