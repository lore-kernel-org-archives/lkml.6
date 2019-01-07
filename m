Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96980C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598742087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CRS69RQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfAGQLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37859 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so385780pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6aM0hklZsFoaklZaSb50j46kecgBnQrkaeqJhZzzu0=;
        b=CRS69RQFENjNlNHF3xKRq9jrAWmuSsg45oCuH+alD6J9nO4XMkDK3JhaHp1la/Rgs5
         Kv4hG84jkN7dVl9XqK4GU/N3L4m/PDo5y3TJR8p17BhzsOiuz14TeFo5m4ub1wUjE5K+
         BbzvDHgmSvw/6TnoG8MUtcH8JyoHVmBYLys25erXg0chDK60FtivqvDU2BjJwyMl9sNu
         nmWHc1bMK2xG27/mYRTVZsP9KrXI8Gla+Wqpa2JPegYexlUYFTlCa+2vcLBPrgDHqb//
         raKpEDvp9NaO8EdHByv3BAM93ZjGYiUVTO18Jh1mgkwTaOh6c21bpAGepP6twy8vE5GU
         f5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v6aM0hklZsFoaklZaSb50j46kecgBnQrkaeqJhZzzu0=;
        b=sIJOJYrwnzUFLflIpIofWtv1UykLzwz9KkT5ceOzvAmx1P2AHz2Lsfy9nFALRw2Ckf
         2MEPlIE23vDcWbZ8/MVv8+04AmlIDI/ArRtVtggkHFqKqW4AwpoeGg74Fu/MoI1BuC10
         FMMKNE9wwC5eVQL/ORM+pwgHrkxUybVKzsqMupM+iyXYXjgRLK9RIyMicYuCDWvHap/i
         uzZREGFmYQM5zP7P0p1Iig8VvNDc9zYU97TkkpKLb70X6ElT+NkKl+Z7fsJpeZNUH4HZ
         PqjHOPr85R77orPPm8UOT0Y2vqeQy+tz8DxqYdjqKruiYxxW2gl8GZmN+q0jEJN3+VmU
         lJig==
X-Gm-Message-State: AA+aEWbMhObAEQ06UficPGis08qFPc/RR2f2BH6pQvUqae1s3SU5syaR
        wJ4/Nl2i+VYgJuaXQii8nuvUMl1dMm0=
X-Google-Smtp-Source: AFSGD/V8as21mLKX4g9nDe++baxp9D7028k8deFV1gH3K4lE4zBPzT/Rjqm2ER2SUS5pNECYt74Hng==
X-Received: by 2002:a62:7042:: with SMTP id l63mr66271895pfc.89.1546877491533;
        Mon, 07 Jan 2019 08:11:31 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:30 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 5/5] RISC-V: Implement compile-time fixed mappings
Date:   Mon,  7 Jan 2019 21:40:47 +0530
Message-Id: <20190107161047.10516-6-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107161047.10516-1-anup@brainfault.org>
References: <20190107161047.10516-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

This patch implements compile-time virtual to physical
mappings. These compile-time fixed mappings can be used
by earlycon, ACPI, and early ioremap for creating fixed
mappings when FIX_EARLYCON_MEM=y.

To start with, we have enabled compile-time fixed
mappings for earlycon.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig              |  3 ++
 arch/riscv/include/asm/fixmap.h | 52 +++++++++++++++++++++++++++++++++
 arch/riscv/mm/init.c            | 32 ++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 arch/riscv/include/asm/fixmap.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e0d7d61779a6..66094aba9a59 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,6 +86,9 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
new file mode 100644
index 000000000000..88e99f506ab9
--- /dev/null
+++ b/arch/riscv/include/asm/fixmap.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * fixmap.h: compile-time virtual memory allocation
+ */
+
+#ifndef _ASM_RISCV_FIXMAP_H
+#define _ASM_RISCV_FIXMAP_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process.
+ *
+ * These 'compile-time allocated' memory buffers are
+ * page-sized. Use set_fixmap(idx,phys) to associate
+ * physical memory with fixmap indices.
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
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_FIXMAP_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b487f76d6060..b10f1423c352 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
 
+#include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
@@ -110,8 +111,28 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
 pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
 pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 
+pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
+
+void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *ptep;
+
+	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
+
+	ptep = &fixmap_pte[pte_index(addr)];
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
@@ -141,6 +162,13 @@ asmlinkage void __init setup_vm(void)
 	}
 	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
 		swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+
+	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
+				__pgprot(_PAGE_TABLE));
+	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =
+		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
+				__pgprot(_PAGE_TABLE));
 #else
 	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
 		pfn_pgd(PFN_DOWN(pa), prot);
@@ -150,5 +178,9 @@ asmlinkage void __init setup_vm(void)
 		swapper_pg_dir[o] =
 			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
 	}
+
+	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
+				__pgprot(_PAGE_TABLE));
 #endif
 }
-- 
2.17.1

