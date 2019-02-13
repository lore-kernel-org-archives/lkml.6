Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F032BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8132222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LK7ZWCmj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JFYc6HsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfBMGcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:32:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24582 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfBMGcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039541; x=1581575541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ubekwtYIPFFf005R5Hzs4jmv+czpJXwjEd3zgesqrRw=;
  b=LK7ZWCmjIzcelVHVQ2xT+5Ft/TvERI9EYs5rLCUo9nXtyW6iOD+8+dFI
   eGu2PNwOjubr0pkzA0uU5IWFqqx1N8rYrAJyrWQDI4uAGV7kxX1jkXquL
   sm+UORhV0nWg433pXFP750ixj3NzLsf/eWvs2aoED1KYpc/sEF06D3gwQ
   XvaVvSjyQ7PjdjZPjtRrRbnI+pcDLqwzYWVck1fZBhBr9ciwoLYAOna63
   gHzOiFwA1p3AcOob0tTT5az1EE0aY7/rWlbJ6XSrCuWLe3myAbVW8l7PA
   xO4pZwGq0W8/OtX01C8W8f0mGXWNCmm6PB7OToh8d40Ld7iOzmPAjn7I5
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="206244733"
Received: from mail-by2nam03lp2052.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcBwDJJXFu1PqOJGPFzp6HBUM2mAFRKjvzARIRyaD18=;
 b=JFYc6HsXYXNEBl/moUVoR+J8llnlCMryjDmgpUmyRUQNwwVAxmxBcZO7D53ExPLfQr3TdeqCA5ci86KVBCaBf4dAq+kXb4d7Lcz30DJC8FjuwUILbwUM22sM2nfplcoLcqjr1tlRfyJFrIMoqPqIuvPg0gk5nzUWmgQM9So6fsM=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5628.namprd04.prod.outlook.com (20.179.51.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 06:32:20 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:32:20 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Topic: [PATCH v4 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Index: AQHUw2XecMjWZazmUk+dH5VlOX50xA==
Date:   Wed, 13 Feb 2019 06:32:20 +0000
Message-ID: <20190213063127.28703-6-anup.patel@wdc.com>
References: <20190213063127.28703-1-anup.patel@wdc.com>
In-Reply-To: <20190213063127.28703-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538d74a1-d08b-43ab-504e-08d6917d015d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5628;
x-ms-traffictypediagnostic: DM6PR04MB5628:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5628;23:L5tgIxZi1VR8CfyL5RitznuH++vYuEE7MWnUTgL?=
 =?iso-8859-1?Q?ZT91xsfkec7ZDDYGw99pPdtknnkr3PT1M9UFnyaygf0/R5f/06yWs72VJ3?=
 =?iso-8859-1?Q?oCFUPPMn+11I0tTUw8GlOiRGtlRwgyf1juEEv7BEwgEk7gp7+M97kHdv7A?=
 =?iso-8859-1?Q?FrgSq3PwPdpIj13sgud6eBUgcw0ABfDR2HuAMcLnQlL1n+NBuYy/JXLDl1?=
 =?iso-8859-1?Q?ZpsDRSVqpVWDKL8/81umGfG1MoWNCjV8ngxO++ckhMmV9kp2uXSv51ge4e?=
 =?iso-8859-1?Q?GAS+sgS283B8fHxhAYeGXmekrrIsAtKE3xgR/8bPqmajunLOTiK0AV6hpw?=
 =?iso-8859-1?Q?lNwlSAyVKI7Xh8QWMBYxh8889+ivw5wpIyTbkPZRJ75W5ozsho/QlELHRp?=
 =?iso-8859-1?Q?7jRFeXyA5fEh1/Y/5KbbcBtVOCGqsPtGZga7UO2khB7xOBQnL+G3tHf1C1?=
 =?iso-8859-1?Q?ZK3eBgqSlWGuSJ7dykW8lB0nqalL/AHgWJ80C/ucLsc3gijNKQjRN/6Z1z?=
 =?iso-8859-1?Q?JBf7a9TMYILCuhqL36QvGbuS8w5vvuYlDfy26JnWpqGyCJZGRtWmkDBZi7?=
 =?iso-8859-1?Q?v4a+IQYJc+jS2nK9IXkNgk07BficGf8ioUILBQMR63E35QkaW7YnHYp5JE?=
 =?iso-8859-1?Q?7aJhp7rVizuKdgtIVTqw9Gb4sx/sErvHziubHsXzaH8V87HtESzPK+VnxA?=
 =?iso-8859-1?Q?4sJhzSd0f9a2Q9bvR/M6ksMoql9S/D8l9Jxt1P6441vW+ooTK2yQQY/4CZ?=
 =?iso-8859-1?Q?FoR7knz9749MQUKzq8hza+D09q2Xb4QwrbKLl+xhfMqReUsFsEp6fUKTZg?=
 =?iso-8859-1?Q?Hv9YqznemOo04P9hdQAiTVAWm5G4hbEXOAhp28PhYgxzFS36LgamcEAtdC?=
 =?iso-8859-1?Q?XreWYBS6pqat80St56BsT2VgvU5VUCljrCSOiYOh9gBMol0KwzsG5t2XXW?=
 =?iso-8859-1?Q?MlCenVlt+D+UzSFibNYgFIGVDnQexfuxrU39583E3oj+cLwh553Efk+zeJ?=
 =?iso-8859-1?Q?F7JsVYooUuBJIhNNld6IOuCrdVVAwcKN4uz4cv5CoerMRWv17aQfvqhlCd?=
 =?iso-8859-1?Q?5fLH/Akp7WWJ62zbafR/jMKy6BkGwrDeK34OTDJtvtLsLlZ6FKqqanGEh3?=
 =?iso-8859-1?Q?JD64aHtdo4FUt/+ECMbBUIr+cc0nwxWyLpaIZk/D92+JuScx8oDtAIHP/S?=
 =?iso-8859-1?Q?2IBBadC5fyf5RIjyrZJnwdlTVS2cFPVJ6k2SDJuTSfuSr8MnJdHNl0s24X?=
 =?iso-8859-1?Q?OrP1uR7KbHTiH5Pn+V+K5ESP2dE9lbMcWB08OP3O5ZRSz680UBw7CzRUek?=
 =?iso-8859-1?Q?jY=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB5628C7D47B4A6958CCD489DE8D660@DM6PR04MB5628.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(14454004)(478600001)(4326008)(106356001)(97736004)(86362001)(50226002)(66066001)(102836004)(2906002)(6436002)(256004)(6512007)(105586002)(72206003)(25786009)(26005)(53936002)(6486002)(36756003)(316002)(186003)(8676002)(7736002)(81166006)(81156014)(8936002)(110136005)(54906003)(11346002)(2616005)(6116002)(71200400001)(3846002)(71190400001)(68736007)(2171002)(52116002)(76176011)(6506007)(386003)(99286004)(1076003)(305945005)(476003)(44832011)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5628;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8+dIr9jd1nTP8wmIhWxAlycNIPQ+YXuEbA8kTjTZgSvPDQ9hL3CnCr/unkdZyz3aoxx7aJud2miY2ffVF7MVbKyetjEPlZOgbkJycAAohjuTdLtU7cebdhMXshX0vYJ7k9T/15fV7VNT8PLvy9/9VGCYjvrlWcUXsLHbPu3xvmzg0RAgFRwf86er9LojxvkYXEbToiOq+q73XbDhPQFddd9AOFjE4JSsI+KDs6SBA0H22H5jG7koy5wlEH/95gyE43lUbldBUg/OgVMfeXw7eBI/E9/KMIa527f47R0VgDj2oK+8JNokC3UklZBrORW3JMYSXuMzdorRl0WoBL89/EH/RPPZx/yG385MONGsXRTMHchlK03VTwg4AIpfTtWqfwc3bwR0/wyFA0v6SJQi/KC+w2k+lxiHX4dwE5HRByI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538d74a1-d08b-43ab-504e-08d6917d015d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:32:17.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements compile-time virtual to physical mappings. These
compile-time fixed mappings can be used by earlycon, ACPI, and early
ioremap for creating fixed mappings when FIX_EARLYCON_MEM=3Dy.

To start with, we have enabled compile-time fixed mappings for earlycon.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/Kconfig              |  3 +++
 arch/riscv/include/asm/fixmap.h | 44 +++++++++++++++++++++++++++++++++
 arch/riscv/mm/init.c            | 34 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 arch/riscv/include/asm/fixmap.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3cc9687..3cfd10d35a28 100644
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
index 7ed6ae90cf6b..efcbdb9b3da3 100644
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
@@ -111,8 +112,28 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __ali=
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
@@ -135,20 +156,33 @@ asmlinkage void __init setup_vm(void)
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

