Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D856C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533DE2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXXoLcWe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MnTWajih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfASN2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:25 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42154 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfASN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904506; x=1579440506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJ+W3Rudkf26ljRN4XY46EsHl7VO+cABUmloHSZ1tuc=;
  b=iXXoLcWeaDGRIhJmNtsEakjri6WIgtnRd7j15/6uGi3n2woDMeUzPaIQ
   CYhv7LR+5aOKwllYwSKpEh6PC6DP6zgtyDMsg7Z3VFsHYdDDPH3S4y/BU
   ce8rPyeg372qOjn3WEVQVi6u98JglWN8drcGeXg1qwx7BTjrWppnQi+6q
   JZST798TVv4TrFlPTGASVf+QLzCB9l22qLZla9jj2uPwvEaBMT10y+qYz
   /GyNOHezOIs3/yqqnvD5MeWj6sqPsEUq9Jn/2NaerWRoTg79GA6VLFMmO
   CWSWxDRv+ZV0Avoj2gp/zXxWvFHaqZtOGO1JazLkvq7Caug45UcUPynd6
   w==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="101011296"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:28:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkZk3Z2NRgYb/c2U2H09g/YoaPj2CBRt5VGMQ34k8p4=;
 b=MnTWajihbDFOXAXY9ranMxotA72KzRdqXJYwef+cd8UUx9i0FC7wMUQkwLvYwW82FxI3zgQw8l77LWTHh2dx0hKzn/ZpbEFWlqQERUZPabVyfObNncHf2ugho0MiUhjDCGzvg9DAFnPOwRRGqsBzNtYWlisPJjXtUwZp/c+BNeI=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB4678.namprd04.prod.outlook.com (52.135.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Sat, 19 Jan 2019 13:28:23 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:28:23 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Topic: [PATCH v2 3/6] RISC-V: Move setup_bootmem() to mm/init.c
Thread-Index: AQHUr/rZbdFQqnRdaUSqSTYx5eJjPQ==
Date:   Sat, 19 Jan 2019 13:28:23 +0000
Message-ID: <20190119132650.9978-4-anup.patel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4678;6:Kn6M0tXIt84puqCTET9sA3+nmu7lEVONoOyvKTlltBgjfgMQTVp/CFOa2+tsAb+7VKQOvAGPCRMsikHDtJYgrhX/w27DxtsP5uwcd2x/6bXc4LRYFTAoH2jj8y/0addgQ8JjJbO8G4kHR9rAY6RyjjMiw7W+OaLD8NLcFKQcIDNjnPGC9EYxjj2whkL2e0qDw3cbKIDIGUSkuTHqittacMNrJFGKvsegVrdWSywzwGRTt6/bTmWFoZdc4n84QSQ2mPzR6Rz8olvVGpK78VjCSNaCqkEprDQBOCPQqXCjAo1h65NyIJA1V5AZIwwIExIv8nLMaYo9+OtnbU7FnwyTZ1UF7cdSQQkUxHTyeUbVOCiMovTrpBRZH/wzyLDZGPdQKAOPgJv4ozaYnmM5ZsnfrmUxXZZ0j7TxHFsY0fXpX88LRHgrJ/MNpiJPPKuaQz5dUvD3l1sehmxcMKb9+kD2pg==;5:PNCb6J5QcxaVt1SP6f5dfLiM5LtLHvwk5CVwzwtW4887IRY7746plu1m+xLZbTPx6W6+IkBGRNUdQq2WKPNRzCqyL0kasfgIVHgMIPlo1NwQCoT8kweozwG+jZeHjTTjXLUahTV9Xxt1ZGKAxRBgq6pmvmyAeQ4jetktmSbPVpqn3YHC+t5HNSUjA+eGAw9sLBazxkfi4gCFhzGZe1I9Yg==;7:w4Fk6JzJOc3NXHj45p7NBuwCPDn9ombuaFbTXy3eHA2lbOi57sPrHGo5AeiYmf+AEYBkp2ECwOkF9R2WLTG+QqOL3gFwpY3i0hbPGmuWMTi8rkyKzAaDRlc5H3RHAN3k5FrbRHalp2Ydgv57gCX55w==
x-ms-office365-filtering-correlation-id: c2fa4096-3cbf-4643-43d4-08d67e11fc45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4678;
x-ms-traffictypediagnostic: BYAPR04MB4678:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB46783CE3CBA2E96AC32E1EF28D9D0@BYAPR04MB4678.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(50226002)(7736002)(2906002)(6436002)(72206003)(5660300001)(106356001)(6486002)(478600001)(68736007)(8936002)(256004)(36756003)(44832011)(486006)(71200400001)(71190400001)(105586002)(97736004)(52116002)(66066001)(14454004)(54906003)(6116002)(3846002)(1076003)(110136005)(25786009)(446003)(99286004)(26005)(76176011)(8676002)(2616005)(476003)(4326008)(86362001)(81166006)(2171002)(305945005)(81156014)(11346002)(53936002)(55236004)(186003)(386003)(102836004)(6512007)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4678;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KobITc8QUiHqItfy7kE6r76WXwzfC7oKTKQ5cYSuE/5c4G84ns0VqtfKbVTDzQYTylUdOXGcLnra5usWj1e5PUBQpBsQVJpUhpmshAQF6x13DUmUOF8QVUSvyfTlNo7kfbSUyt9Xq1GyKf9Xkjm2pf7dp+KkoPDYl6pIJkPSNDc4goXmBcPlgl9rVNSCmeCPjBQAQtLeXIF/nEfhbpy7nirEKpVqNL41zzOl2FCWXaG1QBwxXmriEVQPuhd2rdyA8nOZtEaQ/BmHVkmJDWxmYKU6ONar/F6f+M3XNSkw6Bi6OKb8fvSEC9yd7UJBMm7PQ/OPIh5/bT2kRu9BmVlJf8rPd95X27K+RphPiuHFOgIj9kGOr7chiyY3ySbCIJugXU4q2R1bCk5KXeQ2wNpnUUMiBFjmEnnDA7yYai6j2Ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa4096-3cbf-4643-43d4-08d67e11fc45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:28:20.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
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
index 577d8460d141..ab29a66a17fc 100644
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
-	max_low_pfn =3D memblock_end_of_DRAM();
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
index f354486f9b78..d0965979ee70 100644
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
@@ -62,3 +63,42 @@ void free_initmem(void)
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

