Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968943AbeE3JOI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:14:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34809 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968847AbeE3JN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:13:26 -0400
X-Google-Smtp-Source: ADUXVKIYkg1XePl03K+GiXrjZhrvlzjch2CG9VClmAlbA8vZGg7Xcs87eceQ3a2eJCcIWIoZ3f3PBg==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: [PATCH 4/4] arm64/mm: migrate swapper_pg_dir
Date: Wed, 30 May 2018 17:12:59 +0800
Message-Id: <20180530091259.9386-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530091259.9386-1-yaojun8558363@gmail.com>
References: <20180530091259.9386-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate swapper_pg_dir and tramp_pg_dir. And its placement in
the virtual address space does not correlate with the placement
of the kernel.

Signed-off-by: YaoJun <yaojun8558363@gmail.com>
---
 arch/arm64/mm/mmu.c | 67 +++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 26ba3e70a91c..b508de2cc6c4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -57,6 +57,9 @@ EXPORT_SYMBOL(kimage_voffset);
 
 phys_addr_t __pa_swapper_pg_dir;
 pgd_t *new_swapper_pg_dir = swapper_pg_dir;
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+pgd_t *new_tramp_pg_dir;
+#endif
 
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
@@ -105,6 +108,25 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	return phys;
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+static phys_addr_t __init early_pgtables_alloc(int num)
+{
+	int i;
+	phys_addr_t phys;
+	void *ptr;
+
+	phys = memblock_alloc(PAGE_SIZE * num, PAGE_SIZE);
+
+	for (i = 0; i < num; i++) {
+		ptr = pte_set_fixmap(phys + i * PAGE_SIZE);
+		memset(ptr, 0, PAGE_SIZE);
+		pte_clear_fixmap();
+	}
+
+	return phys;
+}
+#endif
+
 static bool pgattr_change_is_safe(u64 old, u64 new)
 {
 	/*
@@ -554,6 +576,10 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
+	memcpy(new_tramp_pg_dir, tramp_pg_dir, PGD_SIZE);
+	memblock_free(__pa_symbol(tramp_pg_dir),
+		__pa_symbol(swapper_pg_dir) - __pa_symbol(tramp_pg_dir));
+
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
@@ -631,36 +657,35 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
+	phys_addr_t pgd_phys;
+	pgd_t *pgdp;
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	int pages;
+
+	pages = (__pa_symbol(swapper_pg_dir) - __pa_symbol(tramp_pg_dir) +
+			PAGE_SIZE) >> PAGE_SHIFT;
+	pgd_phys = early_pgtables_alloc(pages);
+	new_tramp_pg_dir = __va(pgd_phys);
+	__pa_swapper_pg_dir = pgd_phys + PAGE_SIZE;
+#else
+	pgd_phys = early_pgtable_alloc();
+	__pa_swapper_pg_dir = pgd_phys;
+#endif
+	new_swapper_pg_dir = __va(__pa_swapper_pg_dir);
 
-	__pa_swapper_pg_dir = __pa_symbol(swapper_pg_dir);
+	pgdp = pgd_set_fixmap(__pa_swapper_pg_dir);
 
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
-	/*
-	 * We want to reuse the original swapper_pg_dir so we don't have to
-	 * communicate the new address to non-coherent secondaries in
-	 * secondary_entry, and so cpu_switch_mm can generate the address with
-	 * adrp+add rather than a load from some global variable.
-	 *
-	 * To do this we need to go via a temporary pgd.
-	 */
-	cpu_replace_ttbr1(pgd_phys);
-	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
 	cpu_replace_ttbr1(__pa_swapper_pg_dir);
+	init_mm.pgd = new_swapper_pg_dir;
 
 	pgd_clear_fixmap();
-	memblock_free(pgd_phys, PAGE_SIZE);
 
-	/*
-	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-	 * allocated with it.
-	 */
-	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
-		      - PAGE_SIZE);
+	memblock_free(__pa_symbol(swapper_pg_dir),
+		__pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir));
 }
 
 /*
-- 
2.17.0
