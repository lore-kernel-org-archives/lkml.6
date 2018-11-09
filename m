Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A709C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E981C20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="F0Y+1u07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E981C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeKJCiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:24 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24601 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbeKJCiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:22 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="23878245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 09:56:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 09:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NXmHcYVKDO5wCbw46GgBXtyHrLrEe8DqX7Dq2bRGHI=;
 b=F0Y+1u07wJm1ljDVYRqnpZxTRFUBz9obv3Fyw8AZkTqyscmbl0pJF+qhxMPjegYfb+E6X17mmcjS0GN21VYQ/4S6g533T48f8ASZ00VYxrBSYglu72+eC4SUikRE7Ongy7x1GAUSm/yuXr0M3p9ij/My8nrbBTsnCHFo6s4at9Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.100.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 16:56:54 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 16:56:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 4/5] mtd: spi_nor: pass DMA-able buffer to
 spi_nor_read_raw()
Thread-Topic: [PATCH v2 4/5] mtd: spi_nor: pass DMA-able buffer to
 spi_nor_read_raw()
Thread-Index: AQHUeE03GtkA6RMtvU+Otx7Vo91x2Q==
Date:   Fri, 9 Nov 2018 16:56:54 +0000
Message-ID: <20181109165644.30534-5-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1905;6:uC24TRdsEbrBoJXOB7zoyMG1AhFltI0Z/aPM4JSUdxqf7vdSanY/Jue0SEEeszQnpugy48sjnWOutGp7EnFG30Esn1UGUylCgvzSzbgmS9088TdEsikKRfF0MDQH1BO+Y050vbM6kf5OeFBQ+xW8UZWCQ3DKKuZ2Z2GqKJPnD4txqRc4NlRMSphqBTZzPeT5qWoWqCvCnm8/z1cbDNftFLlpQjuQG2llwg7rMRuOmrV4Udl3afJhxbv0pulYodZVCRByu89w7fjdJKmty3pp7DciSLrre0vgz+5PIriPad6XlULEPZqOd5TxDaYNuUXaGo46Scp+BxRig0vvyy7f4n7+84O9CJvwuasqsj09/+VLNaTkkYZdPg4kORtexUcDBoNnGLC08JWVDb2//cWuKSYxKeMWcQX/rPjj7uyZlKBJwgjI81DzBbybcTgkPUM1VJ15NPlxRXMspSI7wwUAvQ==;5:SyS18VTMr4U1xFvK+9+AOJ9O6rVbbFNCzKBvCkZhMHB+b9D279kDwXZHyJbbatoUKNv+5aVThFHX7+b+PfomvZyJEY2WDsCnsQ8QFXKhB84sIsbGtTci/7ZVWgARF5uxQUuhTw3KqutHEZKOVZ0Yo3YWYYuOyIxPZ9dXkmNajMI=;7:0FtDMA06mVkaHy98Db+aIhmzHOHrUXtnp/SQ9g5CIjVVv8JwgnYWEwJiM6REowl4aHxPw+53k5SNocPqK4sOehHt8pESlX+s/2orQwBvB5vq4Q8lTxl3V71Qe73+XfUYNi6M/LJ35xXDGYAoUoNfaA==
x-ms-office365-filtering-correlation-id: db8a8a42-501c-48a7-5e71-08d646645a33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-microsoft-antispam-prvs: <BN6PR11MB1905C8CCE2F32BDE6C751F06F0C60@BN6PR11MB1905.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1905;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6486002)(8936002)(68736007)(3846002)(81156014)(486006)(8676002)(316002)(71190400001)(2616005)(110136005)(6116002)(11346002)(256004)(86362001)(66066001)(2201001)(39060400002)(186003)(446003)(102836004)(54906003)(71200400001)(7736002)(305945005)(14454004)(81166006)(6436002)(5660300001)(2501003)(97736004)(26005)(2906002)(1076002)(476003)(72206003)(76176011)(4326008)(99286004)(6512007)(52116002)(478600001)(386003)(2900100001)(105586002)(25786009)(106356001)(107886003)(6506007)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xKqVy2bR7Ont9kY7KB9ejcM5a5ySpHqVrFTTG8G5/yThkp9UuxxsWun9a0Jecf04Df6VC162X0h0hm740VJaIKIP9cCe9pj95u0tsLDcVhKBRpkvJsdUpkPIkhmUQQ/QQ0TXIoiIK/fyc7itbVxmbUL1LdSIDqWD9mAj9eKqGcuU9/9vp/y0pI1jBOqGJguKjFn/vYs1rD4NRpREy0Rytdb2fAc5dzOqZAem6n7yF5pXzgjKMHG3NUk0DTue7x2RFR52C741AGKLkincn+OU2FCHIcYVzV73XS2CfnvwM6y/2pBa4HOVkb7glEwsKG3HwE1W90WytXEdNYdsxbOSqXl1olDDm01Bfr6J5J+lHr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db8a8a42-501c-48a7-5e71-08d646645a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 16:56:54.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_nor_read_raw() calls nor->read() which might be implemented
by the m25p80 driver. m25p80 uses the spi-mem layer which requires
DMA-able in/out buffers. Pass kmalloc'ed dma buffer to spi_nor_read_raw().

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: drop GFP_DMA, rename buf, add comment

 drivers/mtd/spi-nor/spi-nor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 04a1c5b825e6..458ca8321999 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2161,7 +2161,7 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp=
,
  * @nor:	pointer to a 'struct spi_nor'
  * @addr:	offset in the serial flash memory
  * @len:	number of bytes to read
- * @buf:	buffer where the data is copied into
+ * @buf:	buffer where the data is copied into (dma-safe memory)
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -2868,11 +2868,17 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
_nor *nor, const u32 *smpt,
 					 u8 smpt_len)
 {
 	const u32 *ret;
+	u8 *buf;
 	u32 addr;
 	int err;
 	u8 i;
 	u8 addr_width, read_opcode, read_dummy;
-	u8 read_data_mask, data_byte, map_id;
+	u8 read_data_mask, map_id;
+
+	/* Use a kmalloc'ed bounce buffer to guarantee it is DMA-able. */
+	buf =3D kmalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
=20
 	addr_width =3D nor->addr_width;
 	read_dummy =3D nor->read_dummy;
@@ -2890,7 +2896,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 		nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
 		addr =3D smpt[i + 1];
=20
-		err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
+		err =3D spi_nor_read_raw(nor, addr, 1, buf);
 		if (err) {
 			ret =3D ERR_PTR(err);
 			goto out;
@@ -2900,7 +2906,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 		 * Build an index value that is used to select the Sector Map
 		 * Configuration that is currently in use.
 		 */
-		map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
+		map_id =3D map_id << 1 | !!(*buf & read_data_mask);
 	}
=20
 	/*
@@ -2931,6 +2937,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
=20
 	/* fall through */
 out:
+	kfree(buf);
 	nor->addr_width =3D addr_width;
 	nor->read_dummy =3D read_dummy;
 	nor->read_opcode =3D read_opcode;
--=20
2.9.4

