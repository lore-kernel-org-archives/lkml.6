Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D086C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6CB26C2A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6CB26C2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965949AbeFZOXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:23:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:53115 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965532AbeFZOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:23:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="53025009"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 07:22:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4F4F99C3; Tue, 26 Jun 2018 17:22:52 +0300 (EEST)
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
Subject: [PATCHv4 17/18] x86/mm: Handle encrypted memory in page_to_virt() and __pa()
Date:   Tue, 26 Jun 2018 17:22:44 +0300
Message-Id: <20180626142245.82850-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-KeyID direct mappings require changes into how we find the right
virtual address for a page and virt-to-phys address translations.

page_to_virt() definition overwrites default macros provided by
<linux/mm.h>. We only overwrite the macros if MTKME is enabled
compile-time.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h   | 3 +++
 arch/x86/include/asm/page_64.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index ba83fba4f9b3..dbfbd955da98 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -29,6 +29,9 @@ void arch_free_page(struct page *page, int order);
 
 int sync_direct_mapping(void);
 
+#define page_to_virt(x) \
+	(__va(PFN_PHYS(page_to_pfn(x))) + page_keyid(x) * direct_mapping_size)
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 53c32af895ab..ffad496aadad 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -23,7 +23,7 @@ static inline unsigned long __phys_addr_nodebug(unsigned long x)
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
 
-	return x;
+	return x % direct_mapping_size;
 }
 
 #ifdef CONFIG_DEBUG_VIRTUAL
-- 
2.18.0

