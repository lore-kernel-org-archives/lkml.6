Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96AB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtCRHv5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96AB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeKTJLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbeKTJLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:42 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B001D214DB;
        Mon, 19 Nov 2018 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667549;
        bh=Ac2RZMxNP8fbsJqvCdTCUjvvTMPVnJvwOguMbOKOZDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=qtCRHv5gYKkz8W6GmomO7Chi/PBYpA9KGOiDsmFoS6FMt48kzgPnGkoV4k35xH2s6
         dMx6cKtaWT1xlzJ10tk38bAPx1tRhY8LwUThOwFHyt5Q4oEr2MAmfq/LMXbzVu+mG9
         9b77pc7f3EWupUOm+JUl9IT5DJUvBcGvWDPZBtVU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 09/13] x86/fault: Remove sw_error_code
Date:   Mon, 19 Nov 2018 14:45:33 -0800
Message-Id: <20b7d988a4fd029ced32087acec716564277489d.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the fault handling code now corrently checks user_mode(regs)
as needed, and nothing depends on the X86_PF_USER bit being munged.
Get rid of the sw_error code and use hw_error_code everywhere.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 52 +++++++++++----------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a6554110ef62..6e18438c367f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1217,7 +1217,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long hw_error_code,
 			unsigned long address)
 {
-	unsigned long sw_error_code;
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -1262,13 +1261,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * hw_error_code is literally the "page fault error code" passed to
-	 * the kernel directly from the hardware.  But, we will shortly be
-	 * modifying it in software, so give it a new name.
-	 */
-	sw_error_code = hw_error_code;
-
 	/*
 	 * It's safe to allow irq's after cr2 has been saved and the
 	 * vmalloc fault has been handled.
@@ -1278,26 +1270,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	if (user_mode(regs)) {
 		local_irq_enable();
-		/*
-		 * Up to this point, X86_PF_USER set in hw_error_code
-		 * indicated a user-mode access.  But, after this,
-		 * X86_PF_USER in sw_error_code will indicate either
-		 * that, *or* an implicit kernel(supervisor)-mode access
-		 * which originated from user mode.
-		 */
-		if (!(hw_error_code & X86_PF_USER)) {
-			/*
-			 * The CPU was in user mode, but the CPU says
-			 * the fault was not a user-mode access.
-			 * Must be an implicit kernel-mode access,
-			 * which we do not expect to happen in the
-			 * user address space.
-			 */
-			pr_warn_once("kernel-mode error from user-mode: %lx\n",
-					hw_error_code);
-
-			sw_error_code |= X86_PF_USER;
-		}
 		flags |= FAULT_FLAG_USER;
 	} else {
 		if (regs->flags & X86_EFLAGS_IF)
@@ -1306,9 +1278,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (sw_error_code & X86_PF_WRITE)
+	if (hw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (sw_error_code & X86_PF_INSTR)
+	if (hw_error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 #ifdef CONFIG_X86_64
@@ -1321,7 +1293,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * The vsyscall page does not have a "real" VMA, so do this
 	 * emulation before we go searching for VMAs.
 	 */
-	if ((sw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
+	if ((hw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
 		if (emulate_vsyscall(regs, address))
 			return;
 	}
@@ -1345,7 +1317,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, sw_error_code, address);
+			bad_area_nosemaphore(regs, hw_error_code, address);
 			return;
 		}
 retry:
@@ -1361,13 +1333,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 	if (user_mode(regs)) {
@@ -1378,12 +1350,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * 32 pointers and then decrements %sp by 65535.)
 		 */
 		if (unlikely(address + 65536 + 32 * sizeof(unsigned long) < regs->sp)) {
-			bad_area(regs, sw_error_code, address);
+			bad_area(regs, hw_error_code, address);
 			return;
 		}
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 
@@ -1392,8 +1364,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(sw_error_code, vma))) {
-		bad_area_access_error(regs, sw_error_code, address, vma);
+	if (unlikely(access_error(hw_error_code, vma))) {
+		bad_area_access_error(regs, hw_error_code, address, vma);
 		return;
 	}
 
@@ -1432,13 +1404,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 			return;
 
 		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, sw_error_code, address, SIGBUS, BUS_ADRERR);
+		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
 	up_read(&mm->mmap_sem);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, sw_error_code, address, fault);
+		mm_fault_error(regs, hw_error_code, address, fault);
 		return;
 	}
 
-- 
2.17.2

