Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B02C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B0222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CUDeNMP+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SFMkwB7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbfBMIHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26109 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390359AbfBMIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045255; x=1581581255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuUS9APfMCm0201mEnejJ6ms7yQO4HAQocfr3TMtdYE=;
  b=CUDeNMP+vRF3yAk9q06rY7BOc1IuhMTLeTDem8j2YOg9Z/RHTAX6JYvO
   ry435008zriIrmdfNLAg2iiJAndT7egYOwqQvtv4J5rjnwuD4qlKWijNq
   qr2Zy/mTsNZzP9Chf7rQVaa9C9PIhdQ4tCe/ujDkdhHznmlW1mWyzVBAm
   KT8ZLaKy+fkHso7CHdpJ2CQ0piVkF8gxVOlnwcE+K4LembQv8kODvFd23
   QpPVmlGNrnfT0L02GyDSFwZGvRfBucTS/CzN2RaPSQ9V/iVq62h1gL9tv
   xXrMUv1TdGTpurwyRUKbSWIHe+F/747MroIxr3WcdNKa/FhV387udQONc
   w==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102402322"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZYC+n40qSzR4f+zCg6G37FQlaEhcuFjDfi10z8r5e4=;
 b=SFMkwB7CWKbs6dvuz+r8HvZSoIRjHdw1wHEIADytmaXx2D+YUdoSKyPCpRPm6+85HdmUxJB68HAhX9T3/Km2uRbRprV/49aZwg+YiB/UxR3rzCTuvx8Sc7z6WA0S40G856qNzQYOECodxkXqWUCEiyJ7SeUu6Lqp1FP8q7FGT/0=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:33 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:32 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v5 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Topic: [PATCH v5 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Index: AQHUw3MshXGMAgT6hE+rgap+UEOhBQ==
Date:   Wed, 13 Feb 2019 08:07:32 +0000
Message-ID: <20190213080647.68204-4-anup.patel@wdc.com>
References: <20190213080647.68204-1-anup.patel@wdc.com>
In-Reply-To: <20190213080647.68204-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd81a7f-a717-4c0f-610d-08d6918a4e69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:PsUO0gxNDrX4tMNwC0dZCEC6faDE0p7EgITH68t?=
 =?iso-8859-1?Q?r8XjckG2FwRE95Hu4kdaJe/zfdJxu6asenkFSk0lV9/T8iYdxuwxfIHQ/4?=
 =?iso-8859-1?Q?j4bTAWFj9B5LFYGt+TdpZWgHGvzn00GtrLvMmGtLa6zFUUso6jVPlPUmFt?=
 =?iso-8859-1?Q?ZYODIEileyAV72iMRIgEH5MPlyIlMRszY/PQ94tjNpmgtKTvWU2elfN7EI?=
 =?iso-8859-1?Q?qzTsvM7X6nyon0X3rENPyeyfptEGmGoWyyn9iG+aZvv+qpAcpRQEDjiw2Z?=
 =?iso-8859-1?Q?qL8q4g93jJBT24ZYw5SubSAygbciLLrMlyn+7ejPfY6kSz9DDBezQq+SGn?=
 =?iso-8859-1?Q?pubcbW+gb9kaO7uUYsyqwx8Ea6B1M0JWhZrm3uyfT8XLArh0rePitSCMBV?=
 =?iso-8859-1?Q?eVX94u2Lm7ydxpaiDfH8ggZaFxzQxJtDGKT5fV+9PbzNAN9iRTNIsVM9Dw?=
 =?iso-8859-1?Q?gceVA2k2xwQyO4S6/Ew6LbhNmcDd6PcpS842on7k42xUFEasS3RWTFleGI?=
 =?iso-8859-1?Q?wgL4RmODnXfh8nOoIcJc4/DIWfXQrxmCx8jmbQHlu80eMjrBYytqpe6zuc?=
 =?iso-8859-1?Q?QPso7HElz742a5akXj3euiJVUTVuDpCrTxA9V66m8W7YjmomRJB0K/L/gr?=
 =?iso-8859-1?Q?f9js6KWo0gaVRf3/9FTxq01BzQ8tKkXJE7vISt2cOWxKHn4no9wEJC53pF?=
 =?iso-8859-1?Q?9rqrqkKqE32PHG64kWE5T2dq7iRSLRIdv84QPSjwjbTUKmnzJGV50f5I4Z?=
 =?iso-8859-1?Q?xDsRaJLQ3Po8/TRPpFG0ylG2cHxfvrHa3AJtbrwaIW654Ipk4/rMCVBvpu?=
 =?iso-8859-1?Q?fedCXPQL1TYD9D1SZcQXBD2VKtCGgkcY2mtEGtUNsVWdgXtZEq4gMf7yef?=
 =?iso-8859-1?Q?pkDQ+JOJ0uGZVFaL6hQGot2u2nQdDA5M5z2L/eGKBa+pFivesgTaaSSB9z?=
 =?iso-8859-1?Q?NVC/7zS2n2n98hXe0Q8GPH9Aw9Ah/cblLSNQjcIYDX1Ljps2TJiYf7mquo?=
 =?iso-8859-1?Q?68DrQQxBKwLJqTCAKEZqthVH6SzBV5z4g8NPVCcozQY3lH+Qawlb7Q3qBq?=
 =?iso-8859-1?Q?c62gfjrhXjzdgaWuv2KyH3OeqiO3IeyAiJ74XWlMxcDrgkTsyouuU/k00h?=
 =?iso-8859-1?Q?QxfNqYJcL4c3WeXXBISvpahVa4kbyfxSRfUZRrx5dpStoAetvWMHFeNg7I?=
 =?iso-8859-1?Q?nY8rfSrM78jtAAzsSCBRNHOEqIUFpdK4qnXhmxPa1AIkFyMvTdcA6cROP1?=
 =?iso-8859-1?Q?1KRCrsK8cgobgGLeT1hf72OzIHe4E1nattRhWgspehBFV9kgQLnRNE1wcM?=
 =?iso-8859-1?Q?nA=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB59931487339DE5B130C5FD5C8D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(76176011)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(102836004)(72206003)(476003)(2906002)(11346002)(446003)(81156014)(1076003)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IOrb1b7D9+EAmqJcsTh78m+UzIFC2JEuSmqgZAFxT73xzXIYaudW6bNQwgJqeNy8p7Y8nWYTZYaiaHc/f2Jg6fYiJWcA4qtdRIYxB9xHUlYUarHiq385YBK7yKC9WmM8+sVbtSdia9xuoQRYJvw1DOB/6lXoLzkDVc33QJ5fVma+sElzGKIKMJuAIaR5zZaqF92h1RM/oVskGyYWjtuIAW7eNjVFYR7MJQeyGlCf+vJ6jzMAQfApDz5I+fu4zU5BvQaeseE87SDJkOYv93rGrFHayAHQCFECu3D6NLA8K3nfsNn8Aw1fo/MAc4VHcItQce6KAxQ5w43biGiYWp/bNpI17/MPrxpFlaEjNZ0GQ4Po8yOBUwwtNcg6guO98QP8yIgK7iwveSRYgEWevUUC4gwQuN25ka/3uCFHWrzXdkI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd81a7f-a717-4c0f-610d-08d6918a4e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:29.5835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_bootmem() mainly populates memblocks and does early memory
reservations. The right location for this function is mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/setup.c        | 48 ++++----------------------------
 arch/riscv/mm/init.c             | 40 ++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 16301966d65b..35893810cba3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -404,6 +404,7 @@ static inline int ptep_clear_flush_young(struct vm_area=
_struct *vma,
 #define kern_addr_valid(addr)   (1) /* FIXME */
 #endif
=20
+extern void setup_bootmem(void);
 extern void paging_init(void);
=20
 static inline void pgtable_cache_init(void)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 9e6395b7d409..ab29a66a17fc 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -163,49 +163,6 @@ void __init parse_dtb(unsigned int hartid, void *dtb)
 #endif
 }
=20
-static void __init setup_bootmem(void)
-{
-	struct memblock_region *reg;
-	phys_addr_t mem_size =3D 0;
-
-	/* Find the memory region containing the kernel */
-	for_each_memblock(memory, reg) {
-		phys_addr_t vmlinux_end =3D __pa(_end);
-		phys_addr_t end =3D reg->base + reg->size;
-
-		if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end) {
-			/*
-			 * Reserve from the start of the region to the end of
-			 * the kernel
-			 */
-			memblock_reserve(reg->base, vmlinux_end - reg->base);
-			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
-		}
-	}
-	BUG_ON(mem_size =3D=3D 0);
-
-	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif /* CONFIG_BLK_DEV_INITRD */
-
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-	memblock_allow_resize();
-	memblock_dump_all();
-
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn =3D memblock_region_memory_base_pfn(reg);
-		unsigned long end_pfn =3D memblock_region_memory_end_pfn(reg);
-
-		memblock_set_node(PFN_PHYS(start_pfn),
-		                  PFN_PHYS(end_pfn - start_pfn),
-		                  &memblock.memory, 0);
-	}
-}
-
 void __init setup_arch(char **cmdline_p)
 {
 	init_mm.start_code =3D (unsigned long) _stext;
@@ -218,6 +175,11 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
=20
 	setup_bootmem();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	paging_init();
 	unflatten_device_tree();
=20
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 504a5e491f5a..a57dba8ac9e7 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/swap.h>
 #include <linux/sizes.h>
+#include <linux/of_fdt.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
@@ -63,3 +64,42 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
+
+void __init setup_bootmem(void)
+{
+	struct memblock_region *reg;
+	phys_addr_t mem_size =3D 0;
+
+	/* Find the memory region containing the kernel */
+	for_each_memblock(memory, reg) {
+		phys_addr_t vmlinux_end =3D __pa(_end);
+		phys_addr_t end =3D reg->base + reg->size;
+
+		if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end) {
+			/*
+			 * Reserve from the start of the region to the end of
+			 * the kernel
+			 */
+			memblock_reserve(reg->base, vmlinux_end - reg->base);
+			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
+		}
+	}
+	BUG_ON(mem_size =3D=3D 0);
+
+	set_max_mapnr(PFN_DOWN(mem_size));
+	max_low_pfn =3D memblock_end_of_DRAM();
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+	memblock_allow_resize();
+	memblock_dump_all();
+
+	for_each_memblock(memory, reg) {
+		unsigned long start_pfn =3D memblock_region_memory_base_pfn(reg);
+		unsigned long end_pfn =3D memblock_region_memory_end_pfn(reg);
+
+		memblock_set_node(PFN_PHYS(start_pfn),
+				  PFN_PHYS(end_pfn - start_pfn),
+				  &memblock.memory, 0);
+	}
+}
--=20
2.17.1

