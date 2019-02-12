Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FE2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4570720823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FHa+wip3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nzz5qKs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfBLOAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:00:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62965 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfBLOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980029; x=1581516029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MMaSjPVSOs1KuGPAIVXOULMT9o2j1tPbTgBb8+q2ItQ=;
  b=FHa+wip3Kg8ltSLGw1UepHvqxj87w9AGpShbaNeJAGlDtzcBre7dWP7h
   7LBN1PX2f9qwnvy6sZijdSmvZAnzwYf9CgVIMeS5CjkgBzDYyVlmdkdoj
   lgD7ejDVYYcTs9BVMmf00TslrXPhAJ/BwOtCFBSFR7EEoiWUrl7XlK9zt
   XbdT/Npgt9nCQ9MdtwoZTmiOPPI3g0T2t0efVbGI2v4Nb+K7gr8nhPxLG
   RZqrKfljrqtBbXCczHbEodIAy7bAxEzPoJbbYqE4ZHcPBFS4jsBEEaoE2
   t80jSQvr+1BR1VCL6Fm8GFYva0dbHX3QWtvIVaqCLv3WlOBDZu2HK1jjC
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="101010259"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:00:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL6B39zTRMesFFycvJsi7f9wzh2NABawCwlr1Qo+OTc=;
 b=nzz5qKs8CZYupXh34LRzcvbUuUlJ+lUMKWHPKRYwAFx9HDMCc/61tBCM66jlsUALnfVo+anRlu8W/VdxoGB+e7cFXtOucZfw8+7fL+RCN5dX6U72DMPgB76l4WnVMAFga6I4cR24WTtA/ng3fUdoNgwmduiiV0NYxDSJ3xlneZc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6224.namprd04.prod.outlook.com (20.178.247.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 14:00:26 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:00:26 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Topic: [PATCH v3 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Index: AQHUwttOdTsDzGHhY0ijRWgwbLe67g==
Date:   Tue, 12 Feb 2019 14:00:26 +0000
Message-ID: <20190212135942.105008-4-anup.patel@wdc.com>
References: <20190212135942.105008-1-anup.patel@wdc.com>
In-Reply-To: <20190212135942.105008-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:de::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.48.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b065dd46-7425-4aec-8e56-08d690f2705a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6224;
x-ms-traffictypediagnostic: MN2PR04MB6224:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6224;23:VrxPQrMbKRy8sKWy5l1c5n74D/O5l24F1/+pQdh?=
 =?iso-8859-1?Q?pnZ0UPenzobqAMVFINR/KHx6tb/Q/4SSoeDJTmOASiUdoXhQ3Mx4asE+qN?=
 =?iso-8859-1?Q?BWmRKHeZ8M4Do1IyZ6YS1qpRXSSW2JNbiEFc4MH3Y8kUC2KzbyWncywqGJ?=
 =?iso-8859-1?Q?rfbP3zheJKX5AZlrBG6MRN2ainRmbZnyciTh09sTcZu9LhNJ4evRReCDsY?=
 =?iso-8859-1?Q?cAd87l2RfRVV4KaihSVXhQT7HhjiMsyjK/7HBZbiHAbvyEreiijFoNL2fQ?=
 =?iso-8859-1?Q?ZoGqN1zmtgjeYPnNcAF8C5Bp2fQi5DXVQSXsQCM3XlNiW/Z5QGjfDMsb3Y?=
 =?iso-8859-1?Q?vt1HogqehVnX21okxufPbcq23IsIAprtP6siuS/NtrSBULlsCi+E8Q3CLW?=
 =?iso-8859-1?Q?b+6VjAT94p3osOW5vPdlh3tcRWv3xdx2hranVwY+gy+tmjJCymeK8j3N0X?=
 =?iso-8859-1?Q?sZdO/YkL9DGJxej0KiYZCr/2sTizn/4gIWfKIHiQU/k6jrJR8aUFQd6dhL?=
 =?iso-8859-1?Q?O0l3qm+EEJ8jSK+izIdC5IQ7/TlvAmImOZPfYHSWLQFnpKLPg6U7yDm05q?=
 =?iso-8859-1?Q?rCa4R/dI7gs/YcBGITlXB62aEPW0bwNnHji3yhaue+dH+xZxdMT+uwLXgO?=
 =?iso-8859-1?Q?ZFgz/+kurNEqHDERO+GG0bakIHaJDE9vLGAEpmzbWuORfOB2YSVhFWJytY?=
 =?iso-8859-1?Q?+KMa0ZOQNjgmzxvrTmuNxQ8WbUasQHm2Hprv4PpReX3vC0frlvBp+/2che?=
 =?iso-8859-1?Q?7a7y4QcAjvMdkLgYwgyM/+dRt/NTOTSAtKMDboBeNzCqGDK5TYyMOMzO7f?=
 =?iso-8859-1?Q?OMFScUa9MfgDDjzBTWT6zJvAA/vB4/GmRaq6iUDdXzXkdXBLicwghXeL90?=
 =?iso-8859-1?Q?z6x6bUqaBhPDTYUt7srgy80wLUNdFM/d8+/wz4+lHP8iAGDXNedL41r2og?=
 =?iso-8859-1?Q?4VLQaFp4D4CWu9SagNSF9QLFfXZsDVi62Epa35YEc+wOtlNHy6FwDUg4lW?=
 =?iso-8859-1?Q?KRx0kSgq28iJ1faKbQuSrHFiuKds7rJW+RYSCif5U0CCYLFbgtvC+Qq/V+?=
 =?iso-8859-1?Q?kXfiSdhTVFCwPGfZZySonuezhCTJsKi5e9V3jr7uUhgikpuecMcGcpFQxx?=
 =?iso-8859-1?Q?+3TFlbgXwEd6E9gvjAjBOWAcivjPYQSBcWMCZPzDMOyCj2e7zQO6a5Huha?=
 =?iso-8859-1?Q?bRp16+kQuR0ijuvWyhK3wMp6gmyQ1wdZRRiMK1h674JoWOHwntiNzq6EWn?=
 =?iso-8859-1?Q?m/BMH7TIB7NQUAi9VMTmKE4oAIkOWHeJJPDliNLc0lmbYLVpcCc0r5lNMy?=
 =?iso-8859-1?Q?tYImwY/WjKLyatL3v0S2QFP?=
x-microsoft-antispam-prvs: <MN2PR04MB62241D411D743B927294142F8D650@MN2PR04MB6224.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(11346002)(25786009)(2616005)(72206003)(486006)(2171002)(478600001)(4326008)(446003)(14454004)(6512007)(476003)(52116002)(36756003)(110136005)(97736004)(3846002)(6116002)(8936002)(50226002)(76176011)(54906003)(99286004)(7736002)(256004)(106356001)(316002)(81166006)(105586002)(68736007)(186003)(8676002)(44832011)(1076003)(6486002)(6436002)(86362001)(66066001)(53936002)(2906002)(305945005)(55236004)(386003)(71200400001)(102836004)(6506007)(71190400001)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6224;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +My5kfXJ+yNGSpeXFSzUxdzTdZeyWV8hts1Da/a016BF4D4+7Vb3LclqSdmbm5MIWlXo+EnbCj7S5bp4icPeah7mpkp2paZ/WuTZAnFg2jGhUQZXEaG9H++38TN2+QJmKM5ktGNFjKQEyWnLoJKu/+R9uempVHnSb/KnkdS0bsvFZSU7Upm12INAkNubJkPPQi5ij4JtjIESYxoU0gvizdReIZ1ccQTAQ8wZ/24yLknQ439nVzGacOmo3IppRNJirnVpkeEgBVOqLbA17l/mLsIwiYXbkP7sFCm3nf4yXYsjro4zVdZRAWXMw+UTnJHmACTXYs5qN+e/nFSkwUucB02dYR53RCdvg+Yt0HFVNfzjGxTBnF7thORaoIeZHusz8Wqem3/aajkx/zu8JfsCkaX3HixXf9wAodnZEyftl5c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b065dd46-7425-4aec-8e56-08d690f2705a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:00:23.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_bootmem() mainly populates memblocks and does early memory
reservations. The right location for this function is mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

