Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEA820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeHaBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:49:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:23359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeHaBtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:49:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 14:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,308,1531810800"; 
   d="scan'208";a="258629084"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2018 14:45:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
Date:   Thu, 30 Aug 2018 14:45:17 -0700
Message-Id: <20180830214517.29372-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trick with flipping bit 63 to avoid loading the address of the
1:1 mapping of the poisoned page while we update the 1:1 map used
to work when we wanted to unmap the page. But it falls down horribly
when we try to directly set the page as uncacheable.

The problem is that when we change the cache mode to uncachable we
try to flush the page from the cache. But the decoy address is
non-canonical, and the CLFLUSH instruction throws a #GP fault.

Fix is to move one step at a time. First mark the page not present
(using the decoy address). Then it is safe to use the actual address
of the 1:1 mapping to mark it "uc", and finally as present.

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Maybe this is horrible. Other suggestions gratefully received.

 arch/x86/include/asm/set_memory.h | 23 +++++++++++++++++++++--
 arch/x86/mm/pageattr.c            |  5 +++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 07a25753e85c..e876860988bf 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -43,6 +43,7 @@ int set_memory_wc(unsigned long addr, int numpages);
 int set_memory_wt(unsigned long addr, int numpages);
 int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
+int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
@@ -111,9 +112,27 @@ static inline int set_mce_nospec(unsigned long pfn)
 	 */
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
 
-	rc = set_memory_uc(decoy_addr, 1);
-	if (rc)
+	rc = set_memory_np(decoy_addr, 1);
+	if (rc) {
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
+		return rc;
+	}
+
+	native_cpuid_eax(0);
+
+	/* Now safe to use the virtual address in the 1:1 map */
+	rc = set_memory_uc((unsigned long)pfn_to_kaddr(pfn), 1);
+	if (rc) {
+		pr_warn("Could not set pfn=0x%lx uncacheable in 1:1 map\n", pfn);
+		return rc;
+	}
+
+	rc = set_memory_p((unsigned long)pfn_to_kaddr(pfn), 1);
+	if (rc) {
+		pr_warn("Could not remap pfn=0x%lx uncacheable in 1:1 map\n", pfn);
+		return rc;
+	}
+
 	return rc;
 }
 #define set_mce_nospec set_mce_nospec
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 8d6c34fe49be..87400351c5a0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1776,6 +1776,11 @@ int set_memory_np(unsigned long addr, int numpages)
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
 }
 
+int set_memory_p(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
 int set_memory_np_noalias(unsigned long addr, int numpages)
 {
 	int cpa_flags = CPA_NO_CHECK_ALIAS;
-- 
2.17.1

