Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeCEQ0k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:26:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:49459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeCEQ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="208994407"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 21/22] x86/mm: Introduce page_keyid() and page_encrypted()
Date: Mon,  5 Mar 2018 19:26:09 +0300
Message-Id: <20180305162610.37510-22-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helpers checks if page is encrypted and with which keyid.
They use anon_vma get the information.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 14 ++++++++++++++
 arch/x86/mm/mktme.c          | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 56c7e9b14ab6..dd81fe167e25 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -33,10 +33,24 @@ bool anon_vma_encrypted(struct anon_vma *anon_vma);
 
 #define anon_vma_keyid anon_vma_keyid
 int anon_vma_keyid(struct anon_vma *anon_vma);
+
+int page_keyid(struct page *page);
 #else
+
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
 #define mktme_keyid_shift	0
+
+static inline int page_keyid(struct page *page)
+{
+	return 0;
+}
 #endif
 
+static inline bool page_encrypted(struct page *page)
+{
+	/* All pages with non-zero KeyID are encrypted */
+	return page_keyid(page) != 0;
+}
+
 #endif
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 69172aabc07c..0ab795dfb1a4 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -39,6 +39,23 @@ int anon_vma_keyid(struct anon_vma *anon_vma)
 	return anon_vma->arch_anon_vma.keyid;
 }
 
+int page_keyid(struct page *page)
+{
+	struct anon_vma *anon_vma;
+	int keyid = 0;
+
+	if (!PageAnon(page))
+		return 0;
+
+	anon_vma = page_get_anon_vma(page);
+	if (anon_vma) {
+		keyid = anon_vma_keyid(anon_vma);
+		put_anon_vma(anon_vma);
+	}
+
+	return keyid;
+}
+
 void prep_encrypt_page(struct page *page, gfp_t gfp, unsigned int order)
 {
 	void *v = page_to_virt(page);
-- 
2.16.1
