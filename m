Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64FB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EhWIeu53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64FB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeIGFQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:25 -0400
Received: from mail-eopbgr710120.outbound.protection.outlook.com ([40.107.71.120]:61954
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeIGFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/xRLe5GR0sbDbCexj0oMYCMLvLJmMIxe5JjMOfC9cM=;
 b=EhWIeu53mYy+mY3eyJPW3436FYU6Xaq+a+/hZtM7FGWiV0vlRGELh09RJjvIov0QB4C3ntyZ4Wq9xbyZMwIzDoVDgmkIQNgmxCJRCxjigbIsyzeSW5M8AwY/x7TVDufeayU8KyoCLv9/Is5ZyJIwvbVzTNc3GaVJYLLmOBf7uIY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/67] iommu/io-pgtable-arm-v7s: Abort allocation
 when table address overflows the PTE
Thread-Topic: [PATCH AUTOSEL 4.14 05/67] iommu/io-pgtable-arm-v7s: Abort
 allocation when table address overflows the PTE
Thread-Index: AQHURkLxr169K9HC50CGJOqzx9chrA==
Date:   Fri, 7 Sep 2018 00:37:24 +0000
Message-ID: <20180907003716.57737-5-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:6ladbYGcyX4P8c1YQDRv8WZlkdW+ejPMZcZ/0T/NK4dfnnd1Y4vhIPzm08RbzgiTYssv0CslLPdeBNrePVLGwZEfH9xszPSNMeg1QJJ8yT6Wnz3RgCwRPxz5jIpixkMVhk7F9mDZJL1WnhX3iqWrYWA7ftlzeb3DIwZXEN9QzofMXTZzy6JJHeXc9k9Hvge/x0hlnTO5CzE07SVlC7HEgU7/LNxr/zc0uSJVBXLQdullq0K8mUJZSN97GBRoVEupaYhAGwyFLJXJybaQewtV61EwhzErjtLB/NdRxlzAoB8fZ6GBznjiZbzo/4MvhOD2FYg1Dmf8V39GcTdQ66DirDtG0N3IbQpBD0MhahIfHsiQY1OUFJR3dQ+cJ63ztVnCv3prjbETVEjIaRywEhqxYD0cbjyIP2BNxlYG5mF43ZkoEqr9TUA0UZHyW2ne4ab2gDLV+SvekU1eijFL1VkvHg==;5:4i+xVWSMGDuejhE2Sin6ufDgRbccAg1eTrwu89jaHdkVL0rABjUjIgCHNWzcfuq2oy9rm0z++AiTafIh20Odyk0JK7S9NKYwQW9snDlDtX9noLAi6ow33xqFsBVldTzKOOIQ7W1VnGgAROPRN+wAEIqOiGnFb2XdEWoLUfZAUms=;7:U4iQTfy8Fl+ngw+f0Zn4wz5iyGaxkcplm/Zjiwih1rh3NHeL6/aZWgua2t2BWrLAsfEKBeGynGkMXRS5NyS2s7gewIDXLyiXBHMHbKYVuRIeWCx9V/K6JOVLfWFSNWXF4y/wpJlQtYGwL4SPcy7LpVGVj8/UESQqvXw8UBLjL+avJoWQGmnJJvS0YEO4XIqDkqMtwnyebxBupwJPrG7eKY4bOuOXumN9fJg0ZhrkUcI3kG2CWhJRXegn+dkWg9cO
x-ms-office365-filtering-correlation-id: 27e7a7b0-5f6c-417d-687f-08d6145a3241
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083942BC9C8BA58D8BDE3CE1FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(20558992708506)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HllJ+zk8ltkAkpgmCNXxRbRQ2fDmXuFn3QWtsMs0VPcX37F8sCqsyucyqCOnU5WOzSQmL0mK9ma1erc5kwy+FxDy9gVO9K6FOSbWzVOXNxzdubHIWtC2gWtA14AMl1moUAD58kRggeakHMQTWQ4kUqCXFVfohk6bd1q30UAWhy17i+/IGne4rDxA9J8WLJSbOb6VpgSAYn4qtWMz7j+ZtYLKriqb7HdG5zdS+FRtA0GUUdwdXht2b6jK9m11fa/tzNkilzLdde4y/GyRgVcy01r8hM2uu+pN7KsSBEiVr4SoD4gUk7kbafSqFA1CQaFRNC9StLbIHQ33GFz0pADQtggwxUBIslNuPE8OkhflDMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e7a7b0-5f6c-417d-687f-08d6145a3241
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:24.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 6961fc393f0b..29b7a6755fcd 100644
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
