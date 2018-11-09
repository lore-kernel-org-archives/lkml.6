Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="A64ltiKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeKJCiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:22 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14074 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:20 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="22919204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 09:56:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 09:56:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6EmGTdbrpdj+i6Ca2VSU13l1EOW4CkdQFsrEhBiqws=;
 b=A64ltiKBlv9xg46P391o2X0ZROjhClqICQo6yQ9bVa1IfZU5u8R4ezSfF7np+sA/BmgUE0k2x8RREuH51FFbB99otnsICjvDp3ONh++v6jE/cJ5QYb8QYHjT2qzOoynShn6kkF69t2kdXhjpXZpc+bRUXJaHlNkc/1nbQ6ZfC2w=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.100.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 16:56:52 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 16:56:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 3/5] mtd: spi-nor: don't overwrite errno in
 spi_nor_get_map_in_use()
Thread-Topic: [PATCH v2 3/5] mtd: spi-nor: don't overwrite errno in
 spi_nor_get_map_in_use()
Thread-Index: AQHUeE02e2YB+znz1EKqJk1a+8CjMQ==
Date:   Fri, 9 Nov 2018 16:56:52 +0000
Message-ID: <20181109165644.30534-4-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1905;6:kEoIXflPSb4oIfwtXR5Uc12tPa4cJv/aL4bsn9o0/yLRSmq5ipy45hMQ0O0FsHx8KeA/6ZRApbmUd1L8oM4xboZfno//JscpN+gYCkmypRDBhR1TjRRAONX8NG/neZE82AR5wpBQrm93vtK5kfYrG4y9OKPG6bJf7tVDex1EOr58L7pQqpdjXZTLsfBZ46NHwnaKDpr9hnT7b9fFL88BbS1u/c6/cKvDoGT0W7Jev0cQwrpxVYpKmLU/uPvbqbzZR3XNJ871mscy8JKAgwcL4RgXlKMM7KC2Od5Xdbv2xeIASxzwkB1yOe6mnEv6QMYHCoFOUv2z+NPaUu2JaHgj0zeAHyPPv7vFY1hmgc0cuG3GaHL0K6/kNAcAwpH08+QmC0dAV/rvfA6ZWmHGMCbqjrRamEsEt2M25xl3VG9FH0Uw/RU0MR/iOtWcn7YSUrsy78yaHhpSTflrxaAaGAR8ig==;5:wEmSlkaVu+klZpwGHjOCe/VOcc7crdrQFAuN5vzli6gU3SZ25EnWw9LxmPn1bCufWGVtzaL4j3SABjHCQ0qXRY14Zeo+N97oHtcwnaveHeWryK3pTEx8uPKSSu4u4uqpjRuyl8Zar7B5dflMnQe03sAHE/c1yIcSBJGE1Ileum4=;7:4pKBE8wlWNI06SK7fH/FD4ndtTrnNnaKg3dN5T9n0GoHe0aeJCc89K7bKmqS3s3oK8ha3UixYLtENusk1ht24fkvDS6LKF4LZaipP9gxyaGx90jGHEwMaP+e7AQaPOots05bZF1xcL1u0YJ5x1k5Bg==
x-ms-office365-filtering-correlation-id: 06fa576e-b77b-4788-5bae-08d646645911
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-microsoft-antispam-prvs: <BN6PR11MB1905A05CCFCF8CE2C25C61C1F0C60@BN6PR11MB1905.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1905;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6486002)(8936002)(68736007)(3846002)(81156014)(486006)(8676002)(316002)(71190400001)(2616005)(110136005)(6116002)(11346002)(256004)(86362001)(66066001)(2201001)(39060400002)(186003)(446003)(102836004)(54906003)(71200400001)(7736002)(305945005)(14454004)(81166006)(6436002)(5660300001)(2501003)(97736004)(26005)(2906002)(1076002)(476003)(72206003)(76176011)(4326008)(99286004)(6512007)(52116002)(478600001)(386003)(2900100001)(105586002)(25786009)(106356001)(107886003)(6506007)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UT4uDqVQd+sGbruxUCdGliZzM02kvLKdIgt+Idsbt17tKoMjmFXfd3fZ3y+dTpb2x/SeGz9/7a0sSwET5o5tFUZtj0lhRQyLKnjgVAUr7wPsT4qD8Ev0spkLsNzWrOigWUgEnSK9xTZMOIuTBpR2d2n7ilv7DSkjyEfYB9jlseNj0TteU72Qp9fwgLjVgONzqMdn4Q41NPoyi17u2e+D6HCVpiwsXOulRl+vCLcmGrb3962noDLf9YYGj7yWmUrPftSg6zStUxjfuyyUXzFgs+clx4Itabpr3I8ga7YVKmjAU+JdEFMpLtk5vXK0nSF4RnlkO95Z2VcIwmNQz/3Fk4f4EukltVN6rbNbTkH1T14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa576e-b77b-4788-5bae-08d646645911
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 16:56:52.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't overwrite the errno from spi_nor_read_raw().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 98e433e8e4c2..04a1c5b825e6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2861,11 +2861,13 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
nor *nor, const u32 settings)
  * @nor:	pointer to a 'struct spi_nor'
  * @smpt:	pointer to the sector map parameter table
  * @smpt_len:	sector map parameter table length
+ *
+ * Return: pointer to the map in use, ERR_PTR(-errno) otherwise.
  */
 static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt,
 					 u8 smpt_len)
 {
-	const u32 *ret =3D NULL;
+	const u32 *ret;
 	u32 addr;
 	int err;
 	u8 i;
@@ -2889,8 +2891,10 @@ static const u32 *spi_nor_get_map_in_use(struct spi_=
nor *nor, const u32 *smpt,
 		addr =3D smpt[i + 1];
=20
 		err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
-		if (err)
+		if (err) {
+			ret =3D ERR_PTR(err);
 			goto out;
+		}
=20
 		/*
 		 * Build an index value that is used to select the Sector Map
@@ -2906,6 +2910,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 	 *
 	 * Find the matching configuration map.
 	 */
+	ret =3D ERR_PTR(-EINVAL);
 	while (i < smpt_len) {
 		if (SMPT_MAP_ID(smpt[i]) =3D=3D map_id) {
 			ret =3D smpt + i;
@@ -3046,8 +3051,8 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 		smpt[i] =3D le32_to_cpu(smpt[i]);
=20
 	sector_map =3D spi_nor_get_map_in_use(nor, smpt, smpt_header->length);
-	if (!sector_map) {
-		ret =3D -EINVAL;
+	if (IS_ERR(sector_map)) {
+		ret =3D PTR_ERR(sector_map);
 		goto out;
 	}
=20
--=20
2.9.4

