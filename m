Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25569C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFBB2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SzM2tkhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFBB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeKHUmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:47 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14785 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:47 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="20108338"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:43 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ7nDPZ+Omadyij19/H325cslcGmFce/HtANZfMPIrA=;
 b=SzM2tkhDLuF77ZYDUe29mwqHxdlU5y/92OeARhVMkIe+CamsLwJVAdwzFESxSVcJ1NfYjCaQMRosAJ2e9CjAedzsbuDVnbZaLi+3RCjcqyhb1RCdZ5LNEQNYzq83eSUmYRv4lqw8+NHHnKNYujOnoIHSOtcmbI1q/5uGqwKud2c=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:07:16 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 5/7] mtd: spi_nor: pass DMA-able buffer to spi_nor_read_raw()
Thread-Topic: [PATCH 5/7] mtd: spi_nor: pass DMA-able buffer to
 spi_nor_read_raw()
Thread-Index: AQHUd1M1O+vx4j6wFUm81PYNE1DiXA==
Date:   Thu, 8 Nov 2018 11:07:16 +0000
Message-ID: <20181108110653.21063-6-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:+8T89Cq2RZT4Qx0fbCdD6s+cI/qg6qYUPbljEn3Q5lCNMw9k/93uIrCNbbo7K9+paCmIb9YnVXhY2qhyqLlHkCuslBJGPFl85IpcP366Jt85L/YF49ij4b62xNbOTgqOtreld6P4+ghosDbQxYzGxXV2a0JMbY7jza5+2+06zHZkepd9rf9LZkZ8KnIhG6xwcCfzG4kaOpJSP5wFj5y0+nJ1PfD0cnPiudXv16ezIQDOw4yYs8cUl05iQgmnDJxSogyE8n8DXhrpyqRK/dLBQqPvATE8EodqAmJg9Bonn6vgtaIhu8r26U1TDx6vm8ZlZl4IsruS+gSbqa/C74vknRIWVNkAlnheiIvqYLloGYlVqi2NAALg8ILK7RRQJKb45C/VopYZ0bb/ehOvNmZqqqNUM2zXrPChf8q+UuehzyOIxiLq6cFnrPBVrZkcMX4NCcEVc6/9fZZrrHSuT3ci4g==;5:4I6xmrG6MjmS0juLwTAdxJRZAEfAIvE6Kj94rA8Ti3O8wgiYknTCX5kQYwkXfEwBqZekYJPhoOFCkjAPnLrEyOYv4pBbQHOgYKm7c0H93IyTdlNc4Hp2WJwEdVDVAKv3JDdbDIVnQpRyIp/R0hC/kBNVIZJKaF4pp7QmUg65sYw=;7:sQnBb7vYxdHtKIbZbCldpXgS2Fn4qB9fLYutAlGlo/m+85N8ZpuPk9/AEHC9TFeYNeZoezKZXSnLTyNzp6QwVONBkDeYxE5PJqeYN1Ng56hezwERy9YhOKmGVEkWRUTap2KeEon0O4VPWMHqbbN7Rg==
x-ms-office365-filtering-correlation-id: 5e783b3a-a07f-4c8a-a942-08d6456a579c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB1987D12FFBD2DD58895AE565F0C50@BN6PR11MB1987.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1987;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1987;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(72206003)(8676002)(81166006)(5660300001)(81156014)(102836004)(14454004)(68736007)(305945005)(26005)(86362001)(1076002)(2201001)(39060400002)(7736002)(8936002)(2906002)(2900100001)(36756003)(3846002)(6116002)(71200400001)(71190400001)(107886003)(97736004)(6436002)(6486002)(110136005)(54906003)(2501003)(2616005)(11346002)(446003)(99286004)(53936002)(6512007)(256004)(4326008)(478600001)(66066001)(52116002)(386003)(6506007)(186003)(25786009)(316002)(105586002)(76176011)(476003)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 00i9aG1MzLzRXlsF71w2+hvA+VFEzEkUwoc9SdG8n0m0TrTRdyv3E1ruagLAHzY3cXQyW7gJFWELHnuFM1rdV8OsXPoPHHrj/IoDw9P1dHwt7wTUklxPHYhb8pfBVZbk86BEkGEsB17jTUpwUXEIm0ttUYjGqSRbUiW2FHDb7Zf5IJrvzG2ggl4qVWCcRSgrCWHfeEiiSasvzyDaSRygS58fZEyumqbrMSP9fwSMNPAnldSteN7tFVRq3C2SPFmb6c2otKeha8mLK5VlR25/0JbKTzfRvaSXHL7oLjlTUgPe0YhqfqSwS7YyuUxi+wtewGLPeiE0qiFxaTruLHlqSb3FoqtNXJrKPbl37XDUNAs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e783b3a-a07f-4c8a-a942-08d6456a579c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:16.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_nor_read_raw() calls nor->read() which might be implemented
by the m25p80 driver. m25p80 uses the spi-mem layer which requires
DMA-able in/out buffers. Pass kmalloc'ed dma buffer to spi_nor_read_raw().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 79ca1102faed..2eaa21c85483 100644
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
@@ -2868,11 +2868,16 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
_nor *nor, const u32 *smpt,
 					 u8 smpt_len)
 {
 	const u32 *ret;
+	u8 *dma_safe;
 	u32 addr;
 	int err;
 	u8 i, ncmds, nmaps;
 	u8 addr_width, read_opcode, read_dummy;
-	u8 read_data_mask, data_byte, map_id;
+	u8 read_data_mask, map_id;
+
+	dma_safe =3D kmalloc(sizeof(*dma_safe), GFP_KERNEL | GFP_DMA);
+	if (!dma_safe)
+		return ERR_PTR(-ENOMEM);
=20
 	addr_width =3D nor->addr_width;
 	read_dummy =3D nor->read_dummy;
@@ -2890,7 +2895,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 		nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
 		addr =3D smpt[i + 1];
=20
-		err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
+		err =3D spi_nor_read_raw(nor, addr, 1, dma_safe);
 		if (err) {
 			ret =3D ERR_PTR(err);
 			goto out;
@@ -2900,7 +2905,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 		 * Build an index value that is used to select the Sector Map
 		 * Configuration that is currently in use.
 		 */
-		map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
+		map_id =3D map_id << 1 | !!(*dma_safe & read_data_mask);
 		ncmds++;
 	}
=20
@@ -2941,6 +2946,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
=20
 	/* fall through */
 out:
+	kfree(dma_safe);
 	nor->addr_width =3D addr_width;
 	nor->read_dummy =3D read_dummy;
 	nor->read_opcode =3D read_opcode;
--=20
2.9.4

