Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeERKfk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:35:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:38319 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbeERKfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:35:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="51925863"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 6/7] x86/mm: Mark p4d_offset() __always_inline
Date: Fri, 18 May 2018 13:35:27 +0300
Message-Id: <20180518103528.59260-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pgtable_l5_enabled shouldn't be needed after system has booted, we can
mark it as __initdata, but it requires preparation.

KASAN initialization code is a user of USE_EARLY_PGTABLE_L5, so all
pgtable_l5_enabled() translated to __pgtable_l5_enabled there, including
the one in p4d_offset().

It may lead to section mismatch, if a compiler would not inline
p4d_offset(), but leave it as a standalone function: p4d_offset() is not
marked as __init.

Marking p4d_offset() as __always_inline fixes the issue.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5715647fc4fe..99ecde23c3ec 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -898,7 +898,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 #define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static __always_inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
 	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
-- 
2.17.0
