Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeEHMQv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:16:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35123 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754950AbeEHMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:16:49 -0400
X-Google-Smtp-Source: AB8JxZqwNfFLaZygmI1QivyUJbbWQnDYASG2afF4n/Y6TS35LQn9mNKyW8UhTx8iXiumSw+k2rZmog==
From: Alexander Potapenko <glider@google.com>
To: dave.hansen@linux.intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        dvyukov@google.com, md@google.com
Subject: [PATCH] x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'
Date: Tue,  8 May 2018 14:16:38 +0200
Message-Id: <20180508121638.174022-1-glider@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to commit 187e91fe5e91
("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'"),
'__supported_pte_mask' must be also accessed using fixup_pointer() to
avoid position-dependent relocations.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")
---
 arch/x86/kernel/head64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..1b36ae4d0035 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -113,6 +113,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
+	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
@@ -196,7 +197,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
+	mask_ptr = (pteval_t *)fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.17.0.441.gb46fe60e1d-goog
