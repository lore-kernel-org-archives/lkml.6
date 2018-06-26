Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DAE26C50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DAE26C50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936060AbeFZO0w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:26:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:6711 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935966AbeFZOWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:22:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="240770208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2018 07:22:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D00E073D; Tue, 26 Jun 2018 17:22:51 +0300 (EEST)
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
Subject: [PATCHv4 08/18] x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
Date:   Tue, 26 Jun 2018 17:22:35 +0300
Message-Id: <20180626142245.82850-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An encrypted VMA will have KeyID stored in vma->vm_page_prot. This way
we don't need to do anything special to setup encrypted page table
entries and don't need to reserve space for KeyID in a VMA.

This patch changes _PAGE_CHG_MASK to include KeyID bits. Otherwise they
are going to be stripped from vm_page_prot on the first pgprot_modify().

Define PTE_PFN_MASK_MAX similar to PTE_PFN_MASK but based on
__PHYSICAL_MASK_SHIFT. This way we include whole range of bits
architecturally available for PFN without referencing physical_mask and
mktme_keyid_mask variables.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 99fff853c944..3731f7e08757 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -120,8 +120,21 @@
  * protection key is treated like _PAGE_RW, for
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
+ *
+ * They include the physical address and the memory encryption keyID.
+ * The paddr and the keyID never occupy the same bits at the same time.
+ * But, a given bit might be used for the keyID on one system and used for
+ * the physical address on another. As an optimization, we manage them in
+ * one unit here since their combination always occupies the same hardware
+ * bits. PTE_PFN_MASK_MAX stores combined mask.
+ *
+ * Cast PAGE_MASK to a signed type so that it is sign-extended if
+ * virtual addresses are 32-bits but physical addresses are larger
+ * (ie, 32-bit PAE).
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
+#define PTE_PFN_MASK_MAX \
+	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
 			 _PAGE_SOFT_DIRTY)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
-- 
2.18.0

