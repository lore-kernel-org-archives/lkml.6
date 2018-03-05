Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeCEQ2Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:28:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:37468 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeCEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="35620828"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 17/22] x86/mm: Implement vma_is_encrypted() and vma_keyid()
Date: Mon,  5 Mar 2018 19:26:05 +0300
Message-Id: <20180305162610.37510-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We store KeyID in upper bits for vm_page_prot that match position of
KeyID in PTE. vma_keyid() extracts KeyID from vm_page_prot.

VMA is encrypted if KeyID is non-zero. vma_is_encrypted() checks that.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  9 +++++++++
 arch/x86/mm/mktme.c          | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index df31876ec48c..08f613953207 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -3,10 +3,19 @@
 
 #include <linux/types.h>
 
+struct vm_area_struct;
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
+
+#define vma_is_encrypted vma_is_encrypted
+bool vma_is_encrypted(struct vm_area_struct *vma);
+
+#define vma_keyid vma_keyid
+int vma_keyid(struct vm_area_struct *vma);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 467f1b26c737..3b2f28a21d99 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,5 +1,22 @@
+#include <linux/mm.h>
 #include <asm/mktme.h>
 
 phys_addr_t mktme_keyid_mask;
 int mktme_nr_keyids;
 int mktme_keyid_shift;
+
+bool vma_is_encrypted(struct vm_area_struct *vma)
+{
+	return pgprot_val(vma->vm_page_prot) & mktme_keyid_mask;
+}
+
+int vma_keyid(struct vm_area_struct *vma)
+{
+	pgprotval_t prot;
+
+	if (!vma_is_anonymous(vma))
+		return 0;
+
+	prot = pgprot_val(vma->vm_page_prot);
+	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
+}
-- 
2.16.1
