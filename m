Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A167C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B2120855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MBp7HorC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B2120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeKZXjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:39:51 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:61958 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeKZXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:39:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="23515086"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Nov 2018 05:45:48 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 26 Nov 2018 05:45:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWIsapqZYNtyorKuZMwOfYDMLjrvi9tynWSCjhwMp2M=;
 b=MBp7HorCD5RVYDEHPSAC3oiBrt5jdP9la2R9740eJoZ/mc6aukGzOkjmUrBhN3W93XY/JIwNchIhAz1xHHfuf/hcndD3Gg4jH0hKuO87CF88NUWtgDNGUQfykRI0oLgdNvRFjDLrYETqKmnRaH5fcJJFARCgKq02XtO8oypSzbk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB0001.namprd11.prod.outlook.com (10.161.155.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 12:45:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 12:45:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <alexander.sverdlin@nokia.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2] mtd: spi-nor: fix erase_type array to indicate current map
 conf
Thread-Topic: [PATCH v2] mtd: spi-nor: fix erase_type array to indicate
 current map conf
Thread-Index: AQHUhYXyqNwBRhXCWUmPjriIVe6LZw==
Date:   Mon, 26 Nov 2018 12:45:44 +0000
Message-ID: <20181126124531.17548-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::27) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0001;6:RR/Us99dzlNxcVwlPab2sEwpt7S+nKh3sEfrCsNxDeNMQOQb+O1AnSYdk/LUcwrpEzZ0YpodP37TkacGe4tx1hH+PPKZVACDxiIGKaQ5eX1N9OY2F8illPA0yAsOq8WwnVIrjpO9uRcohldox8VsdBeYRW4gMiWDyhyVyi5Ldd8C6wbStGf3dN2x6e53WxBuea0/ByYi575Y4PtB3IFqSgfZhMdmfxMAx8Os90KFjABpcg4J6OfYmsBnMJH4a0S7l3Filrspj9LsSocbhywiNBN0tDkw7O+ke+Dg6h9T2f1tJhCT/KhAIfGo+H7nYuVef34sO7aBuL2GgS0fAWzvqGyGC5t/FCO/oC7FndXHyNPEcpLrDUByBSXSZcS1jVpLERsIAcFVckyoowT/VSoW/jbHhUnfI1ORNH9JuhCkb7CPCDi+Y3RhWRRIeqg7raigB1ZrgsWQBSgOg+dm5V+TIA==;5:8PkEDFzXjxUyUcgBrgS7cH/DsYD048+OK4oGJMdzm7rGJM2IquG7BBF4WjfE+fCeHwc82u6AjuKnmvn5adnPud3toRMWsjdSe5uj3kdkjV3jYJajBlWignnRPS7LF6PyTzsTiUEKBvllwVd2DqSlWIoSX2+U3+/WytXPvLMEqdY=;7:o8hYhjA+uEAUL1njWekJcEI/MV8/p/SmpXAft9MTzIjFW13VhWF2u74XtPIzs1pLVij3nMsqWP1LeRA6Ggiy86Fbw/DSFbomaiYKtzMxVupgGVOScEBywuJvi/5IcZPRf2Do3/Cbq9eVnDJXQxqA3Q==
x-ms-office365-filtering-correlation-id: 3ef46e8b-0d88-4433-100f-08d6539d14b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0001;
x-ms-traffictypediagnostic: BN6PR11MB0001:
x-microsoft-antispam-prvs: <BN6PR11MB0001F4D9624B246F55C67993F0D70@BN6PR11MB0001.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB0001;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB0001;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(72206003)(4326008)(39060400002)(66066001)(36756003)(52116002)(8936002)(54906003)(305945005)(110136005)(7736002)(68736007)(478600001)(316002)(71200400001)(71190400001)(6512007)(99286004)(6486002)(86362001)(6506007)(386003)(2201001)(14454004)(107886003)(53936002)(105586002)(2616005)(106356001)(6436002)(1076002)(102836004)(5660300001)(6116002)(3846002)(186003)(8676002)(256004)(26005)(14444005)(25786009)(486006)(2906002)(97736004)(2501003)(81166006)(476003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0001;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 84mDEOleznwk9rUDQl3Wt5cTOxQX9CpKyCBEFJBtAu1VZPll+vDMLBgTQolJeZ75jdFiS7sxULl8j1JCX6fx0lvS+mkWp96jxX28CsP5aqaHqMvGOzPAaLJw13ROrRQQbGw1bF4+Z+A2OFm40uVBGpwgmWhuplyO+0TR8sedEdCi6TFWm0xumbPb4J/eN7I881HbsSFjd1FCEdPDDzjTgGsn1hfcM/hrlcBzJzeaz7u5sdp1tJ2c0m3fzPwHqTUv8gDRPMNidRncDvAMFb+3SHkzyiM/IQxf1UE46S9nimc7yj8u2ccIyzUx454zFw6DAWSs9OucCMYuHB6KOwgtt0SWfBTxnoJACZiw29JnR4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef46e8b-0d88-4433-100f-08d6539d14b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 12:45:44.8121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0001
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

BFPT advertises all the erase types supported by all the possible
map configurations. Mask out the erase types that are not supported
by the current map configuration.

Backward compatibility test done on sst26vf064b.

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Reported-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2:
- drop const qualifier
- update commit message and comment

 drivers/mtd/spi-nor/spi-nor.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 93c9bc8931fc..1fdd2834fbcb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2995,12 +2995,13 @@ static int spi_nor_init_non_uniform_erase_map(struc=
t spi_nor *nor,
 					      const u32 *smpt)
 {
 	struct spi_nor_erase_map *map =3D &nor->erase_map;
-	const struct spi_nor_erase_type *erase =3D map->erase_type;
+	struct spi_nor_erase_type *erase =3D map->erase_type;
 	struct spi_nor_erase_region *region;
 	u64 offset;
 	u32 region_count;
 	int i, j;
-	u8 erase_type, uniform_erase_type;
+	u8 uniform_erase_type, save_uniform_erase_type;
+	u8 erase_type, regions_erase_type;
=20
 	region_count =3D SMPT_MAP_REGION_COUNT(*smpt);
 	/*
@@ -3014,6 +3015,7 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
 	map->regions =3D region;
=20
 	uniform_erase_type =3D 0xff;
+	regions_erase_type =3D 0;
 	offset =3D 0;
 	/* Populate regions. */
 	for (i =3D 0; i < region_count; i++) {
@@ -3030,13 +3032,38 @@ static int spi_nor_init_non_uniform_erase_map(struc=
t spi_nor *nor,
 		 */
 		uniform_erase_type &=3D erase_type;
=20
+		/*
+		 * regions_erase_type mask will indicate all the erase types
+		 * supported in this configuration map.
+		 */
+		regions_erase_type |=3D erase_type;
+
 		offset =3D (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
 			 region[i].size;
 	}
=20
+	save_uniform_erase_type =3D map->uniform_erase_type;
 	map->uniform_erase_type =3D spi_nor_sort_erase_mask(map,
 							  uniform_erase_type);
=20
+	if (!regions_erase_type) {
+		/*
+		 * Roll back to the previous uniform_erase_type mask, SMPT is
+		 * broken.
+		 */
+		map->uniform_erase_type =3D save_uniform_erase_type;
+		return -EINVAL;
+	}
+
+	/*
+	 * BFPT advertises all the erase types supported by all the possible
+	 * map configurations. Mask out the erase types that are not supported
+	 * by the current map configuration.
+	 */
+	for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++)
+		if (!(regions_erase_type & BIT(erase[i].idx)))
+			spi_nor_set_erase_type(&erase[i], 0, 0xFF);
+
 	spi_nor_region_mark_end(&region[i - 1]);
=20
 	return 0;
--=20
2.9.4

