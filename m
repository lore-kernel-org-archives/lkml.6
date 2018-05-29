Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbeE2JQe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:16:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39318 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbeE2JQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:16:26 -0400
X-Google-Smtp-Source: AB8JxZohPEkaeKyIwH5nXCrewcWL9BUWFJHXagLc/d4gSoaQOwVdtrvnF2Mp53uP+AJ/BRrbM10Uyg==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        jmorris@namei.org
Subject: [PATCH] mark tramp_pg_dir read-only
Date: Tue, 29 May 2018 17:16:09 +0800
Message-Id: <20180529091609.9830-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent KSMA(Kernel Space Mirroring Attack), it's necessary
to set tramp_pg_dir read-only after initialization.

---
 arch/arm64/mm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..964520e4e675 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -551,6 +551,9 @@ static int __init map_entry_trampoline(void)
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
+	update_mapping_prot(__pa_symbol(tramp_pg_dir), (unsigned long)tramp_pg_dir,
+			    PGD_SIZE, PAGE_KERNEL_RO);
+
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-- 
2.17.0
