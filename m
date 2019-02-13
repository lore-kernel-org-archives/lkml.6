Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB909C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20FE222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NOZ4yRIW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YJGYaa6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbfBMIHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26120 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390359AbfBMIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550045262; x=1581581262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7AOlzjSj/WH9jMA4KAlBpIw3dgu/3amnrTdBqVuJ7o4=;
  b=NOZ4yRIWeQiLTBUIWQCCZqo45KzBJV86h15Exy2q4k97nR9vGRZz4ps6
   dpv/SpcsqZQmsv8XFs4FKD5XyBW29DVdX0PP5pBvzN/Mz58stcvExI7JO
   kyVyE1mE7aKLFC2z6IXAk0d32A6dpxx7lX8NV2hC011yA91T1vJSz7IYC
   ksBGbEncpJyBCOIIanO3GPj36bOHy2TMmHgWTpqqFt0EYYL1gKHccXD5H
   FYFwIFzCk8sMZbtPnBHbcab3WKklV82yatsmq/eKtx6BrG1sknjjw5rKG
   wmBdCRx3EWEHDGUrDZT7pF3IQ3PHI2e8z/iOFvrIlsLSS2F6UHHkgf2PN
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102402329"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 16:07:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJY7sWbcAVPre4asLkQ/uKfSKIpiTlgqnZgh0KYFeFE=;
 b=YJGYaa6TlTowI9yfcAtbfdwFtKL5rhQPslkyqiHy68fSQgaFnh28bVL+a8zy0iUxOa0C2oBQV3fO2invqO7aRl3D/F9XzXjOaf/SmhKoBFaBd3hYUe+eZb97iTsaFhU1fOpUnLeGTwc+BMPVV2SBe3IryuFmv9uZAhNZAkN0D20=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5993.namprd04.prod.outlook.com (20.178.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:07:39 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:07:39 +0000
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
Subject: [PATCH v5 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Topic: [PATCH v5 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Index: AQHUw3MviTRH367Kt0WCzQchbikLcg==
Date:   Wed, 13 Feb 2019 08:07:39 +0000
Message-ID: <20190213080647.68204-5-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 2dfdeb91-9e28-4e61-a861-08d6918a5255
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5993;
x-ms-traffictypediagnostic: DM6PR04MB5993:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5993;23:1HGuRLC6eUbQ4Lw3q+pTtZWoeDZIEDDIb1kLKfb?=
 =?iso-8859-1?Q?WgRDnku7QR8UrCEnU6/NewbW3DN3CPJeRBrQbid4OvSh82on3suvCgAhhk?=
 =?iso-8859-1?Q?WNNe74izchMqa4nHFM0Qd70skwLG8Mg8lcG1W7egRGSrGvMtHpa23sS1XL?=
 =?iso-8859-1?Q?1PAvYv9lj30AS2Rs/veofZWNHCO1JRFt+hHuWmNhSEnKSkXdcSw18GpaUI?=
 =?iso-8859-1?Q?fAAoGReSbqDW7zvHVm8jVNU8NcOyRVb8yRdfxkJk5+R/vCeJz4NjMrazHp?=
 =?iso-8859-1?Q?li7MRN+8IB8KZ336GO6zc8aS29Jdm8CvdEnaj8z+oKEjZ2g6o/5G12Nyi8?=
 =?iso-8859-1?Q?PCBqCsdz6s5OcHdbImIjDdTvAXltacVDFCLmMn/KbFOfTLvypOei5FpOgA?=
 =?iso-8859-1?Q?5Rezy3OL3/P0i5RD7FVyWyr3oAlUZE+rfUbgXsl9RDKXBFkRDq3h+FGkue?=
 =?iso-8859-1?Q?kBoW61fy5qAY7qfkS80POpmiuuo8CQGUJUxS32S2SpEDc4bnXwr1BQVHlf?=
 =?iso-8859-1?Q?WrDRBhyMbcGxfP2mq2Jj7aYtKJ3qTaYryjT+4Bng/KQf1uUfsspNW8m6P7?=
 =?iso-8859-1?Q?jzv4VQ3kqmU4IkAokemMhbyFflIf4IqrZlqlC+nLD3DC6Hr2vjUa0LSmR/?=
 =?iso-8859-1?Q?x2HbhzmWR4hAQL8OPCxCSM+ODu/+Fxrn5H4gkIbEZU8CbdwguCWQXHKUZG?=
 =?iso-8859-1?Q?rPufuIehEkPHvPlwMGwHMnQNS3wK2en4dFJ5vqXn/s0YHFM+LFYu1gCH3A?=
 =?iso-8859-1?Q?uMLfMRAvtsHszYBtpk7QA68PTdrwzKX9nJznuCG0AKy5Sjo3jCIVkCmyk6?=
 =?iso-8859-1?Q?DgPc+qHVaz7W2bY2eNerRMNfauKRTttnHN22mZpiIHTFT08BVm8mgPGNn3?=
 =?iso-8859-1?Q?kqOVSMWVB1bF5kyoLQLbz87C+gy9Ga/NNbSmPEj9M66mttDm/JU8gA0hI8?=
 =?iso-8859-1?Q?ZY/oL9e794/q4fYaAraYMFCYhOHcMOB/Abznq+tHb7osmqRojEBhY+jT+G?=
 =?iso-8859-1?Q?diFw6QpQyXUaSfiW40/BdiH5hRqT7ptIkYg9H0a9a/Hn1013R4jG03AxoA?=
 =?iso-8859-1?Q?2/Fsv6dd41XvIyvUINM9U1EQctAJ2+88hRYenxF72pTzqZIxT2h/EJenKl?=
 =?iso-8859-1?Q?jenM/O3Q8G2/RgiQi78C6oAjqen4ZvckOWQ3H7q//3vzSwRUc3GM9eco6L?=
 =?iso-8859-1?Q?LwU/GuCbTkkKTEj/AHnuxdR8p7pcn/WDlNf1tBaGj0aQEEPhuhd3H/I8WT?=
 =?iso-8859-1?Q?5TSBr50QtxgAHdnm+UETAqhRbqlq6Wwt2/odZYZAKKLq6RfJzuF8GxLt8y?=
 =?iso-8859-1?Q?Zk=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB5993FEE995D1FD726A53D39F8D660@DM6PR04MB5993.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6512007)(99286004)(53936002)(50226002)(386003)(6116002)(52116002)(105586002)(3846002)(106356001)(76176011)(110136005)(6506007)(25786009)(256004)(54906003)(86362001)(6436002)(316002)(2171002)(36756003)(6486002)(97736004)(4326008)(81166006)(66066001)(8676002)(68736007)(102836004)(72206003)(476003)(2906002)(11346002)(446003)(81156014)(1076003)(14454004)(71200400001)(71190400001)(8936002)(7736002)(305945005)(26005)(186003)(486006)(2616005)(478600001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5993;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nn3tBN/hvydU5Raq8XQxqrodz86JyhvDXdNkwwqMe5TJoIfSsQIxuID8ru+lMorH8KKQlTLmSR0qWd+ZSJJT2pLqDA0kqXeMjkUfk3+WtyqfXWCSL19V1Hug6LpgHKCtGFS3KmyCJWjUmoGL0mJyLx0nFMGW74MjJ+aErkcRYsRxA5ux7qWQevMFvHF2HPWtc5NJ19riDsAYw7I5g9XXD25+oZSvKj6hxkfm3bwQZrVTFgqL45PNy8CcAoCTPy5kMjVsrwTDg3GE/KKBj6uZ4nWTjE1eWhyIqYq6ILSfBv2rSy//MHc5dsO8lvpnbmtel1q2fVA4ygSNdo0AHumwaH86fL6ce65NUuVcsE1EoDszk985AaJzsvTTXCChiN+E28ey+xg3/DkFHFs1I5HstIO2+bPP/waBne9KikbOeGc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfdeb91-9e28-4e61-a861-08d6918a5255
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:07:36.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
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

