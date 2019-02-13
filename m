Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C855C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DA4222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j/7p+WZJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EZ1irKMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391955AbfBMLxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:53:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:65250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391942AbfBMLxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550058829; x=1581594829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MXwtB/6kdzvkLSnmhvP1yQ8F2Bym4aV17HddVT2C4do=;
  b=j/7p+WZJoUIuGeLtJNWKwZ6fCACpsaqLaIkqSKBI4Uxj6/9QPrGMbjsd
   zWVJqWRFJxyPypHTsPgQhjQR8HYLhlErkTaSZqzwkV9tS74zttHnbVA58
   YcSqEXVb73BIlzC+fb/ZApT9DmWCpZAO7RTszlj6j4nzAj4chyK1Q/Wcy
   f0qbojyYybokKMqdYyXbcWmqBtMoWKe468ZDeUGb60D5MYMynm/8Sb8fN
   MSpzv1N0xPKUyTI+bycBxo0G1iat+yskD+x0caKXmtJw2UKOx0Ug+5zFM
   RBU3MLwT1gHih0Esf2srrW0mk2WaHmhreaQA5n3V2JalGaeJ+d31G2zQT
   w==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102883457"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 19:53:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIDgpony2OOpbAJB9j4n/tkKHKAtaD6tZ2pRyXqkoyc=;
 b=EZ1irKMpPx/FZ6cVPpB3DBRTpBRpNcgowqfOESpYOPMIBqGFw+utnuQCamJA25+obwjCsIC7EbOB3eSMLGq0bWDgf33uuLNls8OwzwuJtugDZWUN8VE3Ow+C7zmbtqhDpD31oDFyuoF1WKhUmoFkBkbEAuj3V9WaQ+diwkpDMTA=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB6171.namprd04.prod.outlook.com (20.178.227.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 11:53:47 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:53:47 +0000
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
Subject: [PATCH v6 4/5] RISC-V: Implement compile-time fixed mappings
Thread-Topic: [PATCH v6 4/5] RISC-V: Implement compile-time fixed mappings
Thread-Index: AQHUw5LHaJ/8dfuWWUGPZC+DaMx2xg==
Date:   Wed, 13 Feb 2019 11:53:47 +0000
Message-ID: <20190213115301.103989-5-anup.patel@wdc.com>
References: <20190213115301.103989-1-anup.patel@wdc.com>
In-Reply-To: <20190213115301.103989-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::17) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e042ee8e-b44f-498c-5359-08d691a9e930
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB6171;
x-ms-traffictypediagnostic: DM6PR04MB6171:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB6171;23:WZbrdD7JAvcoQJhqGDEM30FanJ4dJkCKa4Sb7XR?=
 =?iso-8859-1?Q?Kk5sFFronD3k0uRD7nt2jtXh78A9MVhiJMwcQZbY+oia/0OmPquTJiaUDM?=
 =?iso-8859-1?Q?YZ3cbYO8uLh/CD8hrjkz11DutMLMBQHNdG24Km2fDCLMzUVpc5/lRgkFmx?=
 =?iso-8859-1?Q?cZ59YRrBhWeYMznu63nzvlCskrpOL6AHlcbhiVWUIbKTUFIyLHCvNFlhA8?=
 =?iso-8859-1?Q?wsOtLdmMpX/cy0Fs4szDlRl2BnpUgEwRcEPLdclXqNkyOXfqCjHlxCqmRv?=
 =?iso-8859-1?Q?KugW4zQna6knbyeyfbh4A+LZVR3XP7XYIndPvZjigf1KC2wweVqu9v/Fmz?=
 =?iso-8859-1?Q?lORxwR00YOHW5i9iUiMpETVI9zn0WgfET7q2dCGBSAgcZxdZpjZmgIZRlM?=
 =?iso-8859-1?Q?55m6e8hzaAqwzhhHfCFkrw0J0WYi/GMXqfzFvVL8q21PmW3O3zP0695a6G?=
 =?iso-8859-1?Q?WlSPP7CegVEHq6lLGqUH7N1ujG1rmt42Zgqrg7c6tWpoSeFEJLp5UAsbDc?=
 =?iso-8859-1?Q?EKPuDeiPZnS0UdP8iyeIOd3QN/cyt8YHLsuYf96FoX69M3GDIZPcJb73MP?=
 =?iso-8859-1?Q?8vS7YhM6w5BJMw2weclKOMjTNFDZYCycgc2Ut6a8QJyi6LgYYdD+IwJP1k?=
 =?iso-8859-1?Q?5rna5reeg9TeKVnIg1GS3RGSrGDpEWJhMpZd8/+cHtbDi0kFp0pKHe0tU+?=
 =?iso-8859-1?Q?vS8AahkO5dEjwcIf3AOi2VS/VHA22PjFQVODWSojMw9dbud1lkzo98k/Yv?=
 =?iso-8859-1?Q?Xd+ggy3gzQQ1ijHrabJ6414Rkrg+EHD8fH8LIZNzF9cTPSl9lupnrzenlV?=
 =?iso-8859-1?Q?VxIIS/ve8i1+NMhhyu7VxShPlL8U2RmwYHceG+ngYRPGpRkZhDphc1aiV7?=
 =?iso-8859-1?Q?VgeAqqPw+h35nkOzvOSGWHMLWOHjCeTG3GKe4tinQgjk3DMvURuN4vyOB4?=
 =?iso-8859-1?Q?QjpPtg/ZY0ArN8qBtsxbpX+hlZLeDyBBhxaqkgdDUVPn9VbZITCxJGPMTI?=
 =?iso-8859-1?Q?ZjDCQLDeS4igT7OuzelPY6NNj2/TPuqutMEMtmFYvX8PQBiPsPMYeM7Dqa?=
 =?iso-8859-1?Q?KTHKQIzUkj77OlGspOTbdvw4lI6CkeGDfEHvfyQgYzNWAxvTA8Nn0IchO8?=
 =?iso-8859-1?Q?7ATDRQIBdwNEwffEq0IKn8+Y0V2bSpKh8jtcQeMlsjM95x4j/ikjHHtT0c?=
 =?iso-8859-1?Q?Q4W9+Y7262ENMcHTwsO2CvP4PinjlLywg5p2KnxUeyJfURNfFNmbOTGWpQ?=
 =?iso-8859-1?Q?wCI5fzC8QDfrYN8a91WC8V+eNssujhtgZxaD805831u7e2a7xmIRp7LUFe?=
 =?iso-8859-1?Q?RexN1dKgAjcaNpcGhIDP0zf?=
x-microsoft-antispam-prvs: <DM6PR04MB61716803BBBA45A783A61B358D660@DM6PR04MB6171.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(52116002)(4326008)(66066001)(71190400001)(76176011)(316002)(8676002)(6436002)(106356001)(6486002)(6116002)(71200400001)(105586002)(3846002)(53936002)(386003)(44832011)(6506007)(6512007)(256004)(55236004)(97736004)(8936002)(54906003)(478600001)(72206003)(305945005)(26005)(102836004)(446003)(186003)(68736007)(1076003)(14454004)(81156014)(81166006)(7736002)(25786009)(99286004)(36756003)(2171002)(486006)(86362001)(11346002)(2616005)(50226002)(110136005)(476003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6171;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vy5gV24SqEUxiMooA/1zuCqd3qxfH17z2EOwnjB7MmapFJmb6PhFzBcf8Q86UrkTcalWTQp0FTb832LDD0LttZ3M4p0zNYAx0XadoNJ/0kdRNrMbHUOAWuMp+uy5vyO0qJU4+k3JTHoco+f8ZqkXg6sAEyN43OsGD5Dq9KTMgWnWdJ25euU68DDtY2BkQpp+2Zq2cv8ReP/703y25LhCYoHeervf/9b1EaCMy+F8X0WKYhUa6qo5lzRF8IMrBGcc6OX2XyrVyzx7taZqcxtq5YmwT4XWzbDKk9uCwYIUwZYSAZ8ACCVvAgemdf5N3ROCpwGC7KoFSXywxx4j9hOBBQSZgYCX4X1n0gooZOcXlm9/XWPFG1Dw3xmQpPJg0+WkCdM0LUeExm/Lgk53YEC0CyQ/UkCheSxKJzp9z9Aq5m8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e042ee8e-b44f-498c-5359-08d691a9e930
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:53:43.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6171
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
index 358e3d5daa29..b1167a6f5a92 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -19,6 +19,7 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
=20
+#include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
@@ -148,8 +149,28 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __ali=
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
@@ -172,20 +193,33 @@ asmlinkage void __init setup_vm(void)
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

