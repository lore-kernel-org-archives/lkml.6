Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D073FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875C2208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934334AbeFLOjc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:39:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:29477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934245AbeFLOj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="63432755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2018 07:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3886F648; Tue, 12 Jun 2018 17:39:21 +0300 (EEST)
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
Subject: [PATCHv3 14/17] x86/mm: Introduce direct_mapping_size
Date:   Tue, 12 Jun 2018 17:39:12 +0300
Message-Id: <20180612143915.68065-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel need to have a way to access encrypted memory. We are going to
use per-KeyID direct mapping to facilitate the access with minimal
overhead.

Direct mapping for each KeyID will be put next to each other in the
virtual address space. We need to have a way to find boundaries of
direct mapping for particular KeyID.

The new variable direct_mapping_size specifies the size of direct
mapping. With the value, it's trivial to find direct mapping for
KeyID-N: PAGE_OFFSET + N * direct_mapping_size.

Size of direct mapping is calculated during KASLR setup. If KALSR is
disable it happens during MKTME initialization.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h   |  2 ++
 arch/x86/include/asm/page_64.h |  1 +
 arch/x86/kernel/head64.c       |  2 ++
 arch/x86/mm/kaslr.c            | 21 ++++++++++++---
 arch/x86/mm/mktme.c            | 48 ++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 9363b989a021..3bf481fe3f56 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -40,6 +40,8 @@ int page_keyid(const struct page *page);
 
 void mktme_disable(void);
 
+void setup_direct_mapping_size(void);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..53c32af895ab 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -14,6 +14,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long direct_mapping_size;
 
 static inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a21d6ace648e..b6175376b2e1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -59,6 +59,8 @@ EXPORT_SYMBOL(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
+unsigned long direct_mapping_size __ro_after_init = -1UL;
+EXPORT_SYMBOL(direct_mapping_size);
 
 #define __head	__section(.head.text)
 
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 4408cd9a3bef..3d8ef8cb97e1 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -69,6 +69,15 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+#ifndef CONFIG_X86_INTEL_MKTME
+static void __init setup_direct_mapping_size(void)
+{
+	direct_mapping_size = max_pfn << PAGE_SHIFT;
+	direct_mapping_size = round_up(direct_mapping_size, 1UL << TB_SHIFT);
+	direct_mapping_size += (1UL << TB_SHIFT) * CONFIG_MEMORY_PHYSICAL_PADDING;
+}
+#endif
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -93,7 +102,11 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	/*
+	 * Upper limit for direct mapping size is 1/4 of whole virtual
+	 * address space
+	 */
+	kaslr_regions[0].size_tb = 1 << (__VIRTUAL_MASK_SHIFT - 1 - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
@@ -101,8 +114,10 @@ void __init kernel_randomize_memory(void)
 	 * add padding if needed (especially for memory hotplug support).
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
-	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_MEMORY_PHYSICAL_PADDING;
+
+	setup_direct_mapping_size();
+
+	memory_tb = direct_mapping_size * mktme_nr_keyids + 1;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 43a44f0f2a2d..3e5322bf035e 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -89,3 +89,51 @@ static bool need_page_mktme(void)
 struct page_ext_operations page_mktme_ops = {
 	.need = need_page_mktme,
 };
+
+void __init setup_direct_mapping_size(void)
+{
+	unsigned long available_va;
+
+	/* 1/4 of virtual address space is didicated for direct mapping */
+	available_va = 1UL << (__VIRTUAL_MASK_SHIFT - 1);
+
+	/* How much memory the systrem has? */
+	direct_mapping_size = max_pfn << PAGE_SHIFT;
+	direct_mapping_size = round_up(direct_mapping_size, 1UL << 40);
+
+	if (mktme_status != MKTME_ENUMERATED)
+		goto out;
+
+	/*
+	 * Not enough virtual address space to address all physical memory with
+	 * MKTME enabled. Even without padding.
+	 *
+	 * Disable MKTME instead.
+	 */
+	if (direct_mapping_size > available_va / mktme_nr_keyids + 1) {
+		pr_err("x86/mktme: Disabled. Not enough virtual address space\n");
+		pr_err("x86/mktme: Consider switching to 5-level paging\n");
+		mktme_disable();
+		goto out;
+	}
+
+	/*
+	 * Virtual address space is divided between per-KeyID direct mappings.
+	 */
+	available_va /= mktme_nr_keyids + 1;
+out:
+	/* Add padding, if there's enough virtual address space */
+	direct_mapping_size += (1UL << 40) * CONFIG_MEMORY_PHYSICAL_PADDING;
+	if (direct_mapping_size > available_va)
+		direct_mapping_size = available_va;
+}
+
+static int __init mktme_init(void)
+{
+	/* KASLR didn't initialized it for us. */
+	if (direct_mapping_size == -1UL)
+		setup_direct_mapping_size();
+
+	return 0;
+}
+arch_initcall(mktme_init)
-- 
2.17.1

