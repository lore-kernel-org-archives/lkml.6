Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeCEQ12 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:27:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:14697 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbeCEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="34759451"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 18/22] x86/mm: Handle allocation of encrypted pages
Date: Mon,  5 Mar 2018 19:26:06 +0300
Message-Id: <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware/CPU does not enforce coherency between mappings of the
same physical page with different KeyIDs or encrypt ion keys.
We are responsible for cache management.

We have to flush cache on allocation and freeing of encrypted page.
Failing to do this may lead to data corruption.

Zeroing of encrypted page has to be done with correct KeyID. In normal
situation kmap() takes care of creating temporary mapping for the page.
But during allocaiton path page doesn't have page->mapping set.

kmap_atomic_keyid() would map the page with the specified KeyID.
For now it's dummy implementation that would be replaced later.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  3 +++
 arch/x86/include/asm/page.h  | 13 +++++++++++--
 arch/x86/mm/mktme.c          | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 08f613953207..c8f41837351a 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -5,6 +5,9 @@
 
 struct vm_area_struct;
 
+struct page *__alloc_zeroed_encrypted_user_highpage(gfp_t gfp,
+		struct vm_area_struct *vma, unsigned long vaddr);
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..8f808723f676 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -19,6 +19,7 @@
 struct page;
 
 #include <linux/range.h>
+#include <asm/mktme.h>
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
@@ -34,9 +35,17 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
-#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
-	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr)			\
+({										\
+	struct page *page;							\
+	gfp_t gfp = movableflags | GFP_HIGHUSER;				\
+	if (vma_is_encrypted(vma))						\
+		page = __alloc_zeroed_encrypted_user_highpage(gfp, vma, vaddr);	\
+	else									\
+		page = alloc_page_vma(gfp | __GFP_ZERO, vma, vaddr);		\
+	page;									\
+})
 
 #ifndef __pa
 #define __pa(x)		__phys_addr((unsigned long)(x))
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 3b2f28a21d99..1129ad25b22a 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,10 +1,17 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/mktme.h>
 
 phys_addr_t mktme_keyid_mask;
 int mktme_nr_keyids;
 int mktme_keyid_shift;
 
+void *kmap_atomic_keyid(struct page *page, int keyid)
+{
+	/* Dummy implementation. To be replaced. */
+	return kmap_atomic(page);
+}
+
 bool vma_is_encrypted(struct vm_area_struct *vma)
 {
 	return pgprot_val(vma->vm_page_prot) & mktme_keyid_mask;
@@ -20,3 +27,34 @@ int vma_keyid(struct vm_area_struct *vma)
 	prot = pgprot_val(vma->vm_page_prot);
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
+
+void prep_encrypt_page(struct page *page, gfp_t gfp, unsigned int order)
+{
+	void *v = page_to_virt(page);
+
+	/*
+	 * The hardware/CPU does not enforce coherency between mappings of the
+	 * same physical page with different KeyIDs or encrypt ion keys.
+	 * We are responsible for cache management.
+	 *
+	 * We have to flush cache on allocation and freeing of encrypted page.
+	 * Failing to do this may lead to data corruption.
+	 */
+	clflush_cache_range(v, PAGE_SIZE << order);
+
+	WARN_ONCE(gfp & __GFP_ZERO, "__GFP_ZERO is useless for encrypted pages");
+}
+
+struct page *__alloc_zeroed_encrypted_user_highpage(gfp_t gfp,
+		struct vm_area_struct *vma, unsigned long vaddr)
+{
+	struct page *page;
+	void *v;
+
+	page = alloc_page_vma(gfp | GFP_HIGHUSER, vma, vaddr);
+	v = kmap_atomic_keyid(page, vma_keyid(vma));
+	clear_page(v);
+	kunmap_atomic(v);
+
+	return page;
+}
-- 
2.16.1
