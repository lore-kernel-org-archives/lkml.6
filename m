Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747E257C5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8747E257C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeFZOXC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:23:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:30236 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965575AbeFZOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:23:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="66458367"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 07:22:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EEAE078C; Tue, 26 Jun 2018 17:22:51 +0300 (EEST)
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
Subject: [PATCHv4 10/18] x86/mm: Implement vma_keyid()
Date:   Tue, 26 Jun 2018 17:22:37 +0300
Message-Id: <20180626142245.82850-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We store KeyID in upper bits for vm_page_prot that match position of
KeyID in PTE. vma_keyid() extracts KeyID from vm_page_prot.

With KeyID in vm_page_prot we don't need to modify any page table helper
to propagate the KeyID to page table entires.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  5 +++++
 arch/x86/mm/mktme.c          | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 7266494b4f0a..f0b7844e36a4 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -4,6 +4,8 @@
 #include <linux/types.h>
 #include <linux/page_ext.h>
 
+struct vm_area_struct;
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
@@ -14,6 +16,9 @@ extern struct page_ext_operations page_mktme_ops;
 #define page_keyid page_keyid
 int page_keyid(const struct page *page);
 
+#define vma_keyid vma_keyid
+int vma_keyid(struct vm_area_struct *vma);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 09cbff678b9f..a1f40ee61b25 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,3 +1,4 @@
+#include <linux/mm.h>
 #include <asm/mktme.h>
 
 phys_addr_t mktme_keyid_mask;
@@ -37,3 +38,14 @@ struct page_ext_operations page_mktme_ops = {
 	.need = need_page_mktme,
 	.init = init_page_mktme,
 };
+
+int vma_keyid(struct vm_area_struct *vma)
+{
+	pgprotval_t prot;
+
+	if (!mktme_enabled())
+		return 0;
+
+	prot = pgprot_val(vma->vm_page_prot);
+	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
+}
-- 
2.18.0

