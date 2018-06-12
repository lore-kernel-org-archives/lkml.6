Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5ACBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535C208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7535C208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeFLOl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:41:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:8257 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934244AbeFLOj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="49279031"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2018 07:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 25AC44C9; Tue, 12 Jun 2018 17:39:21 +0300 (EEST)
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
Subject: [PATCHv3 12/17] x86/mm: Allow to disable MKTME after enumeration
Date:   Tue, 12 Jun 2018 17:39:10 +0300
Message-Id: <20180612143915.68065-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate MKTME enumaration from enabling. We need to postpone enabling
until initialization is complete.

The new helper mktme_disable() allows to disable MKTME even if it's
enumerated successfully. MKTME initialization may fail and this
functionallity allows system to boot regardless of the failure.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 12 ++++++++++++
 arch/x86/kernel/cpu/intel.c  | 15 ++++-----------
 arch/x86/mm/mktme.c          |  9 +++++++++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index ec7036abdb3f..9363b989a021 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -6,11 +6,21 @@
 
 struct vm_area_struct;
 
+/* Values for mktme_status */
+#define MKTME_DISABLED			0
+#define MKTME_ENUMERATED		1
+#define MKTME_ENABLED			2
+#define MKTME_UNINITIALIZED		3
+
+extern int mktme_status;
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
 
+void mktme_disable(void);
+
 #define prep_encrypted_page prep_encrypted_page
 void prep_encrypted_page(struct page *page, int order, int keyid, bool zero);
 
@@ -28,6 +38,8 @@ extern struct page_ext_operations page_mktme_ops;
 #define page_keyid page_keyid
 int page_keyid(const struct page *page);
 
+void mktme_disable(void);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index efc9e9fc47d4..fb58776513e6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -508,11 +508,7 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
+int mktme_status __ro_after_init = MKTME_UNINITIALIZED;
 
 static void detect_tme(struct cpuinfo_x86 *c)
 {
@@ -568,11 +564,11 @@ static void detect_tme(struct cpuinfo_x86 *c)
 
 	if (mktme_status == MKTME_UNINITIALIZED) {
 		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
+		mktme_status = MKTME_ENUMERATED;
 	}
 
 #ifdef CONFIG_X86_INTEL_MKTME
-	if (mktme_status == MKTME_ENABLED && nr_keyids) {
+	if (mktme_status == MKTME_ENUMERATED && nr_keyids) {
 		mktme_nr_keyids = nr_keyids;
 		mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
 
@@ -591,10 +587,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
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
index 1821b87abb2f..43a44f0f2a2d 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -6,6 +6,15 @@ phys_addr_t mktme_keyid_mask;
 int mktme_nr_keyids;
 int mktme_keyid_shift;
 
+void mktme_disable(void)
+{
+	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	mktme_keyid_mask = 0;
+	mktme_keyid_shift = 0;
+	mktme_nr_keyids = 0;
+	mktme_status = MKTME_DISABLED;
+}
+
 int page_keyid(const struct page *page)
 {
 	if (mktme_status != MKTME_ENABLED)
-- 
2.17.1

