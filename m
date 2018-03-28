Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeC1Q4J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:56:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:50175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbeC1Qzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:55:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="28816307"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 13/14] x86/mm: Implement prep_encrypted_page()
Date: Wed, 28 Mar 2018 19:55:39 +0300
Message-Id: <20180328165540.648-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware/CPU does not enforce coherency between mappings of the same
physical page with different KeyIDs or encrypt ion keys.
We are responsible for cache management.

We flush cache before changing KeyID of the page. KeyID is preserved for
freed pages to avoid excessive cache flushing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  3 +++
 arch/x86/mm/mktme.c          | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 5f440d57aa47..5b22ef0f0ae3 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -11,6 +11,9 @@ extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
 
+#define prep_encrypted_page prep_encrypted_page
+void prep_encrypted_page(struct page *page, int order, int keyid);
+
 #define vma_is_encrypted vma_is_encrypted
 bool vma_is_encrypted(struct vm_area_struct *vma);
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 3da25212a372..cebec794bae8 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/mktme.h>
 
 phys_addr_t mktme_keyid_mask;
@@ -21,6 +22,34 @@ int vma_keyid(struct vm_area_struct *vma)
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
 
+void prep_encrypted_page(struct page *page, int order, int new_keyid)
+{
+	int i;
+	void *v;
+
+	/*
+	 * The hardware/CPU does not enforce coherency between mappings of the
+	 * same physical page with different KeyIDs or encrypt ion keys.
+	 * We are responsible for cache management.
+	 *
+	 * We flush cache before changing KeyID of the page. KeyID is preserved
+	 * for freed pages to avoid exessive cache flushing.
+	 */
+
+	for (i = 0; i < (1 << order); i++) {
+		int old_keyid = page_keyid(page);
+
+		if (old_keyid == new_keyid)
+			continue;
+
+		v = kmap_atomic(page + i);
+		clflush_cache_range(v, PAGE_SIZE);
+		kunmap_atomic(v);
+
+		lookup_page_ext(page)->keyid = new_keyid;
+	}
+}
+
 static bool need_page_mktme(void)
 {
 	/* Make sure keyid doesn't collide with extended page flags */
-- 
2.16.2
