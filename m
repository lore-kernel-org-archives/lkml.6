Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755529AbeEHQ2i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:28:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42186 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbeEHQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:28:35 -0400
X-Google-Smtp-Source: AB8JxZone6v8n+C+AXE3D4QMJ1XwPzqSpSQ+4v81iieu0KQ8Ezxy5CVR/wI2bcNAnv2jjCTchAYR1A==
From: Alexander Potapenko <glider@google.com>
To: dave.hansen@linux.intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        dvyukov@google.com, md@google.com
Subject: [PATCH v2] x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'
Date: Tue,  8 May 2018 18:28:29 +0200
Message-Id: <20180508162829.7729-1-glider@google.com>
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
 v2: better patch description, added a comment to __startup_64()
---
 arch/x86/kernel/head64.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..9223792f6d0e 100644
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
+	mask_ptr = (pteval_t *)fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.17.0.441.gb46fe60e1d-goog
