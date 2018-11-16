Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6812086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PiDjK/uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6812086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbeKQEAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:00:01 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:2125 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeKQEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:00:01 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="20494488"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 16 Nov 2018 10:46:40 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 16 Nov 2018 10:46:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDdf6FsSACAFz583uUlvBW8Mvsdu+G2j/j0ckYB3KWc=;
 b=PiDjK/uXnjAikpABor/clcvdCpXwzHZczvvTY0x6OML80KFlER2yOmcchDLvg5P/ZQn9xRBkHbaRlwKuo1g2LsY8kqh00eA9jPzkcLoJzlkrRDBw/qkK0a4tq6ztm9l9d5tN8nZuPXlmBG/V3MJ9qhx765VZfSi37lQvCzm92bY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB0068.namprd11.prod.outlook.com (10.161.155.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Fri, 16 Nov 2018 17:46:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:46:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2] mtd: spi-nor: fix selection of uniform erase type in
 flexible conf
Thread-Topic: [PATCH v2] mtd: spi-nor: fix selection of uniform erase type in
 flexible conf
Thread-Index: AQHUfdRSAITPs2Qs+0mODdYecOJPCA==
Date:   Fri, 16 Nov 2018 17:46:37 +0000
Message-ID: <20181116174624.10817-1-tudor.ambarus@microchip.com>
References: <3c2c7a76-c7da-5c6e-0bb3-8963132f79d4@microchip.com>
In-Reply-To: <3c2c7a76-c7da-5c6e-0bb3-8963132f79d4@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0068;6:SGE0Brq4hUhDGOy8Sep/7kPehcc8lLNGDrvg/F58QrVQ0+T3V08OvUY/FqvWQpJM0wmlYpQTMSkVyvdX5eMmtDD4+NJ7E6eQZ9pgXJQmWLBIlWx2WZs7fRmQBq8jas4Btj8y7Wf/CPOiXSygWT1MO4rX15OjwRvI4MKFeSN+OO9jwcBXKaY84WeObpBxuIilCmEPncv3vjRyAbmOxCmGjiWECJ9LmPMufA7y35ZG3hnDpyuW2gBm1h2t7F2T3ZNfeQJrUqsnuiuwWoQBbufxM1KQ60pit+ZgH60kH/0FdilUNKPPtD1keJ9C+Khjlv3GdNskbHOPr9OKEa6mDV5FcPJTl4DqOOvnS10ZhvwM5YSLvWHNrv0skB/xa6yJ/kzcZG0ZlDlZ6UiRvlyjUnCeBimvbmZxKXILrRWnMngVL37GARV+NNF4RsxSD/fcJZQDKT9oGk+EboDZRAGLndseGg==;5:CLhi+aR/AkHG10vwczE8KpA5YJZCdzRq6KK1ya5+s1xZR83v0Ap3Mr00K5HJNl/oDqW9xRUB29nJdOCQqoa1aNPn+Rifh7wvRGeQh0ZV0ygIN6QUB1zTTaS0w5vcSy3lZIoTtjwF7zf8F2P3vGhqaowpGoS9D1Yfab91b6r/dnQ=;7:ZQgfqYPO83thQFF1o9g70qJuz0rs5Zy2rxw7io21fMTDyMEFCLjJBPYsA4fw3T+moIwXHxuk1Qwg77YBQuBZTzpFxiKZK5UOgxQOkiHIndweTaN8840RZ/IdGArHTcnMbomHt5dVg1huDnkpTyM/Rg==
x-ms-office365-filtering-correlation-id: 94912738-1911-4a01-385f-08d64beb752d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0068;
x-ms-traffictypediagnostic: BN6PR11MB0068:
x-microsoft-antispam-prvs: <BN6PR11MB0068BE66D1EB91FE7602133FF0DD0@BN6PR11MB0068.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB0068;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB0068;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(14454004)(68736007)(52116002)(81156014)(105586002)(99286004)(25786009)(8676002)(5660300001)(2501003)(6506007)(107886003)(53936002)(97736004)(66066001)(39060400002)(106356001)(6116002)(3846002)(6512007)(386003)(72206003)(446003)(1076002)(478600001)(6436002)(486006)(7736002)(102836004)(86362001)(76176011)(11346002)(2616005)(4326008)(26005)(476003)(8936002)(71200400001)(316002)(186003)(2906002)(71190400001)(6486002)(2900100001)(2201001)(36756003)(110136005)(14444005)(256004)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0068;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ngzHeBcHK5OBSvuuDfKNvGGr0ZGS2OeBifi3w4ET8C5DdSNFenem7G/HTRdAZ9pKCIlL3lcGBBun5rmte38LB5mg3Nobhxd5YQqh3CfvTbfRvajKbkPOS9gNECu7OmDtzJTPYepFG3QFyKs9fEcFozM/yXN4Igzxo1dR60pD0eukBahjXh/l8fQOCWY/QBXqw+HyTQQwLYM/2ZrPXdPGz+RuXp/mDlZjok9WCzNIGLPd0qjmowRGeZp3OeXyZwM18s7jmYW/VNsCK8xFKZTt1vCNJazTV7XsYhnRnUPpXMKhi+3Y28jzxSa2O/nqY0jF8GjrZqAfEuGX2WkMN1EnwKtFRAUfnDq9u/yghJckScI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94912738-1911-4a01-385f-08d64beb752d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:46:37.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0068
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are uniform, non-uniform and flexible erase flash configurations.

The non-uniform erase types, are the erase types that can _not_ erase
the entire flash by their own.

As the code was, in case flashes had flexible erase capabilities
(support both uniform and non-uniform erase types in the same flash
configuration) and supported multiple uniform erase type sizes, the
code did not sort the uniform erase types, and could select a wrong
erase type size.

Sort the uniform erase mask in case of flexible erase flash
configurations, in order to select the best uniform erase type size.

Uniform, non-uniform, and flexible configurations with just a valid
uniform erase type, are not affected by this change.

Uniform erase tested on mx25l3273fm2i-08g and sst26vf064B-104i/sn.
Non uniform erase tested on sst26vf064B-104i/sn.

Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR=
 flash memories")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: drop uneeded change

 drivers/mtd/spi-nor/spi-nor.c | 47 +++++++++++++++++++++++++++++++++------=
----
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 69784b3b8ca1..4c7e4dc25006 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2529,6 +2529,34 @@ static int spi_nor_map_cmp_erase_type(const void *l,=
 const void *r)
 }
=20
 /**
+ * spi_nor_sort_erase_mask() - sort erase mask
+ * @map:	the erase map of the SPI NOR
+ * @erase_mask:	the erase type mask to be sorted
+ *
+ * Replicate the sort done for the map's erase types in BFPT: sort the era=
se
+ * mask in ascending order with the smallest erase type size starting from
+ * BIT(0) in the sorted erase mask.
+ *
+ * Return: sorted erase mask.
+ */
+static u8 spi_nor_sort_erase_mask(struct spi_nor_erase_map *map, u8 erase_=
mask)
+{
+	struct spi_nor_erase_type *erase_type =3D map->erase_type;
+	int i;
+	u8 sorted_erase_mask =3D 0;
+
+	if (!erase_mask)
+		return 0;
+
+	/* Replicate the sort done for the map's erase types. */
+	for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++)
+		if (erase_type[i].size && erase_mask & BIT(erase_type[i].idx))
+			sorted_erase_mask |=3D BIT(i);
+
+	return sorted_erase_mask;
+}
+
+/**
  * spi_nor_regions_sort_erase_types() - sort erase types in each region
  * @map:	the erase map of the SPI NOR
  *
@@ -2543,19 +2571,13 @@ static int spi_nor_map_cmp_erase_type(const void *l=
, const void *r)
 static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map=
)
 {
 	struct spi_nor_erase_region *region =3D map->regions;
-	struct spi_nor_erase_type *erase_type =3D map->erase_type;
-	int i;
 	u8 region_erase_mask, sorted_erase_mask;
=20
 	while (region) {
 		region_erase_mask =3D region->offset & SNOR_ERASE_TYPE_MASK;
=20
-		/* Replicate the sort done for the map's erase types. */
-		sorted_erase_mask =3D 0;
-		for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++)
-			if (erase_type[i].size &&
-			    region_erase_mask & BIT(erase_type[i].idx))
-				sorted_erase_mask |=3D BIT(i);
+		sorted_erase_mask =3D spi_nor_sort_erase_mask(map,
+							    region_erase_mask);
=20
 		/* Overwrite erase mask. */
 		region->offset =3D (region->offset & ~SNOR_ERASE_TYPE_MASK) |
@@ -2985,7 +3007,7 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
 	u64 offset;
 	u32 region_count;
 	int i, j;
-	u8 erase_type;
+	u8 erase_type, uniform_erase_type;
=20
 	region_count =3D SMPT_MAP_REGION_COUNT(*smpt);
 	/*
@@ -2998,7 +3020,7 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
 		return -ENOMEM;
 	map->regions =3D region;
=20
-	map->uniform_erase_type =3D 0xff;
+	uniform_erase_type =3D 0xff;
 	offset =3D 0;
 	/* Populate regions. */
 	for (i =3D 0; i < region_count; i++) {
@@ -3013,12 +3035,15 @@ static int spi_nor_init_non_uniform_erase_map(struc=
t spi_nor *nor,
 		 * Save the erase types that are supported in all regions and
 		 * can erase the entire flash memory.
 		 */
-		map->uniform_erase_type &=3D erase_type;
+		uniform_erase_type &=3D erase_type;
=20
 		offset =3D (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
 			 region[i].size;
 	}
=20
+	map->uniform_erase_type =3D spi_nor_sort_erase_mask(map,
+							  uniform_erase_type);
+
 	spi_nor_region_mark_end(&region[i - 1]);
=20
 	return 0;
--=20
2.9.4

