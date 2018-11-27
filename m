Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA2FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614022082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614022082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeK0WNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:13:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:5178 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeK0WNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:13:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 03:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="114082877"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 03:16:13 -0800
From:   Luming Yu <luming.yu@intel.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spurious check for user space address
Date:   Tue, 27 Nov 2018 13:16:11 +0200
Message-Id: <20181127111612.74578-1-luming.yu@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we saw a suspected spurious fault that failed VMA
access check but passed spurious check for a user
space address access of (rw,execut). The patch is
trying to catch the case which might have indicated
a stale TLB (software bug found) and a harmful
spruious fault.

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Yongkai Wu <yongkaiwu@tencent.com>
---
 arch/x86/mm/fault.c | 95 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..5e2a49010d87 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1004,29 +1004,7 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 	return 1;
 }
 
-/*
- * Handle a spurious fault caused by a stale TLB entry.
- *
- * This allows us to lazily refresh the TLB when increasing the
- * permissions of a kernel page (RO -> RW or NX -> X).  Doing it
- * eagerly is very expensive since that implies doing a full
- * cross-processor TLB flush, even if no stale TLB entries exist
- * on other processors.
- *
- * Spurious faults may only occur if the TLB contains an entry with
- * fewer permission than the page table entry.  Non-present (P = 0)
- * and reserved bit (R = 1) faults are never spurious.
- *
- * There are no security implications to leaving a stale TLB when
- * increasing the permissions on a page.
- *
- * Returns non-zero if a spurious fault was handled, zero otherwise.
- *
- * See Intel Developer's Manual Vol 3 Section 4.10.4.3, bullet 3
- * (Optional Invalidation).
- */
-static noinline int
-spurious_kernel_fault(unsigned long error_code, unsigned long address)
+static int spurious_page_table_check(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1035,19 +1013,6 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	pte_t *pte;
 	int ret;
 
-	/*
-	 * Only writes to RO or instruction fetches from NX may cause
-	 * spurious faults.
-	 *
-	 * These could be from user or supervisor accesses but the TLB
-	 * is only lazily flushed after a kernel mapping protection
-	 * change, so user accesses are not expected to cause spurious
-	 * faults.
-	 */
-	if (error_code != (X86_PF_WRITE | X86_PF_PROT) &&
-	    error_code != (X86_PF_INSTR | X86_PF_PROT))
-		return 0;
-
 	pgd = init_mm.pgd + pgd_index(address);
 	if (!pgd_present(*pgd))
 		return 0;
@@ -1090,12 +1055,52 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 
 	return ret;
 }
+
+/*
+ * Handle a spurious fault caused by a stale TLB entry.
+ *
+ * This allows us to lazily refresh the TLB when increasing the
+ * permissions of a kernel page (RO -> RW or NX -> X).  Doing it
+ * eagerly is very expensive since that implies doing a full
+ * cross-processor TLB flush, even if no stale TLB entries exist
+ * on other processors.
+ *
+ * Spurious faults may only occur if the TLB contains an entry with
+ * fewer permission than the page table entry.  Non-present (P = 0)
+ * and reserved bit (R = 1) faults are never spurious.
+ *
+ * There are no security implications to leaving a stale TLB when
+ * increasing the permissions on a page.
+ *
+ * Returns non-zero if a spurious fault was handled, zero otherwise.
+ *
+ * See Intel Developer's Manual Vol 3 Section 4.10.4.3, bullet 3
+ * (Optional Invalidation).
+ */
+static noinline int
+spurious_kernel_fault(unsigned long error_code, unsigned long address)
+{
+	/*
+	 * Only writes to RO or instruction fetches from NX may cause
+	 * spurious faults.
+	 *
+	 * These could be from user or supervisor accesses but the TLB
+	 * is only lazily flushed after a kernel mapping protection
+	 * change, so user accesses are not expected to cause spurious
+	 * faults.
+	 */
+	if (error_code != (X86_PF_WRITE | X86_PF_PROT) &&
+	    error_code != (X86_PF_INSTR | X86_PF_PROT))
+		return 0;
+
+	return spurious_page_table_check(error_code, address);
+}
 NOKPROBE_SYMBOL(spurious_kernel_fault);
 
 int show_unhandled_signals = 1;
 
 static inline int
-access_error(unsigned long error_code, struct vm_area_struct *vma)
+access_error(unsigned long error_code, unsigned long address, struct vm_area_struct *vma)
 {
 	/* This is only called for the current mm, so: */
 	bool foreign = false;
@@ -1120,19 +1125,27 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	if (error_code & X86_PF_WRITE) {
 		/* write, present and write, not present: */
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
-			return 1;
+			goto maybe_spurious;
 		return 0;
 	}
 
 	/* read, present: */
 	if (unlikely(error_code & X86_PF_PROT))
-		return 1;
+		goto maybe_spurious;
 
 	/* read, not present: */
 	if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
-		return 1;
+		goto maybe_spurious;
 
 	return 0;
+
+maybe_spurious:
+	if (spurious_page_table_check(error_code, address)) {
+		WARN_ONCE(1, "spurious fault? Failed VMA check, passed page table check!\n");
+		return 0;
+	}
+
+	return 1;
 }
 
 static int fault_in_kernel_space(unsigned long address)
@@ -1402,7 +1415,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(sw_error_code, vma))) {
+	if (unlikely(access_error(sw_error_code, address, vma))) {
 		bad_area_access_error(regs, sw_error_code, address, vma);
 		return;
 	}
-- 
2.14.4

