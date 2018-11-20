Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD63C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0F9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeKTSpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:45:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKTSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:45:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8HPOg2909016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:17:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8HODm2909013;
        Tue, 20 Nov 2018 00:17:24 -0800
Date:   Tue, 20 Nov 2018 00:17:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-e49d3cbef0176c182b86206185f137a87f16ab91@git.kernel.org>
Cc:     luto@kernel.org, tglx@linutronix.de, yu-cheng.yu@intel.com,
        dvlasenk@redhat.com, peterz@infradead.org, riel@surriel.com,
        brgerst@gmail.com, hpa@zytor.com, mingo@kernel.org,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org
Reply-To: riel@surriel.com, brgerst@gmail.com, tglx@linutronix.de,
          peterz@infradead.org, yu-cheng.yu@intel.com, dvlasenk@redhat.com,
          luto@kernel.org, torvalds@linux-foundation.org,
          dave.hansen@linux.intel.com, bp@alien8.de,
          linux-kernel@vger.kernel.org, luto@amacapital.net, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <b31159bd55bd0c4fa061a20dfd6c429c094bebaa.1542667307.git.luto@kernel.org>
References: <b31159bd55bd0c4fa061a20dfd6c429c094bebaa.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Make error_code sanitization more robust
Git-Commit-ID: e49d3cbef0176c182b86206185f137a87f16ab91
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e49d3cbef0176c182b86206185f137a87f16ab91
Gitweb:     https://git.kernel.org/tip/e49d3cbef0176c182b86206185f137a87f16ab91
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:31 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:29 +0100

x86/fault: Make error_code sanitization more robust

The error code in a page fault on a kernel address indicates
whether that address is mapped, which should not be revealed in a signal.

The normal code path for a page fault on a kernel address sanitizes the bit,
but the paths for vsyscall emulation and SIGBUS do not.  Both are
harmless, but for subtle reasons.  SIGBUS is never sent for a kernel
address, and vsyscall emulation will never fault on a kernel address
per se because it will fail an access_ok() check instead.

Make the code more robust by adding a helper that sets the relevant
fields and sanitizing the error code in the helper.  This also
cleans up the code -- we had three copies of roughly the same thing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/b31159bd55bd0c4fa061a20dfd6c429c094bebaa.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3c9aed03d18e..b5ec1ca2f4a0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -631,6 +631,24 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
+static void set_signal_archinfo(unsigned long address,
+				unsigned long error_code)
+{
+	struct task_struct *tsk = current;
+
+	/*
+	 * To avoid leaking information about the kernel page
+	 * table layout, pretend that user-mode accesses to
+	 * kernel addresses are always protection faults.
+	 */
+	if (address >= TASK_SIZE_MAX)
+		error_code |= X86_PF_PROT;
+
+	tsk->thread.trap_nr = X86_TRAP_PF;
+	tsk->thread.error_code = error_code | X86_PF_USER;
+	tsk->thread.cr2 = address;
+}
+
 static noinline void
 no_context(struct pt_regs *regs, unsigned long error_code,
 	   unsigned long address, int signal, int si_code)
@@ -656,9 +674,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * faulting through the emulate_vsyscall() logic.
 		 */
 		if (current->thread.sig_on_uaccess_err && signal) {
-			tsk->thread.trap_nr = X86_TRAP_PF;
-			tsk->thread.error_code = error_code | X86_PF_USER;
-			tsk->thread.cr2 = address;
+			set_signal_archinfo(address, error_code);
 
 			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_fault(signal, si_code, (void __user *)address,
@@ -821,9 +837,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (likely(show_unhandled_signals))
 			show_signal_msg(regs, error_code, address, tsk);
 
-		tsk->thread.cr2		= address;
-		tsk->thread.error_code	= error_code;
-		tsk->thread.trap_nr	= X86_TRAP_PF;
+		set_signal_archinfo(address, error_code);
 
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, pkey);
@@ -937,9 +951,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-	tsk->thread.cr2		= address;
-	tsk->thread.error_code	= error_code;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
+	set_signal_archinfo(address, error_code);
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
