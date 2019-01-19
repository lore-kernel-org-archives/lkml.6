Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7046FC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352992086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yb0pRR4J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eIfgBp00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfASN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59594 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfASN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904533; x=1579440533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bGPlGg8EE3H4XUDQMXXPKEwt2W12jtDqim6zbzgAvJM=;
  b=Yb0pRR4JhyYBVY91oFH5gaOTwkkeUPFGEVWsRGR3kGovORSeU1T52tKd
   9eImTkeui9co+CY9EWOL5HoTJP39b2h8uHrNTI3ql2G572o90I3KjFrU7
   +BhbqOSCokdfmIhHvtnpeqayYprSj3pAvFm0SIn1B355AE2gVDoz2X8FD
   EqHK6DiNKEdiQWwTwXSuAMB9L3MA10yV7EuBFDV9ND6CP4eIN0CMl93Di
   EgDZwjS/GxHNBiC8osWsiPU8LmFxSIA2jk7OzPHvSr2QSGM5PadGgLIVM
   Lmo7R2tWkEK0ZhadWQ98VC6Z3EzqTsPw7J1H4kf9HwE0B1iOPRTW0jn8d
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="104187208"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:28:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgdNNWdPnXdH9THUJg9iQNdnvoZEA2SBeGHYVByoDwY=;
 b=eIfgBp00G9Ef4BJIeDRLlTSq6Z/50injE6uISpdciBhHUaD26u5/Y9RAAYsld9MVo04Ngi+Ysa/6dPjLOYxrbUZg2GZqOH88bUqcrQ2xcLlFn1Ptfdtiv9bTRoiW09gOwtufkhnLzQYgc6zAlGe66yllkuRo00DEuEbvwwIHXzo=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB6117.namprd04.prod.outlook.com (20.178.234.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Sat, 19 Jan 2019 13:28:51 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:28:51 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Topic: [PATCH v2 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Index: AQHUr/rq5jJd1glB7k+R6lJy0++NFQ==
Date:   Sat, 19 Jan 2019 13:28:51 +0000
Message-ID: <20190119132650.9978-6-anup.patel@wdc.com>
References: <20190119132650.9978-1-anup.patel@wdc.com>
In-Reply-To: <20190119132650.9978-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::27) To BYAPR04MB5303.namprd04.prod.outlook.com
 (2603:10b6:a03:c8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.191]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB6117;6:3SQQTa77+t9VZX2o/w/gu2dIe4Dnp+5u7w0psdzVFNFSppM0boH39zicQEZ6URVW7e9Jq6eRbLD0RQ0gHAFCS27SkGhtvyipPdeR+WwPZLsC9FKiIdXvbEcgkgfu7OUsEm9KaxyAKFWhN+J49v+IH6bJ1v0rxgQ3GEKNt4zNbx5ZgPiC3pzHQ4fppGANRqm3fq+jiVagFGineAlgOPihr/daakTBvVJgRVMCZZgQSrV5oZRns/aSuK061XUX0kXAhS04/iv7QS7JTjphk/3HQWv0DSFVB+rplFiYpabjHbmG6bRDJZ4iduplAH57xVeS+e6Dgh1caLZBRffOmUIlO4AlMo5FaC7o5TC672FNQN7tTSh1yV6aAKnjZNldFA2u8LQt03IO+OX5b5PscF/wFpVpU9PQfjVnV/h5H3PkEBgKSSusvOV/n3Toq5WmtofXCa7O2FPH01Of2fPLk30o6A==;5:4EVFdVI9tpCmf4Jn9CioiiyjOsjRmv7cNSGU0CfXByXoRR0Wjt5V5LBqqCJTMf+b23UTvYvxzbWi9qkDhufVmFpO8Oo4C0erFMhTTEZAC3BSQwfkbAWL+ilWBM64ZQsdFxAy8xl0pZnAz+KMDZixLO2EYJ8nnRvtP143LQNt1VjM3fUH6MRjjEYS6fOc8LNEB+KzFwaQ4l0EhlfmDP3PGA==;7:U07bX/vV+xSL60fkqdwdUXSphfOSxXKXe71DBq4o6JFW9wRbk3LdK8ZgFGwnJEBe5VYJz90ZJp3t/4PFgeDBLNuqhVSrAPxfkn/O7fPDBfeDlZ+5+pS1MtIUUowiUYNcaUhzFhD4EVRV/KsOz8DuSw==
x-ms-office365-filtering-correlation-id: b0914f4c-d5b3-4ad5-9162-08d67e120cc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB6117;
x-ms-traffictypediagnostic: BYAPR04MB6117:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6117AB08A8D82D09ECEE4F108D9D0@BYAPR04MB6117.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(346002)(366004)(189003)(199004)(476003)(8936002)(52116002)(102836004)(55236004)(446003)(36756003)(6506007)(386003)(76176011)(2616005)(2171002)(50226002)(8676002)(6486002)(4326008)(81156014)(81166006)(25786009)(44832011)(105586002)(106356001)(53936002)(71200400001)(71190400001)(186003)(68736007)(99286004)(97736004)(6512007)(305945005)(3846002)(72206003)(478600001)(6116002)(256004)(86362001)(66066001)(5660300001)(7736002)(1076003)(316002)(2906002)(26005)(6436002)(11346002)(486006)(14454004)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6117;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p1mmbdGyitIUD+gxssOy+cMpNPnSzFw52rTpF+u8hCwsmIG52PuYzvpeDZKxHlLtrWFXv9ghtngHkvca6BSZi9Dg5RlAm8b125WhFFxTfxy0q0nRIbF7rZVH2dJsxfvYESH2Qk3lPDlUhbmBRKd0mnDmhSW7B8MWlKLLdPiZP1/TpxM0Lh1bzAuAl9IXHCNJAxFQ1Ght/XzckZ8Mh9zrU8d95qms2/VyTArzuTP9RWduejIGefrJOnN47bo8sQ5ILxTXRITEipM1779/y2Z4FbeSgN2S03tm6QrdqVrkiabqDAKr8q4WD/+NykLott6CD4Jn6br9JPslVVWYkTr8EFNvouKHcsFHU7os6jtJmI84FlkG9Eok+VePqieAKwleAY4IVBBvj6VQvNGCoryuAal6pQdhc6OSeJ9UvjIdw24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0914f4c-d5b3-4ad5-9162-08d67e120cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:28:48.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements compile-time virtual to physical
mappings. These compile-time fixed mappings can be used
by earlycon, ACPI, and early ioremap for creating fixed
mappings when FIX_EARLYCON_MEM=3Dy.

To start with, we have enabled compile-time fixed
mappings for earlycon.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig              |  3 +++
 arch/riscv/include/asm/fixmap.h | 44 +++++++++++++++++++++++++++++++++
 arch/riscv/mm/init.c            | 34 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 arch/riscv/include/asm/fixmap.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index feeeaa60697c..c18bba5d0e32 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -89,6 +89,9 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
=20
+config FIX_EARLYCON_MEM
+	def_bool y
+
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
new file mode 100644
index 000000000000..57afe604b495
--- /dev/null
+++ b/arch/riscv/include/asm/fixmap.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef _ASM_RISCV_FIXMAP_H
+#define _ASM_RISCV_FIXMAP_H
+
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+/*
+ * Here we define all the compile-time 'special' virtual addresses.
+ * The point is to have a constant address at compile time, but to
+ * set the physical address only in the boot process.
+ *
+ * These 'compile-time allocated' memory buffers are page-sized. Use
+ * set_fixmap(idx,phys) to associate physical memory with fixmap indices.
+ */
+enum fixed_addresses {
+	FIX_HOLE,
+	FIX_EARLYCON_MEM_BASE,
+	__end_of_fixed_addresses
+};
+
+#define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
+#define FIXADDR_TOP		(PAGE_OFFSET)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+
+#define FIXMAP_PAGE_IO		PAGE_KERNEL
+
+#define __early_set_fixmap	__set_fixmap
+
+#define __late_set_fixmap	__set_fixmap
+#define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
+
+extern void __set_fixmap(enum fixed_addresses idx,
+			 phys_addr_t phys, pgprot_t prot);
+
+#include <asm-generic/fixmap.h>
+
+#endif /* _ASM_RISCV_FIXMAP_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f8e396dc80a4..4c627b8d53c7 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
=20
+#include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
@@ -110,8 +111,28 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __ali=
gned(PAGE_SIZE);
 #define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
 pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
 pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
=20
+pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
+
+void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t pro=
t)
+{
+	unsigned long addr =3D __fix_to_virt(idx);
+	pte_t *ptep;
+
+	BUG_ON(idx <=3D FIX_HOLE || idx >=3D __end_of_fixed_addresses);
+
+	ptep =3D &fixmap_pte[pte_index(addr)];
+
+	if (pgprot_val(prot)) {
+		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
+	} else {
+		pte_clear(&init_mm, addr, ptep);
+		local_flush_tlb_page(addr);
+	}
+}
+
 asmlinkage void __init setup_vm(void)
 {
 	extern char _start;
@@ -134,20 +155,33 @@ asmlinkage void __init setup_vm(void)
=20
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+
 		swapper_pg_dir[o] =3D
 			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
 				__pgprot(_PAGE_TABLE));
 	}
 	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
 		swapper_pmd[i] =3D pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+
+	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
+				__pgprot(_PAGE_TABLE));
+	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =3D
+		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
+				__pgprot(_PAGE_TABLE));
 #else
 	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
 		pfn_pgd(PFN_DOWN(pa), prot);
=20
 	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
 		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+
 		swapper_pg_dir[o] =3D
 			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
 	}
+
+	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
+				__pgprot(_PAGE_TABLE));
 #endif
 }
--=20
2.17.1

