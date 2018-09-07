Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0372C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FDC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nagSYpVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FDC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIGFOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:11 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeIGFOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0GpN1RcPLx2TI57RUXzRx16IC9SHbve9HFcUbyq7bs=;
 b=nagSYpVM/8ZEwlh16E9VQhx+FB9g1mFEYQV3vm/b21mz5daX3Cf1ExMhzJKu4wSLF+0nUDEhlJHmNIeQihdCPyzgilKWBW1MUcG2RkqpxJvnc85JwAZSddxRTxl94/c5eNJquyFVzxxz4g0Q0SXniNaS2tx/M+AZJFZSE13Fkqk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/88] iommu/io-pgtable-arm-v7s: Abort allocation
 when table address overflows the PTE
Thread-Topic: [PATCH AUTOSEL 4.18 05/88] iommu/io-pgtable-arm-v7s: Abort
 allocation when table address overflows the PTE
Thread-Index: AQHURkK9w/gf6Z3yZkiZov3WjOL2CA==
Date:   Fri, 7 Sep 2018 00:35:56 +0000
Message-ID: <20180907003547.57567-5-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:jUmJChkTivh91BWkFVbfvM9wxpsnNrv5guRHJb8TARLFuYBB333GlJnw5uxBbPQRNF4tFifFNH1d7q2jzgBhVptZ78mVGGf2SE/uHIowUg8REBdo/1wSa85Q1rHT1iEWApwU9aBKQSA8MXASCZFsx/eyhO5+u8IdNILuf/MyGIW2M7+925Yk1/mcTI2RD0kaIeuTrChtYf1bz24zH1/wmdWFF7olLujqQr2EuNp82w4eD/J9YQ6fqpNW9BmvB10m1fiwtWZG+X8o6jBF3xYy2z1vIa265dm91xwqulaT9o2Ug89rnFvEwjIR+wVBI6e4xRe/u0bL9aMCeaYtKZ58OhPd3+XZH7cR+Vp4YFXJ6Gk3itgQjIoFU9H40Y3rHpScTsNkELxdBKJ3xFxZvEZEhxrdibheT+xVVIxa2Ji21SkzESxV+6kTLgdBcQxvzotnaKp3PepHBFrgVe23cgtS1g==;5:YojmwEHps8Tmd5SxN8RmVd16qHOySd06cbhqJiFnY7YzDGkdjq1zbi3X7+C4ypnLYBqP5P87oF436mCmu+SqKvNPhVyHBj6jxSx0TvMavoGMvQqHrYxcRerd5sOpYQs5BPjJ3nj+El7w2WHw0BQaB9Lb7gJwBSiN5bsPRx+vVGY=;7:pVSbngHclJLNO6srWt0+OuWtKd2bW7U3sCnQUxNLI71/heQMsF35gCS7LMxoukFZSpOXXHkdBAlUvGC8lw369kdbrZHdzbNViftzsbPYFRz6cvVD7ft5XNnulfGDLbQq+T3O5x6D0Tozzua4RajoMjczAFYljpgV6+Nx2dYroP0MDtiyPY21xfdNA7iOfcM9oUPsmwzrx+3RsMBUe3GjhAHBzW1KVu71W48wvcptUlYvoEuvJ7MxVkNalsVv6aV6
x-ms-office365-filtering-correlation-id: fb1de049-324a-4a26-a479-08d61459e00f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07736AD47AF9C4A914FFA1F6FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(20558992708506)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Bvq1P2+XnOosOr0o2FV11A8VkktfxMRO2w6suaPEeSzfwdwBJbprkhGrsqJ7Iv4nvQrWkWBiK1IGMEjw8SypgdRSmGUvSyVfUFa85lIN/WRbByiKCXZl+Tr9TL8IZi9ONkUvIVkhS9LpXZ5rkDzH7B2jR5EtscnvfZH1V/DWQf57TUSTlIw1ahrB/ar9wSDZiPb5tEkXIjm/OPwhahjT+VDfDBXsfDPaFO2tuoQ02he6TQxf731eAXn5XtsXIoQKW/QBmhXwhbjztmv1zbHK1B7SjMp8ZLi7IfOzy/osm2Uig0yv+/CwU+obVFsAU5Rbu40vJqpmBBKUY7YFQ+ZiT5/Wn8akZbBLN2/p2tQCPU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1de049-324a-4a26-a479-08d61459e00f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:56.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 29859aeb8a6ea17ba207933a81b6b77b4d4df81a ]

When run on a 64-bit system in selftest, the v7s driver may obtain page
table with physical addresses larger than 32-bit. Level-2 tables are 1KB
and are are allocated with slab, which doesn't accept the GFP_DMA32
flag. Currently map() truncates the address written in the PTE, causing
iova_to_phys() or unmap() to access invalid memory. Kasan reports it as
a use-after-free. To avoid any nasty surprise, test if the physical
address fits in a PTE before returning a new table. 32-bit systems,
which are the main users of this page table format, shouldn't see any
difference.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-=
arm-v7s.c
index 50e3a9fcf43e..b5948ba6b3b3 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -192,6 +192,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 {
 	struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
 	struct device *dev =3D cfg->iommu_dev;
+	phys_addr_t phys;
 	dma_addr_t dma;
 	size_t size =3D ARM_V7S_TABLE_SIZE(lvl);
 	void *table =3D NULL;
@@ -200,6 +201,10 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		table =3D (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl =3D=3D 2)
 		table =3D kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+	phys =3D virt_to_phys(table);
+	if (phys !=3D (arm_v7s_iopte)phys)
+		/* Doesn't fit in PTE */
+		goto out_free;
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma =3D dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -209,7 +214,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		 * address directly, so if the DMA layer suggests otherwise by
 		 * translating or truncating them, that bodes very badly...
 		 */
-		if (dma !=3D virt_to_phys(table))
+		if (dma !=3D phys)
 			goto out_unmap;
 	}
 	kmemleak_ignore(table);
--=20
2.17.1
