Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E89C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A97222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o8POxGFY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZQdsTTYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfBMGcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:32:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24582 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfBMGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039537; x=1581575537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7AOlzjSj/WH9jMA4KAlBpIw3dgu/3amnrTdBqVuJ7o4=;
  b=o8POxGFYFexiw01ssQtta0eKnbTgiJQsEY4ofhJMJV51Jo/p/SpQNPWX
   UDEeEg+TZIq7LRLk0YwmEt6oRTdEDHglxOiMM2Slu539otnGNdXVKcxmJ
   YwSpk7in/RUS1XZTlJ+qnToOcZmInJ89dC4Jb2fUX0LaZHRPtrQFmHPJ8
   Hl+JABjK7bTdH81yvPBw5BMJ9QVBjim67G4JBcythVWwYOD0FbbJYLrVg
   jOJggMCBI+48c7avCG1LLXzVeZGHL8h5HufiN43OkNE2UzkSvGqxqwu7q
   12Te1EuOu66pH3BVZFJZZBklhfI38TzH5Cpx4VSmdO0e/AXE2IPtv+eEs
   w==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="206244724"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJY7sWbcAVPre4asLkQ/uKfSKIpiTlgqnZgh0KYFeFE=;
 b=ZQdsTTYcbpj7fOnE/WJMpE0QQynJAqo5xMIoHJl3prcE3f4EQWNUPAY2NmsiNk6KljuW+YzENcVmnZRwe7zL/C+QBKeDAkIpfSOoHbVWfo5MQt+W9lQvEdnp43a7/DOCawBsX2/ClrEyzWq/kcdLvb+xgIKY6DloVWkvPYEBz/A=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5628.namprd04.prod.outlook.com (20.179.51.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 06:32:15 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:32:15 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Topic: [PATCH v4 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Index: AQHUw2XcDqJ7FZsjdUi9mP3ngbpFlg==
Date:   Wed, 13 Feb 2019 06:32:15 +0000
Message-ID: <20190213063127.28703-5-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: cec771fe-7800-487e-244c-08d6917cfec8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5628;
x-ms-traffictypediagnostic: DM6PR04MB5628:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5628;23:Q0n3F3Ns7FXXTvdCDLS85Jy9y3kBLF9yFpVr72p?=
 =?iso-8859-1?Q?RXR+KLowKg+mZlHLxJBr0nNXMLuJ2IjsLkYlgf+BO1d16pZNVGFRicyEuV?=
 =?iso-8859-1?Q?gRD2O0jCD4zqMXH1UZIaJz4ysntPzcGqrIIKgfQ7YhGlYIB3E6arbroazw?=
 =?iso-8859-1?Q?7Tw1phqeuzBzMW2jAyMunVCchOyugiTpND//sjs335hfpa1x5f79B1e5WP?=
 =?iso-8859-1?Q?rAhIJB8rmyXn55SJ+0X3fnDisTXXHKLPWXYpSSNrTDHDRn1miLJmFujBIZ?=
 =?iso-8859-1?Q?er6c0MPm4fsbdPLY/KMcU1JRsyeXQSk9DtCBzX9lksPOE6aiNpWwkMF7kM?=
 =?iso-8859-1?Q?kfJwCqtEEY0di155/1gzf5zGn/KIKLX6d9qDQrINgqgS6dyHsuIEbeG527?=
 =?iso-8859-1?Q?nkkAhVaNttsYl3znjDHHi0Cn8do5rLqsNYbQ4WF9jOPmI2PnOPw4fyRfl0?=
 =?iso-8859-1?Q?CYw7OD2ot2A+c/lBDsk2AVVPFFYDd1YU7uqHoVKdh0ZQEZhkfn+jb2+SvQ?=
 =?iso-8859-1?Q?Yqza5AB78fwXrecil3O5fZVmCgLmgkRKjl58xVGLmAP55xwTgU6ocRxRRc?=
 =?iso-8859-1?Q?FQplqmXAdkzqMbwWgIRb2Z54pw/ANlvYeccA2qwJQG/SHe7uipL5pnw8K+?=
 =?iso-8859-1?Q?VyKxU3dJmmn+bbbuIgt66phMlUSuBqU8s1IeDxswPUN+pt3QpxTOcm3kJz?=
 =?iso-8859-1?Q?EwcqdnUAAF6vY/ogeinei77Xvjd3S3kT0KxWpD4mNd89K6rU0sbTqxKBxl?=
 =?iso-8859-1?Q?KWsLUmUM3vc4I/NLeEZn/snzw6K0nowGVLYM7KdNj0LTUbc3PCdbJOTisa?=
 =?iso-8859-1?Q?+mDQgpbS8Nn0jG5kUYhm7vND2AP4614m13WBOBR4MbX21G+YMJoeJZpzDn?=
 =?iso-8859-1?Q?bv5FAE4YDtzsE0ORf+1IqyPzy1H8gEApxVlObWhw23PlwfMtQhozHcB5s9?=
 =?iso-8859-1?Q?FQsvo5F30lG+kjnah7fyWlJ1imNgsMfXRnq6NlcoLrY4J9K1G+2oJvPNV5?=
 =?iso-8859-1?Q?h87/0EMgt36TgiHPQs7dA4wXYIaBPxwsavIuz87NffkX8Qp3tG1G+R9pxg?=
 =?iso-8859-1?Q?ZsDize4AdNlLY2Eu2GNfjvw+AooiaEDjuIaH8UOb8PKPD8+39dPuRgVzRw?=
 =?iso-8859-1?Q?yY1Rbn6btj8wOAKWNFiYh/6fnOTBssPZNB05WzHnRTaM9Fsx5r42kM91Dx?=
 =?iso-8859-1?Q?eXtqnj993kxyBU+iHJgjG6rUVpyqw7hLQZ2fa00K8jmzbmAaAGmuybqBq/?=
 =?iso-8859-1?Q?6rw7YSnen/vl2cpvmkGoZL1G03QeR0aJbI3ltrYSGJI4z4c7tcrJdydfo6?=
 =?iso-8859-1?Q?VQ=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB56286486613AC6A1195216F58D660@DM6PR04MB5628.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(14454004)(478600001)(4326008)(106356001)(97736004)(86362001)(50226002)(66066001)(102836004)(2906002)(6436002)(256004)(6512007)(105586002)(72206003)(25786009)(26005)(53936002)(6486002)(36756003)(316002)(186003)(8676002)(7736002)(81166006)(81156014)(8936002)(110136005)(54906003)(11346002)(2616005)(6116002)(71200400001)(3846002)(71190400001)(68736007)(2171002)(52116002)(76176011)(6506007)(386003)(99286004)(1076003)(305945005)(476003)(44832011)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5628;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s4CciL6aitM+8GTm3MGsU/LcXMrp89YSZffXLgTS7jErRxkaVny4Egbwd/5XUn/PK3mto6Oi445sDDPbmJ6ESc+m0QTOsbRo72G7NmAgGXpI19KfIUrf5Iytgt6mubvdlDmUkeKNik8NYMUA6EhZ06YjzfyM6B7DWXdFj9q+1kE3Xb0uFO51+x7k5gqOfCd6RKgmfFEsu8Jzc2yray/ZzCHFbm43CIq2s/NDxPwPs1c8g7BaOh9qgBg9N55fKuzzmVH6udJipZR7ohP8MDV68vbmdcyfWq3uNgAWdFLYx2lNQ5kDh7Wsmxvq4znIBjy1qZybwkowEW3KJr8cPCMAIzPFguOkiCOSaj7qkACllcQWJdFfu6+J/7eM/gcjZFxb+zg4l82Mk5ntKbL/tiEuKyB9Iict6yI2ajmnxFL/XWU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec771fe-7800-487e-244c-08d6917cfec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:32:12.5674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5628
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

