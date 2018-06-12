Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0FAA4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302D208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C302D208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934509AbeFLOmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:42:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:60221 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933408AbeFLOj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="56706818"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 07:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 13AB4477; Tue, 12 Jun 2018 17:39:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 10/17] x86/mm: Implement prep_encrypted_page() and arch_free_page()
Date:   Tue, 12 Jun 2018 17:39:08 +0300
Message-Id: <20180612143915.68065-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware/CPU does not enforce coherency between mappings of the same
physical page with different KeyIDs or encryption keys.
We are responsible for cache management.

Flush cache on allocating encrypted page and on returning the page to
the free pool.

prep_encrypted_page() also takes care about zeroing the page. We have to
do this after KeyID is set for the page.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  6 ++++++
 arch/x86/mm/mktme.c          | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 0fe0db424e48..ec7036abdb3f 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -11,6 +11,12 @@ extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
 
+#define prep_encrypted_page prep_encrypted_page
+void prep_encrypted_page(struct page *page, int order, int keyid, bool zero);
+
+#define HAVE_ARCH_FREE_PAGE
+void arch_free_page(struct page *page, int order);
+
 #define vma_is_encrypted vma_is_encrypted
 bool vma_is_encrypted(struct vm_area_struct *vma);
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index b02d5b9d4339..1821b87abb2f 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/mktme.h>
 
 phys_addr_t mktme_keyid_mask;
@@ -30,6 +31,44 @@ int vma_keyid(struct vm_area_struct *vma)
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
 
+void prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
+{
+	int i;
+
+	/*
+	 * The hardware/CPU does not enforce coherency between mappings of the
+	 * same physical page with different KeyIDs or encrypt ion keys.
+	 * We are responsible for cache management.
+	 *
+	 * We flush cache before allocating encrypted page
+	 */
+	clflush_cache_range(page_address(page), PAGE_SIZE << order);
+
+	for (i = 0; i < (1 << order); i++) {
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
+		lookup_page_ext(page)->keyid = keyid;
+
+		/* Clear the page after the KeyID is set. */
+		if (zero)
+			clear_highpage(page);
+	}
+}
+
+void arch_free_page(struct page *page, int order)
+{
+	int i;
+
+	if (!page_keyid(page))
+		return;
+
+	for (i = 0; i < (1 << order); i++) {
+		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);
+		lookup_page_ext(page)->keyid = 0;
+	}
+
+	clflush_cache_range(page_address(page), PAGE_SIZE << order);
+}
+
 static bool need_page_mktme(void)
 {
 	/* Make sure keyid doesn't collide with extended page flags */
-- 
2.17.1

