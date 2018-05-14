Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeENMjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:39:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeENMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:39:10 -0400
Date: Mon, 14 May 2018 05:38:47 -0700
From: tip-bot for Alexander Potapenko <tipbot@zytor.com>
Message-ID: <tip-4a09f0210c8b1221aae8afda8bd3a603fece0986@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org, glider@google.com,
        mingo@kernel.org, dave.hansen@intel.com
Reply-To: dave.hansen@intel.com, glider@google.com, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180509091822.191810-1-glider@google.com>
References: <20180509091822.191810-1-glider@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
Git-Commit-ID: 4a09f0210c8b1221aae8afda8bd3a603fece0986
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4a09f0210c8b1221aae8afda8bd3a603fece0986
Gitweb:     https://git.kernel.org/tip/4a09f0210c8b1221aae8afda8bd3a603fece0986
Author:     Alexander Potapenko <glider@google.com>
AuthorDate: Wed, 9 May 2018 11:18:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:30 +0200

x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'

Clang builds with defconfig started crashing after the following
commit:

  fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

This was caused by introducing a new global access in __startup_64().

Code in __startup_64() can be relocated during execution, but the compiler
doesn't have to generate PC-relative relocations when accessing globals
from that function. Clang actually does not generate them, which leads
to boot-time crashes. To work around this problem, every global pointer
must be adjusted using fixup_pointer().

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dvyukov@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: linux-mm@kvack.org
Cc: md@google.com
Cc: mka@chromium.org
Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")
Link: http://lkml.kernel.org/r/20180509091822.191810-1-glider@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..2d29e47c056e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -104,6 +104,12 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+/* Code in __startup_64() can be relocated during execution, but the compiler
+ * doesn't have to generate PC-relative relocations when accessing globals from
+ * that function. Clang actually does not generate them, which leads to
+ * boot-time crashes. To work around this problem, every global pointer must
+ * be adjusted using fixup_pointer().
+ */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -113,6 +119,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
+	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
@@ -196,7 +203,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
+	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
