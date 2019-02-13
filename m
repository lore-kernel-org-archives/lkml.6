Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80500C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CFC222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+VCSK9b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gm8ymGkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391927AbfBMLxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:53:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18775 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391908AbfBMLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550058825; x=1581594825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KQcGW8lAHUewzSPpCVt2l3wyt8C2e+e5pUxeKnjvl8E=;
  b=I+VCSK9bV8TxBJ99oj6AFso2B2AUuY2oYjwIw9MKz/1vRayNrRngf70S
   xMiG6Ve43mLnnyDUt+2r/MTN+kldP3R9e9ZMym4VYAaK09nD+AdX+Mh+r
   18xHNjgHH+V//j5+rYP7014j+7jjKu5ONBTuO3+VT29Gfu69bL5B/qCZP
   HFZE0DVwtextqr6fp44PYj97LoX27qy+ZyfxIygfZ4nCbLJ6J9vcZroks
   ozZG3NTNaWGNpQKONS8adOXp3pn2TMkYZTy3tDfQKcUyONoRHQVVvAp2o
   Mt5I+ygxv+Di9QqeEHMqsO9u6/BqLbMtRXT7uxsBfaNzcHT4wI3Olfyax
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="106122630"
Received: from mail-by2nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 19:53:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfy9a7eQpprxHOxnGVIApyfvb1IkN/Eoi7kyg0aj3DU=;
 b=Gm8ymGkcNxlkUJzKDRBv5rgxN5j5PdjDgt/nGEmPJpf1lNHSCglRdibdyJuVoTN7q4BK5W/7fvaBfqsCfJfSpEhOQw2xn08s2BdivynXX2LTOBNxIRm26d1UB4R1lzcw+hh1jc7fgNsxeNZtth473wFOlOv0oI8xVARHxdqveNE=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB6171.namprd04.prod.outlook.com (20.178.227.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 11:53:42 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:53:42 +0000
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
Subject: [PATCH v6 3/5] RISC-V: Move setup_vm() to mm/init.c
Thread-Topic: [PATCH v6 3/5] RISC-V: Move setup_vm() to mm/init.c
Thread-Index: AQHUw5LEqZUXVUXd9EWkO2EciZPqYA==
Date:   Wed, 13 Feb 2019 11:53:42 +0000
Message-ID: <20190213115301.103989-4-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: b9cb2d7f-1d15-4967-e7cb-08d691a9e661
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB6171;
x-ms-traffictypediagnostic: DM6PR04MB6171:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB6171;23:hMp3BXTmo6atw/NvBhCZhXdbfFeK9G28jPITtpm?=
 =?iso-8859-1?Q?GMYa1LGIGcvxSbuAqyDGwI5vfFKooJHfrjBedqnlb5RGero7bdJU/D+2Gq?=
 =?iso-8859-1?Q?l25QWKLdmw8OUqxchuIaBdeArjPNK4EwrNNLO6RKKF8+LzdusSZqyRyTW0?=
 =?iso-8859-1?Q?YCQNCGyX+EVh3V6DZOmoi6TAnIrIbbay5ZITIV+mOvPc5Wa4hJWTEoP1HL?=
 =?iso-8859-1?Q?OUMysYNT+mYzke0Tqw2vRmBx1IH5LSHwadFz9l+KN3qPtA2L6435McaC0Z?=
 =?iso-8859-1?Q?lq+DuBdlcNnr919aLhGXR6ra6d53lWVXs/3wy9F14O1/0qyCnFR1iyb8eK?=
 =?iso-8859-1?Q?wTLOLV3EsJycJQr+sqgw/f3+G9yP8CeHH2zC5E7N3GqpMAtzOE4DT4Qp7m?=
 =?iso-8859-1?Q?uXU+fBg61u3TgCQfrdagN2U2jNtqKlrnZY+qbaUEsWv59KKPWDMAnxVRmG?=
 =?iso-8859-1?Q?QGSLtMk+L9S6zFw2LodFLWCa3DtZVFLTQU6zm8h71lFBA9/WKHYrqfpv+I?=
 =?iso-8859-1?Q?uWSgPV35GAFT8YrHSS7YQUSwAB2msRW+ucCrT6uJVGKpFFdefh3ijqotoh?=
 =?iso-8859-1?Q?TbODyjzNxC4psUkuVa7RJWd4YTKFmLcSFGhWrSTGjVx6sgpOCCA7xneQUL?=
 =?iso-8859-1?Q?wTSptbPQWAwd8zNtKiuvZyfPRuaOOsLzv2Mcf9UpUOZE+9kr2N3A7Z3uwE?=
 =?iso-8859-1?Q?b3mih1RAMwgKqNgSapzR06Z+VhKPT5vZ9PJtjO62cy6GLIib0PvXoKgYY9?=
 =?iso-8859-1?Q?fqHJVg8cTkzxHT869j4An2v6uVCvXHkvPood0GRXpbUDKn6cNcuw9O2ulB?=
 =?iso-8859-1?Q?VkdNiYgC1qOBVFC3a+ow4MiBwG62lIvviaEaSpgnjaulZCK5TWCNixIzfP?=
 =?iso-8859-1?Q?3x4IWNQv7gO3+BbnQF0omG4xX1f5AiKwjHx/xoDBwoeRCOL1owYb8gGQxy?=
 =?iso-8859-1?Q?z0+NnsYo6HeCn0OyqkLrD3O5k+LCsaJ0lSo42E7L3h91KVBLjjfX5FDUaJ?=
 =?iso-8859-1?Q?sL7/eL4ud4HZ8bI8bILrlrBtRG1mYhId9GJ9NoFRUNmRU/LJQz23VHxbQi?=
 =?iso-8859-1?Q?wVHlWolKTo6ruujiTnT1Xph4y0tfkuff+YA8D7BKuFIk+uBap9UZV9Opkk?=
 =?iso-8859-1?Q?HBJKLHRT15Iwc2Bu9bAJM8CC4kT0iRnZQOX3EZ45m4QXs/Sz/lhVOOibYd?=
 =?iso-8859-1?Q?1JzCSARwgiAw+2x95++/vjQxnL+/b9mzBlD7mb9g9cuDnjQXYAJ5HjMZIv?=
 =?iso-8859-1?Q?+eoru55OaDz66i3iGjH2x9RYOVU6hqe5XJTvzBUhFL9jZMZxG+OkfHJ7tS?=
 =?iso-8859-1?Q?Kb03+bE40fiMvUfyPs4xD2f?=
x-microsoft-antispam-prvs: <DM6PR04MB6171063FA996F7BB84CD97598D660@DM6PR04MB6171.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(52116002)(4326008)(66066001)(71190400001)(76176011)(316002)(8676002)(6436002)(106356001)(6486002)(6116002)(71200400001)(105586002)(3846002)(53936002)(386003)(44832011)(6506007)(6512007)(256004)(55236004)(97736004)(8936002)(54906003)(478600001)(72206003)(305945005)(26005)(102836004)(446003)(186003)(68736007)(1076003)(14454004)(81156014)(81166006)(7736002)(25786009)(99286004)(36756003)(2171002)(486006)(86362001)(11346002)(2616005)(50226002)(110136005)(476003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6171;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p3mkempJrc+2kJTsavInElWPc47QyJsLVPJ/T++PkLEuPYTbyn9wKUmkaHQAcataEq2LcJRtlmQVyVA31V6p1XXomwn5eAGqdkfufP2QSHRidlC2Z0Ubheu8UJI0GSo9pNf+5JwCtr3fWaxcnloqhBWB3uSZVj8zdd2AOBcvY1k2B3bONx0PJxFCwfk4K4ID5UiP1JKM5xLnxg3v1YM/h98DIrdWstExH49ycEBj6lXZOOZ2PQOVCUDHEIev83oJOwAlLiQq/PqiX/VvmhFg8ROB2pcEaNX/ekHDjGO+3XiWM/tq0OrX3GPLMLC7EtPryXh73RpAaS8PVWMRF4oPXiaemE0q2qiRjfdwwmx7j6LV2R81MEWq2iOb0FrYScsRMyfRw7E5e5lMAoL656GY8Sop3zMAWyJ0uyw5dtve2q4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb2d7f-1d15-4967-e7cb-08d691a9e661
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:53:39.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_vm() is responsible for setting up initial page table hence
should be placed in mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/setup.c | 49 ---------------------------------------
 arch/riscv/mm/init.c      | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 49bce6692f39..cffe0b3caba4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -69,55 +69,6 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
 }
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
index bedaf04f9c2f..358e3d5daa29 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -140,3 +140,52 @@ void __init setup_bootmem(void)
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

