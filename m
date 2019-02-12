Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A393620823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UJU+u0Ln";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="irxJEDkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfBLOAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:00:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42773 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfBLOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980033; x=1581516033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/9qqvZm9BuFaUahBO5rE9KWZFbLQhXyUVzJqiZgjWRo=;
  b=UJU+u0LnbiVlJJ0OJSzA5hFQxDMyuaRDQDhlRndiuIptz/mahH4lXmpP
   Rfy83KBWRzVI3qGhr4kN0+ZCsBcxZvUcpoTdy1JhDI6liQF6+/g5n23Lt
   3lzxNa0vCUPLs1l3EWzIjytsfulSlfaeOP+Po3dblYOStVKhhuBgCMyj4
   lUN0nqLFULInfyVqguQBvmIAszLnzmPrb867jX4EyDe73qBuzquyfJUlI
   rVdbUTm8PsJsiUcK3uYP3B0+LHo1jkJVeeH9QMdhvCQxcYi3pXwx3cxWL
   bMsMgNc4D4UEopppQs6fdLmklKFDDoPE7xL0GS+pm/aQu1WV0JHclhiM1
   A==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="102320639"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:00:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0F4pvgq60HxEKWnoc+e9Gn5WgL9ePYqiMQTmBSNiP8=;
 b=irxJEDkreoMiqZ1UWfGVA1njvyCU8WVp1wsH94sulULJEPkCe/qemhLACCk4YgHD4zGM5gtqeP0CCDvdD6hN79QPfKL4vvM98GpO+FLMXloHivNgDP6pQPmpVrPqH3/pwX9fLx3so/YWruytk6rOiNbKOYFcoXo3gruFiqUhlWc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6224.namprd04.prod.outlook.com (20.178.247.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 14:00:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:00:31 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Topic: [PATCH v3 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Index: AQHUwttQVbyPbi79K06WYpnA0PywoQ==
Date:   Tue, 12 Feb 2019 14:00:30 +0000
Message-ID: <20190212135942.105008-5-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 69d173a4-763b-43c4-fc69-08d690f2731f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6224;
x-ms-traffictypediagnostic: MN2PR04MB6224:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6224;23:bD1z6jr0MatCoyNxyOAFkgQC3IYwJ8ZXKKLSZ66?=
 =?iso-8859-1?Q?qwvoVBsKtzcjs9O7Wr5s4hBatV3giXWnKqdORBZN8cjhgPuB4tBh4R/dnQ?=
 =?iso-8859-1?Q?nCrfWMl8m+Wjoe20Y2WrL/iPkcunezFQMkrXSk1JZbaaL2Jd/IyI9fyMJ7?=
 =?iso-8859-1?Q?tcUrvKJXFMVWizsyRadyYOy5mpJ24Yn/xniOJZyfm27TRx0X5CEduRVCFz?=
 =?iso-8859-1?Q?hvRuz5QgRtfT6/PQ8LCo/q6WGZ4lxGJp/qfGfSYzl4EaSKwCNO3gs4U8Yq?=
 =?iso-8859-1?Q?6Fjf8Tgt3Wf683y1ZMT6oW3wSxebbiv3hco0o6BBvrqYsU5xsbUWYzVfn9?=
 =?iso-8859-1?Q?tLnxioG53v0oilJANBb2GsEpGptH2vrSuJLRAHZnt9DVWdoLwpQw4UqaIY?=
 =?iso-8859-1?Q?F4CpeKbdDxdqc7rtewXDLwOJqVu7WlrQk0im31YmxiTtev0YgjQCTJTj/7?=
 =?iso-8859-1?Q?1TMCPyxDqd09YvXlB8/f2vuT9S1mjd/1JBTBWuyUpqkWfxyqP5zDdVCUdg?=
 =?iso-8859-1?Q?ltWGxSRvCYreFNM9/0SICLJ1we/Miyp91mpKyTHyqijT0++X+o6coHZOYF?=
 =?iso-8859-1?Q?bUmcVp2iIc/ape451+Vc0qP2IsxpNVKoDJhyiq9Tyax8QNigo11vBLHrPw?=
 =?iso-8859-1?Q?e+L02Hbau+k4HSxQ2Kdl+ZFPvv+tal4euovzR5+if/dYO9f7f+c8vO8IgT?=
 =?iso-8859-1?Q?Gq3EV+GB2NdHKgO+DlmkCROOgrbQVth5Qytzb/DfIeamRypJ141IqFN26p?=
 =?iso-8859-1?Q?3iNZAZf6vbApwWm0qD9kdqRLw2NOeyzXcDbtpoojdgpxlswr+pDkdrdgMF?=
 =?iso-8859-1?Q?/rmYs3TL6HpsYCcfKV3AW6Ip4vjthaO7+O/5AM15/HK7w5mCRkQynYZ/dX?=
 =?iso-8859-1?Q?thvu6vs370UUwLoSM3KzcE//s/Y4aVcD3h70PAkV2Lv4q/hNdGArtp8jAU?=
 =?iso-8859-1?Q?xNJ/ttUFAVW0012gm62UKTpgunU9BpRx0f++UYxC7FBnrzpfVgroIeHDMn?=
 =?iso-8859-1?Q?rfb/xmy4g/N6QkwvjzqVllWfXfTbhOrO/77UaUdv9I7U6pb9kr9Zj3MTSl?=
 =?iso-8859-1?Q?p+jVImo047Gcs8JTNcvfOsxgdsPPeSG3gDbHeMU1eMUcyCfaafVtmxqSeS?=
 =?iso-8859-1?Q?oBSf3Wv8VDGZNEYDsdDT25tRC+MTuEVrobJlBQ9vuYK9Zp/OwuwIqSU7N6?=
 =?iso-8859-1?Q?/x0eKuzGZhHnKBiR8MIxDzquVIXYtYqqW3jRKHLdC6kbpcrz4LobJjQzmQ?=
 =?iso-8859-1?Q?WwfxPLeKMR68RiTCW7yqI+TdK2bmsTFVWd1RFXppfgF98N7fWpd/p7I95b?=
 =?iso-8859-1?Q?jZW/9S00I7I7in7Xt6QntkR?=
x-microsoft-antispam-prvs: <MN2PR04MB6224AC348035676E05611D348D650@MN2PR04MB6224.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(11346002)(25786009)(2616005)(72206003)(486006)(2171002)(478600001)(4326008)(446003)(14454004)(6512007)(476003)(52116002)(36756003)(110136005)(97736004)(3846002)(6116002)(8936002)(50226002)(76176011)(54906003)(99286004)(7736002)(256004)(106356001)(316002)(81166006)(105586002)(68736007)(186003)(8676002)(44832011)(1076003)(6486002)(6436002)(86362001)(66066001)(53936002)(2906002)(305945005)(55236004)(386003)(71200400001)(102836004)(6506007)(71190400001)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6224;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pKKXRZr34twV7Kh87BLcJ4WhxsrdStFAmA1BoRLsfURuewQTtgSgmG+pl0w7X7FlrC30vY3b7tHg7hPGy1gcw10HxXICQqW51rdYEhDWhgP1vrKJq5kbRrZs7VcX3nZbW5LMBhV7bTC3LE9lIOaR5MQPUSz+JSjvHE4/Be5scC2gF2H4v5IKGuTORsxWjMURpbM9IXBR8xTlJpBQrt0k8xQ4iPuuaFEM2cEjKa/O8Q12wG/c72iwuLO4m6Wpp2XcqICw9fRWBnKwepqm6uIzys15xaTqW0JMSUlHLJdxebSiwsDhmGwyEoNUmN+hMQogDhhJBVygjYMN8EeXw9OKpTorukQYojNSCrcKR1H41s3eAKPiWkvtNR023fKoEKRgXC7ndebo3I7YGhSE/D09g6nytTuN2f3bqqjOPl2Bgk0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d173a4-763b-43c4-fc69-08d690f2731f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:00:28.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_vm() is responsible for setting up initial page table hence
should be placed in mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/setup.c | 49 ---------------------------------------
 arch/riscv/mm/init.c      | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ab29a66a17fc..9cd583b6d1cd 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -102,55 +102,6 @@ void free_initrd_mem(unsigned long start, unsigned lon=
g end)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
=20
-pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
-pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
-pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-#endif
-
-asmlinkage void __init setup_vm(void)
-{
-	extern char _start;
-	uintptr_t i;
-	uintptr_t pa =3D (uintptr_t) &_start;
-	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
-
-	va_pa_offset =3D PAGE_OFFSET - pa;
-	pfn_base =3D PFN_DOWN(pa);
-
-	/* Sanity check alignment and size */
-	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) !=3D 0);
-	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
-			__pgprot(_PAGE_TABLE));
-	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(pa), prot);
-
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
-				__pgprot(_PAGE_TABLE));
-	}
-	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
-		swapper_pmd[i] =3D pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
-#else
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
-		pfn_pgd(PFN_DOWN(pa), prot);
-
-	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
-		swapper_pg_dir[o] =3D
-			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
-	}
-#endif
-}
-
 void __init parse_dtb(unsigned int hartid, void *dtb)
 {
 	if (!early_init_dt_scan(__va(dtb)))
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a57dba8ac9e7..7ed6ae90cf6b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -103,3 +103,52 @@ void __init setup_bootmem(void)
 				  &memblock.memory, 0);
 	}
 }
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
+pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned=
_bss;
+pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+#endif
+
+asmlinkage void __init setup_vm(void)
+{
+	extern char _start;
+	uintptr_t i;
+	uintptr_t pa =3D (uintptr_t) &_start;
+	pgprot_t prot =3D __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+
+	va_pa_offset =3D PAGE_OFFSET - pa;
+	pfn_base =3D PFN_DOWN(pa);
+
+	/* Sanity check alignment and size */
+	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) !=3D 0);
+	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) !=3D 0);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
+			__pgprot(_PAGE_TABLE));
+	trampoline_pmd[0] =3D pfn_pmd(PFN_DOWN(pa), prot);
+
+	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =3D
+			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
+				__pgprot(_PAGE_TABLE));
+	}
+	for (i =3D 0; i < ARRAY_SIZE(swapper_pmd); i++)
+		swapper_pmd[i] =3D pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+#else
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =3D
+		pfn_pgd(PFN_DOWN(pa), prot);
+
+	for (i =3D 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		size_t o =3D (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =3D
+			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
+	}
+#endif
+}
--=20
2.17.1

