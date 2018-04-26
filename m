Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeDZOaX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:30:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54975 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756476AbeDZO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:28:51 -0400
X-ME-Sender: <xms:I-LhWgDBQ6I6yd7bD6qsHfPozjso1i7s1atBJfm5XfUffQkORiwENg>
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Subject: [RFC PATCH 4/9] i386: mm: migrate: add pmd swap entry to support thp migration.
Date: Thu, 26 Apr 2018 10:27:59 -0400
Message-Id: <20180426142804.180152-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/include/asm/pgtable-2level.h | 2 ++
 arch/x86/include/asm/pgtable-3level.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 685ffe8a0eaf..fba4722ec2c2 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -93,6 +93,8 @@ static inline unsigned long pte_bitop(unsigned long value, unsigned int rightshi
 					 ((type) << (_PAGE_BIT_PRESENT + 1)) \
 					 | ((offset) << SWP_OFFSET_SHIFT) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
+#define __pmd_to_swp_entry(pmd)		((swp_entry_t) { native_pmd_val(pmd) })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
+#define __swp_entry_to_pmd(x)		(native_make_pmd(x.val))
 
 #endif /* _ASM_X86_PGTABLE_2LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index f24df59c40b2..9b7e3c74fbc0 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -246,7 +246,9 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 #define __swp_offset(x)			((x).val >> 5)
 #define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
+#define __pmd_to_swp_entry(pmd)		((swp_entry_t){ (pmd).pmd_high })
 #define __swp_entry_to_pte(x)		((pte_t){ { .pte_high = (x).val } })
+#define __swp_entry_to_pmd(x)		((pmd_t){ { .pmd_high = (x).val } })
 
 #define gup_get_pte gup_get_pte
 /*
-- 
2.17.0
