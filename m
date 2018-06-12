Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BE6DFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E84F208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E84F208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbeFLOje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:39:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:32098 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934302AbeFLOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="236788346"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2018 07:39:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4AEA483A; Tue, 12 Jun 2018 17:39:21 +0300 (EEST)
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
Subject: [PATCHv3 16/17] x86/mm: Handle encrypted memory in page_to_virt() and __pa()
Date:   Tue, 12 Jun 2018 17:39:14 +0300
Message-Id: <20180612143915.68065-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-KeyID direct mappings require changes into how we find the right
virtual address for a page and virt-to-phys address translations.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h   | 3 +++
 arch/x86/include/asm/page_64.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index efc0d4bb3b35..d6edcabacfc7 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -43,6 +43,9 @@ void mktme_disable(void);
 void setup_direct_mapping_size(void);
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
2.17.1

