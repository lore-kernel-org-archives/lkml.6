Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeE3EsP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:48:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35473 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbeE3EsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:48:14 -0400
X-Google-Smtp-Source: ADUXVKLsbmELfH1bnift+bJrTjYXDzvaFfe4t5a4++zyRonee4dQiLolhHbokiwibaHWfjtW5vIjAg==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: mark tramp_pg_dir read-only
Date: Wed, 30 May 2018 12:48:06 +0800
Message-Id: <20180530044806.18449-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To protect against KSMA(Kernel Space Mirroring Attack), make
tramp_pg_dir read-only. The principle of KSMA is to insert a
carefully constructed PGD entry into the translation table.
The type of this entry is block, which maps the kernel text
and its access permissions bits are 01. The user process can
then modify kernel text directly through this mapping. In this
way, an arbitrary write can be converted to multiple arbitrary
writes.

Signed-off-by: YaoJun <yaojun8558363@gmail.com>
---
 arch/arm64/mm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..ac4b22c7e435 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -551,6 +551,10 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
+	update_mapping_prot(__pa_symbol(tramp_pg_dir),
+				(unsigned long)tramp_pg_dir,
+				PGD_SIZE, PAGE_KERNEL_RO);
+
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-- 
2.17.0
