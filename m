Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD51DC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAE2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aQ74baj+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NEMSRt9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfASN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42154 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfASN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904510; x=1579440510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ErtookT/WUlzoMYFO9uINopCIBQkAbzJ3kPcEWxBi/A=;
  b=aQ74baj+y/g2qsYSBdxuApjTQ+9cWAGBXSGZe8e3wCbgelWUmiMQphj5
   sBef3LJTTGxWIYl5aIXteYdr8wwGmg7pq5DdHrdm/q+EuiFFJ/NW1cgMt
   8+PAYWLsvo8hvVEZL9IKTO6q3BpKtzHpMX3J3SExcQudlO6ZMRDxG9Zcu
   PnEUjuNd9s0EtzXQfxBFC8dxGZ9uLynCX2KsBYNRDkL2OAvqrjiiLnERp
   ACiuo+HWsG9iIgVOMASR1DLogO7cJ8tiGex6zaBFWVhXA3H/IK3kZ/9IB
   DLRfugjIo95hKUzMpEUy7humSqUiXpd94VZZt/rO1uDNDPF7XywdjNVIH
   g==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="101011301"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:28:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pweH6QhO7Wrmh3erRPcCTJ1f8UZTm7PpWbx9Ijged9Y=;
 b=NEMSRt9vG2US4aZ9tHQUtLLAp6WG4aR4hH9K4PFlNdwIifYWm1dBlcwZgTMeQ6CPii820OiO4N7A0K1fgQJH4I6Z0Wy7n9aZiAlRGRqb65xPPyE2lxo31Gk2iv6KDCueX+BRtWnYeMZajg9aiiBWKByy++idqR3kml4muNN7IeM=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB4678.namprd04.prod.outlook.com (52.135.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Sat, 19 Jan 2019 13:28:28 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:28:28 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Topic: [PATCH v2 4/6] RISC-V: Move setup_vm() to mm/init.c
Thread-Index: AQHUr/rch08vY8x9lUmLhlHn6x7tGg==
Date:   Sat, 19 Jan 2019 13:28:28 +0000
Message-ID: <20190119132650.9978-5-anup.patel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4678;6:eHc44GMaZ+oQYfzm7xhC1y2E2yon2Gfv24cqH6DYBZojurY/z+p5lMh5i/yb6bWPG/JQiyvpai2KA/W2aqOT7jGkYxQrAADZvTeFChz+GCRQAsAp3N2h0amQ3fClSkFBa9iB1D1JFnpIg3w07lfUuMWeIMTMad+62G1n2fn79brqqICeVlBnN9PLtL0aTguIxkk0Dw7ofQscJLfePcbo9dEDDmF1sytVuJocRxcmHtKU0TWo2X6NTpU22yR7YmSNeMN+xSM/A1+yY2UftWkx8bodCJqBXcD9xmm1keUTDwJxeymVN0eqUP5S+ZU5KI8zbx7bGs3H6U2tTxlL9RMvMFWyGmnso2zRn97lnJHfZgdTrgKyIsbJYoFrUChIt4HTUBh6P5Dn4nldjfsQ+BDwxeOdMQGG5EI/Fnw7UpmOZFmfKtxUQ3mfvXk32txMrQjNLDwVU3TgiLExLdiov4iqYw==;5:cy8BSpRrUIzIJF80za93ZLiCSn/Jcdyzulf9lTkQHjOfKAwvE4YusMXTvaB65h4PLsj5i6/lLxeaBhsr8bNZTj79CBvN/EL0D1OmHArXwpjztzmvOJUR0SiQ1Hyk5kYtrjcZVgvLTLPRxOIbnDMoytqLw1q/Y40FYRjoSIim8a07DIJA13OZS8P9QSn7XdMZgYYmiuY6xbqED1Cqy4eMjg==;7:GiC2PiYRWAaHaTYGoZCUdW+RLf4KmSrBi0QVeFfrwpdoYQ9AhyPwmvE4no7w0ZE5F84GSjO0mTy4++TfFBZL1rT9TJalKLwq2yydXGNHHShiPQBbiVfuw46Tsy9t06fAcM5TXAJYyOAEBmHyFyLwuA==
x-ms-office365-filtering-correlation-id: 58c94990-1f48-4279-6451-08d67e11ff09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4678;
x-ms-traffictypediagnostic: BYAPR04MB4678:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB467808D2CCBA2A90B41288CD8D9D0@BYAPR04MB4678.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(50226002)(7736002)(2906002)(6436002)(72206003)(5660300001)(106356001)(6486002)(478600001)(68736007)(8936002)(256004)(36756003)(44832011)(486006)(71200400001)(71190400001)(105586002)(97736004)(52116002)(66066001)(14454004)(54906003)(6116002)(3846002)(1076003)(110136005)(25786009)(446003)(99286004)(26005)(76176011)(8676002)(2616005)(476003)(4326008)(86362001)(81166006)(2171002)(305945005)(81156014)(11346002)(53936002)(55236004)(186003)(386003)(102836004)(6512007)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4678;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Khp+LLegIsNXBm1pfiBSWajaBwi4xImgbczkuqWGPKelg7FEFlinVi3+bipCHxN3dZqWzr7Qw9LlXK9F9glWx8mbGEJcQ608rlH+LpsiGdal2rMYKgIdeAF/gLmzUZWkwcLsoE5EfJ/uk8vcHyceg0fVy5vxEec/Mf/tgIr0ZO7Dd4bO1YEHmxZw+KOLBTIzB0w6Q/DaRHMkbFmcgbEgYSOEUdtpSIogV31sE79IrtafHDpf46sjrBip4C0/4SeZ1KQTRv7+3f09LxB859dh+y0LnrWI4xyzQzD5t4tSPXoYgA7toiu7sBnurR2L8XyvIAspTtfmokpn+OrH7JB0eMudHuNh1YOSfI0EW9y2ixTWtcvQ0oC0WaazKVWAO3Hh7CkYeb4EHNCkrjoXRj0Qg+RiUczDOhHFUJ7EPyBGc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c94990-1f48-4279-6451-08d67e11ff09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:28:25.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_vm() is responsible for setting up initial page table
hence should be placed in mm/init.c.

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
index d0965979ee70..f8e396dc80a4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -102,3 +102,52 @@ void __init setup_bootmem(void)
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

