Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934594AbeEIJSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:18:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54314 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934203AbeEIJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:18:29 -0400
X-Google-Smtp-Source: AB8JxZpBI2FXa1DnYYxvFUPLBY3AIOXR50czh4u2hyNxdXmUn1jcJ9XbeACHkiB3xL2901nwqUMlOQ==
From: Alexander Potapenko <glider@google.com>
To: dave.hansen@linux.intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        dvyukov@google.com, md@google.com
Subject: [PATCH v3] x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'
Date: Wed,  9 May 2018 11:18:22 +0200
Message-Id: <20180509091822.191810-1-glider@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang builds with defconfig started crashing after commit fb43d6cb91ef
("x86/mm: Do not auto-massage page protections")
This was caused by introducing a new global access in __startup_64().

Code in __startup_64() can be relocated during execution, but the compiler
doesn't have to generate PC-relative relocations when accessing globals
from that function. Clang actually does not generate them, which leads
to boot-time crashes. To work around this problem, every global pointer
must be adjusted using fixup_pointer().

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")
---
 v3: removed unnecessary cast
 v2: better patch description, added a comment to __startup_64()
---
 arch/x86/kernel/head64.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..5ea28e9a0250 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -104,6 +104,13 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+
+/* Code in __startup_64() can be relocated during execution, but the compiler
+ * doesn't have to generate PC-relative relocations when accessing globals from
+ * that function. Clang actually does not generate them, which leads to
+ * boot-time crashes. To work around this problem, every global pointer must
+ * be adjusted using fixup_pointer().
+ */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -113,6 +120,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
+	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
@@ -196,7 +204,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
+	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.17.0.441.gb46fe60e1d-goog
