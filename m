Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeCEQ2U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:28:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:49459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbeCEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="208994403"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 16/22] x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
Date: Mon,  5 Mar 2018 19:26:04 +0300
Message-Id: <20180305162610.37510-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encrypted VMA would have KeyID stored in vma->vm_page_prot. This way we
don't need to do anything special to setup encrypted page table entries
and don't need to reserve space for KeyID in a VMA.

This patch changes _PAGE_CHG_MASK to include KeyID bits. Otherwise they
are going to be stripped from vm_page_prot on the first pgprot_modify().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 246f15b4e64c..800f66770163 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -121,8 +121,13 @@
  * protection key is treated like _PAGE_RW, for
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
+ *
+ * It includes full range of PFN bits regardless if they were claimed for KeyID
+ * or not: we want to preserve KeyID on pte_modify() and pgprot_modify().
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
+#define PTE_PFN_MASK_MAX \
+	(((signed long)PAGE_MASK) & ((1UL << __PHYSICAL_MASK_SHIFT) - 1))
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
 			 _PAGE_SOFT_DIRTY)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
-- 
2.16.1
