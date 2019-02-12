Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50BAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AD020823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aqpUxZd5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZJdhWsAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfBLOAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:00:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62992 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBLOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980038; x=1581516038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xccl57cIX77WtD5DIeAQVkFd6c+IU3UU/eqrtt4emLM=;
  b=aqpUxZd590Zgnh0Q1OcqIN8qpP/6Px1prse3NYvXZIOhk66DXQvSyCZt
   N6AVhckUiPX4BZZQTHz8JdBU3AQUZRdRXEuCZSGXWL2s0hQNVmN6engsV
   8QWRIgHhwKcUX2wXXGIkvf4mhdHZNW7e0eWDBb+Hvhd6SNvoI9pmPCshV
   RI8Nm0yViKSf8OhClzPihS8Ncaw9Qkidqt5R4gIYO9Ifl0FmvfBpC1XZS
   D1plNNJDTWbl21cCWuQDkQegxGx6t8xeUq71w1ZvG/sHwT+NS9Wj0s39b
   NVhj31I0eidpF9fLLoQua0Xk71VaNiPMvnERIMkp5v7n/KK4J6HcZXTD3
   g==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="101010271"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:00:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ/M4jfIAscto9mHJTz64lIL4phbcm1TMzKkZbX0JdA=;
 b=ZJdhWsAYh9pmgXIA9Hc5NxiBLAA1QO4vayrFv7Nc0sex61gHpcrK+6KINDA/DWmd5FHx1t0Y5F2SsmDhRjgEQ6jgINROEkMAl9JsNy6JhwcifgDzqnkkvnlfu9qOAP3eKhckxihxXR3VSpZC86mp3jpZtJATlxnqS1T7CgL27rw=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6224.namprd04.prod.outlook.com (20.178.247.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 14:00:35 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:00:35 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Topic: [PATCH v3 5/6] RISC-V: Implement compile-time fixed mappings
Thread-Index: AQHUwttTcPkGKpkMaUyP3qv9nTzjtQ==
Date:   Tue, 12 Feb 2019 14:00:35 +0000
Message-ID: <20190212135942.105008-6-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: b8e4a2a9-42de-4fc7-2322-08d690f275cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6224;
x-ms-traffictypediagnostic: MN2PR04MB6224:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6224;23:OQNh6AbPKD0qb+Uvp1IJeaYqoBk1VF8NhElItiG?=
 =?iso-8859-1?Q?eVoOuehGQAa4QJ2ywduwZANkneusIU0ThEDBHpMgHwMUgXlXQFMUXpqjKS?=
 =?iso-8859-1?Q?faqdWzXfr2KB9otZuryqPW1GlFjvnAYPJRohmrNz2Zj2D7OXabJlNKE60Z?=
 =?iso-8859-1?Q?DGsWNcP1aqtupXjgHQdSC1HEYFjeAegz2ODFrl4VCQbgVYljmTGwiwCMfI?=
 =?iso-8859-1?Q?vt8nk5eNL0Bx3fN4KJLdpfrLNV/ljabRGBvlLpfaY6tknfI0ktCOFTeHez?=
 =?iso-8859-1?Q?ZvfiEuHFmCFHAZy99OlC64W9Ot7U50FDG2GYhbUmPQqX4xkR+7hwiLtRp2?=
 =?iso-8859-1?Q?3KdGU6lbnJn7TGphXvYpqmF/DnC7hT696R3d4YRpD3VJTmdXfJs3Z7MDh3?=
 =?iso-8859-1?Q?3hWA6X7egt1e0bgjiD3TrLbLCSbjHBd1078pASK3KhzjSqAyMU8/hjVTg0?=
 =?iso-8859-1?Q?69tOCXt+RdppZxC4Hfn+l6m5Kl6W+SKcVhM/sv/rS7bf7hb+hP2vZq7FXL?=
 =?iso-8859-1?Q?h4gUGDscn3u+DsTYo65o772sPSSXbmf9wtwvpeARLEmKjDbTLQfroKzEXa?=
 =?iso-8859-1?Q?nn4XFSsQAzvcG0u53mXBKjYU8zEgAw1GzgRopOkQVJySS2d1kd7d36xM1d?=
 =?iso-8859-1?Q?0ICEnmmDuf1sVygpiWdQhWh5g5JbKnQn1oBJdZ+VnfDFXvBY137qmEjVhj?=
 =?iso-8859-1?Q?07CCC29PTFa1AiVxxBSKIT8H6giNPu0ulalpxtiQF1SoirsJrA4fBvI7KW?=
 =?iso-8859-1?Q?Gmqht51EspOZeazcURxQNTDMxfP6PfIRs6c8oBPZPL3IdUUAwOqkUDsQGv?=
 =?iso-8859-1?Q?u5kmi2P0o2dMGK1AKZJKxxrDyKMc2I+3/lmDiaWGAGqeDZr9cVGHcY888O?=
 =?iso-8859-1?Q?meerSJ+xrqYGrQG3PZe/euVfH8pqSgip2yhDJlyx0sWBZ7E+0DSe3qb5d5?=
 =?iso-8859-1?Q?jlTlevOSGey0hyJ8ppKzKOAWo5lAOAkEuzxXutMb3cKfLXaJmm7RE4yQbp?=
 =?iso-8859-1?Q?jCTFgPnLgJhV8wDHw0D2/zLtJMSm2nQTU+ZtJK7BxVhd7cIMEUxH/pLeez?=
 =?iso-8859-1?Q?vcSE1V5/AdAHInpRVYdZv44s2/cKWWBYQU+ej7Hso+WY4yiynzjcmdf74n?=
 =?iso-8859-1?Q?6VIgeDenj4MBjbetOc7/Y8vtX3jY8LtPp58/gMIH1v509XLofF5nAmVmeA?=
 =?iso-8859-1?Q?nr4LA7hMV/D7O7Sbnm3NugZt0C0hen4McLjA0/hE+AIPSQDhH6kedqAIZM?=
 =?iso-8859-1?Q?J0qzR5kRdeDILXg41Y4hrh1pBM4fmEV3vLpIzYHVamHf/+ZS1FdUjGYetP?=
 =?iso-8859-1?Q?1xvFn0wWJQTFONss1PGvf3O?=
x-microsoft-antispam-prvs: <MN2PR04MB62243E04AFD9742F6028B0D38D650@MN2PR04MB6224.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(11346002)(25786009)(2616005)(72206003)(486006)(2171002)(478600001)(4326008)(446003)(14454004)(6512007)(476003)(52116002)(36756003)(110136005)(97736004)(3846002)(6116002)(8936002)(50226002)(76176011)(54906003)(99286004)(7736002)(256004)(106356001)(316002)(81166006)(105586002)(68736007)(186003)(8676002)(44832011)(1076003)(6486002)(6436002)(86362001)(66066001)(53936002)(2906002)(305945005)(55236004)(386003)(71200400001)(102836004)(6506007)(71190400001)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6224;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ODlg2tTpa2kb1jbL4Yc3bZxnrDziLlQaAFu0YetvZEqb3TKPZn/Rxmp6roPayFPua6HxtBBgA0cBnD9YoyCaMhB3/j44fT5YKCeo8PUV0jZlgwLh3FYpPthlp3rXyOV+clTG7OB2q463xt25oO6+m9IUOBkGfHbNdjXg3xfkSAH5XSzd+nWhf8rnHtz5aage+4L7P+JMut1u4HYad6nZ7/JPxzo3bqgxeBQPFvOKRcM0zt1IQaJikL5uzsRljqAUWtpaKvZ4t/NvTs2w4K/lwMMOVxrJkOCxFiPyTsMpv7Olrde5bhl6oJFR/fygvCFvVAJr+j0cy6zLCbIuV1GQcoT7Qsqwbp5Ha0fLyJNvzUrgNAymLHTp9u0O99iCgRy7ESB/gpcm68nNr21H0pKcNElbuaRl70R+my72/5WkT7o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e4a2a9-42de-4fc7-2322-08d690f275cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:00:32.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6224
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

