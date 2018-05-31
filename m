Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754540AbeEaKbh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:31:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38036 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeEaKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:31:31 -0400
X-Google-Smtp-Source: ADUXVKKf+izTxaehS2bLBvm07kaUrS67nC4eFk7WvVAGYEb6zxaaUiiErr38GgNeFjklewbPsob6Nw==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 2/2] arm64/mm: make tramp_pg_dir read-only
Date: Thu, 31 May 2018 18:31:22 +0800
Message-Id: <20180531103122.31793-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make tramp_pg_dir read-only.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/mm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a675fb88914e..2c6e6433090c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -542,6 +542,7 @@ static int __init map_entry_trampoline(void)
 {
 	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
+	int segment_size;
 
 	/* The trampoline is always mapped and can therefore be global */
 	pgprot_val(prot) &= ~PTE_NG;
@@ -551,6 +552,11 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
+	segment_size = __tramp_pgdir_segment_end - __tramp_pgdir_segment_start;
+	update_mapping_prot(__pa_symbol(__tramp_pgdir_segment_start),
+				(unsigned long)__tramp_pgdir_segment_start,
+				segment_size, PAGE_KERNEL_RO);
+
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-- 
2.17.0
