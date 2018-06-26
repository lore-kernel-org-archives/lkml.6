Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A610C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C40C26C3F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C40C26C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936015AbeFZOZ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:25:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:6717 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935974AbeFZOW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:22:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="240770212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2018 07:22:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DF2D6743; Tue, 26 Jun 2018 17:22:51 +0300 (EEST)
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
Subject: [PATCHv4 09/18] x86/mm: Implement page_keyid() using page_ext
Date:   Tue, 26 Jun 2018 17:22:36 +0300
Message-Id: <20180626142245.82850-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store KeyID in bits 31:16 of extended page flags. These bits are unused.

page_keyid() returns zero until page_ext is ready. page_ext initializer
enables static branch to indicate that page_keyid() can use page_ext.
The same static branch will gate MKTME readiness in general.

We don't yet set KeyID for the page. It will come in the following
patch that implements prep_encrypted_page(). All pages have KeyID-0 for
now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  7 +++++++
 arch/x86/include/asm/page.h  |  1 +
 arch/x86/mm/mktme.c          | 34 ++++++++++++++++++++++++++++++++++
 include/linux/page_ext.h     | 11 ++++++++++-
 mm/page_ext.c                |  3 +++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index df31876ec48c..7266494b4f0a 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -2,11 +2,18 @@
 #define	_ASM_X86_MKTME_H
 
 #include <linux/types.h>
+#include <linux/page_ext.h>
 
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
+
+extern struct page_ext_operations page_mktme_ops;
+
+#define page_keyid page_keyid
+int page_keyid(const struct page *page);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..39af59487d5f 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -19,6 +19,7 @@
 struct page;
 
 #include <linux/range.h>
+#include <asm/mktme.h>
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 467f1b26c737..09cbff678b9f 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -3,3 +3,37 @@
 phys_addr_t mktme_keyid_mask;
 int mktme_nr_keyids;
 int mktme_keyid_shift;
+
+static DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
+
+static inline bool mktme_enabled(void)
+{
+	return static_branch_unlikely(&mktme_enabled_key);
+}
+
+int page_keyid(const struct page *page)
+{
+	if (!mktme_enabled())
+		return 0;
+
+	return lookup_page_ext(page)->keyid;
+}
+EXPORT_SYMBOL(page_keyid);
+
+static bool need_page_mktme(void)
+{
+	/* Make sure keyid doesn't collide with extended page flags */
+	BUILD_BUG_ON(__NR_PAGE_EXT_FLAGS > 16);
+
+	return !!mktme_nr_keyids;
+}
+
+static void init_page_mktme(void)
+{
+	static_branch_enable(&mktme_enabled_key);
+}
+
+struct page_ext_operations page_mktme_ops = {
+	.need = need_page_mktme,
+	.init = init_page_mktme,
+};
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index f84f167ec04c..d9c5aae9523f 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -23,6 +23,7 @@ enum page_ext_flags {
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
 #endif
+	__NR_PAGE_EXT_FLAGS
 };
 
 /*
@@ -33,7 +34,15 @@ enum page_ext_flags {
  * then the page_ext for pfn always exists.
  */
 struct page_ext {
-	unsigned long flags;
+	union {
+		unsigned long flags;
+#ifdef CONFIG_X86_INTEL_MKTME
+		struct {
+			unsigned short __pad;
+			unsigned short keyid;
+		};
+#endif
+	};
 };
 
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
diff --git a/mm/page_ext.c b/mm/page_ext.c
index a9826da84ccb..036658229842 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -68,6 +68,9 @@ static struct page_ext_operations *page_ext_ops[] = {
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_X86_INTEL_MKTME
+	&page_mktme_ops,
+#endif
 };
 
 static unsigned long total_usage;
-- 
2.18.0

