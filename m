Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85269C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PTqYLTzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425D620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeKJCiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:19 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22927 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:18 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="20177808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 09:56:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 09:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NzgsXh84Z4sLp4D7cOVNngWNaNVlzL30QoQBQIdt0g=;
 b=PTqYLTzABa2Zjs8PcM8ATwcGaiG2Sa2qkCPC0x/lY2OlW6kZTOObFkCJTQhn/mHNrzO5s3AKmjueMS8AGQSXXLk5ZNHgcDv1YCl5HTdHD4UW1MbNApRJYsf1xZHq7AcfxIKmC7LYF6jQiN4bQKC9N4h1Nqw45eD+t6RH9rHZ12E=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.100.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 16:56:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 16:56:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/5] mtd: spi-nor: fix iteration over smpt array
Thread-Topic: [PATCH v2 2/5] mtd: spi-nor: fix iteration over smpt array
Thread-Index: AQHUeE01oW+J2GHi+UWMkO6cLyG/dQ==
Date:   Fri, 9 Nov 2018 16:56:50 +0000
Message-ID: <20181109165644.30534-3-tudor.ambarus@microchip.com>
References: <20181109165644.30534-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181109165644.30534-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1905;6:QefcSEoXd4VZLTgolRp49I3sGHQitxQJ7WuXeumBgCp1nM/oHDrGOTzNng9p60rgp13NpmmxGZomXgQQm/Og6gnANPatPRIG3IQnPuJtwGfUd7n6M0KzRXn2klvI3K96R+whfljvbDsvnr/3Di8iLeaI1WRSr7mCsknDSWm4Bp+xlJr1aDQ+HWeyJWbATwL4N4ycsKU90kP8g9GG4RNF+pqF9iGOenYpx3NFM2CfIXJOT0dm41TvJ2ac31cNk+IqbOCfdsbYdymMhFAO5RVT+l607TFAEgv4rOtu2lrRorj6VCmKvIK8ORDv3NJRiXc3LF3Y8UEeaVfQyn06rJz7mfqcgynkO/5eoLO1o0Ae4CJuXIMloGqSjIrVRAvE4R4EdeKT/0dq65KqKLOyMh06/FPp5SdU0NzJPkKe01e5nKXX6AxFQEC4z3J1eIbBwTJL1PHISMqepWbd7340NIBoog==;5:OJd5kNvkFk4q8IGJ81ebX/qbAJObxFSQyLB+ZAt+Q9oMDNHMc9HQivjVjLrzYkXDTn9aHa7KADLTGBcDPG4G1VCSuMznPxhrShbRsv3nv+ZTqBxQym2WKs1z+AO/nGUZ31dKe/7fNGAqV1UXXmdjVo0D0Il+AU6dBo4/HKRHBP8=;7:btcaahfbIohqpNhGEsZMiBHgeZeX1qQYDR7x66zQ7RCcvaHOafCFtR+RJfqrSlEGrz9L6Nz6YCA3dBQWe+Tbf0KuPktnqDIUDpWbJtRfGfxOUhLc6r9amktytk/rFJD+/dB6d1WSPJPwONuT9cj1ig==
x-ms-office365-filtering-correlation-id: f553447e-dcd2-4ef0-9e0b-08d6466457df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-microsoft-antispam-prvs: <BN6PR11MB190534AFDEAA669CEA6F77F8F0C60@BN6PR11MB1905.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1905;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6486002)(8936002)(68736007)(3846002)(81156014)(486006)(8676002)(316002)(71190400001)(2616005)(110136005)(6116002)(11346002)(256004)(86362001)(66066001)(2201001)(39060400002)(186003)(446003)(102836004)(54906003)(71200400001)(7736002)(305945005)(14454004)(81166006)(6436002)(5660300001)(2501003)(97736004)(26005)(2906002)(1076002)(476003)(72206003)(76176011)(4326008)(99286004)(6512007)(52116002)(478600001)(386003)(2900100001)(105586002)(25786009)(106356001)(107886003)(6506007)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nFmOaE7GyIdR2Fl/LlocfBACdqx5jpyMu5vR7mCX3sYn9AAhOpHPYk/tIrCAzyMr2CRkTuUGX5UlOR5nFRzA7J6Bf1D5UzDdGkwJ7V7HkBrtT7QkcMGjfHpNwJq74MbAmwGpaP8IiA2ltjdLOur4KJpSRJFS4Bei0iT0NSJzCV5IB12Fw1zy9/4B+tIPop9/lGrD8LUa/hHpMfdklYmco3bB8ngVd+afl0hRpvkgvWpDDvn/gP8nnA+uSxJmJq2wO/AyRVMUx+MKWRAGfkPtHmBE3d6EDzSuvqKRw1u5GlR5WoZ3S4/U+ov+2PCb/nfnnicDUm52/9Qsbt2D734Sar6DxK5k9KKErQZ+VoGTpsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f553447e-dcd2-4ef0-9e0b-08d6466457df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 16:56:50.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate over smpt array using its starting address and length
instead of the blind iterations that used data found in the array.

This prevents possible memory accesses outside of the smpt array
boundaries in case software, or manufacturers, misrepresent smpt
array fields.

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: add Fixes tag, add a blank line

 drivers/mtd/spi-nor/spi-nor.c | 40 ++++++++++++++++++++++++++++++---------=
-
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2cdf96013689..98e433e8e4c2 100644
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
@@ -2874,9 +2877,11 @@ static const u32 *spi_nor_get_map_in_use(struct spi_=
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
+
 		read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
 		nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
 		nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i]);
@@ -2892,18 +2897,33 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
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
@@ -3025,7 +3045,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
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

