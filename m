Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384ABC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24862075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24862075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIHAfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:35:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:44940 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeIHAfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:35:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 12:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="260780738"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2018 12:51:28 -0700
Subject: [RFC][PATCH 3/8] x86/mm: break out user address space handling
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 07 Sep 2018 12:48:57 -0700
References: <20180907194852.3C351B82@viggo.jf.intel.com>
In-Reply-To: <20180907194852.3C351B82@viggo.jf.intel.com>
Message-Id: <20180907194857.93621ACE@viggo.jf.intel.com>
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
---

 b/arch/x86/mm/fault.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-01 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-01	2018-09-07 11:21:46.663751901 -0700
+++ b/arch/x86/mm/fault.c	2018-09-07 11:21:46.667751901 -0700
@@ -1203,6 +1203,7 @@ static inline bool smap_violation(int er
 	return true;
 }
 
+/* Handle faults in the kernel portion of the address space */
 static void
 do_kern_addr_space_fault(struct pt_regs *regs, unsigned long hw_error_code,
 			 unsigned long address)
@@ -1252,14 +1253,11 @@ do_kern_addr_space_fault(struct pt_regs
 }
 NOKPROBE_SYMBOL(do_kern_addr_space_fault);
 
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
+void do_user_addr_space_fault(struct pt_regs *regs,
+			      unsigned long hw_error_code,
+			      unsigned long address)
 {
 	unsigned long sw_error_code;
 	struct vm_area_struct *vma;
@@ -1272,17 +1270,6 @@ __do_page_fault(struct pt_regs *regs, un
 	tsk = current;
 	mm = tsk->mm;
 
-	prefetchw(&mm->mmap_sem);
-
-	if (unlikely(kmmio_fault(regs, address)))
-		return;
-
-	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address))) {
-		do_kern_addr_space_fault(regs, hw_error_code, address);
-		return;
-	}
-
 	/* kprobes don't want to hook the spurious faults: */
 	if (unlikely(kprobes_fault(regs)))
 		return;
@@ -1486,6 +1473,28 @@ good_area:
 
 	check_v8086_mode(regs, address, tsk);
 }
+NOKPROBE_SYMBOL(do_user_addr_space_fault);
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
+		do_kern_addr_space_fault(regs, hw_error_code, address);
+	else
+		do_user_addr_space_fault(regs, hw_error_code, address);
+}
 NOKPROBE_SYMBOL(__do_page_fault);
 
 static nokprobe_inline void
_
