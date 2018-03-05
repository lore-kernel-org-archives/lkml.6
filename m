Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeCEQ1K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:27:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:9033 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbeCEQ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39349304"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
Date: Mon,  5 Mar 2018 19:26:07 +0300
Message-Id: <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As on allocation of encrypted page, we need to flush cache before
returning page to free pool. Failing to do this may lead to data
corruption.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/mktme.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 1129ad25b22a..ef0eb1eb8d6e 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -45,6 +45,19 @@ void prep_encrypt_page(struct page *page, gfp_t gfp, unsigned int order)
 	WARN_ONCE(gfp & __GFP_ZERO, "__GFP_ZERO is useless for encrypted pages");
 }
 
+void free_encrypt_page(struct page *page, int keyid, unsigned int order)
+{
+	int i;
+	void *v;
+
+	for (i = 0; i < (1 << order); i++) {
+		v = kmap_atomic_keyid(page, keyid + i);
+		/* See comment in prep_encrypt_page() */
+		clflush_cache_range(v, PAGE_SIZE);
+		kunmap_atomic(v);
+	}
+}
+
 struct page *__alloc_zeroed_encrypted_user_highpage(gfp_t gfp,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
-- 
2.16.1
