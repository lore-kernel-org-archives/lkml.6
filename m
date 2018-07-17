Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D21208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D21208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeGQLx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:53:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:40792 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731368AbeGQLx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:53:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 04:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="75441626"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2018 04:21:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4773F7BC; Tue, 17 Jul 2018 14:21:49 +0300 (EEST)
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
Subject: [PATCHv5 14/19] x86/mm: Allow to disable MKTME after enumeration
Date:   Tue, 17 Jul 2018 14:20:24 +0300
Message-Id: <20180717112029.42378-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper mktme_disable() allows to disable MKTME even if it's
enumerated successfully. MKTME initialization may fail and this
functionality allows system to boot regardless of the failure.

MKTME needs per-KeyID direct mapping. It requires a lot more virtual
address space which may be a problem in 4-level paging mode. If the
system has more physical memory than we can handle with MKTME the
feature allows to fail MKTME, but boot the system successfully.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 2 ++
 arch/x86/kernel/cpu/intel.c  | 5 +----
 arch/x86/mm/mktme.c          | 9 +++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 44409b8bbaca..ebbee6a0c495 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -6,6 +6,8 @@
 
 struct vm_area_struct;
 
+void mktme_disable(void);
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index efc9e9fc47d4..75e3b2602b4a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -591,10 +591,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * Maybe needed if there's inconsistent configuation
 		 * between CPUs.
 		 */
-		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
-		mktme_keyid_mask = 0;
-		mktme_keyid_shift = 0;
-		mktme_nr_keyids = 0;
+		mktme_disable();
 	}
 #endif
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 1194496633ce..bb6210dbcf0e 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -13,6 +13,15 @@ static inline bool mktme_enabled(void)
 	return static_branch_unlikely(&mktme_enabled_key);
 }
 
+void mktme_disable(void)
+{
+	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	mktme_keyid_mask = 0;
+	mktme_keyid_shift = 0;
+	mktme_nr_keyids = 0;
+	static_branch_disable(&mktme_enabled_key);
+}
+
 int page_keyid(const struct page *page)
 {
 	if (!mktme_enabled())
-- 
2.18.0

