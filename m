Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D1C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E4F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E4F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1Waf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:30737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeI1Wae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="94343879"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2018 09:06:06 -0700
Subject: [PATCH 3/8] x86/mm: break out user address space handling
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:23 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160223.9C4F6440@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The last patch broke out kernel address space handing into its own
helper.  Now, do the same for user address space handling.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-01 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-01	2018-09-27 10:17:22.485343569 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:22.489343569 -0700
@@ -968,6 +968,7 @@ bad_area_access_error(struct pt_regs *re
 		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
 }
 
+/* Handle faults in the kernel portion of the address space */
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  u32 *pkey, unsigned int fault)
@@ -1256,14 +1257,11 @@ do_kern_addr_fault(struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
-/*
- * This routine handles page faults.  It determines the address,
- * and the problem, and then passes it off to one of the appropriate
- * routines.
- */
-static noinline void
-__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		unsigned long address)
+/* Handle faults in the user portion of the address space */
+static inline
+void do_user_addr_fault(struct pt_regs *regs,
+			unsigned long hw_error_code,
+			unsigned long address)
 {
 	unsigned long sw_error_code;
 	struct vm_area_struct *vma;
@@ -1276,17 +1274,6 @@ __do_page_fault(struct pt_regs *regs, un
 	tsk = current;
 	mm = tsk->mm;
 
-	prefetchw(&mm->mmap_sem);
-
-	if (unlikely(kmmio_fault(regs, address)))
-		return;
-
-	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address))) {
-		do_kern_addr_fault(regs, hw_error_code, address);
-		return;
-	}
-
 	/* kprobes don't want to hook the spurious faults: */
 	if (unlikely(kprobes_fault(regs)))
 		return;
@@ -1490,6 +1477,28 @@ good_area:
 
 	check_v8086_mode(regs, address, tsk);
 }
+NOKPROBE_SYMBOL(do_user_addr_fault);
+
+/*
+ * This routine handles page faults.  It determines the address,
+ * and the problem, and then passes it off to one of the appropriate
+ * routines.
+ */
+static noinline void
+__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
+		unsigned long address)
+{
+	prefetchw(&current->mm->mmap_sem);
+
+	if (unlikely(kmmio_fault(regs, address)))
+		return;
+
+	/* Was the fault on kernel-controlled part of the address space? */
+	if (unlikely(fault_in_kernel_space(address)))
+		do_kern_addr_fault(regs, hw_error_code, address);
+	else
+		do_user_addr_fault(regs, hw_error_code, address);
+}
 NOKPROBE_SYMBOL(__do_page_fault);
 
 static nokprobe_inline void
_
