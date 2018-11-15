Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A17C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50142145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="dsmBFT/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbeKPIAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:00:42 -0500
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:60384
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729203AbeKPIAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6envCZ6S3An5zl7MzPeoS3XEBq7ErSJTtxfRx6cwa4=;
 b=dsmBFT/5/doofgSIE4jDD1auQe2rddjgfoa0nOAm7/n5sFK1TiifFrcSXDGzUazsLrQcIsp/u0qSUijhACC48XgAz1TwMaPqbQJXxYuIFDXEGy1Lh0SDVY3D33e8aDHhKd5qttY9HEyW5LDuFJXW39svuqAL4LqzUrg5Ju38Ax0=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4863.namprd07.prod.outlook.com (52.135.75.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Thu, 15 Nov 2018 21:51:04 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 21:51:04 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        John Garry <john.garry@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 2/2] irqchip/gic-v3-its: Use CMA for allocation of large
 device tables
Thread-Topic: [PATCH 2/2] irqchip/gic-v3-its: Use CMA for allocation of large
 device tables
Thread-Index: AQHUfS1OydriUw4dmUeW0piSOGtXyA==
Date:   Thu, 15 Nov 2018 21:51:04 +0000
Message-ID: <20181115215012.23922-3-rrichter@cavium.com>
References: <20181115215012.23922-1-rrichter@cavium.com>
In-Reply-To: <20181115215012.23922-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0059.eurprd07.prod.outlook.com
 (2603:10a6:203:2::21) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.169.238]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4863;6:XrkHCHus4bPWTene/ktlZgOJSJjJgRuhrR+zWGJ9ovtABFQRYXHREp/GqhzhUXTmXGQhg+IeOFKq2mkBVDG/OrZNYykx7TfS7fx4AbFj0PBBFghOC7W1atzcDcptu2nWCZFG+wTzNYEGSYyXfjcMfVhCcJpDAzST+9vd9H8HkLPGeodKG1Bg5GsCJnkz62OP/8s/vlQglv5u9GQi1fE+4W7low5kLp0DyHDR/wi280XdMGtS9s0wv98e8NwpxhbBHcTiWI1vS+W92/aJqpZO2we6bruHw0ayamuJNTqHsCcBjF17suu/ZT3+cScZdEEl4w8PE6xwc7MIkEke0fFLnM7D0DQtfdaHaCqE/8+MjNoOgnm91fBT7UNVOzgZgvP/x/OvgKShbozsXcZhGj9CIxpTxh40P2B/fyTUVv5gvBX5V54u2Wqail/MGEEk5amCg94zt2LHJSl1DCp/ZrlDkQ==;5:ybLrEs2uMGQktxP+6JFDa9/APYBa0uCeY3PAJyloTAXFkWMWqxsF4qqiK3c7JdEHuYY1cOaGfCta4GNqp3chSx5o0JlPBjXnfRVPRZINRfHhc31/j00duE70tVHgP/CBjzRDRbBHWIPKNQ7IcsScITW0UTCKkWzUvfQ86LqXBO4=;7:r6SHGNKQwivJlu+Fi+A75+deQxuZLz4VFpTPICBx1zNOSUulKbTVvYLvXQTUejufYwf1D7tTv5g1KgbnN6uFk9CSLQhKGAbWiH5l+rpEQzfO1khEFOWSYN5Oah+tr1fP3OMaKvtFZPLzwKunbumxAA==
x-ms-office365-filtering-correlation-id: 72a062d1-bf49-495f-1ebc-08d64b44709c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4863;
x-ms-traffictypediagnostic: SN6PR07MB4863:
x-microsoft-antispam-prvs: <SN6PR07MB4863C7A99EF95A32FD0523DCF1DC0@SN6PR07MB4863.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231415)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4863;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4863;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(186003)(386003)(6436002)(106356001)(26005)(6506007)(72206003)(14454004)(6486002)(97736004)(3846002)(6116002)(68736007)(105586002)(2906002)(8936002)(81156014)(81166006)(8676002)(1076002)(102836004)(316002)(99286004)(54906003)(66066001)(110136005)(2900100001)(7416002)(76176011)(256004)(14444005)(39060400002)(446003)(305945005)(52116002)(71200400001)(71190400001)(6512007)(486006)(476003)(2616005)(11346002)(107886003)(25786009)(7736002)(5660300001)(4326008)(36756003)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4863;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T72cNfekHkLNV3dSeFS90aUnUpBPeXelhKEFZI/jHER73vNAdFTG5coQRZUIgYrLkZKL5Nwfj26j2jttzxLS5dCDwjvJ639rzUdEzakIbvYY4mZ7ukY6Tk72lQXLv019bRDXfY2kSPlsJ5A5TtHuZYAUfWEwPtGu7uridSG8J7+vGAabTdVJF39kDSaKUPPL0uxFg9Cubna8ZXLZTb4USRFFZjUIlT4hoIoPJ0GuVVvCHluMirIoT+nuNQyqOfN2z+UTcG7woNIbo1QFkWCcSXhaLOC20Ovxwgp0ZnnbqvPHIKUb+sAMXdM6a9ztm+VoWx7K7BqFCHQ4n26zKtu4Ll3NUkTaBI1F6/yBlYRV8fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a062d1-bf49-495f-1ebc-08d64b44709c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 21:51:04.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gicv3-its device table may have a size of up to 16MB. With 4k
pagesize the maximum size of memory allocation is 4MB. Use CMA for
allocation of large tables.

We use the device managed version of dma_alloc_coherent(). Thus, we
don't need to release it manually on device removal.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 113 ++++++++++++++++++++++++++++-------=
----
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index a4b1b2fcb60f..6ba221aa27b9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -1732,6 +1733,41 @@ static void its_write_baser(struct its_node *its, st=
ruct its_baser *baser,
 	baser->val =3D its_read_baser(its, baser);
 }
=20
+static void *its_alloc_table(struct its_node *its, u32 order,
+			u64 *baser_phys)
+{
+	dma_addr_t dma_handle;
+	void *base;
+
+	if (order < MAX_ORDER) {
+		base =3D (void *)devm_get_free_pages(&its->dev,
+						GFP_KERNEL | __GFP_ZERO,
+						order);
+		*baser_phys =3D virt_to_phys(base);
+		return base;
+	}
+
+	/* try using CMA */
+	base =3D dmam_alloc_coherent(&its->dev,
+				PAGE_ORDER_TO_SIZE(order),
+				&dma_handle,
+				GFP_KERNEL | __GFP_ZERO);
+	*baser_phys =3D base ? dma_handle : 0;
+	return base;
+}
+
+static void its_free_table(struct its_node *its, u32 order, void *base,
+			u64 baser_phys)
+{
+	if (order < MAX_ORDER) {
+		devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO, order);
+		return;
+	}
+
+	dmam_free_coherent(&its->dev, PAGE_ORDER_TO_SIZE(order), base,
+			(dma_addr_t)baser_phys);
+}
+
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 			   u64 cache, u64 shr, u32 psz, u32 order,
 			   bool indirect)
@@ -1753,12 +1789,20 @@ static int its_setup_baser(struct its_node *its, st=
ruct its_baser *baser,
 		order =3D get_order(GITS_BASER_PAGES_MAX * psz);
 	}
=20
-	base =3D (void *)devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO,
-					   order);
-	if (!base)
-		return -ENOMEM;
+	base =3D its_alloc_table(its, order, &baser_phys);
=20
-	baser_phys =3D virt_to_phys(base);
+	if (!base && order >=3D MAX_ORDER) {
+		order =3D MAX_ORDER - 1;
+		dev_warn(&its->dev, "%s Table too large, reduce ids %u->%u, no CMA memor=
y available\n",
+			its_base_type_string[type], its->device_ids,
+			ilog2(PAGE_ORDER_TO_SIZE(order) / (int)esz));
+		goto retry_alloc_baser;
+	}
+
+	if (!base) {
+		dev_err(&its->dev, "Failed to allocate device table\n");
+		return -ENOMEM;
+	}
=20
 	/* Check if the physical address of the memory is above 48bits */
 	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && (baser_phys >> 48)) {
@@ -1816,29 +1860,27 @@ static int its_setup_baser(struct its_node *its, st=
ruct its_baser *baser,
 		goto retry_baser;
 	}
=20
-	if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
-		/*
-		 * Page size didn't stick. Let's try a smaller
-		 * size and retry. If we reach 4K, then
-		 * something is horribly wrong...
-		 */
-		devm_free_pages(&its->dev, (unsigned long)base);
-		baser->base =3D NULL;
-
-		switch (psz) {
-		case SZ_16K:
-			psz =3D SZ_4K;
-			goto retry_alloc_baser;
-		case SZ_64K:
-			psz =3D SZ_16K;
-			goto retry_alloc_baser;
+	if (val !=3D tmp) {
+		its_free_table(its, order, base, baser_phys);
+
+		if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
+			/*
+			 * Page size didn't stick. Let's try a smaller
+			 * size and retry. If we reach 4K, then
+			 * something is horribly wrong...
+			 */
+			switch (psz) {
+			case SZ_16K:
+				psz =3D SZ_4K;
+				goto retry_alloc_baser;
+			case SZ_64K:
+				psz =3D SZ_16K;
+				goto retry_alloc_baser;
+			}
 		}
-	}
=20
-	if (val !=3D tmp) {
 		dev_err(&its->dev, "%s doesn't stick: %llx %llx\n",
 		       its_base_type_string[type], val, tmp);
-		devm_free_pages(&its->dev, (unsigned long)base);
 		return -ENXIO;
 	}
=20
@@ -1862,7 +1904,6 @@ static bool its_parse_indirect_baser(struct its_node =
*its,
 				     u32 psz, u32 *order, u32 ids)
 {
 	u64 tmp =3D its_read_baser(its, baser);
-	u64 type =3D GITS_BASER_TYPE(tmp);
 	u64 esz =3D GITS_BASER_ENTRY_SIZE(tmp);
 	u64 val =3D GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
 	u32 new_order =3D *order;
@@ -1898,12 +1939,6 @@ static bool its_parse_indirect_baser(struct its_node=
 *its,
 	 * feature is not supported by hardware.
 	 */
 	new_order =3D max_t(u32, get_order(esz << ids), new_order);
-	if (new_order >=3D MAX_ORDER) {
-		new_order =3D MAX_ORDER - 1;
-		ids =3D ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		dev_warn(&its->dev, "%s Table too large, reduce ids %u->%u\n",
-			its_base_type_string[type], its->device_ids, ids);
-	}
=20
 	*order =3D new_order;
=20
@@ -3522,6 +3557,22 @@ static int __init its_init_one(struct its_node *its)
 		return err;
 	}
=20
+	/*
+	 * Setup dma_ops to be used with dmam_alloc_coherent() for its
+	 * device table allocation. Since the device table is
+	 * exclusively used by the device only we can mark this mem as
+	 * coherent.
+	 */
+	arch_setup_dma_ops(&its->dev, 0, 0, NULL, true);
+
+	err =3D dma_coerce_mask_and_coherent(&its->dev, DMA_BIT_MASK(64));
+	if (err)
+		err =3D dma_coerce_mask_and_coherent(&its->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_warn(&its->dev, "Unable to set DMA mask\n");
+		goto fail;
+	}
+
 	its_base =3D devm_ioremap(&its->dev, its->phys_base, its->phys_size);
 	if (!its_base) {
 		dev_warn(&its->dev, "Unable to map ITS registers\n");
--=20
2.11.0

